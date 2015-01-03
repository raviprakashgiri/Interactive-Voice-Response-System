<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.ozonetel.kookoo.Response,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:choose>
 		<c:when test='${param.event == "NewCall"}'> 
		<%
		Response kResponse = new Response();
		kResponse.addPlayText("This is a broadcast message");
		String caller_id=request.getParameter("cid");
		System.out.println("MessageURL on jsp cid : "+caller_id);
// 		kResponse.addPlayAudio(msgURL);
// 		kResponse.addGotoNEXTURL("http://qassist.cse.iitb.ac.in/RuralIvrs/voice/Welcome.jsp?event=NewCall");
		
		kResponse.addPlayText("Thank you");		
		out.print(kResponse.getXML());
		
		%>
		</c:when>
</c:choose>