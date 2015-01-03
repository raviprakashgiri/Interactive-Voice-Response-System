<!DOCTYPE html >

<!-- 
Document : ViewPrintBill.jsp

 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList;"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />
<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean" scope="request" />
<jsp:useBean id="billingBean" class="com.iitb.SettingsBean.BillingBean" scope="request" />
<jsp:useBean id="orderBean" class="com.iitb.OrderBean.OrderBean" scope="request" />
<jsp:useBean id="voiceTextMessagesBean" class="com.iitb.MessageBean.VoiceTextMessagesBean" scope="request" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Bill</title>
	<link rel="stylesheet" type="text/css" href="css/Main.css" />
</head>
<%  try{
	Object[][] processedMessages=voiceTextMessagesBean.getProcessed_messages();
System.out.println("process "+processedMessages);
	String groupId=groupBean.getGroups_id();	
	String groupName =groupBean.getGroup_name();
	
	System.out.println(groupId);
	System.out.println(groupName);
	
	Object[][] billData=billingBean.getBill_settings();
	String[] billId = billingBean.getBill_id_list();
	String billTotal[] = billingBean.getBill_total_list();
	ArrayList<Object[][]> savedOrderList=orderBean.getSave_order();

	String billdata="Bill Summary<br/><br/><br/>";
%>

<body >


<% 
//validating user on loading the file
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
    requestDispatcher.forward(request, response);
}

%>
<%



for(int i=0;i<processedMessages.length;i+=2){
if(billData!=null)
{
	
	billdata+="<table>"+
			"<tr><td><b>"+billData[0][1]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][2]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][3]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][4]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][5]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][6]+"</b></th></tr>"+
			"<tr><td><b>Member Name</b></td><td>"+processedMessages[i][1]+"</td></tr>"+
			"<tr><td><b>Group Name</b></td><td>"+groupName+"</td></tr>"+
			"<tr><td><b>Member Address</b></td><td>"+processedMessages[i][4]+"</td></tr>"+
			"<tr><td><b>Order ID</b></td><td>"+processedMessages[i][0]+"</td></tr>"+
			"<tr><td><b>Order Time</b></td><td>"+processedMessages[i][3]+"</td></tr>"+
			"<tr><td><b>Bill ID</b></td><td>"+billId[i]+"</td></tr></table>"+
			"<table><tr><td><b>Product</b></td><td></td><td><b>Quantity</b></td><td></td><td><b>Rate</b></td><td></td><td><b>Cost</b></td></tr>";
	
%>
<div id="" style="page-break-inside:avoid;">
<div class="left-bar-bill">
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
		<td class="td"><%=processedMessages[i][1] %></td>
		<th class="td">Group Name</th>
		<td class="td"><%=groupName %></td>
	</tr>
	<tr>
		<td colspan="2" class="td">Member Address</td>
		<td colspan="2" class="td"><%=processedMessages[i][4]%></td>
		
	</tr> 
	
	<tr>
		<th class="td">Order ID</th>
		<td class="td"><%=processedMessages[i][0] %></td>
		<th class="td">Order Time</th>
		<td class="td"><%=processedMessages[i][3]%></td>
	</tr>
	<tr>
		<th class="td">Bill ID</th>
		<td class="td" colspan="3"><%=billId[i]%></td>		
	</tr>
	<tr class="td">
		<th >Product</th>
		<th >Quantity</th>
		<th >Rate</th>
		<th >Cost</th>
	</tr>
	<%
	Object savedOrder1[][]=savedOrderList.get(i);
	
	for(int p=0;savedOrder1!=null && p< savedOrder1.length;p++)
	{
		
		billdata+="<tr><td>"+savedOrder1[p][2]+"</td><td></td>"+
					"<td>"+savedOrder1[p][3]+"</td><td></td>"+
					"<td>"+savedOrder1[p][5]+"</td><td></td>"+
					"<td>"+savedOrder1[p][4]+"</td></tr>";
	%>
	<tr>
		<td><%=savedOrder1[p][2]%></td>
		<td><%=savedOrder1[p][3] %></td>
		<td><%=savedOrder1[p][5]%></td>
		<td><%=savedOrder1[p][4]%>
	</tr>
	<%
	} 
	
		billdata+="<tr><th>Total</th><td></td>";
	
	%>
	<tr>
		<th class="td" colspan="3">Total</th>
		<%
		double total1=Math.round(Float.parseFloat(billTotal[i])*100)/100;
		billdata+="<td>"+total1+"</td>"+
				"<tr><td>"+billData[0][7]+"</td></tr>"+
				"<tr><td>"+billData[0][8]+"</td></tr></table><br/><br/>";
		
		%>
		<td class="td"><%=total1%></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][7] %></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][8]%></td>
	</tr>
	
</table>
</div>
</div>
<%
int j=i+1;
if(j<processedMessages.length){
	
	billdata+="<table>"+
			"<tr><td><b>"+billData[0][1]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][2]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][3]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][4]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][5]+"</b></th></tr>"+
			"<tr><td><b>"+billData[0][6]+"</b></th></tr>"+
			"<tr><td><b>Member Name</b></td><td>"+processedMessages[j][1]+"</td></tr>"+
			"<tr><td><b>Group Name</b></td><td>"+groupName+"</td></tr>"+
			"<tr><td><b>Member Address</b></td><td>"+processedMessages[j][4]+"</td></tr>"+
			"<tr><td><b>Order ID</b></td><td>"+processedMessages[j][0]+"</td></tr>"+
			"<tr><td><b>Order Time</b></td><td>"+processedMessages[j][3]+"</td></tr>"+
			"<tr><td><b>Bill ID</b></td><td>"+billId[j]+"</td></tr></table>"+
			"<table><tr><td><b>Product</b></td><td></td><td><b>Quantity</b></td><td></td><td><b>Rate</b></td><td></td><td><b>Cost</b></td></tr>";
	
%>
<div style="page-break-inside:avoid">
<div >
<table class="table-vpb-right">
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
		<td class="td"><%=processedMessages[j][1] %></td>
		<th class="td">Group Name</th>
		<td class="td"><%=groupName %></td>
	</tr>
	<tr>
		<td colspan="2" class="td">Member Address</td>
		<td colspan="2" class="td"><%=processedMessages[j][4]%></td>
		
	</tr> 
	<tr>
		<th class="td">Order ID</th>
		<td class="td"><%=processedMessages[j][0] %></td>
		<th class="td">Order Time</th>
		<td class="td"><%=processedMessages[j][3]%></td>
	</tr>
	<tr>
		<th class="td">Bill ID</th>
		<td class="td" colspan="3"><%=billId[j]%></td>		
	</tr>
	<tr class="td">
		<th >Product</th>
		<th >Quantity</th>
		<th >Rate</th>
		<th >Cost</th>
	</tr>
	<%
	Object savedOrder2[][]=savedOrderList.get(j);
	
	for(int p=0;savedOrder2!=null && p< savedOrder2.length;p++)
	{
		
		
		billdata+="<tr><td>"+savedOrder2[p][2]+"</td><td></td>"+
				"<td>"+savedOrder2[p][3]+"</td><td></td>"+
				"<td>"+savedOrder2[p][5]+"</td><td></td>"+
				"<td>"+savedOrder2[p][4]+"</td></tr>";
	%>
	<tr>
		<td><%=savedOrder2[p][2]%></td>
		<td><%=savedOrder2[p][3] %></td>
		<td><%=savedOrder2[p][5]%></td>
		<td><%=savedOrder2[p][4]%>
	</tr>
	<%
	} 
	billdata+="<tr><th>Total</th>";
	%>
	<tr>
		<th class="td" colspan="3">Total</th>
		<%
		float total2=Float.parseFloat(billTotal[j]);
		billdata+="<td>"+total2+"</td>"+
				"<tr><td>"+billData[0][7]+"</td></tr>"+
				"<tr><td>"+billData[0][8]+"</td></tr></table><br/><br/>";
		System.out.println(total2);
		//double total2=Math.round(total*100)/100;
		//String total2=billTotal[j];
		%>
		<td class="td"><%=total2%></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][7] %></td>
	</tr>
	<tr>
		<td class="style-td" colspan="4"><%=billData[0][8]%></td>
	</tr>
	
</table>
</div>


<%
}
%>
</div>
	<%

	}} 

	billdata+="<br/>Thank you for using Rural IVRS.<br/><br/>";
	%>	
	
	
<form action="Email.jsp?req_type=bill" method="POST">
<textarea style="display:none;" name="bill" id="bill"><%=billdata %></textarea>
<input type="submit" style="background-color:cadetblue;" id="mail-bills" value="Mail This"/>
<!-- <button  value="Mail This" id="mail-bills" onclick="mailbill()">Mail This</button>-->
</form>

</body>

	

<%
	
}
	catch(Exception e){
		e.printStackTrace();
		//redirects to Error page in case of any exception
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("Error.html");  
	    requestDispatcher.forward(request, response);  
	}
	%>
</html>