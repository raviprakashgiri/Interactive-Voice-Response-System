<!DOCTYPE html>
<!-- 
Document : ProductForm.jsp
Modified By :Richa Nigam(Conversion to MVC)
 -->
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="productBean" class="com.iitb.ProductBean.ProductBean"
	scope="request"></jsp:useBean>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="css/Main.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/Validate.js"></script>

<script type="text/javascript">
	$(function() {
		$("#tabs").tabs();
	});

	function refreshManage() {
		$("#dialog").dialog("close");
		location.reload();
	}
</script>
</head>

<body>
	<%
		// validates the user on loading the page
		if (loginUser.getUsername() == null
				|| loginUser.getParent_org() == null
				|| loginUser.getOrg_id() == null) {
			RequestDispatcher rd = request
					.getRequestDispatcher("Login.jsp");
			rd.forward(request, response);

		}
		try {
			String x="";
			%>
			
	<div id="tabs" class="tabs" >
		<ul>
			<li><a href="#editProduct">Product List <br> ( उत्पाद सूची )</a></li>			
			<li><a href="#product_price">Product Price<br> ( उत्पाद मूल्य )</a></li>
			<li><a href="#quantity">Product Quantity<br> ( उत्पाद मात्रा )</a></li>
		</ul>
		<div id="editProduct"><!-- start of editProduct division -->
			<br>
			<P>
			<div id="addPros">
				<form id="addProducts" class="addQuans" action="IvrsServlet"
					onsubmit="return checker('products','updateProductsList');"
					method="post">						<!--addProducts form -->
					<table id="addProsList">
						<tr>
							<td><div id="div2"></div></td>
						</tr>
						<tr>
							<td><p>
									<button type="button" class="add-button"
										onclick="generateRow2('products','addProsList')">&nbsp;&nbsp;Add
										Product&nbsp;&nbsp;</button>
								</p></td>
						</tr>
						<tr>
							<td>
						<tr>
							<td><input type="hidden" name="req_type" type="number"
								value="addProductNameAndPrice" /></td>
						</tr>
					</table>
					<button type="submit" name="Submit" value="Submit"
						class="add-button">Submit</button>
				</form>
			</div>
			<br>
			<P>
			<form id="editProform" name="editProForm" method="post"
				action="IvrsServlet">									<!-- edit Product form -->
				<div>
					<%
						Object productName[][] = productBean.getProduct_detail();

							if (productName == null) {
					%><br> <span class="span">There is no product in the
						system !</span>
					<%
						} else {
					%>
					<table>
						<tr>
							<td><input type="checkbox" onClick="checkAllToDelete1(this);" />
								<b>&nbsp;Select All</b><br /></td>
						</tr>
						<%
							Integer i = 0;
									for (i = 0; i < productName.length; i++) {
						%>
						<tr>
							<td><input type="checkbox" id="<%=productName[i][1]%>"
								name="existingProducts" class="existingProducts"
								value="<%=productName[i][0]%>" />&nbsp;&nbsp;&nbsp;<input
								name="updateProductsList" id="updateProductsList<%=i%>"
								class="pro-price" value="<%=productName[i][1]%>" required /></td>
						</tr>
						<%
							}
						%>
						<tr>
							<!--  to delete the selected products -->
							<td><button type="submit" name="req_type"
									value="deleteMultiProducts" class="deleteMultiProducts">Delete</button></td>
							<!-- to update the products -->
							<td><button type="submit" name="req_type"
									value="updateMultiProducts" class="updateMultiProducts">Update</button></td>
						</tr>
					</table>
					<%
						}
					%>
				</div>
			</form>
		</div>					<!-- end of editProduct division -->
		<div id="quantity">		<!-- start of quantity division -->
			<br>
			<P>
			<div id="addQuans">
				<form id="addQuans" class="addQuans" action="IvrsServlet"
					onsubmit="return checker('quantity','updateQuansList');"
					method="post">			<!-- add quantity form -->
					<table id="addQuansList">
						<tr>
							<td><div id="div2"></div></td>
						</tr>
						<tr>
							<td><p>
									<button type="button" class="add-button" value="Add"
										onclick="generateRow2('quantity','addQuansList')">&nbsp;&nbsp;Add
										Quantity&nbsp;&nbsp;</button>
								</p></td>
						</tr>
						<tr>
							<td><input type="hidden" name="req_type" type="number"
								value="addProductQuantity" /></td>
						</tr>
					</table>
					<button type="submit" name="Submit" value="Submit"
						id="submitQuantity" class="submitQuantity">Submit</button>
				</form>
			</div>
			<br>
			<p>
			<form id="editQuanform" name="editQuanForm" method="post"
				action="IvrsServlet">			<!-- edit quantity form -->
				<div>
					<%
						Object[][] quantity = productBean.getProduct_quantity_detail();
							if (quantity == null) {
					%><br> <span class="span">There is no quantity in the
						system !</span>
					<%
						} else {
					%>
					<table>
						<tr>
							<td><input type="checkbox"
								onClick="checkAllToDelete2(this);" /> <b>&nbsp;Select All</b><br /></td>
						</tr>
						<%
							Integer k = 0;
									for (k = 0; k < quantity.length; k++) {
						%>
						<tr>
							<td><input type="checkbox" id="<%=quantity[k][0]%>"
								name="existingQuans" class="existingQuans"
								value="<%=quantity[k][0]%>" />&nbsp;&nbsp;&nbsp;<input type="number"
								name="updateQuansList" id="updateQuansList<%=k%>"
								class="pro-price" value="<%=quantity[k][1]%>" /></td>
						</tr>
						<%
							}// end of for loop
						%>
						<tr>
						<!-- to delete selected quantity unit -->
							<td><button type="submit" name="req_type"
									value="deleteMultiQuans" class="deleteMultiQuans">Delete</button></td>
						<!--  to update the quantity units -->
							<td><button type="submit" name="req_type"
									value="updateMultiQuans" class="updateMultiQuans">Update</button></td>
						</tr>
					</table>
					<%
						} // end of else block
					%>
				</div>
			</form>
		</div>
		<div id="product_price">			<!-- start of product price division -->
			<form id="form3" name="form3" method="post" action="IvrsServlet">
				<table>
					<tr>
						<th id="mem-number" class="mem-number-pf">Product Name</th>
						<th id="mem-response">&nbsp; &nbsp;Product Price</th>
					</tr>
					
					<%

		
					
					if (productName == null) {
						x="There is no product in the system !";
						%><br> <span class="span">There is no product in the
							system !</span>
						<%
							} else {
								x+="<table>"+
										"<tr>"+
											"<th>Product Name</th>"+
											"<th>Product Price</th>"+
										"</tr>";
					
						Integer k;
							for (k = 0; k < productName.length; k++) {
								%>
								
					<tr>
						<td><%=productName[k][1]%></td>
						<td>&nbsp; &nbsp;<input type="number" name="price" id=""
							value="<%=productName[k][2]%>" class="pro-price" required /></td>
						<td>&nbsp; &nbsp;<input type="hidden" name="priceid" id=""
							value="<%=productName[k][0]%>" class="pro-price" required /></td>
						
					</tr>
					<%
					x+="<tr>"+
							"<td>"+productName[k][1]+"</td>"+
							"<td>"+productName[k][2]+"</td>"+
						"</tr>";
					
						}		//end of for loop
							}//end of else block
							
							x+="</table><br/><br/>Thank you for using Rural IVRS.";
					%>
					<tr>
						<td><input type="hidden" value="updateProductDetail"
							name="req_type" id="req_type" /> <input type="submit"
							value="Update" class="update-submit" style="background-color:cadetblue;color:white;" /></td><!-- updates product details -->
						<td></td>
						<td><input type="button" style="background-color:cadetblue;color:white;" id="mail" name="mail" value="Mail List" onClick="mailFn()"/></td>
							
						<!-- redirects to PrintList.jsp  -->
						<td><input type="button" value="Print List"
							onclick="window.parent.location.href='IvrsServlet?req_type=printlist'" style="background-color:cadetblue;color:white;" /></td>
				</table>
			</form>
							
		</div>

	</div>   <!-- end of product price division -->
	
<form id="test" method="POST" action="Email.jsp?req_type=list">
	<textarea name="list" id="list" style="display:none"><%=x%></textarea>
	<input type="submit" style="display:none;" id="mail-bills"/>
</form>

	<script type="text/javascript">
		function mailFn()
		{
		var list='<%=x%>';
		var temp=document.getElementById("mail-bills");
		temp.click();
		}
	</script>
	
	<%
	
		} catch (Exception e) {

			e.printStackTrace();
			//redirects to error page in case of exception
			RequestDispatcher requestDispatcher = request
					.getRequestDispatcher("Error.jsp");
			requestDispatcher.forward(request, response);

		}
	%>
</body>
</html>