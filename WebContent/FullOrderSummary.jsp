<!DOCTYPE html>
<!-- 
Document:FullOrderSummary.jsp

 -->
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session"></jsp:useBean>
<jsp:useBean id="productBean" class="com.iitb.ProductBean.ProductBean" scope="request"></jsp:useBean>
<jsp:useBean id="orderBean" class="com.iitb.OrderBean.OrderBean" scope="request"></jsp:useBean>

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/Main.css">
	<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
  
  <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
  <script type="text/javascript" src="js/jquery-ui.js"></script>
	<script>
	 
	$(function() {
		$("#tabs").tabs();
	});
	</script>
</head>


<body>
<%
//validates the user on loading the page
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
     requestDispatcher.forward(request, response);  
}
	try{
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
%>
	<div id="tabs" class="tabs">
    <ul>
      
      <li><a href="#fullReport">Full Order Report&nbsp;( पूर्ण ऑर्डर  रिपोर्ट )</a></li>
     
    </ul>
				<%
					// Contains list of products that have been sold 
					Object product[][]=productBean.getProcessed_product_list();
				
					//Contains list of quantity units in which the products are sold
					Object quantity[][]=productBean.getProduct_quantity();
					
					//Contains amount of quantity units are sold
					Object totalUnitSold[][]=orderBean.getTotal_unit_sold();
					
					//Contains total amount of each product sold
					Float totalQuantitySold[]=orderBean.getTotal_quantity_sold();
						
					Integer var = 0;
					Integer prdId=0;
					
					%>
					
					<table class="table-1">
						<tr>
							<th class="table-1-th">&nbsp;Count&nbsp;</th>
							<th class="table-1-th">&nbsp;Product / Quantity&nbsp;</th>
							<% 
							if(quantity!=null){
							for (Integer i=0;i<quantity.length;i++){ %>
							<th class="table-1-th"><%=quantity[i][0]%></th>
							<%
							}
							}
							%>
							<th class="table-1-th">&nbsp;Total KGs&nbsp;</th>
						</tr>
						<%
						Integer counter=0;
						if( prdId!=null){
						for(prdId=0; prdId<product.length;prdId++){
						%>
							<tr><td class="table-1-td">&nbsp;<%=++counter %>&nbsp;</td>	
								<td class="table-1-td">&nbsp;<%=product[prdId][0] %>&nbsp;</td>			
							
											
						<%		
						if(quantity!=null){
							for(Integer i=0;i<quantity.length;i++) {		
								System.out.println(totalUnitSold[prdId][i]);
						%>

							<td class="table-1-td">&nbsp;<%=totalUnitSold[prdId][i]%>&nbsp;</td>
			
						<% 
							}
						}
									
						%>
							<td class="table-1-td">&nbsp;<%=totalQuantitySold[prdId]%>&nbsp;</td>
						</tr>
						<%
						}
						}
						%>
					</table>
				
				<!--  Prints a full report of the products soldin that duration -->
				<input class="to-from-date" type="button" value=" Print " onclick='window.parent.location.href="IvrsServlet?ToDate=<%=toDate%>&FromDate=<%=fromDate%>&req_type=FullReport"'/>

	</div>
<%
	}
	catch(Exception e){
		e.printStackTrace();
		//redirects to error page in case of exception 
		 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Error.html");  
	     requestDispatcher.forward(request, response);  
	}
		
	%>
</body>
</html>