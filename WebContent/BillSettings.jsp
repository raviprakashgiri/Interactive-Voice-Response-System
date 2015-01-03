<!DOCTYPE html>
<!-- 
stavan here
Document : BillSettings.jsp
Modified By :Richa Nigam(Conversion to MVC)
 -->
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session"></jsp:useBean>
<jsp:useBean id="billingBean" class="com.iitb.SettingsBean.BillingBean" scope="request"></jsp:useBean>


<html>
<head>
	<title>Bill Settings</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	
	<link rel="stylesheet" type="text/css" href="css/Main.css">
	<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
	
	<script type="text/javascript" src="js/Validate.js"></script>
	<script type="text/javascript">
	$(function() {
		$("#tabs").tabs();
	});
	</script>
</head>

<%
 String update;// update signifies if the page is being loaded again after updating the setttings
if(billingBean.getUpdate()!=null)
	update="true";
else 
	update="false";
System.out.println(update);
%>


<body onload=" return updatebill(<%=update%>)">
<%
//  Validates the user on loading the page
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
     requestDispatcher.forward(request, response);  

}
%>
<div id="tabs" class="tabs" >
		<ul>
			<li><a href="#editBill">Bill Settings&nbsp; ( बिल सेटिंग्स )</a></li>
			
		</ul>
<form name=form1 class="form "action='IvrsServlet' onsubmit="return updatebill();">
	<%  
		
		Object[][] billSettings=billingBean.getBill_settings();
		if(billSettings!=null){	  
	%>
	<!-- Displays existing bill Settings -->
	<table class="table-BillSettings">
		<tr>
			<th>Header of the Generated Bill</th>
		</tr>
		<tr>
			<td class="table-td-1"></td>
		</tr>
		<tr>
			<td><input name='organizationName' id='organizationName' placeholder='Name of Organization' type='text' class="table-input-1" value="<%=billSettings[0][1]  %>" required/> <span class="span"> *</span></td>
		</tr>
		<tr>
			<td><input name='organizationAddress1' id='organizationAddress1' placeholder='Address of Organization (Line 1)' type='text' class="table-input-2" value="<%=billSettings[0][2]%>"/></td>
		</tr>	
		<tr>
			<td><input name='organizationAddress2' id='organizationAddress2' placeholder='Address of Organization (Line 2)' type='text' class="table-input-2" value="<%=billSettings[0][3]%>"/></td>
		</tr>	
		<tr>
			<td><input name='organizationAddressCity' id='organizationAddressCity' placeholder='Address of Organization (City)' type='text' class="table-input-2"  value="<%=billSettings[0][4]%>"/></td>
		</tr>	
		<tr>
			<td><input name='organizationContact' id='organizationContact' placeholder='Contact Number' type='number' min ='0000000000000000' max='9999999999999999' class="table-input-2" value="<%=billSettings[0][5]%>"  onchange="phonenumber(document.form1.organizationContact)" required>  <span class="span">* eg : 02228999999 or 09999999999</span></input></td>
		</tr>	
		<tr>
			<td><input name='extra' id='extra' placeholder='Extra Details' type='text' value="<%=billSettings[0][6]%>" class="table-input-3" /></td>
		</tr>	

		<tr>
			<th >Footer of the Generated Bill</th>
		</tr>	
		<tr>
			<td><input name='footer1' id='footer1' class="footer1" placeholder='Line 1 of Footer' type='text' value="<%=billSettings[0][7]  %>" /></td>
		</tr>	
		<tr>
			<td><input name='footer2' id='footer2' class="footer2" placeholder='Line 2 of Footer' type='text' value="<%=billSettings[0][8] %>" /></td>
		</tr>	
	</table>
	
	<%
		}
		else{
	%>
	<!-- If no existing bill settings are present -->
	<table class="table">
		<tr>
			<th>Header of the Generated Bill</th>
		</tr>
		<tr>
			<td class="table-td-1"></td>
		</tr>
		<tr>
			<td><input name='organizationName' id='organizationName' placeholder='Name of Organization' type='text' class="table-input-1" required/> <span class="span"> *</span></td>
		</tr>
		<tr>
			<td><input name='organizationAddress1' id='organizationAddress1' placeholder='Address of Organization (Line 1)' type='text' class="table-input-2"/></td>
		</tr>	
		<tr>
			<td><input name='organizationAddress2' id='organizationAddress2' placeholder='Address of Organization (Line 2)' type='text' class="table-input-2"/></td>
		</tr>	
		<tr>
			<td><input name='organizationAddressCity' id='organizationAddressCity' placeholder='Address of Organization (City)' type='text' class="table-input-2"/></td>
		</tr>	
		<tr>
			<td><input name='organizationContact' id='organizationContact' placeholder='Contact Number' type='number' min ='00000000000' max='99999999999' class="table-input-2"  onchange="phonenumber(document.form1.organizationContact)" required>  <span class="span">* eg : 02228999999 or 09999999999</span></input></td>
		</tr>	
		<tr>
			<td><input name='extra' id='extra' placeholder='Extra Details' type='text' class="table-input-3"/></td>
		</tr>	

		<tr>
			<th >Footer of the Generated Bill</th>
		</tr>	
		<tr>
			<td><input name='footer1' id='footer1' placeholder='Line 1 of Footer' type='text' class="footer1"/></td>
		</tr>	
		<tr>
			<td><input name='footer2' id='footer2' placeholder='Line 2 of Footer' type='text' class="footer2"/></td>
		</tr>	
	</table>
	<% }%>
	<input type='hidden' name='req_type' id='req_type' value='updateBill'/>
	<input id="submit" type="submit" value="Submit"  class="submit-button" />
	</form>
	</div>
</body>
</html>