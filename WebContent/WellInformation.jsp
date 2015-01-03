<!DOCTYPE html>

<!-- 
Document : WellInformation.jsp
Modified By : Nachiketh(Conversion to MVC)
 -->
 
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.WellinfoBean.*"%>

<jsp:useBean id="wellinfo" class="com.iitb.WellinfoBean.WellDataBean" scope="session"></jsp:useBean>

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
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
	<link rel="stylesheet" type="text/css" href="css/Main.css" />


<%
	WellDataBean wellInfo = (WellDataBean) request
			.getAttribute("wellinfo");

	String[] districtName = wellInfo.getDistrict_name();
	String[] districtToTehsil = wellInfo.getDistrict_to_tehsil();
	String[] tehsilToVillage = wellInfo.getTehsil_to_village();
	
%>

<script type="text/javascript">  

var districtname=new Array(<%for (int q = 0; q < districtName.length; q++) {
				out.print("\"" + districtName[q] + "\"");
				if (q + 1 < districtName.length) {
					out.print(",");
				}
			}%>);


    $(document).ready(function(){
        
        $("iframe").height($(document).height()-100);
        $(".group-header").click(function(){
            var elem=$(this).next();
            $(this).next().slideToggle();

        });
        $( "#all-groups" ).accordion({ collapsible: true });
        
    });
    
    

	$(function() {
		$("#tabs").tabs();
		
	});
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
  	      var chosenDistrict = getDistrictName.options[getDistrictName.selectedIndex].text;
  		xmlhttp.open("GET","IvrsServlet?req_type=namesForWell&districtName="+chosenDistrict+"&findTehsil=1&findVillage=0&fromDate=0&toDate=0&getWellData=0",true);
  		xmlhttp.send();
  	   });

 
		
	
$(document).on('click','#getData',function () {
	  var getTehsilName = document.getElementById("tehsilview");
	  var chosenTehsil = getTehsilName.options[getTehsilName.selectedIndex].text;
	  var getDistrictName = document.getElementById("districtview");
	  var chosenDistrict = getDistrictName.options[getDistrictName.selectedIndex].text;
	  var getVillageName = document.getElementById("villageview");
	  var chosenVillage = getVillageName.options[getVillageName.selectedIndex].text;
	  var fromDate=document.getElementById("fromdate").value;
	  var toDate=document.getElementById("todate").value;
	var xmlhttp;   

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
	    document.getElementById("welldata").innerHTML=xmlhttp.responseText;
	    }
	  };
      xmlhttp.open("GET","IvrsServlet?req_type=namesForWell&districtName="+chosenDistrict+"&tehsilName="+chosenTehsil+"&villageName="+chosenVillage+"&fromDate="+fromDate+"&toDate="+toDate+"&getWellData=1&findTehsil=0&findVillage=0",true);
	xmlhttp.send();	
});

$(document).on('change','#tehsilview',function () {
	  var getTehsilName = document.getElementById("tehsilview");
	  var chosenTehsil = getTehsilName.options[getTehsilName.selectedIndex].text;
	  var getDistrictName = document.getElementById("districtview");
	  var chosenDistrict = getDistrictName.options[getDistrictName.selectedIndex].text;

	var xmlhttp;   

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
	    document.getElementById("villagenames").innerHTML=xmlhttp.responseText;
	    }
	  };
    xmlhttp.open("GET","IvrsServlet?req_type=namesForWell&districtName="+chosenDistrict+"&tehsilName="+chosenTehsil+"&findTehsil=0&findVillage=1&fromDate=0&toDate=0&getWellData=0",true);
	xmlhttp.send();	
});

$(document).on('change','#districtview',function () {
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
	      var chosenDistrict = getDistrictName.options[getDistrictName.selectedIndex].text;
		xmlhttp.open("GET","IvrsServlet?req_type=namesForWell&districtName="+chosenDistrict+"&findTehsil=1&findVillage=0&fromDate=0&toDate=0&getWellData=0",true);
		xmlhttp.send();
	   });

</script>


</head>

<body>
	<%
		try {
	%>

	<!-- Start Of  Order Summary  -->
<div id="tabs" class="tabs">
<ul>
<li><a href="#wellinfo">Well Information</a></li>
</ul>
	<form name="wellinfo" id="wellinfo" action="IvrsServlet" method="POST">
		
		<tr class="wellinfo-span">Choose District
		</tr>

		<div id="districtnames">
			<select name="districtview" id="districtview"  class="table-input-1">
				<option value='0'>Select</option>
				<%
					for (int i = 0; i < districtName.length; i++) {
				%>
				<option value="<%=districtName[i]%>"><%=districtName[i]%>
				</option>
				<%
					}
				%>

			</select>
		</div>

		<tr class="wellinfo-span">Choose Tehsil
		</tr>
		<td>&nbsp;&nbsp;</td>
		<div id="tehsilnames">
			<select name="tehsilview" id="tehsilview" class="table-input-1">
				<option value='0'>Select</option>
				<%
					for (int i = 0; i < districtToTehsil.length; i++) {
				%>
				<option value="<%=districtToTehsil[i]%>"><%=districtToTehsil[i]%>
				</option>
				<%
					}
				%>

			</select>
		</div>
		<tr class="wellinfo-span">Choose Village
		</tr>
		<div id="villagenames">
			<select name="villageview" id="villageview"  class="table-input-1">
				<option value='0'>Select</option>
				<%
					for (int i = 0; i < tehsilToVillage.length; i++) {
				%>
				<option value="<%=tehsilToVillage[i]%>"><%=tehsilToVillage[i]%>
				</option>
				<%
					}
				%>

			</select>
		</div>

		<div>
			<tr class="wellinfo-span">
				<b>Choose Date Range :</b>
			</tr>
			<br>
		</div>
		<div class="view">
			<tr class="wellinfo-span-new">From
			</tr>
			<br>
		</div>
		<div>
			<tr class="wellinfo-span-new">
				<input type="date" id='fromdate' name='fromdate' class="table-input-1" />
			</tr>
			<br>
		</div>
		<div>
			<tr class="wellinfo-span-new">To
			</tr>
			<br>
		</div>
		<div>
			<tr class="wellinfo-span-new">
				<input type="date" id='todate' name='todate' class="table-input-1" />
			</tr>
			<br>
		</div>
		<div class="view">
			<input type="hidden" name="req_type" value="getWellData" /> 
			<input type="button" name="getData" class="add-button" id="getData" value="  Find  " />
		</div>
		<div id="welldata" class="welldata">
			<tr class="wellinfo-span">Please select set of inputs !
			</tr>
		</div>
	</form>
	</div>
</body>
<%
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("Error.html");
	}
%>
</html>