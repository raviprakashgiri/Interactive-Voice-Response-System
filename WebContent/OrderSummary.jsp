<!DOCTYPE html>
<!-- 
Document : OrderSummary.jsp
Modified By : Richa Nigam (Conversion to MVC)
 -->
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session"></jsp:useBean>
<jsp:useBean id="productBean" class="com.iitb.ProductBean.ProductBean" scope="request"></jsp:useBean>
<jsp:useBean id="orderBean" class="com.iitb.OrderBean.OrderBean" scope="request"></jsp:useBean>


<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	<script src="js/jquery-1.9.1.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/jquery-1.10.1.min.js"></script>
	<script src="js/ajax.jquery.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="css/Main.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	
	<!-- Java Script Added -->
	<script type="text/javascript" src="js/Validate.js"></script>

<script type="text/javascript">

$(function() {
	$("#tabs").tabs();
});
  
	$(document).ready(function () {
	    $('#1').show();
	    $('#optionsss').change(function () {
	       $('.box-os').hide();
	        $('#'+$(this).val()).show();
	    });
	    
	});
</script>
</head>

<body>
<%
// Validating the user on loading the file
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
     requestDispatcher.forward(request, response);  

}
try{
%>
	<div id="content" class="content-dash" >
		<div id="tabs" class="tabs" >
    <ul>
      
      <li><a href="#orderSummary">Product Order Summary &nbsp; ( उत्पाद ऑर्डर  सारांश )</a></li>
    
    </ul>
			<!--  Order Summary  -->
			<div id="total">
				
				<%
					// Contains list of products that have been processed				
					Object [][] product=productBean.getProcessed_product_list();
					System.out.println("Product recived");
					Integer i=0;
					Integer givId = 1;// gives id for options in select tag
					
				%>
				<div class="view">
				<span class="span-prod">Choose Product &nbsp; (उत्पाद  चुनें )</span><br>
				<!-- Selects a product from list -->
				<select name="options" id="optionsss"  class="view">		<!-- start of select tag -->		
					<%
						for(i=0;i<product.length;i++){
					%>
					<option value="<%=givId%>"><%=product[i][0]%>
					</option>
					<%givId++;}
					
					%>
				</select>	<!-- end of select tag -->
				</div>
						<%
						// Contains list of quantities the products are sold in
							Object quantity[][]=productBean.getProduct_quantity();
						System.out.println("quantity recived"+quantity.length);
							
							Object totalUnitSold[][]=orderBean.getTotal_unit_sold();
							Float totalQuantitySold[]=orderBean.getTotal_quantity_sold();
							System.out.println("total quantity  recived"+totalQuantitySold.length);
							Integer var=0;
							Integer prdId;
							Integer idForDiv = 0;// gives each article a unique id
							for (prdId = 0; prdId < product.length; prdId++) {						
								System.out.println("idfordiv");				
								idForDiv++;
						%>

				<!-- Every product has a different article -->
				<article id="<%=idForDiv%>" class="box-os"><!-- start of article tag -->
					<table class="box-inner">

						<tr>
							<!-- displays the product name -->
							<th colspan="2" class="box-inner-th">&nbsp;<b class="span"><%=product[prdId][0].toString()%></b></th>
						</tr>
						<tr>
							<th class="box-inner-td">UNIT</th>
							<th class="box-inner-td">QUANTITY</th>
						</tr>
						<%
					
						
							for (var = 0; var < quantity.length; var++) {
								System.out.println(totalUnitSold[prdId][var]+" && "+quantity[var][0]);
								Integer q=Integer.parseInt(totalUnitSold[prdId][var].toString());
								if(q!=0){
						%>

						<tr>
							<td class="box-inner-td">&nbsp;&nbsp;<%=quantity[var][0]%></td><!-- displays unit of quantity -->
							<td class="box-inner-td">&nbsp;&nbsp;<%=totalUnitSold[prdId][var]%></td><!--displays amount of the unit sold -->
			</tr>
						<%
							}
							}
						%>
						<tr>
							<th class="box-inner-td">Total</th>
							<th class="box-inner-td">&nbsp;&nbsp;<%=totalQuantitySold[prdId].toString()%></th>
							<!-- diplays total quantity of that product sold -->
						</tr>
					</table>
		</article><!-- end of article tag -->
						<%
							}
						%>
					
			</div>
			</div>
		</div>
		<%
	}
	catch(Exception e){
		e.printStackTrace();
		//redirects to Error page in case of any exception
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("Error.html");  
	    requestDispatcher.forward(request, response);  
	}
	%>
</body>
</html>