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
String language = "";
String dataresponse = "";
try{
	
	// select the language and response from database
	KooKooFunctions kookoofunction = new KooKooFunctions();
	String LanguageResponse[]=kookoofunction.GetLanguageResponse().split(",");
	language = LanguageResponse[0];
	dataresponse = LanguageResponse[1];
	}
catch(Exception e){
	e.printStackTrace();
}
CollectDtmf cd = new CollectDtmf();
cd.setTimeOut(5000);
String groups_id = request.getParameter("groups_id");
System.out.println(groups_id);
String language_name[] ={ConfigParams.DEFAULTWAV+"/default_wav/hindi.wav",ConfigParams.DEFAULTWAV+"/default_wav/marathi.wav",ConfigParams.DEFAULTWAV+"/default_wav/english.wav"};
String language_url[]={"IncomingCallHindi.jsp?event=NewCall&Responsetype="+dataresponse+"&language="+"1"+"&groups_id="+groups_id,"IncomingCallMarathi.jsp?event=NewCall&Responsetype="+dataresponse+"&language="+"2"+"&groups_id="+groups_id,"IncomingCallEnglish.jsp?event=NewCall&Responsetype="+dataresponse+"&language="+"3"+"&groups_id="+groups_id};
Response languageResponse= new Response(); 
languageResponse.setFiller("yes");

String number[]={ConfigParams.DEFAULTWAV+"/default_wav/en_oneR.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_twoR.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_threeR.wav"};
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
        
        		// for one language
        if(char_language.length == 1){
        String extraUrl = language_url[char_language[0]-'4'];
        System.out.println(extraUrl);
        languageResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+extraUrl);
         out.print(languageResponse.getXML());
        }
        		// for more then one language
        else {
        String voice="";
        for (int i=1;i<=language.length();i++){
        	
            languageResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_pressR.wav");
    		languageResponse.addPlayAudio(number[i-1]);
    		languageResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_forR.wav");
      		languageResponse.addPlayAudio(language_name[char_language[i-1] - '4']);
            
        }
           
        languageResponse.addPlayText(voice);
        languageResponse.addCollectDtmf(cd);
        languageResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?language="+language+"&groups_id="+groups_id);
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
       	   languageResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?language="+language+"&groups_id="+groups_id);       
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
    	   languageResponse .addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&language="+language);
      }
       out.print(languageResponse .getXML());
   }
   catch(Exception e){
    e.printStackTrace();
   }
   
   
   %>
   
   
   </c:when>
   
  </c:choose>