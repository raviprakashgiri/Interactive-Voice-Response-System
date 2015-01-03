<!DOCTYPE html>

<!-- 
Document : WellInformation.jsp
Modified By : Nachiketh(Conversion to MVC)
 -->
 
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Login Update</title>
	
	<script type="text/javascript" type="jsjquery-latest.js"></script>
	<script type="text/javascript" src="js/Validate.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/Main.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">
	
	<link rel="stylesheet" type="text/css" href="css/Main.css" />
	<link rel="stylesheet" href="css/jquery-ui.css" />
	
	<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/Validate.js"></script>

<script>
	window.location.hash = "no-back-button";
	window.location.hash = "Again-No-back-button";//again because google chrome don't insert first hash into history
	window.onhashchange = function() {
		window.location.hash = "no-back-button";
	}
	
	$(function() {
		
	    $( "#tabs" ).tabs();
	});
</script>
</head>

<body >
	<%
		try {
			String pass = (String) session.getAttribute("pass");
	%>
	<div class="tabs" id="tabs">
	<ul >	<li><a href="#updatelogincredential">Update Login Credential </a>
		</li>
				</ul>
		<div class="container" style="margin-top:30px;">
			<form name="login"
				action="IvrsServlet" method="POST" class="form-horizontal">
				<div class="form-group">
					<label for="" class="control-label"><b>Username:
							&nbsp;&nbsp;</b></label>
					<div class="col-lg-10">
						<input type="text" name="user1" id="username" class="table-input-1"
							placeholder="USERNAME" required />
					</div>
				</div>
				<div class="form-group">
					<label for="" class="control-label"><b>Old
							Password:&nbsp;&nbsp;</b></label>
					<div class="col-lg-10">
						<input type="password" name="pass1" class="form-control"
							id="password1" placeholder="PASSWORD" required />
					</div>
				</div>

				<div class="form-group">
					<label for="password" class="control-label"><b>New
							Password:&nbsp;&nbsp;</b></label>
					<div class="col-lg-10">
						<input type="password" name="pass2" class="form-control"
							id="password2" placeholder="PASSWORD" required />
					</div>
				</div>

				<div class="form-group">
					<label for="password" class="control-label"><b>Retype
							New Password: &nbsp;&nbsp;</b></label>
					<div class="col-lg-10">
						<input type="password" name="pass3" class="form-control"
							id="password3" placeholder="PASSWORD" required />
					</div>
				</div>

				<div class="form-group-update">
					<div class="col-lg-offset-2 col-lg-10">
						<input type="hidden" value="Submit"> <input type="hidden"
							name="req_type" value="updateVerifyPassword" />
						<button style="margin-left: 110px;" type="submit"
							class="add-button">Update Password</button>
					</div>
				</div>


			</form>
			<form name="login" action="IvrsServlet" method="POST"
				class="form-horizontal">
				<br> <br>
				<div class="form-group">
					<label for="" class="control-label"><b>Old Username :
							&nbsp;&nbsp;</b></label>
					<div class="col-lg-10">
						<input type="text" name="user1" id="username" class="form-control"
							placeholder="USERNAME" required />
					</div>
				</div>

				<div class="form-group">
					<label for="" class="control-label"><b>New Username :
							&nbsp;&nbsp;</b></label>
					<div class="col-lg-10">
						<input type="text" name="user2" id="username" class="form-control"
							placeholder="USERNAME" required />
					</div>
				</div>

				<div class="form-group">
					<label for="" class="control-label"><b>Password :
							&nbsp;&nbsp;</b></label>

					<div class="col-lg-10">
						<input type="password" name="pass1" class="form-control"
							id="password1" placeholder="PASSWORD" required />
					</div>
				</div>

				<div class="form-group-update">
					<div class="col-lg-offset-2 col-lg-10">
						<input type="hidden" value="Submit"> <input type="hidden"
							name="req_type" value="updateVerifyUserName" />
						<button style="margin-left: 110px;" type="submit"
							class="add-button">Update UserName</button>
					</div>
				</div>

			</form>
		</div>
	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("Error.html");
		}
	%>
</body>
</html>
