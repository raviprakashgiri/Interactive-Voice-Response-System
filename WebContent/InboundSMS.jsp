<!DOCTYPE html>

<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="java.sql.ResultSet"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/Main.css">
        <link rel="stylesheet" type="text/css" href="css/inbox-layout.css">

</head>
<body>
<%

if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{ 
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
	requestDispatcher.forward(request, response);  

}
%>
        <span id="bar-name" class="bar-name"></span>
	
		<table>
		<tr>
			<th>DATE</th>		
			<th>MEMBER</th>
			<th>MESSAGE</th>
			<th>COMMENTS</th>
		</tr>
	   </table>
</body>
</html>