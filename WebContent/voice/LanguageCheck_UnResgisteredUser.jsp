<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@page import= "java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%
Response lang_response=new Response();
lang_response.setFiller("yes");
String language = request.getParameter("language");
System.out.println(language);
String groups_id = request.getParameter("groups_id");
System.out.print(groups_id);
String register_number = request.getParameter("register_number");
CollectDtmf cd = new CollectDtmf();
cd.setMaxDigits(1);
// wait 8 sec for collect DTMF
cd.setTimeOut(8000);
		
char Language = language.charAt(0);
char base = '1';

// array for redirecting this page to another page
String afterClick[] = {"OrderMenu_UnRegisterUser.jsp?event=NewCall&register_number="+register_number+"&groups_id="+groups_id,"Feedback_UnRegisterUser.jsp?event=NewCall&register_number="+register_number+"&groups_id="+groups_id,"Response_UnregisterUser.jsp?event=NewCall&register_number="+register_number+"&groups_id="+groups_id};
String noneClip[] = {ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav" ,ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String afterDtmf[]={ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String noneUrl[] ={"LanguageCheck_UnResgisteredUser.jsp?event=NewCall&language="+language+"&register_number="+register_number+"&groups_id="+groups_id};

%>
    <c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state == "start" }'> 
        <%            
           
      // language: what language you selected , base : all ready defined                         
        switch(Language - base){
            case 0:
              
                lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_mainMenuOne.wav");
                 lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_mainMenuTwo.wav");
                lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_mainMenuThree.wav");
                break;
                
            case 1:
               
                 lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_mainMenuOne.wav");
                 lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_mainMenuTwo.wav");
                 lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_mainMenuThree.wav");
                break;
            case 2:
                
            	IvrsMenuSettings im = new IvrsMenuSettings();
                 lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_mainMenuOne.wav");
                 lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_mainMenuTwo.wav");
                lang_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_mainMenuThree.wav");
                break;
             }
           
   
            lang_response.addCollectDtmf(cd);
            session.setAttribute("state", "collectdNumber");
            lang_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"LanguageCheck_UnResgisteredUser.jsp?language="+language+"&register_number="+register_number+"&groups_id="+groups_id);
            out.print( lang_response.getXML());
            
            %>
    </c:when>
    
     <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
        <%   
        
         try{
        	 
        	 String register_number1=request.getParameter("register_number");
        	 String Groups_id = request.getParameter("groups_id");
            String number = request.getParameter("data"); // data will come from user side
            
            //interpreting the selected option
            if(number==null||number.equals("")||number==""||number.equals(null)){
            	
            	lang_response.addPlayAudio(afterDtmf[Language-base]);
            	lang_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"LanguageCheck_UnResgisteredUser.jsp?event=NewCall&language="+language+"&register_number="+register_number1+"&groups_id="+Groups_id);
            }
           else if (number.equals("1")  || number.equals("2")|| number.equals("3")) {
               
        	   session.removeAttribute("state");
                lang_response.addGotoNEXTURL(ConfigParams.getIvrslink()+ afterClick[(Integer.parseInt(number))-1] + "&language=" + language +"&register_number="+register_number1+"&groups_id="+Groups_id);  
            }
            else{
                
            	session.removeAttribute("state");
                lang_response.addPlayAudio(noneClip[Language - base]);            
                lang_response.addGotoNEXTURL(ConfigParams.getIvrslink()+noneUrl[0]);
            }
                out.print(lang_response.getXML());
         }
        catch(Exception e){
        	System.out.println(e);
          }
            %>
    </c:when>
</c:choose>
