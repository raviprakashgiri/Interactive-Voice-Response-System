<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>

<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.ozonetel.kookoo.CollectDtmf"%>
 
 <%@page import= "java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.iitb.globals.ReadPropertyFile" %>
<%@ page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions" %>

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
            
            //terminat symbol
            cd.setTermChar("#");
            String callerID = request.getParameter("caller_id");
            String Groups_id = request.getParameter("groups_id");
            // make the object of IvrsUtilityFunctions
            IvrsUtilityFunctions call = new IvrsUtilityFunctions();
           	try{
           	String values[] = call.getGroupsIdBroadcastMessageFromCallerId(callerID).split(",");
            // get the group_id 
           	String group_id=values[0];
           	System.out.println(group_id);
           	
           	// get the second latest broadcast message
            String broadcastMessage = values[1];
            System.out.println(broadcastMessage);
              	if(broadcastMessage.equals("No broadcast message"))
              	{
                 		kResponse.addPlayText(broadcastMessage);
                   		kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage.jsp?event=NewCall&groups_id="+Groups_id);
              	}
              	else{
			           	kResponse.addPlayAudio(broadcastMessage);
			           	kResponse.addPlayText("press 1 for listen previous broadcast message");
			           	kResponse.addCollectDtmf(cd);
			           	kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"LatestBroadcastMessageAgain.jsp?groups_id="+Groups_id+"&caller_id="+callerID);
              	}
        
           }
           	catch(Exception e){
           		System.out.println(e);
           	}
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
           else if(language.equals("1"))
            
              {
        	   
        	    kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PreviousBroadcast.jsp?event=NewCall&caller_id="+callerID);
        	 
              }
          else if(language.equals("2"))
             {
        	 
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
