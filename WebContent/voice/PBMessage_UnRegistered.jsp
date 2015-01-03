
<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
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
    String register_number = request.getParameter("register_number");
    String groups_id = request.getParameter("groups_id");
    System.out.println(groups_id);
    String caller_id = request.getParameter("caller_id");
    System.out.println(caller_id);
    Response audioResponse = new Response();
    CollectDtmf cd = new CollectDtmf();
    cd.setMaxDigits(3);
    cd.setTimeOut(8000);
    audioResponse.addPlayText("Press 1 for listen to the Previous broadcast message");
    audioResponse.addCollectDtmf(cd);
    session.setAttribute("state", "collectdNumber");
    audioResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PBMessage_UnRegistered.jsp?groups_id="+groups_id+"&caller_id="+caller_id+"&register_number="+register_number); 
    out.println(audioResponse.getXML()); 
    %>
        
    </c:when>
     <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
        <%   
        
         try{
        	 
        	String registered_number = request.getParameter("register_number"); 
        	String Groups_id=request.getParameter("groups_id");
        	System.out.println("repeatBroadcastmsgg="+Groups_id);
        	 String callerID= request.getParameter("caller_id");
        	 System.out.println("repeatmsg=="+callerID);
            String language = request.getParameter("data");
            System.out.println("value="+language);
  
            //interpreting the selected option
           if(language.equals(null)||language.equals("")||language==""||language==null){
        	  
        	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"MenuLanguage_UnRegsitered.jsp?event=NewCall&groups_id="+Groups_id+"&register_number="+registered_number);
        	 
           }
           else if(language.equals("1")){
        	   
        	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PreviousBroadcast_UnRegistered.jsp?event=NewCall&caller_id="+callerID+"&register-number="+registered_number);
           	}
          
           else {
            	   kResponse.addPlayText("this is not valid number");
               	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PBMessage_UnRegistered.jsp?event=NewCall&groups_id="+Groups_id+"&caller_id="+callerID+"&register_number="+registered_number);
               }
           out.print(kResponse.getXML());
     
        	   
               
            }    
            
         
        catch(Exception e){
        	System.out.println(e);
        }
            %>
    </c:when>
    </c:choose>