<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<%
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher rd=request.getRequestDispatcher("Login.jsp");  
    rd.forward(request, response);
}
String username=loginUser.getUsername();
String org_id=loginUser.getOrg_id();

String content = "<select name='selectedGroup'  id='selectedGroup' style='width:auto'>"+
				"<option value='selectGroup'>--Select Group--</option>";
String getGroupsList = "SELECT groups_id,groups_name FROM groups WHERE groups_id NOT IN (0) AND org_id=1";
ResultSet rs = DataService.getResultSet(getGroupsList);
String groups_id= "";
String groups_name= "";
	while(rs.next()){
		groups_id = rs.getString("groups_id");
		groups_name = rs.getString("groups_name");
	content  = content+"<option value='"+groups_id+"'>"+groups_name+"</option>";
}
	content = content+"</select>";
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Group Activities</title>
	<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">
	<link rel="stylesheet" type="text/css" href="css/Main.css">
	
	<!-- jQuery -->
	<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
	
	<!-- DataTables -->
	<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	
	<script type="text/javascript">
	
	    $(function() {
	        $( "#tabs" ).tabs();
	        getData('inbox');
	    });
	</script>
	
	
	<!--  Java Script Added -->
	<script type="text/javascript" src="js/Validate.js"></script>
	
	
	<script>
	  $(function() {
		  $( "#broadcast-call-dialog" ).dialog({
		    	resizable: false,
		    	height:450,
		    	width:500,
		    	autoOpen: false,
		    	modal: true,
		    });
	  });
	</script>
</head>
<body style="background-image:url(img/back-new-6.jpg);background-repeat:no-repeat;min-height:100%;">
	<input type="hidden" name="content" id = "content" value="<%=content%>"/> 
	<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="navbar-inner" style="height:60px;">
				<div id="container" >
					<div class="brand">&nbsp; Educational I.V.R.S. </div>
					<div class="brand" style="font-size:1.2em;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IVRS Number :<%=ConfigParams.getKookoonumbertodisplay() %></div>
					<div class="brand" style="font-size:1.2em;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IVRS Students SMS Number : 0-922-750-7512<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(please enter
				the 0)
					</div>
					<ul class="nav pull-right">
					<li><a href="Login.jsp"><i class="icon-eject icon-white"></i> Sign Out</a></li>
					<!--  <li><a href=""><i class="icon-question-sign icon-white"></i> About </a></li>-->
				</ul>
			</div>
		</div>
	</div>


	
	<div class="content" style="opacity:0.7;margin-top:8%;">
		<div id="tabs">
			<ul>
				<li><a href="#inbox" onclick="getData('inbox')">Inbox</a></li>
				<!-- <li><a href="#accepted" onclick="getData('accepted')">Accepted(स्वीकार)</a></li> -->
				<li><a href="#rejected" onclick="getData('rejected')">Rejected</a></li>
				<li><a href="#broadcast" onclick="getData('broadcast')">Broadcast Calls</a></li>
			</ul>
			<div id="inbox">
			    <table>
				</table>
				<br>
			</div>
			<div id="accepted">
				<table>
					<tbody>
					</tbody>
				</table>
				<br>
			</div>
			<div id="rejected">
				<table>
					<tbody>
					</tbody>
				</table>
				<br>
			</div>
			<div id="broadcast">
				<table>
					<tbody>
					</tbody>
				</table>
				<br>
			</div>
		</div>
	</div>
	<div id="broadcast-call-dialog" class="broadcast-call-dialog">
    </div>
	<script type="text/javascript">

function getData(req_type){
	 var tableData;
	    $.ajax({
	       url:'IVRSDataServlet',
	       type: 'POST',
	       data:{'req_type':req_type,'dataTable':'true','org_id':<%=(org_id)%>},
	       dataType:'json',
	       success: function(data){
	           tableData=data;
	           
	           if(req_type=='broadcast'){
	        	   $('#'+req_type+' > table').dataTable( {
	   	            "aaData": tableData,
	   	            "aoColumns": [
	   	            { "sTitle": "Date-Time" },
	   	            { "sTitle": "Group Name" },
	   	            { "sTitle": "Publisher Name" },
	   	         	{ "sTitle": "Audio File" },
	   	         	{ "sTitle": "Link" },
	   	           	{ "sTitle": "Broadcast" }
	   	         	
	   	            
	   	        	]	        
	   	    		} );
	           }
	          $('#'+req_type+' > table').dataTable( {
	            "aaData": tableData,
	            "aoColumns": [
	            { "sTitle": "Date-Time" },
	            { "sTitle": "Group Name" },
	            { "sTitle": "Message ID" },
	            { "sTitle": "Mem Name" },
	            { "sTitle": "Audio File" },
	            { "sTitle": "Status" },
	            { "sTitle": "Comments" },
	        	]	  
	         
	    		} );
	       }
	    });
}
</script>
</body>
</html>