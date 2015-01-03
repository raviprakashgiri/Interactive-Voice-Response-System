<!DOCTYPE html >

<!-- 
Document : ViewPrintBill.jsp
@author  : Rasika Mohod (MVC Conversion)
 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />
<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean" scope="request" />
<jsp:useBean id="billingBean" class="com.iitb.SettingsBean.BillingBean" scope="request" />
<jsp:useBean id="orderBean" class="com.iitb.OrderBean.OrderBean" scope="request" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Bill</title>
	<link rel="stylesheet" type="text/css" href="css/Main.css" />
</head>
<%  try{
	String messageId=request.getParameter("messageId");
	String memberName=request.getParameter("memberName");
	String memberAddress=request.getParameter("memberAddress");
	String orderTime=request.getParameter("orderTime");
	String groupId=groupBean.getGroups_id();	
	String groupName =groupBean.getGroup_name();
	
	Object[][] billData=billingBean.getBill_settings();
	String billId = billingBean.getBill_id();

%>
<body>
<% 
//validating user on loading the file
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
    requestDispatcher.forward(request, response);
}

%>

<%

String billdata="Billing details for your latest purchase, ,";
%>

<%
if(billData!=null){
	billdata+="<table>"+
			"<tr><td><b>"+billData[0][1]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][2]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][3]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][4]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][5]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][6]+"</b></th></tr>"+
			"<tr><td><b>Member Name</b></td><td>"+memberName+"</td></tr>"+
			"<tr><td><b>Group Name</b></td><td>"+groupName+"</td></tr>"+
			"<tr><td><b>Member Address</b></td><td>"+memberAddress+"</td></tr>"+
			"<tr><td><b>Order ID</b></td><td>"+messageId+"</td></tr>"+
			"<tr><td><b>Order Time</b></td><td>"+orderTime+"</td></tr>"+
			"<tr><td><b>Bill ID</b></td><td>"+billId+"</td></tr></table>"+
			"<table><tr><td><b>Product</b></td><td></td><td><b>Quantity</b></td><td></td><td><b>Rate</b></td><td></td><td><b>Cost</b></td></tr>";
	
%>
<table class="table-vpb">
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][1]%></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][2]%></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][3]%></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][4]%></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][5]%></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][6]%></td>
	</tr>
	<tr>
		<th class="td">Member Name</th>
		<td class="td"><%=memberName %></td>
		<th class="td">Group Name</th>
		<td class="td"><%=groupName %></td>
	</tr>
	<tr>
		<td colspan="2" class="td">Member Address</td>
		<td colspan="2" class="td"><%=memberAddress%></td>
		
	</tr> 
	<tr>
		<th class="td">Order ID</th>
		<td class="td"><%=messageId %></td>
		<th class="td">Order Time</th>
		<td class="td"><%=orderTime %></td>
	</tr>
	<tr>
		<th class="td">Bill ID</th>
		<td class="td" colspan="3"><%=billId%></td>		
	</tr>
	<tr class="td">
		<th >Product</th>
		<th >Quantity</th>
		<th >Rate</th>
		<th >Cost</th>
	</tr>
	<%
	String billTotal = billingBean.getBill_total();
	Object[][] savedOrder=orderBean.getSaved_order();
	for(int p=0;savedOrder!=null && p< savedOrder.length;p++)
	{
		billdata+="<tr><td>"+savedOrder[p][2]+"</td><td></td>"+
				"<td>"+savedOrder[p][3]+"</td><td></td>"+
				"<td>"+savedOrder[p][5]+"</td><td></td>"+
				"<td>"+savedOrder[p][4]+"</td></tr>";
	%>
	<tr>
		<td><%=savedOrder[p][2]%></td>
		<td><%=savedOrder[p][3] %></td>
		<td><%=savedOrder[p][5]%></td>
		<td><%=savedOrder[p][4]%>
	</tr>
	<%
	} 
	billdata+="<tr><th>Total</th>";
	billdata+="<td>"+billTotal+"</td>"+
			"<tr><td>"+billData[0][7]+"</td></tr>"+
			"<tr><td>"+billData[0][8]+"</td></tr></table><br/><br/>";
	billdata+="Thankyou for using Rural IVRS.";
	%>
	<tr>
		<th class="td" colspan="3">Total</th>
		<td class="td"><%=billTotal%></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][7] %></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][8]%></td>
	</tr>
	
</table>

<form action="Email.jsp?req_type=bill" method="POST">
<textarea style="display:none;" name="bill" id="bill"><%=billdata %></textarea>
<input type="submit" style="margin-left:50px;background-color:cadetblue;" id="mail" value="Mail This"/>
</form>


	<%
	} 
	else
	{ 
	%>
<span class="span-vpb">Please Enter Header and Footer in GlobalSettings page, in the Bill Settings link !</span>
	<% 
	}
	%>
</body>
<%
	}
	catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("Error.html");
	}
	%>
</html>