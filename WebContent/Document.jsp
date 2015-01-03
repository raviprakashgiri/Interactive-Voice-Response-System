<!DOCTYPE html>
<!-- 
Document: Document.jsp
-->
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>User Login</title>
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/Main.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">
	
	<script type="text/javascript">
		window.location.hash="no-back-button";
		window.location.hash="Again-No-back-button";//again because google chrome don't insert first hash into history
		window.onhashchange=function(){window.location.hash="no-back-button";}
	</script> 
</head>

<body class="" style="background-size: cover;
background-position: top center !important;
background-repeat: no-repeat !important;
background-attachment: fixed;background-image:url(img/blue1.jpg);">
<%
	session.invalidate();
%>

	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<div class="brand">Educational I.V.R.S.</div>
			</div>
		</div>
	</div>
	
	<div class="hero-unit1">
		<div class="container">
			<div class="container-inner-document">
				<bold>Contact-Number - 022-33578383</bold><br><br><br/>
				<a href = "Download\students.pdf" target="_blank" style="color:black;">User Guide for Educational IVRS for Students</a>
				<br><br/>
				<a href = "Download\experts.pdf" target="_blank" style="color:black;">User Guide for Educational IVRS for Experts</a>
				<br>		
			</div>
		</div>
	</div>
</body>
</html>
