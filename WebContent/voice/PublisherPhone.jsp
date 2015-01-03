
<%@page import="com.ozonetel.kookoo.Response,java.util.Date,com.ozonetel.kookoo.Record"%>
<%@page import= "java.sql.*"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<c:choose> 
    <c:when test='${param.event == "NewCall" }'> 
       <%
          Response audioResponse = new Response();
          String broadcastMSG=request.getParameter("broadcastMSG");
          System.out.println(broadcastMSG);
          CollectDtmf cd = new CollectDtmf();
          cd.setMaxDigits(3);
          audioResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/ForGroupId.wav");
          audioResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/NameAndAllGroup.wav");
          audioResponse.addCollectDtmf(cd);
          session.setAttribute("state", "collectdNumber");
          audioResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherPhone.jsp?broadcastMSG="+broadcastMSG); 
          out.println(audioResponse.getXML());
       %>
       
     </c:when>
     
       <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectNumber"}' >
       <%
                String number2 = request.getParameter("data");
                String broadcastMSG=request.getParameter("broadcastMSG");
                System.out.println(broadcastMSG);
                int feedbackmenu_number = Integer.parseInt(number2);
                Response kResponse1 = new Response();
              //interpreting the selected option
                if(number2.equals(null)||number2.equals("")||number2==""||number2==null){
    	        	kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/HiNotValidInput.wav");   
		        	kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherPhone.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
	             }
                 else if(feedbackmenu_number == 1)
                {
                	session.removeAttribute("state");   
                    kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherPhoneGroupId.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
                } 
                
                else if(feedbackmenu_number == 2)
                {
                    session.removeAttribute("state");
                    kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherByPhone.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
                }
                else {
                   	  kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/HiNotValidInput.wav");
                      kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"Publisher.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
                 }
                out.print(kResponse1.getXML());
                kResponse1.addHangup();
                
                %>  
              
             </c:when>
             
              
    
     </c:choose>