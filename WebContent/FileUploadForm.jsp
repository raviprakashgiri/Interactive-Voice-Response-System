<!DOCTYPE html >

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.iitb.globals.*"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 	<script src="js/jquery-1.9.1.js"></script>
  	<script src="js/1.10.4.jquery-ui.js"></script>
  	
  	<link rel="stylesheet" href="css/jquery-ui.css">
 	<link rel="stylesheet" href="css/Main.css">
	
	<title>Add Groups</title>
 </head>
 
<script type="text/javascript" src="js/Validate.js"></script>

<body >
<% try{
	String fileName = request.getParameter("fileName");
	String language = request.getParameter("ln");
%>
	<div id="uploadDialog">
 		<form ENCTYPE="multipart/form-data" action="IvrsServletMulti2" method="POST" name="new_file_upload" id="newfileupload" onsubmit="return SaveSettings();">
		<p>File Uploading...</p>
		<div class="fileupload">
	          <input type="file" name="file_upload" id="file_upload"/> 
       	</div>
		<table>
		<tr>
		<td><input type="hidden" name="req_type" id = "req_type" value="">
			<input type="hidden" name="fileName" id = "fileName" value="<%=fileName%>">
			<input type="hidden" name="ln" id = "ln" value="<%=language%>">
		</td>
        	<td><input type="submit" value="Upload" /></td>
		</tr>
		<tr class="style-tr"></tr>
		</table>
		</form>
	</div> 
	<%
	}
	catch(Exception e){
		e.printStackTrace();
		//redirects to error page in case of exception 
		 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Error.html");  
	     requestDispatcher.forward(request, response); 
	}
	%>
</body>
</html>
