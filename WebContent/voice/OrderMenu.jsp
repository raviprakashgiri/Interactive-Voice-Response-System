<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.ozonetel.kookoo.CollectDtmf"%>
 <%@page import= "java.sql.*"%>
 <%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
Response ordermenu_response = new Response();
ordermenu_response.setFiller("yes");
String groups_id = request.getParameter("groups_id");
System.out.println("OrderMenu===="+groups_id);
String language = request.getParameter("language");
char Language = language.charAt(0);
char base = '1';

// array for redirecting from this page to another page
String afterOrder[] = {"PlaceOrder.jsp?event=NewCall","CancelOrder.jsp?event=NewCall","Language.jsp?event=NewCall"};                  
String noneClip[] = {ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav", ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String afterDtmf[]={ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String noneUrl[] ={"OrderMenu.jsp?event=NewCall&language="+language+"&groups_id="+groups_id};

%>
    <c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state1 == "start" }'> 
        <%            
        
        CollectDtmf cd = new CollectDtmf();
        cd.setMaxDigits(1);
        
     // this code for order cancelation
           try {
        	   KooKooFunctions kookoofunction = new KooKooFunctions();
               String value_orderCancel = kookoofunction.getOrderValue();

            		   
                	// order cancelation is disable
                	
                	if(value_orderCancel.equals("0")){
                	ordermenu_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"PlaceOrder.jsp?event=NewCall&language=" + language+"&groups_id="+groups_id);

                	}
                 // order cancelation is enable      	
                    else{
                    	
                   switch(Language-base){
                    case 0:
                       
                      ordermenu_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_semi_structured_one.wav");
                      ordermenu_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_semi_structured_two.wav");
                      ordermenu_response.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/hi_go_back_main.wav");
                      break;
                    
                    case 1:
                                     
                          ordermenu_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_semi_structured_one.wav");
                          ordermenu_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_semi_structured_two.wav");
                          ordermenu_response.addPlayAudio(ConfigParams.DEFAULTWAV+"default_wav/mr_go_back_main.wav");
                        break;
                    
                    case 2:
                     
                        ordermenu_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_structured_one.wav");
                        ordermenu_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_structured_two.wav");
                        ordermenu_response.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_go_back_main.wav");
                        break;
                    }
                    
                    ordermenu_response.addCollectDtmf(cd);
                    session.setAttribute("state1", "orderfunction");
                    ordermenu_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"OrderMenu.jsp?language=" + language+"&groups_id="+groups_id);
                    System.out.println(ConfigParams.getIvrslink()+"OrderMenu.jsp?language=" + language+"&groups_id="+groups_id);
                }
           }
        catch(Exception e){
        	
        	e.printStackTrace();
        }
            
     out.print(ordermenu_response.getXML());
            
           
        %>
    </c:when>
    
    
    <c:when test='${param.event == "GotDTMF" || requestScope.state1 == "orderfunction"}' >
                
                <%
                
                String Groups_id=request.getParameter("groups_id");
                System.out.println("OrderMenu=="+Groups_id);
                String ordermenu_number= request.getParameter("data");
                session.removeAttribute("state1");
                //interpreting the selected option
                
                if(ordermenu_number.equals("")||ordermenu_number.equals(null)||ordermenu_number==null||ordermenu_number==""){
                	
                	ordermenu_response.addPlayAudio(afterDtmf[Language-base]);
                	ordermenu_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"OrderMenu.jsp?event=NewCall&language=" + language+"&groups_id="+Groups_id);
             
                }
                
              //interpreting the selected option
              else  if(ordermenu_number.equals("1") || ordermenu_number.equals("2")|| ordermenu_number.equals("3"))
                {
                    session.removeAttribute("state1");
                    ordermenu_response.addGotoNEXTURL(ConfigParams.getIvrslink()+afterOrder[Integer.parseInt(ordermenu_number)-1] + "&language=" + language+"&groups_id="+Groups_id);
                }
                
                else{
                	
                	ordermenu_response.addPlayAudio(noneClip[Language - base]); 
               	    ordermenu_response.addGotoNEXTURL(ConfigParams.getIvrslink()+noneUrl[0]);
                }
                out.print(ordermenu_response.getXML());
                
                %>
             </c:when>
             
   
       </c:choose>
