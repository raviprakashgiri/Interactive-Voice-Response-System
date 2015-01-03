<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.ozonetel.kookoo.Response,java.util.Date,com.ozonetel.kookoo.Record"%>
<%@page import= "java.sql.*"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="java.util.Arrays"%>

<%

CollectDtmf cd = new CollectDtmf();
// wait 8 sec for user input (collect DTMF)
cd.setTimeOut(8000);
String language_response=request.getParameter("language");
// split the langauge_response string with the help of "x"
String[] forGroups_id = language_response.split("x");
// get the groups_id
String language = forGroups_id[0];
// get the response
String dataresponse = forGroups_id[1];
// get lanaguage response
String groups_id = forGroups_id[2];

System.out.println("groups_id="+groups_id);
System.out.println("response="+dataresponse);
System.out.println("language_value="+language);
String language_name[]={ "hindi","marathi","english"};

// array of redirecting from this page to another page
String language_url[]={"Publisher_Hindi.jsp?event=NewCall&Responsetype="+dataresponse+"&language="+"1"+"&groups_id="+groups_id,"Publisher_Marathi.jsp?event=NewCall&Responsetype="+dataresponse+"&language="+"2"+"&groups_id="+groups_id,"Publisher_English.jsp?event=NewCall&Responsetype="+dataresponse+"&language="+"3"+"&groups_id="+groups_id};
Response languageResponse= new Response(); 
// for music
languageResponse.setFiller("yes");
		
String number[]={ConfigParams.DEFAULTWAV+"/default_wav/en_one.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_two.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_three.wav"};
String response_type[]= {ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_structured.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_unstructured.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_structured.wav"};
char char_language[] = language.toCharArray();
Arrays.sort(char_language);



%>
<c:choose> 
    <c:when test='${param.event == "NewCall" }'> 
        <%--When we get a new call,we have to prompt for voice--%>
        <%
        String caller_id=request.getParameter("cid");
        int length_cid=caller_id.length();
        String caller_id1=caller_id.substring(1,length_cid);
        System.out.println(caller_id);
        
        KooKooFunctions kookoofunction = new KooKooFunctions();
        String broadcastValue[] = kookoofunction.GetBroadcastMsg(groups_id).split(",");
        String broadcastURL = broadcastValue[0];
        		
        if(broadcastURL.equals("")){
        		// latest broadcast message will play
              languageResponse.addPlayText("No new message");
        	}
        else{
        	   languageResponse.addPlayAudio(broadcastURL);
        	} 
       
        //  this will work for only one language
        if(char_language.length == 1){
        String extraUrl = language_url[char_language[0]-'4'];
        System.out.println(extraUrl);
        languageResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+extraUrl);
         out.print(languageResponse.getXML());
        }
        // this will work for more then one language
        else {
        String voice="";
        for (int i=1;i<=language.length();i++){
        	
            languageResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_press.wav");
    		languageResponse.addPlayAudio(number[i-1]);
    		languageResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_for.wav");
       		languageResponse.addPlayText(language_name[char_language[i-1] - '4']);
            
        }
           
        languageResponse.addPlayText(voice);
        languageResponse.addCollectDtmf(cd);
        languageResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"LanguageChecked.jsp?language="+language_response+"&groups_id="+groups_id);
        session.setAttribute("state1","collectNumber");
        out.print(languageResponse.getXML());
        }
             %>
    </c:when>
    
   <c:when test='${param.event == "GotDTMF" || requestScope.state1 == "collectNumber"}' >
   
   <%
   
   try{
       String language_value = request.getParameter("data");
       
       int length=language.length();
       if(language_value.equals("")||language_value.equals(null)||language_value==""||language_value==null){
    	   
       	   languageResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav");
    	   languageResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"LanguageChecked.jsp?event=NewCall&language="+language_response+"&groups_id="+groups_id);
       }
       else if((Integer.parseInt(language_value))<=length){
    	   
	       String extraUrl = language_url[char_language[Integer.parseInt(language_value)-1]-'4'];
	       System.out.println("uRL="+extraUrl);
	       System.out.println("main url"+ConfigParams.getIvrslink()+extraUrl);
	       languageResponse .addGotoNEXTURL(ConfigParams.getIvrslink()+extraUrl);
	       session.removeAttribute("state1");
      }
      else{
    	  
    	  System.out.println("end");
      	  languageResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav");
    	  languageResponse .addGotoNEXTURL(ConfigParams.getIvrslink()+"LanguageChecked.jsp?event=NewCall&language="+language_response);
      }
       out.print(languageResponse .getXML());
   }
   catch(Exception e){
          
	   e.printStackTrace();
   }
      
   %>
   
   
   </c:when>
   
  </c:choose>