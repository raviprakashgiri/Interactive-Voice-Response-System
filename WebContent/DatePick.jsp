<!DOCTYPE html>
<!-- 
Document: DatePick.jsp
Modified By : Ravi Prakash Giri
 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<script src="js/jquery-1.9.1.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/Validate.js"></script>
	
	<link rel="stylesheet" href="css/jquery-ui.css">
	<link rel="stylesheet" href="css/Main.css">

<title>Add Groups</title>
<style>
#datePicker {
	height:20%;
	width:20%;
}
</style>

</head>
<script>

	$(function() {
		$("#datePicker").dialog({
			position: [300,70],
			resizeable : false,
			height : 300,
			width : 250

		});
	});
</script>
<%
String invalid=request.getParameter("invalidDate");
if(invalid==null){
	invalid="false";
}
System.out.println("date :"+invalid);
%>
<body onload="checkvalid(<%=invalid%>)">
<%
//Validates user on loading the file
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
     requestDispatcher.forward(request, response);  
}
%>


	<div id="datePicker" >
		<form name="form" action="IvrsServlet" method="post">
		<table>
		
		<tr>
		<td>Choose Date Range :</td></tr>
		<tr>
			<td><br></td>
			</tr>
			<tr>
				<td>From</td>
			</tr>
			<tr>
				<td><input type="date" id="FromDate" name="FromDate"></td><!-- from date taken -->
			</tr>
			<tr>
			<td><br></td>
			</tr>
			<tr>
			<td>To</td>
			</tr>
			<tr>
				<td><input type="date" id="ToDate" name="ToDate"></td><!-- to date taken -->
			</tr>
			<tr>
			<td><br></td>
			</tr>
			<tr>
	<td><input type="submit" value="Submit" style="background-color:cadetblue"><input type="hidden" value="orderSummary" name="req_type"></td>
			</tr>
			
	</table>
		</form>
	</div>
		

</body>
</html>
