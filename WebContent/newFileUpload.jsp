<!DOCTYPE html >

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.iitb.globals.*"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="Validate.js"></script>
	<script type="text/javascript" src="js/1.10.4.jquery-ui.js"></script>
	
	<link rel="stylesheet" href="css/jquery-ui.css">

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<%
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
    requestDispatcher.forward(request, response);  
}
%>
<title>Add Groups</title>
</head>
<body >
  <div id="uploadDialog">
 		<form ENCTYPE="multipart/form-data" action="IvrsServlet" method="POST" name="new_file_upload" id="newfileupload">
		<p>File Uploading...</p>
		<div class="new-file-upload">
	          <input type="file" name="file_upload" id="file_upload"/> 
       	</div>
		<table>
		<tr>
			<td><input type="hidden" name="req_type" id = "req_type" value="new_file_upload"></td>
	        <td><input type="submit" value="Upload" onclick="return SaveSettings4();" /></td>
		</tr>
		<tr class="new-file-upload-tr"></tr>
		</table>
		</form>
 </div> 
</body>
</html>
