<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
<%@page import="com.ozonetel.kookoo.Response,java.util.Date,com.ozonetel.kookoo.Record"%>
<%@page import= "java.sql.*"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:choose> 
    <c:when test='${param.event == "NewCall" }'> 
       <%
          Response audioResponse = new Response();
          CollectDtmf cd = new CollectDtmf();
          // collect maximum three digit from user side
          cd.setMaxDigits(3);
          String broadcastMSG=request.getParameter("broadcastMSG");
          System.out.println(broadcastMSG);
          audioResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_semi_structured_confirm.wav");
          audioResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_semi_structured_rerecord.wav");
          audioResponse.addCollectDtmf(cd);
          session.setAttribute("state", "collectdNumber");
          audioResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherByComputer.jsp?broadcastMSG="+broadcastMSG); 
          out.println(audioResponse.getXML());
       %>
       
     </c:when>
    
    <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectNumber"}' >
                   <%
                
                String number2 = request.getParameter("data");
                int feedbackmenu_number = Integer.parseInt(number2);
                String broadcastMSG=request.getParameter("broadcastMSG");
                Response kResponse1 = new Response();
              //interpreting the selected option
                if(number2.equals(null)||number2.equals("")||number2==""||number2==null){
     	        	   kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/HiNotValidInput.wav");
		        	   kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherByComputer.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
		        }
                else  if(feedbackmenu_number == 1)
                 {
                       session.removeAttribute("state");
                     // Database connectivity goes here
                      String caller_id=request.getParameter("cid");
                     
                     //for downloading 
                     try{
                     DownloadFile.downloadPublisherFeedback(broadcastMSG);
                     }catch(Exception e){
                         System.out.println(e);
                         e.printStackTrace();
                     }
                     ProcessOrder.storePublisherFeedback(broadcastMSG, caller_id);
                     kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/Thanku.wav");
                } 
             // for  re record
                else if(feedbackmenu_number == 2)
                {
                	session.removeAttribute("state");
                    kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"Publisher.jsp?event=NewCall");
                }
                
                else {
                	kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/HiNotValidInput.wav");
             	    kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherByComputer.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
                }

                out.print(kResponse1.getXML());
                kResponse1.addHangup();
                
                %>
             </c:when>
             
              
    
    
  </c:choose>