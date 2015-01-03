<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.ozonetel.kookoo.CollectDtmf"%>
 <%@page import= "java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>

<%

Response cancel_response = new Response();
cancel_response.setFiller("yes");
String language = request.getParameter("language");
String groups_id=request.getParameter("groups_id");
System.out.println("cancleOrder=="+groups_id);
CollectDtmf cd = new CollectDtmf();
cd.setMaxDigits(5);
cd.setTermChar("#");
cd.setTimeOut(4000);
char Language = language.charAt(0);
char base = '1';

IvrsMenuSettings im = new IvrsMenuSettings();
String cancel_order = im.getSemiStructured(1, 1, 2, 0, "opt_2");
String order_cancelled = "your Question has been canceled.";

String CancelQn[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_semi_structured_three.wav", ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_semi_structured_three.wav"};
String conformClip[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_semi_structured_cancelled.wav", ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_semi_structured_cancelled.wav"};
String afterDtmf[]={ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
%>
    <c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state == "start" }'> 
        <%            
        
                             
            // for order cancel
            if(Language-base!=2) cancel_response.addPlayAudio(CancelQn[Language - base]);
            else 
           cancel_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_structured_three.wav");

            cancel_response.addCollectDtmf(cd);
            session.setAttribute("state", "cancelorder");
           // cancel_response.addGotoNEXTURL("http://qassist.cse.iitb.ac.in/RuralIvrs/voice/CancelOrderHindi.jsp");

            cancel_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"CancelOrder.jsp?language=" +language+"&groups_id="+groups_id);

            out.print(cancel_response.getXML());
        %>
    </c:when>
    
    <c:when test='${param.event == "GotDTMF" && sessionScope.state == "cancelorder"}' >
    <%
           
           session.removeAttribute("state");
           String ordernumber = request.getParameter("data");
           String Groups_id=request.getParameter("groups_id");
           System.out.println("cancleorder===="+Groups_id);
           //interpreting the selected option
           
           if (ordernumber.equals("")||ordernumber.equals(null)||ordernumber==""||ordernumber==null){
           
        	   cancel_response.addPlayAudio(afterDtmf[Language-base]);
        	   cancel_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"CancelOrder.jsp?event=NewCall&language=" + language+"&groups_id="+Groups_id);

        	   
           }
           else{
           
        	   // processorder.java is calling for order cancel
	           ProcessOrder.cancelOrder(ordernumber);
	           if(Language-base!=2) cd.addPlayAudio(conformClip[Language - base]);
	           else 
	          cd.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_structured_cancelled.wav");
	           }
           out.println(cancel_response.getXML());
    %>
    
    </c:when>
    
    </c:choose>
