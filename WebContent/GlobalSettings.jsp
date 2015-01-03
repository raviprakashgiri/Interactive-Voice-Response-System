<!DOCTYPE html >
<!--
Document : GlobalSettings.jsp
-->
<%@page import="com.iitb.globals.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session"></jsp:useBean>

<html>
<head>
<title>Global Settings</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="js/jquery-1.10.1.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/Validate.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">
	<link rel="stylesheet" type="text/css" href="css/Main.css">
	
<script type="text/javascript">
    $(document).ready(function()
    {    
        $("iframe").height($(document).height()-100);
        $(".group-header").click(function(){
            var elem=$(this).next();
            $(this).next().slideToggle();
        });
        $( "#all-groups" ).accordion({ collapsible: true });  
    }); 
   </script>
</head>

<body>
<%
//validating user on loading the file
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{ 
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
	requestDispatcher.forward(request, response);  
}
try{
%>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
			<div class="brand">Interactive Voice Forum  </div>
				<ul class="nav pull-right">
					<li><a href="IvrsServlet?req_type=signout"><b>Sign out</b></a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="hero-unit" style="margin-top:50px;">
		<div class="container">
			<table>
			<tr><td><b>Welcome <%=loginUser.getUsername()%></b></td></tr>
			<tr><td>IVRS Number is: <b><%=ConfigParams.getKookoonumbertodisplay() %></b></td></tr>
			</table>	
		</div>
	</div>
	<% 
		String groupId = "0";
		String orgId=loginUser.getOrg_id();
		String parentOrg=loginUser.getParent_org();
	%>
	<div class="left-bar">
		<span id="bar-name" class="bar-name">Settings</span>
		<div id="all-groups" class="all-groups">
			<h3>Global Settings</h3>
			<div class="group-content">
				<ul class="group-options">
					<li>
					<a title="Update Groups of All Members" <%out.print( "href='IvrsServlet?req_type=globalGroupChange&group_id="+groupId+"' target='content-iframe'");%>>Global Group Change</a>
					</li>
					<li>
					<a title="Update All Publishers" <%out.print( "href='IvrsServlet?req_type=publish&group_id="+groupId+"&parent_org="+parentOrg+"' target='content-iframe'");%>>Publisher</a>
					</li>
					<li>
					<a title="Update Incoming/Outgoing Call Settings" href='IvrsServlet?req_type=settings' target='content-iframe'>Setting</a>
					</li>
					<li>
					<a href='IvrsServlet?ln=en&req_type=IvrsMenuSettings' target='content-iframe'>English IVRS Menu Settings</a>
					</li>
					
					<li>
						<a href='IvrsServlet?ln=hi&req_type=IvrsMenuSettings' target='content-iframe'>Hindi IVRS Menu Settings</a>
					</li>
					<li>
						<a href='IvrsServlet?ln=mr&req_type=IvrsMenuSettings' target='content-iframe'>Marathi IVRS Menu Settings</a></li>
				    
				    <li>
				    	<a href='UpdateLoginCredential.jsp' target='content-iframe'>Update UserName/Password</a>
				    </li> 
                    <li>
                    	<a title="Update New Product/Quantity/Price" href='IvrsServlet?req_type=productForm'	target='content-iframe'>Product Form</a>
					</li> 
				 	<li>
				 		<a title="View Well Information" href='IvrsServlet?req_type=wellsummary' target='content-iframe'>Well Information</a>
				 	</li>  
					<li>
						<a title="Update Bill Format" <% out.print("href='IvrsServlet?req_type=billSettings' target='content-iframe'");%>>Bill Settings</a>
					</li>
					<li>
						<a title="View Summary of Orders Placed" href='IvrsServlet?req_type=datePick' target='content-iframe'>Order Summary</a>
					</li>
					<li>
					 	<a title="View All Orders Placed" href='IvrsServlet?req_type=fullReportDate' target='content-iframe'>Full Report </a>
					</li>
				</ul>
			</div>
         	<h3>Parent Group&nbsp;<%//=group_name%></h3>  
			<div class="group-content">
				<ul class="group-options">
					<li><a title="View and Manage All Voice Messages"
						<% out.print("href='IvrsServlet?groupId="+groupId+"&req_type=voiceMessage' target='content-iframe'"); %>>Voice Message Response<br>
						</a>
					</li>
					<li><a title="Broadcast Voice/Text Messages"
						<% out.print("href='IvrsServlet?req_type=voice&group_id="+groupId+"' target='content-iframe'"); %>>Broadcast<br>
						</a>
					</li>
					<li><a title="Manage Call/Members of Group"
						<% out.print("href='IvrsServlet?group_id="+groupId+"&req_type=manage' target='content-iframe'"); %>>Manage<br>
						</a>
					</li>
					<li><a title="View and Manage All Text Messages"
						<% out.print("href='IvrsServlet?groupId="+groupId+"&req_type=textMessage' target='content-iframe'"); %>>Text Message Response<br>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="right-bar">
		<iframe name="content-iframe" src=""></iframe>
	</div>
    <%
	}

	catch(Exception e)
	{
		e.printStackTrace();
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("Error.html");  
        requestDispatcher.forward(request, response); 
	}
	%>
</body>
</html>