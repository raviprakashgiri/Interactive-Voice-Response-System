<!DOCTYPE html>
<!--
Document: Login.jsp
Modified By :Ravi Prakash Giri
 -->
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>


<html >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>User Login</title>
	
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/Main.css">
	<link rel="stylesheet" type="text/css" href="css/Login.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">	
	<script>
	window.location.hash="no-back-button";
	window.location.hash="Again-No-back-button";//again because google chrome don't insert first hash into history
	window.onhashchange=function(){window.location.hash="no-back-button";}
	</script> 
</head>

<body >
<%
	session.invalidate();
%>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner" style="height:60px;">
			<div class="container">
				<div class="brand" >Interactive Voice Forum</div>
				<ul class="nav pull-right">
					<!-- Redirects to IvrsServlet for Document.jsp -->
					<li ><b><a class="brand" style="color:grey;" href = "IvrsServlet?req_type=document" title="User Guide of Voice Forum I.V.R.S. System" target="_blank">User Guide</a><br>
					</b></li>
				</ul>
			</div>
		</div>
	</div>

	<div id="wrapper" style="width:inherit;">
	<form name="login" class="login-form" action="IvrsServlet"
		method="post">

		<div class="header">
			<h3>Login Into Voice Forum.</h3>
		</div>

		<div class="content">
			<input name="user" id="username" type="text" class="input username"
				placeholder="Username" required/>
			<div class="user-icon"></div>
			<input name="password" id="password" type="password" class="input password"
				placeholder="Password" required/>
			<div class="pass-icon"></div>
		</div>
		<div id="output" style="color:red; text-align:center; font-size:20px;" ></div>
		<div class="footer" align="center">
			<input type="hidden" name="req_type" value="verifyUser" />
			<button class="button" type="submit">Log In</button>
		</div>

	</form>

	</div>
<div class="gradient"></div>
			<div class="login-result">
				<%
					String auth = request.getParameter("auth");// checks if the page is being redirected after invalid login

					if (auth != null) {
						%>
						<script type="text/javascript">
						document.getElementById('output').innerHTML = "Invalid Username/Password";
						</script>
						<% 
					}
				%>
			</div>
</body>
</html>
		