<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.ozonetel.kookoo.CollectDtmf"%>
 <%@page import= "java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.iitb.globals.ReadPropertyFile" %>


<%
Response kResponse = new Response();
// for music
kResponse.setFiller("yes");

%>
<c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state == "start" }'> 
    <%
    String groups_id = request.getParameter("groups_id");
    System.out.println(groups_id);
    String caller_id = request.getParameter("caller_id");
    System.out.println(caller_id);
    Response audioResponse = new Response();
    CollectDtmf cd = new CollectDtmf();
    // collect maximum 3 digit from userside
    cd.setMaxDigits(3);
    // wait 5 sec for user input
    cd.setTimeOut(5000);
    audioResponse.addPlayText("Press 1 for listen to the Broadcast Message again");
    audioResponse.addCollectDtmf(cd);
    session.setAttribute("state", "collectdNumber");
    audioResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"RepeatBroadcastMessage.jsp?groups_id="+groups_id+"&caller_id="+caller_id); 
    out.println(audioResponse.getXML()); 
    %>
        
    </c:when>
    <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
        <%   
        
         try{
        	 
        	String Groups_id=request.getParameter("groups_id");
        	System.out.println("repeatBroadcastmsgg="+Groups_id);
        	 String callerID= request.getParameter("caller_id");
        	 System.out.println("repeatmsg=="+callerID);
            String language = request.getParameter("data");
            System.out.println("value="+language);
  
            //interpreting the selected option
           if(language.equals(null)||language.equals("")||language==""||language==null){
        	  
        	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+Groups_id);
        	 
           }
           else if(language.equals("1")){
        	   
        	   IvrsUtilityFunctions call = new IvrsUtilityFunctions();
           	try{
           	String values[] = call.getGroupsIdBroadcastMessageFromCallerId(callerID).split(",");
            // get the group_id according to broadcast message
           	String group_id=values[0];
           	System.out.println(group_id);
           	
           	// get the latest broadcast message 
              	String broadcastMessage = values[1];
              	System.out.println(broadcastMessage);
              	if(broadcastMessage.equals("No broadcast message"))
              	{
                 	kResponse.addPlayText(broadcastMessage);
                  	kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+Groups_id);
              	}
              	else{
			         kResponse.addPlayAudio(broadcastMessage);
			         kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+Groups_id);
              	}
        
           }
           	catch(Exception e){
           		System.out.println(e);
           	}
           }
          
           else {
            	   kResponse.addPlayText("this is not valid number");
               	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"RepeatBroadcastMessage.jsp?event=NewCall&groups_id="+Groups_id+"&caller_id="+callerID);
               }
           out.print(kResponse.getXML());
   
            }    
            
         
        catch(Exception e){
        	System.out.println(e);
        }
            %>
    </c:when>
</c:choose>