<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>


<c:choose> 
    <c:when test='${param.event == "NewCall" }'> 
        <%--When we get a new call,we have to prompt for voice--%>
        <%
        
                Response kResponse=new Response();
        		CollectDtmf cd = new CollectDtmf();
                cd.setMaxDigits(2);
                String group_id="";
                String caller_id = request.getParameter("caller_id");
                System.out.println(caller_id);
                String register_number = request.getParameter("register_number");
                IvrsUtilityFunctions call = new IvrsUtilityFunctions();
                try{
        		
        		String values[][]=call.getLatestBroadcastList(caller_id);
        		int size_array=values.length;
        		if(size_array>2){
        		
                 group_id=values[2][0];
               	System.out.println(group_id);
                 
               	// get the third latest broadcast message 
               	String broadcastMessage = values[2][1];
               	System.out.println(broadcastMessage);
            	kResponse.addPlayAudio(broadcastMessage);
              	               
        		}
        		else{
        			group_id ="0";
        			kResponse.addPlayText("no broadcast message");
        		}
        		
        	
            kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage_UnRegistered.jsp?event=NewCall&groups_id="+group_id+"&register_number"+register_number);  
            session.setAttribute("state", "collectdNumber");
      			 
                }
             
                catch(Exception e){
                	e.printStackTrace();
                }
                
                out.print(kResponse.getXML());
           	
        %>
    </c:when>
    
    <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
         <%   
        
         try{
        	 String registered_number = request.getParameter("register_number");
        	Response kResponse = new Response(); 
        	String Groups_id=request.getParameter("groups_id");
        	System.out.println("welcome="+Groups_id);
            String language = request.getParameter("data");
            System.out.println("value="+language);
            String callerID= request.getParameter("caller_id");
            //interpreting the selected option
           if(language.equals(null)||language.equals("")||language==""||language==null){
        	   kResponse.addPlayText("please enter any digit");
        	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PreviousNextBroadcast_UnRegistered.jsp?event=NewCall&language="+language+"&register_number"+registered_number);
        	   
           }
          
            // if user press 1 , 2 or 3 
           else if(language.equals("1") || language.equals("2") || language.equals("3")){
        	  
        	   System.out.println(ConfigParams.getIvrslink()+"Language.jsp?event=NewCall&language="+language+"&groups_id="+Groups_id);
            	 kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language.jsp?event=NewCall&language="+language+"&groups_id="+Groups_id);
               }
           else {
            	   kResponse.addPlayText("this is not valid number");
            	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PreviousNextBroadcast_UnRegistered.jsp?event=NewCall&language="+language+"&register_number"+registered_number);
                 }
     
        	   out.print(kResponse.getXML());
               
            }    
            
         
        catch(Exception e){
        	e.printStackTrace();
        }
            %>
    </c:when>
    </c:choose>
