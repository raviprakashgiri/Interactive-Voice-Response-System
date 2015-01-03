<!DOCTYPE html >

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<script src="js/jquery-1.9.1.js"></script>
	<script src="js/1.10.4.jquery-ui.js"></script>
	
	<link rel="stylesheet" href="css/jquery-ui.css">
 
<title>Add Groups</title>

</head>
<link rel="stylesheet" type="text/css" href="css/Main.css" />

<script>
</script>

<body >
<%
if(loginUser.getOrg_id()==null)
{
	session.invalidate();
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
    requestDispatcher.forward(request, response);
}	
%>
<div id="uploadByPhone">
 	<h3>Please call on this number to record your order or voice.</h3>
 	<h2>02233578383</h2>		
</div> 

</body>
</html>
