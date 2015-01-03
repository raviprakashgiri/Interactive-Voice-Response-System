<!DOCTYPE html >

<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.iitb.globals.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Child Activities</title>
	<script src="js/jquery-1.10.1.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/Validate.js"></script>
	
	<link rel="stylesheet" href="css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">
	<link rel="stylesheet" type="text/css" href="css/Main.css">

<script>
$(function() {
    $("#tabs").tabs();
    $(".sub-tabs").tabs();
});

var lowerBound=-10;
function getData(req_type,org_id){
	
	lowerBound+=10;
	
	$.ajax({
		url: 'IVRSDataServlet',
		data: {'req_type':req_type,'lowerBound':lowerBound,'org_id':org_id},
		type: 'POST',
		success: function(resp){
			$("#"+req_type+" > table").append(resp);
		}
	});
	return false;
}
function resetLowerBound(){
	lowerBound=-10;
	$("table > tbody").html("");
}
</script>
</head>

<body style="background-image:url(img/back-new-6.jpg);">
<%
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher rd=request.getRequestDispatcher("Login.jsp");  
    rd.forward(request, response); 
}
%>
		<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="navbar-inner" style="height:60px;">
				<div id="container" >
					<div class="brand">&nbsp; Educationalal I.V.R.S. </div>
					<div class="brand" style="font-size:1.2em;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IVRS Number :<%=ConfigParams.getKookoonumbertodisplay() %></div>
					<div class="brand" style="font-size:1.2em;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IVRS Customer SMS Number : 0-922-750-7512<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(please enter
				the 0)
					</div>
					<ul class="nav pull-right">
					<li><a href="Login.jsp"><i class="icon-eject icon-white"></i> Sign Out</a></li>
					<!-- <li><a href=""><i class="icon-question-sign icon-white"></i> About </a></li> -->
				</ul>
			</div>
		</div>
	</div>
	</div>
	<div class="content" style="margin-top:8%;height:400px;">
		<div id=tabs>
			<ul>
				<%
       String getALlChildrenQuery="SELECT member_name,org_id FROM organization WHERE parent_org='"+loginUser.getOrg_id()+"';";
       try{
       ResultSet allChildrenResultSet=DataService.getResultSet(getALlChildrenQuery);
       while(allChildrenResultSet.next()){
    	   String child_id=allChildrenResultSet.getString(2);
    	   String member_name=allChildrenResultSet.getString(1);
       %>
				<li><a href="#<%=child_id %>"><%=member_name %></a></li>
				<%
       }//end of 1st while
       %>
			</ul>
			<%
       allChildrenResultSet.beforeFirst();
       while(allChildrenResultSet.next()){
    	   String child_id=allChildrenResultSet.getString(2);
    	%>
			<div id="<%=child_id %>">
				<!-- Start of sub tabs -->
				<div class="sub-tabs">
					<ul>
						<li><a href="#inbox-<%=child_id %>"
							onclick="resetLowerBound(); getData('inbox',<%=child_id %>);">Inbox</a></li>
						<li><a href="#accepted-<%=child_id %>"
							onclick="resetLowerBound(); getData('accepted',<%=child_id %>);">Accepted</a></li>
						<li><a href="#rejected-<%=child_id %>"
							onclick="resetLowerBound(); getData('rejected',<%=child_id %>);">Rejected</a></li>
						<li><a href="#broadcast-<%=child_id %>"
							onclick="resetLowerBound(); getData('broadcast',<%=child_id %>);">Broadcast Calls</a></li>
					</ul>
					<div id="inbox-<%=child_id %>">
						<table>
							<tbody>
							</tbody>
						</table>
						<br>
						<button onclick="return getData('inbox',<%=child_id %>);">View More</button>
					</div>
					<div id="accepted-<%=child_id %>">
						<table>
							<tbody>
							</tbody>
						</table>
						<br>
						<button onclick="return getData('accepted',<%=child_id %>);">View More</button>
					</div>
					<div id="rejected-<%=child_id %>">
						<table>
							<tbody>
							</tbody>
						</table>
						<br>
						<button onclick="return getData('rejected',<%=child_id %>);">View More</button>
					</div>
					<div id="broadcast-<%=child_id %>">
						<table>
							<tbody>
							</tbody>
						</table>
						<br>
						<button onclick="return getData('broadcast',<%=child_id %>);">View More</button>
					</div>
				</div>
				<!-- End of sub tabs -->
			</div>
			<%
       }//end of 2st while
       }catch(Exception e){
    	   e.printStackTrace();
       }
       %>
		</div>
	</div>
</body>
</html>