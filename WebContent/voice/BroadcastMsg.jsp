<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.ozonetel.kookoo.Response,java.util.Date,com.ozonetel.kookoo.Record"%>
<%@page import= "java.sql.*"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>
<%
IvrsMenuSettings im = new IvrsMenuSettings();
String thankyou = im.getStandard(1, "thankyou_msg"); 
%>
    <c:choose>
    <c:when test='${param.event == "NewCall" }'> 
    
    
        <%            
        
        Response kResponse = new Response();
        String group_id=request.getParameter("group_id");
        System.out.println(group_id);
        String conform="SELECT * FROM groups where groups_id="+group_id;
        ResultSet run_query=DataService.getResultSet(conform);
        if(run_query.next()){
        String broadcastMSG=request.getParameter("broadcastMSG");
        System.out.println(broadcastMSG);
                    
             // Database connectivity goes here
        String caller_id=request.getParameter("cid");
        
        //for testing
        try{
       
        DownloadFile.downloadPublisherFeedback(broadcastMSG);
        
        }catch(Exception e){
            System.out.println(e);
            e.printStackTrace();
        }

        ProcessOrder.PublisherPhoneMessage(broadcastMSG, caller_id, group_id);

           kResponse.addPlayText(thankyou);
           out.print(kResponse.getXML());
           kResponse.addHangup();
        }
        else{
        	
        	kResponse.addPlayText("group number is not valid");
        	kResponse.addHangup();
        }
        %>
    </c:when>
    
    </c:choose>