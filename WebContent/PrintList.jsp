<!DOCTYPE html>
<!--
Document: PrintList.jsp
Modified By :Richa Nigam(Conversion  to MVC) 
 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session"></jsp:useBean>
<jsp:useBean id="productBean" class="com.iitb.ProductBean.ProductBean" scope="request"></jsp:useBean>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/Main.css">
	<title>Product-Price List</title>
</head>
<body>
<%
//validate the user on loading the page
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
     requestDispatcher.forward(request, response);  
}
%>
<%
// Contains list of all products in the database
Object productName[][]=productBean.getProduct_detail();
System.out.println("in printlist jsp");
if(productName.equals(null)){
%>	
No products listed !
<%} else{%>
<table class="table-pl">
	<tr>
		<td class="table-pl-td-1"><b>Sr.no</b></td>
		<td class="table-pl-td-2"><b>Product</b></td>
		<td class="table-pl-td-3"><b>Rate (Rs. per Unit)</b></td>
	</tr>
	<%
	Integer i=0;
	for(i=0;i<productName.length;i++) {%>
	<tr class="table-pl-tr">
		<td><%=i+1%></td>
		<td><%=productName[i][1]%></td>
		<td><%=productName[i][2] %></td>	
	<%} }%>
	</tr>
</table>
</body>
</html>