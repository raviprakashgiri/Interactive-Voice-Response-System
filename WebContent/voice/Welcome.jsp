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

<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>

<%
Response kResponse = new Response();
kResponse.setFiller("yes");

//IvrsUtilityFunctions call = new IvrsUtilityFunctions();
%>
<c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state == "start" }'> 
        <%            
                    
                    //take the information from kookoo
                    
            CollectDtmf cd = new CollectDtmf();
            cd.setMaxDigits(2);
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
        	Calendar cal = Calendar.getInstance();
        	cal.getTime();
        	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        	System.out.println( sdf.format(cal.getTime()) );
        	
        	//Getting info on the group to which caller belongs
        	if(caller_id.length()>10){
        		caller_id=caller_id.substring(1);
        	}
      
        	// check that caller_id belong to as publisher or not
        	String publisher_query="Select publisher_id from publisher where publisher_number like '%"+caller_id+"';";
			ResultSet publisher=DataService.getResultSet(publisher_query);
            
			// if yes 
            if(publisher.next()){
            	
           	kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Publisher.jsp?event=NewCall");
            }
			
			
			//if no then again check called_id belong to as a member
            else {
            	
           	String query="SELECT * FROM member WHERE member_number LIKE '%"+caller_id+"';";
           	System.out.println(query);
            ResultSet rs=DataService.getResultSet(query);
            
            if(rs.next()){
                String  group_id="";
                member_id="";
                rs.close();
                String group_name="";
               
                String getWelcomeMsgQuery="SELECT broadcast_call,welcome_msg_location,Previous_broadcast FROM globalsettings"; // To get welcome msg path 
                ResultSet welcomeMsgQueryResult=DataService.getResultSet(getWelcomeMsgQuery);
                
                if(welcomeMsgQueryResult.next()){
                	String broadcast_call_values=welcomeMsgQueryResult.getString("broadcast_call");
                	System.out.println("value======"+broadcast_call_values);
                	String welcomeMsgPath=welcomeMsgQueryResult.getString("welcome_msg_location");
                	System.out.println(welcomeMsgPath);
                	String Previous_broadcast=welcomeMsgQueryResult.getString("Previous_broadcast");
                	System.out.println(Previous_broadcast);
                	try{
                		// check welcome message is present 
                	if(!welcomeMsgPath.equals("")){
                		kResponse.addPlayAudio(welcomeMsgPath);
                	}            	     	
                	else{
                	kResponse.addPlayText("No new welcome message" );
                	} 
                	}catch(Exception e){
                		
                	}
                	//check broadcast message is enable 
                	if(broadcast_call_values.equals("1")){
                		
                    // call ivrsutilityfunctions.java to find out lastest broadcast message
                	IvrsUtilityFunctions call = new IvrsUtilityFunctions();
                	try{
		                	String values[] = call.getGroupsIdBroadcastMessageFromCallerId(caller_id).split(",");
		                	group_id=values[0];
		                	System.out.println(group_id);
		                   	String broadcastMessage = values[1];
		                   	System.out.println(broadcastMessage);
                   	if(broadcastMessage.equals("No broadcast message"))
                   	      {
                      		kResponse.addPlayText(broadcastMessage);
                      		kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+group_id);
                   	      }
                   	else{
                	kResponse.addPlayAudio(broadcastMessage);
                	// check that previous broadcast message is enable
                    if(Previous_broadcast.equals("1"))
                            {
                			  kResponse.addPlayText("Do you want to hear the first previous broadcast message press 1 otherwise press 2");
                	          kResponse.addCollectDtmf(cd);
                  			  kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Welcome.jsp?groups_id="+group_id+"&caller_id="+caller_id);
                              session.setAttribute("state", "collectdNumber");
                	     
                            }
                	else{
                		
                		 kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+group_id);
                   		 session.setAttribute("state", "collectdNumber");
                	}
                   	
                   	
                   	}}
                	catch(Exception e){
                		System.out.print(e);
                	}
                	}
                	else{
                	   
                		 kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+0);	
                     // kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Menu.jsp?event=NewCall&groups_id="+0);
                      session.setAttribute("state", "collectdNumber");
                	}
                	//For logging incoming calls
                	System.out.println(kookooId + caller_id+ caller_circle+ caller_operator+ group_id+ member_id+ kookoo_number);
                	ActivityLog.logIncomingCall(kookooId, caller_id, caller_circle, caller_operator, group_id,kookoo_number);
                }
                
                }
            
            // if caller_id does not belong to in member or publisher then it is redirect to the unregistered.jsp
                else{ 
                	
                	System.out.println(kookooId + caller_id+ caller_circle+ caller_operator+ 0+ 0+ kookoo_number);
                	ActivityLog.logIncomingCall(kookooId, caller_id, caller_circle, caller_operator, "0",kookoo_number);
                //	kResponse.addGotoNEXTURL("http://qassist.cse.iitb.ac.in/RuralIvrs/voice/UnRegistered.jsp?event=NewCall");
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
        	  // kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PreviousBroadcast.jsp?event=NewCall&caller_id="+callerID);
        
           }
           else if(language.equals("2")){
        	 
              	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+Groups_id);
        	  

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