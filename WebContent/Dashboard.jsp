<!DOCTYPE html>
<!-- 
Document : Dashboard.jsp

 -->
<%@page import="com.iitb.globals.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session"></jsp:useBean>
<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean" scope="request"></jsp:useBean>

<html>
<head>
	<title>Dashboard</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<script src="js/jquery-1.10.1.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/Validate.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>	
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
	<!--  <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />-->
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-responsive.min.css" />
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-responsive.css" />
	
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
	<link rel="stylesheet" href="css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="css/Main.css">
    <script type="text/javascript">
    
   /* $('html').click(function() {
    	   $('.dropdown-menu').hide(); 
    	});

    	$('.nav nav-tabs').click(function(event){
    	     event.stopPropagation();
    	});

    	$('#dropdown-dash').click(function(event){
    	     $('.dropdown-menu').toggle();
    	});
    	*/
    
    $(document).ready(function(){
    	$('#center-frame').show();
    	$('#left-bar').hide();
    	 
		$('#right-bar').hide();
        $('.dropdown-toggle').dropdown();
    });
	
	
	$(document).ready(function () {
		
		    $('#search-button').click(function () {
		    	var el=$('#search-box').val();
		    	
		    	el=el.trim();
		    	el=el.replace(" ","-");
		       $('.other-group').hide();
		       $('#'+el).show();
		    });
		    
		
		
		 /* $('.parent').mouseenter(function () {
			    $('#dropdown-menu-parent-group').slideDown();
			    $(".dropdown-menu:not(#dropdown-menu-parent-group").slideUp();
			  });		
		*/
		  $('.welcome').mouseenter(function () {
			  $('#welcome-user').slideDown();
			    $(".dropdown-menu:not(#welcome-user").slideUp();
			  });

		    $('.operationsList').mouseenter(function () {
			  $('#operationsList').slideDown();
			    $(".dropdown-menu:not(#operationsList").slideUp();
			  });
		
	
		  $('.pro').mouseenter(function () {
			    $('#edit-product').slideDown();
			    $(".dropdown-menu:not(#edit-product").slideUp();
			  });
		  $('.well-summary').mouseenter(function () {
			    $('#well-summary').slideDown();
			    $(".dropdown-menu:not(#well-summary").slideUp();
			  });
		  $('.sett').mouseenter(function () {
			    $('#settings').slideDown();
			    $(".dropdown-menu:not(#settings").slideUp();
		  });
		  $('.order').mouseenter(function () {
			    $('#order-sum').slideDown();
			    $(".dropdown-menu:not(#order-sum").slideUp();
		  });
		  $('.ppl').mouseenter(function () {
			    $('#people').slideDown();
			    $(".dropdown-menu:not(#people").slideUp();
		  });
		  
		  $('.groups').mouseenter(function () {
			    
			    $(".dropdown-menu:not(#groups").slideUp();
		  });
		  
		  $('.publisher').mouseenter(function () {
			    $('#publisher').slideDown();
			    $(".dropdown-menu:not(#publisher").slideUp();
		  });
			    
			    $('#edit-product').mouseleave(function () {
			    $('#edit-product').slideUp();
			  });
		  $('#well-summary').mouseleave(function () {
			    $('#well-summary').slideUp();
			  });
		  $('#settings').mouseleave(function () {
			    $('#settings').slideUp();
			  });
		  $('#order-sum').mouseleave(function () {
			    $('#order-sum').slideUp();
			  });
		  $('#people').mouseleave(function () {
			    $('#people').slideUp();
			  });
		  $('#welcome-user').mouseleave(function () {
			    $('#welcome-user').slideUp();
			  });
		  $('#operationsList').mouseleave(function () {
			    $('#operationsList').slideUp();
			  });
		  $('#publisher').mouseleave(function () {
			    $('#publisher').slideUp();
			  });

		  
		  /*$('#dropdown-menu-parent-group').mouseleave(function () {
			  $('#dropdown-menu-parent-group').slideUp();
			  });*/
		  
	
	    $('#groups').click(function () {
	        $('#center-frame').hide();
	        $('#left-bar').show();
	       // $('#right-bar').show();
	    });
			  $('.group-options').click(function () {
			        //$('#center-frame').hide();
			       // $('#left-bar').show();
			        $('#right-bar').show();
			    });  
	    $('#send-email').click(function(){
	    	 $('#right-bar').show();
	    	
	    });
	
	    $('#options-pro').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-well').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-mem').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-pub').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-ord').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-full').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-log').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-sys').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-bill').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-eng').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-mar').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-hin').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });
	    $('#options-group').click(function () {
	    	$('#center-frame').show();
	    	$('#left-bar').hide();
	        $('#right-bar').hide();
	        
	    });

        $( "#all-groups" ).accordion({ collapsible: true });
        $( "#all-groups-new" ).accordion({ collapsible: true });

	    
	});
	
	
</script>
<style>
.dropdown-toggle{
color:white;
opacity:1;
}
/*
.dropdown-menu {
    display:none;
}
*/
.dash{
height:20px;
position:relative;
z-index:2;
 
}

.dash ul li{
opacity:100%;
font-color:red;

}
.dash ul li a{
color:white;
align:left;

}
.dash ul li ul li a{
color:white;
align:left;
position:relative;
z-index:2;
}
/*.dash ul li ul li a:hover{
background-color:cadetblue;
}
*/
.dash ul li ul li ul li a{
text-decoration: none;

}

.dash ul li ul li ul li:hover{
background-color:cadetblue;
}
/*.other-groups li ul li{
position:relative;
z-index:2;
}
.inner-dash{
/*margin-top:62px;



.panel-body{
position:relative;
z-index:10;
overflow:visible;
}*/
.other-group{
position:relative;
}
#my-frame{
max-height:70%;

}
body.myframe {
	scrollbar-arrow-color: #ffffff;
	scrollbar-track-color: #ffffff;
	scrollbar-face-color: #ffffff;
	scrollbar-highlight-color: #ffffff;
	scrollbar-shadow-color: #ffffff;
	scrollbar-3dlight-color: #ffffff;
	scrollbar-darkshadow-color: #ffffff;
	filter: chroma (color=#ffffff);
}
#tabs { overflow:hidden;height:934px; }
#tabs:hover { overflow-y:auto; }




</style>

<%
Object group1[][]=groupBean.getGroup_details();
String array="[";
String str[] = new String[group1.length];
if(group1!=null){
for(int i=0;i<group1.length;i++){
	
	str[i] = group1[i][1].toString();
	array=array+"'"+str[i]+"',";
}
array=array+"'']";
}
String st = "Hello";
String st2 = "Bye";
%>


<script type="text/javascript" src="js/efpTypeahead.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>

		<script type="text/javascript">
		

		$(function() {
			startSearchBox($("input.input1"), [{id:1, text:"the text to display", category:"warning"},{id:3, text:"third text to display", category:"warning"},{id:2, text:"second text to display", category:"notification"}], function(item) {
   				 alert(item.text || item);
				});
				
				
				
				var str=<%=array%>
				
				$("input.form-control").typeahead({
					source : str
				});
		});
			
		function getGroupIdInDivision(groupId){
			var groupIdJavaScript;
			groupIdJavaScript=groupId;
	
			var linkVoiceMessage=document.getElementById("linkVoiceMessage");
			linkVoiceMessage.setAttribute("href","IvrsServlet?groupId="+groupIdJavaScript+"&req_type=voiceMessage");
			
			var linkVoice=document.getElementById("linkVoice");
			linkVoice.setAttribute("href","IvrsServlet?groupId="+groupIdJavaScript+"&req_type=voice");
			
			var linkTextMessage=document.getElementById("linkTextMessage");
			linkTextMessage.setAttribute("href","IvrsServlet?groupId="+groupIdJavaScript+"&req_type=textMessage");
			
			var linkOutgoingMessage=document.getElementById("linkOutgoingMessage");
			linkOutgoingMessage.setAttribute("href","IvrsServlet?groupId="+groupIdJavaScript+"&req_type=outgoingMessage");
			
			var linkManage=document.getElementById("linkManage");
			linkManage.setAttribute("href","IvrsServlet?groupId="+groupIdJavaScript+"&req_type=manage");
			
			
			var sideMenu=document.getElementById("side-menu");
			sideMenu.setAttribute("visibility","visible");
		}
		
		function mailing()
		{
			location.href="Email.jsp?#right-iframe&req_type=normal";
		}
		</script>

		<style type="text/css">
			.efp-dropdown-menu {
				background-clip: padding-box;
				background-color: rgb(255, 255, 255);
				border: 1px solid rgba(0, 0, 0, 0.2);
				border-radius: 6px 6px 6px 6px;
				box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
				display: none;
				float: left;
				left: 0;
				list-style: none outside none;
				margin: 2px 0 0;
				min-width: 100px;
				padding: 5px 0;
				position: absolute;
				top: 100%;
				z-index: 1000;
				
			}
			.efp-dropdown-menu li {

			}
			.efp-dropdown-menu li.active {
				background-color: rgb(0, 129, 194);
				background-image: -moz-linear-gradient(center top , rgb(0, 136, 204), rgb(0, 119, 179));
				background-repeat: repeat-x;
			}

			.efp-dropdown-menu li a, .efp-dropdown-menu li a:active, efp-dropdown-menu li a:hover {
				color: #000000;
				clear: both;
				display: block;
				font-weight: normal;
				line-height: 20px;
				padding: 3px 20px;
				white-space: nowrap;
				text-decoration: none;
			}
			.efp-dropdown-menu li:active a, efp-dropdown-menu li:hover a {

			}
			.efp-typeahead-li.active {

			}

			.efp-typeahead-li.active a, .efp-typeahead-li.active a:hover, .efp-typeahead-li.active a:focus, .efp-typeahead-li a, .efp-typeahead-li a:hover, .efp-typeahead-li a:focus, .dropdown-submenu:hover a {
				background: none;
			}
		</style>






</head>
<body class="" style="background-size: cover;
background-position: top center;
 overflow-x: scroll;
background-repeat: no-repeat;
background-attachment: fixed;background-image:url(img/back-new-6.jpg);" >

<%
// Validates the user on loading the page
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
     requestDispatcher.forward(request, response);  

}
try{
	String username=loginUser.getUsername();
	String parentOrg=loginUser.getParent_org();
	String parentName =loginUser.getParent_name();
	String orgId=loginUser.getOrg_id();
	System.out.println("orgId "+orgId);
	%>
	<br>
	<br>
	<!-- start of Welcome message to User -->
	<!-- div class="hero-unit"-->
		
		
	<!-- end of Welcome message to user -->
	
		<div class="navbar navbar-inverse navbar-fixed-top"  >
			<div class="navbar-inner" style="height:23%">
				<div id="container" >
					<div class="brand">&nbsp; Educational I.V.R.S. </div>
					<div class="brand" style="font-size:1.1em;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IVRS Number :<%=ConfigParams.getKookoonumbertodisplay() %></div>
					<div class="brand" style="font-size:1.1em;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IVRS Student SMS Number : 0-922-750-7512<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(please enter
				the 0)
					</div>
					<ul class="nav pull-right">

		<li class="dropdown" style="width:100%;"><a href="#" class="dropdown-toggle welcome"data-toggle="dropdown"><span class=" icon-th-list"></span>&nbsp;&nbsp;&nbsp; Welcome <%=username%></a>
<ul  id="welcome-user"class="dropdown-menu" role="menu" aria-labelledby="dLabel" >
				
				<li>
						<a  href="GroupActivities.jsp" target="_blank">View all Group Activities
						<br></br></a>
					</li>
					<%if(loginUser.getParent_org().toString().equals("0")){ %>
					<li>
						<a  href="ChildActivities.jsp" target="_blank">Child login Activities
						<br></br></a>
					</li>
		<%} %>
						<li><a href="IvrsServlet?req_type=signout"><b>Sign out</b></a></li>
						<!-- <li><a href="GlobalSettings.jsp" target="_blank">Settings <i class="icon-cog icon-white"></i></a></li> -->
					</ul>
			
		</li>
		</ul>
				</div>
			</div>
		</div>
		
		
		<div class="dash" id="dash-1" style="margin-top:20px;min-width:100%">
		<!-- div class="dash-upper" style="height:62px;/*background-color:#BFFF00*/;opacity:0.6;"></div-->
	<ul class="nav nav-tabs">
		

		<li class="dropdown" id="dropdown-dash" ><a class="dropdown-toggle groups" data-toggle="dropdown" style="vertical-align:middle;" href="#" id="groups"><span class="icon-globe"></span>&nbsp;&nbsp;&nbsp; Groups<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </a>
			<ul id="groups-down" class="dropdown-menu " role="menu" aria-labelledby="dLabel" style="max-height:0px;">
			</ul>		
		</li>

		<!--  >li class="dropdown" id="dropdown-dash"><a href="#" class="dropdown-toggle pro" data-toggle="dropdown" ><span class="icon-edit"></span>&nbsp;&nbsp;&nbsp; Product Details <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;( उत्पाद विवरण )</a>
			<ul id="edit-product" class="dropdown-menu " role="menu" aria-labelledby="dLabel" style="color:white;">
				<li><a  id="options-pro" title="Update New Product/Quantity/Price" href='IvrsServlet?req_type=productForm'	target='content-iframe'>Edit Product Details <br> ( संपादित उत्पाद विवरण )</a></li>
			</ul>
		</li>
		<!-- 
		<li class="dropdown" id="dropdown-dash" ><a href="#" class="dropdown-toggle well-summary"data-toggle="dropdown"><span class=" icon-tint"></span>&nbsp;&nbsp;&nbsp;  Well Summary<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( कुआं सारांश) &nbsp;</a>
		<ul id="well-summary"class="dropdown-menu ">
			<li><a  id="options-well"title="View Well Information" href='IvrsServlet?req_type=wellsummary' target='content-iframe'>Well Summary Report<br> ( सारांश रिपोर्ट )</a></li>
		</ul>
		</li>-->
		<!-- >li class="dropdown" id="dropdown-dash" ><a href="#" class="dropdown-toggle order" data-toggle="dropdown"><span class=" icon-shopping-cart"></span>&nbsp;&nbsp;&nbsp; Order Summary <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;( ऑर्डर सारांश )</a>
		<ul id="order-sum" class="dropdown-menu " role="menu" aria-labelledby="dLabel">
			<li><a id="options-ord" title="View Summary of Orders Placed" href='IvrsServlet?req_type=datePick' target='content-iframe'>Product Wise Orders<br>( उत्पाद अनुसार ऑर्डर )</a></li>
			<li><a id="options-group" title="View Summary of Orders Placed in a Group" href='IvrsServlet?req_type=groupDatePick' target='content-iframe'>Group Wise Orders<br>( समूह अनुसार ऑर्डर )</a></li>
			<li><a id="options-full" title="View All Orders Placed" href='IvrsServlet?req_type=fullReportDate' target='content-iframe'>Full Order Summary<br>( पूर्ण  ऑर्डर सारांश )</a></li>
		</ul>
		</li-->
		<li class="dropdown" id="dropdown-dash" ><a href="#"  class="dropdown-toggle ppl"
			data-toggle="dropdown" ><span class="icon-user" ></span>&nbsp;&nbsp;&nbsp;Students Settings <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<ul id="people"class="dropdown-menu " role="menu" aria-labelledby="dLabel">
			<li><a id="options-mem" title="Update Groups of All Members" <% out.print( "href='IvrsServlet?req_type=globalGroupChange&groupId=0' target='content-iframe'");%>>Students</a></li>
			
		</ul>
		</li>
		<li class="dropdown" id="dropdown-dash" ><a href="#"  class="dropdown-toggle publisher"
			data-toggle="dropdown"><span class="icon-user"></span>&nbsp;&nbsp;&nbsp; Experts &nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;</a>
		<ul id="publisher"class="dropdown-menu " role="menu" aria-labelledby="dLabel">
		<li><a id="options-pub" title="Update All Publishers" <% out.print( "href='IvrsServlet?req_type=publish&groupId=0' target='content-iframe'");%>>Experts</a></li>
		</ul></li>
		<li class="dropdown" id="dropdown-dash" ><a href="#"  id="options" class="dropdown-toggle sett"
			data-toggle="dropdown"><span class=" icon-cog"></span>&nbsp;&nbsp;&nbsp; General Settings <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<ul id="settings"class="dropdown-menu " role="menu" aria-labelledby="dLabel">
			<li><a id="options-log" href='UpdateLoginCredential.jsp' target='content-iframe'>Update Login Credentials <br> </a></li>
			<li><a id="options-sys" title="Update Incoming/Outgoing Call Settings" href='IvrsServlet?req_type=settings' target='content-iframe'>System Settings</a></li>
			<!-- li><a id="options-bill" title="Update Bill Format" <% out.print("href='IvrsServlet?req_type=billSettings' target='content-iframe'");%>>Bill Layout Settings<br> ( बिल सेटिंग्स )</a></li-->
			<li><a  href="#">Ivrs Menu Settings<br> </a>
			<ul style="list-style:none;margin-left:35px;text-decoration: none;">
				<li ><a  style="text-decoration: none;" id="options-eng" href='IvrsServlet?ln=en&req_type=ivrsMenuSettings' target='content-iframe'><span class="icon-chevron-right"></span>&nbsp;&nbsp;&nbsp; English &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </a></li>
				<li><a  style="text-decoration: none;" id="options-hin" href='IvrsServlet?ln=hi&req_type=ivrsMenuSettings' target='content-iframe'><span class="icon-chevron-right"></span> &nbsp;&nbsp;&nbsp;Hindi &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </a></li>
				<li><a  style="text-decoration: none;" id="options-mar" href='IvrsServlet?ln=mr&req_type=ivrsMenuSettings' target='content-iframe'><span class="icon-chevron-right"></span>&nbsp;&nbsp;&nbsp; Marathi  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			</ul>
		</ul>
		</li>
		
	</ul>
</div>


	<div class="content-dash">
	<div  id="center-frame" style="margin-left:15%;margin-right:15%;margin-top:5%;opacity:0.8;height:90%;border-radius:6px;">
<iframe name="content-iframe"  id="my-frame" style="height:90%;border-radius:6px;"   ></iframe>
</div>
	<div id="left-bar" class="left-bar" style="margin-top:5%;max-height:90%;border-radius:6px;">
<div class="groups">
<!-- newer display 
<div id="side-menu" style="position:fixed;left:198px;top:133px;">
<ul>
		<li class="dropdown" id="dropdown-dash" style="width:60px;height:40px;border-radius:4px;opacity:1;"><a href="#"  id="options" class="dropdown-toggle operationsList" style="text-decoration:none;vertical-align:sub;font-family:calibri;font-size:smaller"
			data-toggle="dropdown"><span>&nbsp;&nbsp;&nbsp;Go To</span></a>
		<ul id="operationsList"class="dropdown-menu " role="menu" aria-labelledby="dLabel">
			<li><a title="View and Manage All Voice Messages" id='linkVoiceMessage'
							 target='right-iframe'>Voice Message Response<br>(आवाज संदेश प्रतिक्रिया)
						</a></li>							
						<li><a title="Broadcast Voice/Text Messages" id="linkVoice"
							 target='right-iframe'>Broadcast<br>(प्रसारण)
						</a></li>
						<li><a title="Manage Call/Members of Group" id="linkManage"
							 target='right-iframe'>Manage<br>(प्रबंधित)
						</a></li>
						<li><a title="View and Manage All Text Messages" id="linkTextMessage"
							 target='right-iframe'>Text Message Response<br>(पाठ संदेश प्रतिक्रिया)
						</a></li>
					    <li><a title="View all Outgoing Text Messages of Group" id="linkOutgoingMessage"
					    	 target='right-iframe'>Outgoing SMS<br>(जाने वाले संदेश)
					    </a></li>

		</ul>
		</li>

</ul>
</div>
<!--  ends here-->

<div class="panel panel-default" >
  <div class="panel-heading" ><b>Parent Group &nbsp;&nbsp;</b></div>
  <div class="panel-body" >
  <div id="all-groups"class="all-groups">
  <h3>Parent Group&nbsp;</h3>
 <div  class="group-content">
				<ul class="group-options">
					<li><a title="View and Manage All Voice Messages"
						<% out.print("href='IvrsServlet?groupId=0&req_type=voiceMessage' target='right-iframe'"); %>>Voice Message Response<br>
						</a>
					</li>
					<li><a title="Broadcast Voice/Text Messages"
						<% out.print("href='IvrsServlet?groupId=0&req_type=voice' target='right-iframe'"); %>>Broadcast<br>
						</a>
					</li>
					<li><a title="Manage Call/Members of Group"
						<% out.print("href='IvrsServlet?groupId=0&req_type=manage' target='right-iframe'"); %>>Manage<br>
						</a>
					</li>
					<li><a title="View and Manage All Text Messages"
						<% out.print("href='IvrsServlet?groupId=0&req_type=textMessage' target='right-iframe'"); %>>Text Message Response<br>
						</a>
					</li>
					 <li><a title="View all Outgoing Text Messages of Group"
					    	<% out.print("href='IvrsServlet?groupId=0&req_type=outgoingMessage' target='right-iframe'"); %>>Outgoing SMS<br>
					 </a></li>
				</ul>
			</div>
			</div>
			</div>
</div>

<div class="panel panel-default" >

  <div class="panel-heading"><b>Other Groups &nbsp;&nbsp;</b></div>

  <div class="panel-body">
  <div class="other-groups">
	<!-- <div class="navbar form-group">
	    <table>
	    <tr >
	    <td ><input type="text" id="search-box" data-provide="typeahead" class="form-control" placeholder="Search" style="height:20px;width:110px" autocomplete="off"></td>
	   
	  <td><button type="button" id="search-button" style="height:30px" class="btn btn-default"> <!-- onClick="window.location = document.getElementById('search-box').value;"Go</button></td>
	  </tr>
	  </table>
	 </div-->
  	<div id="all-groups-new" class="all-groups-new">
				<%
					// Contains list of groups present in the organization
					Object group[][]=groupBean.getGroup_details();
					Integer i;
					System.out.println("in dashboard before groups");
					if(group!=null){
					for(i=0;i<group.length;i++){
				%>
				<h3><%=group[i][1]%></h3>
				<div class="group-content" scrolling="no"><!-- start of group divison -->
					<ul class="group-options" >
						<li><a title="View and Manage All Voice Messages"
							<% out.print("href='IvrsServlet?groupId="+group[i][0]+"&req_type=voiceMessage' target='right-iframe'"); %>>Voice Message Response<br>
						</a></li>							
						<li><a title="Broadcast Voice/Text Messages"
							<% out.print("href=IvrsServlet?req_type=voice&groupId="+group[i][0]+" target='right-iframe'"); %>>Broadcast<br>
						</a></li>
						<li><a title="Manage Call/Members of Group"
							<% out.print("href='IvrsServlet?groupId="+group[i][0]+"&req_type=manage' target='right-iframe'"); %>>Manage<br>
						</a></li>
						<li><a title="View and Manage All Text Messages"
							<% out.print("href='IvrsServlet?groupId="+group[i][0]+"&req_type=textMessage' target='right-iframe'"); %>>Text Message Response<br>
						</a></li>
					    <li><a title="View all Outgoing Text Messages of Group"
					    	<% out.print("href='IvrsServlet?groupId="+group[i][0]+"&req_type=outgoingMessage' target='right-iframe'"); %>>Outgoing SMS<br>
					    </a></li>
					      
					</ul>
					
				</div><!-- end of group division -->
				<% 	}// end of for loop
					}// end of if condition
               	%>
			</div>   
			</div>
    </div>
     </div>
     </div>
			<br>
			<button id="create-group" class="btn btn-info " name="create" onClick="">Create New Group<br> </button>
			&nbsp;
			<button id="send-email" class="btn btn-info" name="email" ><a title="Send Email" <% out.print("href='Email.jsp?req_type=normal' target='right-iframe'"); %>>Send Email<br></a></button>
		</div>
		<!--  extra testing for side menu
		 -->

		<!-- 
	<div id="side-menu">
		<ul >		
			<li><a title="View and Manage All Voice Messages" id='linkVoiceMessage'
							 target='right-iframe'>Voice Message Response<br>
						</a></li>							
						<li><a title="Broadcast Voice/Text Messages" id="linkVoice"
							 target='right-iframe'>Broadcast<br>(प्रसारण)
						</a></li>
						<li><a title="Manage Call/Members of Group" id="linkManage"
							 target='right-iframe'>Manage<br>(प्रबंधित)
						</a></li>
						<li><a title="View and Manage All Text Messages" id="linkTextMessage"
							 target='right-iframe'>Text Message Response<br>(पाठ संदेश प्रतिक्रिया)
						</a></li>
					    <li><a title="View all Outgoing Text Messages of Group" id="linkOutgoingMessage"
					    	 target='right-iframe'>Outgoing SMS<br>(जाने वाले संदेश)
					    </a></li>
					    
				</ul>
		</div>
		 -->
		<!-- ends here  -->



<!-- New display -->
<!-- 	<div id="side-menu">
	<ul class="nav nav-tabs">
		
		<li ><a title="View and Manage All Voice Messages"  style="vertical-align:middle;" id='linkVoiceMessage'target='right-iframe'>Voice Message Response<br>(आवाज संदेश प्रतिक्रिया)</a>
					</li>
						<li><a title="Broadcast Voice/Text Messages"  style="vertical-align:middle;" id="linkVoice"
							 target='right-iframe'>Broadcast<br>(प्रसारण)
						</a></li>
						<li><a title="Manage Call/Members of Group" style="vertical-align:middle;" id="linkManage"
							 target='right-iframe'>Manage<br>(प्रबंधित)
						</a></li>
						<li><a title="View and Manage All Text Messages" style="vertical-align:middle;" id="linkTextMessage"
							 target='right-iframe'>Text Message Response<br>(पाठ संदेश प्रतिक्रिया)
						</a></li>
					    <li><a title="View all Outgoing Text Messages of Group" style="vertical-align:middle;" id="linkOutgoingMessage"
					    	 target='right-iframe'>Outgoing SMS<br>(जाने वाले संदेश)
					    </a></li>
					    
</ul>
</div>
 -->

<!-- ends here -->



	<div id='right-bar' class="right-bar" style="margin-right:2%;margin-top: 5%;;opacity:0.8;border-radius:6px;position:relative;z-index:-1;">
			<iframe  name="right-iframe" src="" style="max-height:90%;height:90%;border-radius:6px" ></iframe>


		</div>
	<div id="create-group-form" class="create-group-form"> 
		<p>Create New Group</p>
		<br>
		<form action="IvrsServlet" method="POST">
			<label>Please enter Group Name: 
				<input type="text" name="groupName" id="newGroup" >
			</label> 
			<input type="hidden" name="req_type" value="newGroup" /> 
			<br>
			<br>
			<input type="submit" style="background-color:cadetblue;" value="Create Group" onsubmit="success()" />
		</form>
	</div><!-- end of create group dialog 
	-->
	</div>
	<script>
	$( "#create-group-form" ).dialog({ autoOpen: false });
    $( "#create-group" ).click(function() 
    {
        $( "#create-group-form" ).dialog( "open" );
    });
   
</script>
	<%
	}
	catch(Exception e){
		e.printStackTrace();
		//redirects to error page in case of exception 
		response.sendRedirect("Error.html");
	}
	%>
</body>
</html>