<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.ozonetel.kookoo.CollectDtmf"%>
 <%@page import="com.iitb.KookooFunctionsTextToSpeechModel.MsgResponse"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
<%@page import="com.iitb.MessageModel.ActivityLog" %>
 <%@page import= "java.sql.*"%>
<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
Response order_response = new Response();
order_response.setFiller("yes");
String language = request.getParameter("language");
System.out.println("languageresponse=="+language);
String groups_id = request.getParameter("groups_id");
System.out.println("Response="+groups_id);
char Language = language.charAt(0);

char base = '1';

IvrsMenuSettings im = new IvrsMenuSettings();
String positive = im.getStructured(1, 1, 0, 0, "opt_1");
String negative = im.getStructured(1, 1, 0, 0, "opt_2");
String response_conformation = positive+"  "+negative;
// array for english language response
String english_response[]={ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_structured_answer_yes.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_structured_answer_no.wav"};
// array for yes response (hindi , marathi)
String responseYes[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_responsePositive.wav" ,ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_responsePositive.wav"};
// array for no response (hindi , marathi)
String responseNo[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_responseNegative.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_responseNegative.wav"};
String msgs[] = {"Yes", "No"};
//2D array for your answer 1 row for hindi language and 2 row for marathi language
String msgClips[][] = {{ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_structured_answer_yes.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_structured_answer_no.wav"},{ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_structured_answer_yes.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_structured_answer_no.wav"}};
String noneClips[] = {ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav", ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav"};
// for redirecting on same page
String noneUrl[] = {"Response.jsp?event=NewCall&language=" + language+"&groups_id="+groups_id};
String afterDtmf[]={ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};

%>
    <c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state1 == "start" }'> 
        <%            
        
            
            CollectDtmf cd = new CollectDtmf();
            cd.setMaxDigits(1);
            cd.setTermChar("#");
            //  this if use only for hindi or marathi language
            if(Language-base!=2) {
            	
            	order_response.addPlayAudio(responseYes[Language-base]);
            	order_response.addPlayAudio(responseNo[Language-base]);
            }
            
            // this else use for english language
            else{
            	
            	order_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_responsePositive.wav");
            	order_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_responseNegative.wav");
            }
            order_response.addCollectDtmf(cd);
            session.setAttribute("state1", "responseorder");
            order_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"Response.jsp?language=" + language+"&groups_id="+groups_id); 
            out.print(order_response.getXML());
            
           
        %>
    </c:when>
    
    
    <c:when test='${param.event == "GotDTMF" || requestScope.state1 == "responseorder"}' >
                
                <%
                
               
                String number2 = request.getParameter("data");
                String Groups_id = request.getParameter("groups_id");
                System.out.println("Response="+Groups_id);
                CollectDtmf cd = new CollectDtmf();
                String number = request.getParameter("cid"); 
                //interpreting the selected option
                
                if(number2.equals("")||number2.equals(null)||number2==""||number2==null){
               
                   	 order_response.addPlayAudio(afterDtmf[Language-base]);
                	 order_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"Response.jsp?event=NewCall&language=" + language+"groups_id="+Groups_id); 
                	
                }
            
                else if(number2.equals("1")||number2.equals("2")){
                   session.removeAttribute("state1");
                   String msg = msgs[Integer.parseInt(number2)-1];
                   session.removeAttribute("state1");
                   System.out.print(number2);
                   System.out.print(msg);
                   try{
                	      // for stroing message response 
                	  MsgResponse.storeResponse(number, msg, Groups_id);
                   }
                   catch(Exception e){
                       System.out.println(e);
                       e.printStackTrace();
                      }
                  
                   if(Language-base!=2)
                	  {
                	  String url=msgClips[Language-base][Integer.parseInt(number2)-1];
                	 System.out.println(url);
                	order_response.addPlayAudio(url);
                	             	
                    
                	  }
                	  
                  else{
                	 order_response.addPlayAudio(english_response[Integer.parseInt(number2)-1]);
                  }
                  }
                
               else{
                	if(Language-base!=2)order_response.addPlayAudio(noneClips[Language-base]);
                  else 
                	order_response.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav");
                	order_response.addGotoNEXTURL(ConfigParams.getIvrslink()+noneUrl[0]);
                }
               
                out.print(order_response.getXML());
                order_response.addHangup();
                
                %>
             </c:when>
             
   
       </c:choose>
