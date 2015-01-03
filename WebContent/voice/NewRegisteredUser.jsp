<%@page import="com.ozonetel.kookoo.Dial"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import= "java.sql.*"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
 
<c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state == "start" }'> 
        <%  
        
             Response UserResponse = new Response();
            CollectDtmf cd = new CollectDtmf();
            cd.setMaxDigits(11);
            cd.setTermChar("#");
            // wait 10 sec for user input
            cd.setTimeOut(10000);
          
            UserResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_unregister_mobileNumber.wav");
            UserResponse.addCollectDtmf(cd);
            session.setAttribute("state", "collectNumber");
            UserResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"NewRegisteredUser.jsp");
            out.print(UserResponse.getXML());
        %>
    </c:when>
    
     <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectNumber"}' >
        <%           
            String register_number = request.getParameter("data");
            int length = register_number.length();
            
            Response InputResponse = new Response();
            CollectDtmf cd = new CollectDtmf();
            // check that register_number is null or less then 10 
            if (register_number == null || register_number.equals("")||length<10) {
            	InputResponse.addPlayText("you have not entered any input");
                session.setAttribute("state", "start");
            }
            
            else {         
             		
            	KooKooFunctions kookoofunction = new KooKooFunctions();
             	String result = kookoofunction.MemberCheck(register_number);
               
	            if(result.equals("true")){
	            String  group_id="";
	            String member_id="";
	            String group_name="";
            
               	 String data[] =kookoofunction.getGlobalSettingValue().split(",");
                 String broadcast_call_values = data[0];
                 String welcomeMsgPath = data[1];
                 String Previous_broadcast = data[2];
                 String repeat_broadcast = data[3];
                
            	try{
            	if(welcomeMsgPath!=null){
            		InputResponse.addPlayAudio(welcomeMsgPath);
            	}
            	else{
            		InputResponse.addPlayText("No welcome message");
            	}
            	}
            	catch(Exception e){
            		System.out.println(e);
            	}
            	
            	if(broadcast_call_values.equals("1")){
                	IvrsUtilityFunctions call = new IvrsUtilityFunctions();
                	try{
                	String values[] = call.getGroupsIdBroadcastMessageFromCallerId(register_number).split(",");
                	group_id=values[0];
                	System.out.println(group_id);
                   	String broadcastMessage = values[1];
                   	System.out.println(broadcastMessage);
                   	if(broadcastMessage.equals("No broadcast message"))
                   	{
                       		 InputResponse.addPlayText(broadcastMessage);
                       		 InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage_UnRegistered.jsp?event=NewCall&register_number="+register_number+"&groups_id="+group_id);
                             System.out.println("MenuLanguage_UnRegistered.jsp?event=NewCall&register_number="+register_number+"&groups_id="+group_id); 	
                   	}
                   	else{
                	InputResponse.addPlayAudio(broadcastMessage);
                	
                	if(Previous_broadcast.equals("0") && repeat_broadcast.equals("0")){
                		
                		InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage_UnRegistered.jsp?event=NewCall&groups_id="+group_id+"&register_number="+register_number);
                		System.out.println("MenuLanguage_UnRegistered.jsp?event=NewCall&groups_id="+group_id+"&register_number="+register_number); 
                		session.setAttribute("state", "collectdNumber");
                	}
                	else if(Previous_broadcast.equals("0") && repeat_broadcast.equals("1")){
                		
                		InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"RepeatBroadcastMessage_UnRegistered.jsp?event=NewCall&groups_id="+group_id+"&register_number="+register_number);
               		    session.setAttribute("state", "collectdNumber");
                		
                	}
                	else if(Previous_broadcast.equals("1") && repeat_broadcast.equals("1")){
                		
                		InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PreviousRepeatBroadcastMessage_UnRegistered.jsp?event=NewCall&groups_id="+group_id+"&register_number="+register_number);
                  		 session.setAttribute("state", "collectdNumber");
                   		
                	}
                   	
                	else if(Previous_broadcast.equals("1") && repeat_broadcast.equals("0")){
                		
	                	InputResponse.addPlayText("Do you want to hear the first previous broadcast message press 1 otherwise press 2");
	                    InputResponse.addCollectDtmf(cd);
	                    InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Welcome.jsp?groups_id="+group_id+"&caller_id="+register_number);
	                    session.setAttribute("state", "collectdNumber");
                	}
                	else{
                		
                		 InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage_UnRegistered.jsp?event=NewCall&groups_id="+group_id+"register_number="+register_number);
                   		 session.setAttribute("state", "collectdNumber");
                	}
                   	
                   	
                   	}}
                	catch(Exception e){
                		System.out.print(e);
                	}
                	}
                	/**
                	if Latest broadcast message is disable
                	**/
                	else{
                	   
                		 InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+0);	
                         session.setAttribute("state", "collectdNumber");
                	}
                  }
   
                }
                
                out.print(InputResponse.getXML());
              
              
             %>
            </c:when>
          
  
    </c:choose>