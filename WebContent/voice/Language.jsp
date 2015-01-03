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

Response language_response=new Response();
language_response.setFiller("yes");
String language = request.getParameter("language");
System.out.println(language);
String groups_id=request.getParameter("groups_id");
System.out.println("language==="+groups_id);
CollectDtmf cd = new CollectDtmf();
cd.setMaxDigits(1);
cd.setTimeOut(4000);
char Language = language.charAt(0);
char base = '1';

String afterClick[] = {"OrderMenu.jsp?event=NewCall","Feedback.jsp?event=NewCall","Response.jsp?event=NewCall"};
String noneClip[] = {ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav" ,ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String afterDtmf[]={ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String noneUrl[] ={"Language.jsp?event=NewCall&language="+language+"&groups_id="+groups_id};

%>
    <c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state == "start" }'> 
        <%            
           
                               
        switch(Language - base){
            case 0:
             //   lang_response.addPlayAudio("http://qassist.cse.iitb.ac.in/Downloads/order/kookoo_audio1383201464341.wav");
                 language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_mainMenuOne.wav");
                 language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_mainMenuTwo.wav");
                language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_mainMenuThree.wav");
                break;
                
            case 1:
              //  lang_response.addPlayAudio("http://qassist.cse.iitb.ac.in/Downloads/order/kookoo_audio1383129880201.wav");  
                 language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_mainMenuOne.wav");
                 language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_mainMenuTwo.wav");
                language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_mainMenuThree.wav");
                break;
                
            case 2:
                 IvrsMenuSettings im = new IvrsMenuSettings();
                 language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_mainMenuOne.wav");
                 language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_mainMenuTwo.wav");
                 language_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_mainMenuThree.wav");
                break;
                       }
           
   
            language_response.addCollectDtmf(cd);
            session.setAttribute("state", "collectdNumber");
            language_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language.jsp?language="+language+"&groups_id="+groups_id);
            out.print( language_response.getXML());
            
            %>
    </c:when>
    
     <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
        <%   
        
         try{
        	String Groups_id = request.getParameter("groups_id");
        	System.out.println("language="+Groups_id);
            String number = request.getParameter("data");
            if(number==null||number.equals("")||number==""||number.equals(null)){
            	
            	language_response.addPlayAudio(afterDtmf[Language-base]);
            	language_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language.jsp?event=NewCall&language="+language+"&groups_id="+Groups_id);
            }
           else
           if (number.equals("1")  || number.equals("2")|| number.equals("3")) {
                session.removeAttribute("state");
                language_response.addGotoNEXTURL(ConfigParams.getIvrslink()+ afterClick[(Integer.parseInt(number))-1] + "&language=" + language+"&groups_id="+Groups_id);  
            }
            else{
                 
            	language_response.addPlayAudio(noneClip[Language - base]);            
                language_response.addGotoNEXTURL(ConfigParams.getIvrslink()+noneUrl[0]);
            }
                out.print(language_response.getXML());
         }
        catch(Exception e){
        	System.out.println(e);
        
        }
            %>
    </c:when>
</c:choose>
