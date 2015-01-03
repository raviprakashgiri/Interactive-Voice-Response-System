<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.MessageModel.ActivityLog"%>
<%@page
	import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>

<%@page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.iitb.globals.ReadPropertyFile"%>
<%@ page import="com.iitb.dbUtilities.IvrsUtilityFunctions"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>

<%
Response kResponse = new Response();
kResponse.setFiller("yes");
KooKooFunctions kookoofunction = new KooKooFunctions();

%>
<c:choose>
	<c:when
		test='${param.event == "NewCall" || sessionScope.state == "start" }'>
		<%            
                    
            CollectDtmf cd = new CollectDtmf();
            cd.setMaxDigits(2);
            cd.setTermChar("#");
            
            String kookoo_number=request.getParameter("called_number");
            System.out.println(kookoo_number);
            String caller_id=request.getParameter("cid");
            System.out.println(caller_id);
            int tym =0;
            int	timestringss=0;
            String timer = "";
            String tymm ="";
            String statess="";
            String timestrings="";
            String member_id="";
            String kookooId=request.getParameter("sid");
            System.out.println(kookooId);
        	String caller_circle=request.getParameter("circle");
            System.out.println(caller_circle);
        	String caller_operator=request.getParameter("operator");
        	System.out.println(caller_operator);
        	String GlobalSetting[]=kookoofunction.GetTimerValue().split(",");
        	timer= GlobalSetting[0];
        	System.out.println("timer[0]="+timer);
        	tymm = GlobalSetting[1];
        	tym = Integer.parseInt(tymm);
        	System.out.println("timer[1]="+tymm);
        	statess = GlobalSetting[2];
        	System.out.println("timer[2]="+statess);
        	
        		 timestrings=tymm + " " + statess;
        		if(statess.equals("PM")){
        		 
        			timestringss = tym + 12 ;
        		}
        		else{
        			 timestringss= tym ;
        		}
        	        		
        	System.out.print("hourssss=="+timestringss);
            Calendar cal = Calendar.getInstance();
   			int hour = cal.getTime().getHours();
   			int mins = cal.getTime().getMinutes();
			System.out.print("mins=="+mins);
   			System.out.print("hour=="+hour);
   			String state = "AM";
			System.out.println(hour);
			
			if(hour == 12) state="PM";
			String timeString = hour + " " + state;
			System.out.print("timeee="+timeString);
			System.out.println(hour<timestringss);
			
		//	if(hour < timestringss || timer.equals("0")){
           	
        	//Getting info on the group to which caller belongs
         
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
                String broadcast_call_values="";
                String welcomeMsgPath="";
                String Previous_broadcast="";
                String repeat_broadcast="";
             
//                kResponse.addPlayAudio("http://qassist.cse.iitb.ac.in/Downloads/RuralIvrs/audio-record/test_new.wav");
                String data[] =kookoofunction.getGlobalSettingValue().split(",");
                broadcast_call_values = data[0];
                welcomeMsgPath = data[1];
                Previous_broadcast = data[2];
                repeat_broadcast = data[3];
                          
                	try{
                	if(!welcomeMsgPath.equals("")){
                		kResponse.addPlayAudio(welcomeMsgPath);
                	}            	     	
                	else{
                	kResponse.addPlayText("No new welcome message" );
                	} 
                	}catch(Exception e){
                		
                	}
                	/**
                	If latest broadcast message is enable
                	**/
                	if(broadcast_call_values.equals("1")){
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
                	    
                	   if(Previous_broadcast.equals("0") && repeat_broadcast.equals("0")){
                		    kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+group_id);
                		    session.setAttribute("state", "collectdNumber");
                	  }
                	  else if(Previous_broadcast.equals("0") && repeat_broadcast.equals("1")){
                		    kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"RepeatBroadcastMessage.jsp?event=NewCall&groups_id="+group_id+"&caller_id="+caller_id);
               		        session.setAttribute("state", "collectdNumber");
                		
                	  }
                	  else if(Previous_broadcast.equals("1") && repeat_broadcast.equals("1")){
                		    kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PreviousRepeatBroadcastMessage.jsp?event=NewCall&groups_id="+group_id+"&caller_id="+caller_id);
                  		    session.setAttribute("state", "collectdNumber");
                   		
                	}
                   	
                	else if(Previous_broadcast.equals("1") && repeat_broadcast.equals("0")){
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
                	/**
                	if Latest broadcast message is disable
                	**/
                	else{
                	   
                		 kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+0);	
                         session.setAttribute("state", "collectdNumber");
                	}
                	
                	//For logging incoming calls
                	System.out.println(kookooId + caller_id+ caller_circle+ caller_operator+ group_id+ member_id+ kookoo_number);
                	ActivityLog.logIncomingCall(kookooId, caller_id, caller_circle, caller_operator, group_id,kookoo_number);
             //   }
                
                }
            
                else{ 
                	
                	System.out.println(kookooId + caller_id+ caller_circle+ caller_operator+ 0+ 0+ kookoo_number);
                	ActivityLog.logIncomingCall(kookooId, caller_id, caller_circle, caller_operator, "0",kookoo_number);
                  	kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"UnRegistered.jsp?event=NewCall");
                	
                }
                
           // }    
		}
			/*else {
				kResponse.addPlayText("Please call before" + timestrings);
			}*/
                out.print(kResponse.getXML());
        %>
	</c:when>
	<c:when
		test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}'>
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