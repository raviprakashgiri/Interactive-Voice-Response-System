<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
<%@page import="com.iitb.MessageModel.ActivityLog" %>
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
                    
            CollectDtmf cd = new CollectDtmf();
            cd.setMaxDigits(2);
            // terminate symbol
            cd.setTermChar("#");
            
            String kookoo_number=request.getParameter("called_number");
            System.out.println(kookoo_number);
            String caller_id=request.getParameter("cid");
            System.out.println(caller_id);
            String member_id="";
            String kookooId=request.getParameter("sid");
            System.out.println(kookooId);
        	String caller_circle=request.getParameter("circle");
            System.out.println(caller_circle);
        	String caller_operator=request.getParameter("operator");
        	   System.out.println(caller_operator);
        	
        	
        	if(caller_id.length()>10){
        		caller_id=caller_id.substring(1);
        	}
      
        	//Getting info on the group to which caller belongs
        	KooKooFunctions kookoofunction = new KooKooFunctions();
        	String result = kookoofunction.PublisherCheck(caller_id);
        	
           	if(result.equals("true")){
             	kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Publisher.jsp?event=NewCall");
            }
            else {
                 String membercheck = kookoofunction.MemberCheck(caller_id);
            if(membercheck.equals("true")){
                String  group_id="";
                member_id="";
                String group_name="";
                
                String data[] =kookoofunction.getGlobalSettingValue().split(",");
                String broadcast_call_values = data[0];
                String welcomeMsgPath = data[1];
                String Previous_broadcast = data[2];
                    
                	// when broadcast is enable
                	if(broadcast_call_values.equals("1")){
                	IvrsUtilityFunctions call = new IvrsUtilityFunctions();
                	try{
                	String values[] = call.getGroupsIdBroadcastMessageFromCallerId(caller_id).split(",");
                	group_id=values[0];
                	System.out.println(group_id);
                	// getting the latest broadcast message
                   	String broadcastMessage = values[1];
                   	System.out.println(broadcastMessage);
                   	if(broadcastMessage.equals("No broadcast message"))
                   	{
                      		kResponse.addPlayText(broadcastMessage);
                      		kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Menu.jsp?event=NewCall&groups_id="+group_id);
                   	}
                   	else{
                	kResponse.addPlayAudio(broadcastMessage);
                   	
                	// first previous broadcast is enable
                	if(Previous_broadcast.equals("1")){
		                	kResponse.addPlayText("Do you want to hear the first previous broadcast message press 1 otherwise press 2");
		                	
		                    kResponse.addCollectDtmf(cd);
		                    kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Welcome.jsp?groups_id="+group_id+"&caller_id="+caller_id);
		                    session.setAttribute("state", "collectdNumber");
                	}
                	else{
                		
	                		 kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Menu.jsp?event=NewCall&groups_id="+group_id);
	                		 session.setAttribute("state", "collectdNumber");
                	}
                   	
                   	
                   	}}
                	catch(Exception e){
                		System.out.print(e);
                	}
                	}
                	else{
                	                 
                      kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Menu.jsp?event=NewCall&groups_id="+0);
                      session.setAttribute("state", "collectdNumber");
                	}
                	//For logging incoming calls
                	ActivityLog.logIncomingCall(kookooId, caller_id, caller_circle, caller_operator, group_id,kookoo_number);
                 }
            
                else{ 
                    
                	// store in database (incoming call information)
                   	ActivityLog.logIncomingCall(kookooId, caller_id, caller_circle, caller_operator, "0",kookoo_number);
                   	kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"UnRegistered.jsp?event=NewCall");
                	
                }
                
            }    
                out.print(kResponse.getXML());
        %>
    </c:when>
   <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
        <%   
        
         try{
        	 
        	String Groups_id=request.getParameter("groups_id");
        	System.out.println("welcome="+Groups_id);
            String language = request.getParameter("data");
            System.out.println("value="+language);
            String callerID= request.getParameter("caller_id");
            //interpreting the selected option
           if(language.equals(null)||language.equals("")||language==""||language==null){
        	   kResponse.addPlayText("please enter any digit");
        	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Welcome.jsp?event=NewCall&language="+language);
        	 
           }
           else if(language.equals("1")){
        	  kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PreviousBroadcast.jsp?event=NewCall&caller_id="+callerID);
            }
           else if(language.equals("2")){
        	  kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Menu.jsp?event=NewCall&groups_id="+Groups_id);
             }
           else {
            	   kResponse.addPlayText("this is not valid number");
            	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Welcome.jsp?event=NewCall&language="+language);
           }
           out.print(kResponse.getXML());
     
            }    
            
         
        catch(Exception e){
        	System.out.println(e);
        }
            %>
    </c:when>
</c:choose>