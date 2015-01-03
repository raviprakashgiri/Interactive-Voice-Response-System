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
        <%--When we get a new call,we have to prompt for voice--%>
        <%
            Record record = new Record();
            //give unique file name for each recording
            record.setFileName("kookoo_audio" + new Date().getTime());
            // file format is wav
            record.setFormat("wav");
           
        	record.setMaxDuration(9000000000000000000l);
            request.getSession().setAttribute("state", "recorded");
            Response kookooResponse1 = new Response();
            kookooResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/RecordBoarcastMsg.wav");
            kookooResponse1.addRecord(record); 
            kookooResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"Publisher.jsp"); 
            out.print(kookooResponse1.getXML());
            
        %>
    </c:when>
    
    <c:when test='${param.event == "Record" && sessionScope.state == "recorded"}' >
        <%
        
        Response audioResponse = new Response();
        
        CollectDtmf cd = new CollectDtmf();
        cd.setMaxDigits(3);
  
        audioResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/HiRecordedBMsgIs.wav");
        audioResponse.addPlayAudio(request.getParameter("data"));
        String broadcastMSG=request.getParameter("data");
        audioResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/ByPhone.wav");
        audioResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/ByComputer.wav");
        audioResponse.addCollectDtmf(cd);
        session.setAttribute("state", "collectdNumber");
        audioResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Publisher.jsp?event=GotDTMF&broadcastMSG="+broadcastMSG); 
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
        	         kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"Publisher.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
                  }
                                  // for phone
                 else if(feedbackmenu_number == 1){
                   	 session.removeAttribute("state");   
                	 kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherPhone.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
                 } 
                                // for computer
                else if(feedbackmenu_number == 2)
                {
                    session.removeAttribute("state");
                    kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherByComputer.jsp?event=NewCall&broadcastMSG="+broadcastMSG);
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