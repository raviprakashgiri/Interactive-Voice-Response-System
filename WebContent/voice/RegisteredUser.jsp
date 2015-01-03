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
            UserResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"RegisteredUser.jsp");
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
            
            String getWelcomeMsgQuery="SELECT broadcast_call,welcome_msg_location FROM globalsettings"; // To get welcome msg path 
            ResultSet welcomeMsgQueryResult=DataService.getResultSet(getWelcomeMsgQuery);
            
            if(welcomeMsgQueryResult.next()){
            	String broadcast_call_values=welcomeMsgQueryResult.getString("broadcast_call");
            	String welcomeMsgPath=welcomeMsgQueryResult.getString("welcome_msg_location");
            	try{
            	if(welcomeMsgPath!=null){
            		InputResponse.addPlayAudio(welcomeMsgPath);
            	}
            	else{
            		InputResponse.addPlayText("No welcome message");
            	}
            	}
            	catch(Exception e){
            		
            	}
            	
            	if(broadcast_call_values.equals("0")){
                	IvrsUtilityFunctions call = new IvrsUtilityFunctions();
                	try{
                
                    String values[] = call.getGroupsIdBroadcastMessageFromCallerId(register_number).split(",");
                    group_id=values[0];
                	System.out.println(group_id);
                	
                   	String broadcastMessage = values[1];
                   	System.out.println(broadcastMessage);
                	InputResponse.addPlayAudio(broadcastMessage);
                    InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language_UnRegisteredUser.jsp?event=NewCall&register_number="+register_number+"&groups_id="+group_id);
                    session.setAttribute("state", "collectdNumber");
               	
                	}
                	catch(Exception e){
                		System.out.print(e);
                	}
                	}
                	else{
                	
                 
                	 InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language_UnRegisteredUser.jsp?event=NewCall&register_number="+register_number+"&groups_id="+0);
                	 session.setAttribute("state", "collectdNumber");
                	
                	}
                  }
                
                }
                
                }
                
                out.print(InputResponse.getXML());
              
              
             %>
            </c:when>
          
  
    </c:choose>