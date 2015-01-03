<!DOCTYPE html>

<!-- 
Document : GroupOrderSummary.jsp

 -->


<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.WellinfoBean.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="productBean" class="com.iitb.ProductBean.ProductBean"
	scope="request"></jsp:useBean>
<jsp:useBean id="orderBean" class="com.iitb.OrderBean.OrderBean"
	scope="request"></jsp:useBean>
<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean"
	scope="request"></jsp:useBean>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript" src="js/jquery-latest.js"></script>

<script src="js/jquery-1.10.1.min.js"></script>
<script src="js/ajax.query.min.js"></script>
<script type="text/javascript" src="js/Validate.js"> </script>
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="css/bootstrap-responsive.css" />
<link rel="stylesheet" type="text/css" href="css/Main.css" />




<script type="text/javascript">  


    
    

	$(function() {
		$("#tabs").tabs();
		
	});
	/*
	$(document)
			.ready(
					function() {
						$(".view-all").click(function() {

							$(".display-members").toggle('blind', {}, 500);
						});

						$('#selectAll').click(function(event) {

							var selected = this.checked;
							// Iterate each checkbox
							$(':checkbox').each(function() {
								this.checked = selected;
								console.log($(this).val());
							});

						});
						$("#sms-message").keyup(function() {
							var remLen = 160 - $(this).val().length;
							if (remLen >= 0) {
								$("#chars-remaining").text(remLen);
							} else {
								$("#chars-remaining").text("Limit exceeded");
								$(this).val($(this).val().substring(0, 160));
							}
						});

						$("#tags")
								// don't navigate away from the field on tab when selecting an item
								.bind(
										"keydown",
										function(event) {
											if (event.keyCode === $.ui.keyCode.TAB
													&& $(this).data(
															"ui-autocomplete").menu.active) {
												event.preventDefault();
											}
										})
								.autocomplete(
										{
											minLength : 0,
											source : function(request, response) {
												// delegate back to autocomplete, but extract the last term
												response($.ui.autocomplete
														.filter(
																availableTags,
																extractLast(request.term)));
											},
											focus : function() {
												// prevent value inserted on focus
												return false;
											},
											select : function(event, ui) {
												$("#selected>ul")
														.append(
																"<li class=\"list\">"
																		+ ui.item.label
																		+ ": "
																		+ ui.item.value
																		+ ";</li>_______________$tag ");
												$("#selectedNumbers").append(
														ui.item.value + ";");

												this.value = "";
												return false;
											}
										});
						$("button").click(function() {
							alert($("#selected").text());
						});
					});
	
	$(document).on("click", ".list", function() {
		console.log($(this).text());
		$(this);
	});
		
	   $('#districtview').on('change',function () {
  		var xmlhttp;   
		console.log("========================");

  		if (window.XMLHttpRequest)
  		  {// code for IE7+, Firefox, Chrome, Opera, Safari
  		  xmlhttp=new XMLHttpRequest();
  		  }
  		else
  		  {// code for IE6, IE5
  		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		  }
  		xmlhttp.onreadystatechange=function()
  		  {
  		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
  		    {
  		    document.getElementById("tehsilnames").innerHTML=xmlhttp.responseText;
  		    }
  		  };
  		  var getDistrictName = document.getElementById("districtview");
  	      var chosendistrict = getDistrictName.options[getDistrictName.selectedIndex].text;
  		xmlhttp.open("GET","IvrsServlet?req_type=namesforwell&districtname="+chosendistrict+"&findtehsil=1&findvillage=0&fromdate=0&todate=0&getWellData=0",true);
  		xmlhttp.send();
  	   });

$(document).on('click','#print-bills',function () {
	var xmlhttp;   
console.log("========================");

	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	  //  document.getElementById("tehsilnames").innerHTML=xmlhttp.responseText;
	    }
	  };
	  var getGroupName = document.getElementById("districtview");
  		 
	      var chosenGroupId = getGroupName.options[getGroupName.selectedIndex].value;
	    var chosenGroupName = getGroupName.options[getGroupName.selectedIndex].text;
	
	    
	   	 
		xmlhttp.open("GET","IvrsServlet?req_type=groupWiseBills&groupId="+chosenGroupId+"&groupName="+chosenGroupName+"&fromDate=2014-02-02&toDate=2014-02-02",true);
		xmlhttp.send();
   });
		*/
		function printbill (){
			 var getGroupName = document.getElementById("groupview");
				 
			      var chosenGroupId = getGroupName.options[getGroupName.selectedIndex].value;
			    var chosenGroupName = getGroupName.options[getGroupName.selectedIndex].text;
				   
			  	var fromDate="<%=(String)request.getParameter("fromDate")%>";
			  	var toDate="<%=(String)request.getParameter("toDate")%>";
			    var url="IvrsServlet?req_type=groupWiseBills&groupId="+chosenGroupId+"&groupName="+chosenGroupName+"&fromDate="+fromDate+"&toDate="+toDate+"";
			    window.open(url,'_blank');
			//window.top.location.href="IvrsServlet?req_type=groupWiseBills&groupId="+chosenGroupId+"&groupName="+chosenGroupName+"&fromDate=2014-02-02&toDate=2014-02-02";
		}	


$(document).on('change','#groupview',function () {
		var xmlhttp;   
	console.log("========================");

		if (window.XMLHttpRequest)
		  {// code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		  }
		else
		  {// code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
		    document.getElementById("groupbills").innerHTML=xmlhttp.responseText;
		    }
		  };
		  var getGroupName = document.getElementById("groupview");
	  		 
  	      var chosenGroupId = getGroupName.options[getGroupName.selectedIndex].value;
  	    var chosenGroupName = getGroupName.options[getGroupName.selectedIndex].text;
  
  	   
  	var fromDate="<%=(String)request.getParameter("fromDate")%>";
  	var toDate="<%=(String)request.getParameter("toDate")%>";
  	   
  		xmlhttp.open("GET","IvrsServlet?req_type=groupWiseBills&groupId="+chosenGroupId+"&groupName="+chosenGroupName+"&fromDate="+fromDate+"&toDate="+toDate+"",true);
  		xmlhttp.send();
	   });


</script>


</head>

<body>
	<%
		// Validating the user on loading the file
		if (loginUser.getUsername() == null
				|| loginUser.getParent_org() == null
				|| loginUser.getOrg_id() == null) {
			RequestDispatcher requestDispatcher = request
					.getRequestDispatcher("Login.jsp");
			requestDispatcher.forward(request, response);

		}
	
			try {
	%>
	<%

	// Contains list of groups 

		Object[][] groupDetails = groupBean.getGroup_details();
		System.out.println("group recived" + groupDetails.length);
	
	
						Integer i = 0;
						Integer givId = 1;// gives id for options in select tag
				%>
	<!-- Start Of  Order Summary  -->
	<div id="tabs" class="tabs">
		<ul>
			<li><a href="#groupOrder">Group Order Summary &nbsp;( समूह  ऑर्डर सारांश )</a></li>
		</ul>
		<tr>
			<td><br>&nbsp;</td>
		</tr>
		<tr class="span-prod" style="font: 1.2em;">
			<b>Choose Group&nbsp;( समूह चुनें )</b>
		</tr>
		<div id="districtnames">
			<select name="groupview" id="groupview" class="table-input-1">
				<!-- <option>Select</option> -->
				<option value='0'>Parent Group</option>
				<%
							for (i = 0; i < groupDetails.length; i++) {
						%>
				<option value="<%=groupDetails[i][0]%>"><%=groupDetails[i][1]%>
				</option>
				<%
							System.out.println("in select "+groupDetails[i][0]);
					}
						System.out.println("after selecte=ing");
						%>

			</select>
		</div>
		<div>
			<button value="Print Bills" id="print-bills" class="add-button"
				onclick="printbill()" style="align: right; margin-top: 1%;">Print
				bills &nbsp; </button>
		</div>

		<div id="groupbills"
			style="margin-left: 15%; margin-right: 15%; page-break-inside: avoid;">

		</div>




	</div>
</body>
<%
	} catch (Exception e) {
		e.printStackTrace();
		//response.sendRedirect("Error.html");
	}
%>
</html>