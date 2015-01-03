<!DOCTYPE html >

<!-- 
Document : ProcessOrEdit.jsp
@author  : Rasika Mohod (MVC Conversion)
 -->

<%@page  language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />
<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean" scope="request" />
<jsp:useBean id="productBean" class="com.iitb.ProductBean.ProductBean" scope="request" />
<jsp:useBean id="orderBean" class="com.iitb.OrderBean.OrderBean" scope="request" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="css/Main.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
    
	<script src="js/jquery-1.9.1.js"></script>
	<script src="js/jquery-ui.js"></script>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="js/Validate.js"></script>
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	
	
	<link rel="stylesheet" type="text/css" href="css/Main.css">
  <link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
  
  <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
  <script type="text/javascript" src="js/jquery-ui.js"></script>
  <script type="text/javascript" src="js/Validate.js"></script>
    
<title>Generate Bill</title>

<%      try
		{
		String memberName=request.getParameter("memberName");
		String dateTime=request.getParameter("orderTime");
		String msgUrl=request.getParameter("msgUrl");
		String messageId=request.getParameter("messageId");
		System.out.println(messageId);
		String comments=request.getParameter("comments");
		
		String groupId=groupBean.getGroups_id();
		Object[][] productDetails=productBean.getProduct_detail();
		Object[][] productQuantity=productBean.getProduct_quantity_detail();
%>

<script type="text/javascript">

 
$(function() {
    $( "#orderMaking" ).dialog({ 
    	dialogClass: 'no-close',
    	position :[250,50],
    	resizeable:false, 
    	height:420,
    	width:550
		    	
    	});
	});
	
var price = new Array(<%
for(int i = 0; i < productDetails.length; i++) {
  out.print("\""+productDetails[i][2]+"\"");
  if(i+1 < productDetails.length) {
    out.print(",");
  }
}
%>);

var id = new Array(<%
		for(int i = 0; i < productDetails.length; i++)
		{
			out.print("\""+productDetails[i][0]+"\"");
			if(i+1 < productDetails.length)
			{
				out.print(",");
			}
		}
		%>);


var qty = new Array(<%
		for(int i = 0; i < productQuantity.length; i++)
		{
			out.print("\""+productQuantity[i][1]+"\"");
			if(i+1 < productQuantity.length)
			{
			    out.print(",");
			}	
		}
	%>);


var product = new Array(<%
		for(int i = 0; i < productDetails.length; i++)
		{
			out.print("\""+productDetails[i][1]+"\"");
			if(i+1 < productDetails.length)
			{
				 out.print(",");
			}
		}
	%>);

var sum=0;
var productName=new Array();
var quantityValue=new Array();
var i=0;
var setError=0;

	//Function being called on submitting "Save" or "Process" button to save or process order finally
	function countSum(saveOrProcess) {

		var direction=false;
		//To set saved order as saved order or edit saved order
		if(saveOrProcess=="0"){
			var tbl = document.getElementById('orderList');
			if(tbl.rows.length==1){
				alert("Please enter Appropriate Values !");
				return false;
			}
			
			direction = confirm("You really want to save the order ?");		
			if (direction == true) {
				var i, j;
				var boughtProductName = new Array();
				var boughtProductIds = new Array();
				var boughtProductQuantity = new Array();
				var boughtProductPrice = new Array();
				var productPrice=new Array();
				for (i = 1; i < tbl.rows.length; i++) {
					boughtProductName[i] = tbl.rows[i].cells[0].innerHTML;
					for (j = 0; j < product.length; j++) {
						if (boughtProductName[i] == product[j]) {
							boughtProductIds[i] = id[j];
							productPrice[i] = price[j];
						}
					}
					boughtProductQuantity[i] = tbl.rows[i].cells[1].innerHTML;
					boughtProductPrice[i]=boughtProductQuantity[i]*productPrice[i];
				}
				boughtProductQuantity.join();
				boughtProductName.join();
				boughtProductIds.join();
				boughtProductPrice.join();
				productPrice.join();

			$.ajax({
		                type: "post",
		                url: "IvrsServlet",
		                data: "req_type=editAndSaveOrder&boughtProductName=" +boughtProductName+"&boughtProductIds="+boughtProductIds+"&boughtProductPrice="+boughtProductPrice+"&groupId="+<%=groupId%>+"&boughtProductQuantity="+boughtProductQuantity+"&messageId="+<%=messageId%>+"&productPrice="+productPrice,
		                success: function(){      
		              
		                }
		            });
				}
		}
		//To set saved order as processed order
			if(saveOrProcess==1){
				var tbl = document.getElementById('orderList');
				if(tbl.rows.length==1){
					alert("Please enter Appropriate Values !");
					return false;
				}
		
				direction = confirm("You really want to process the order ?");		
		
				if (direction == true) {
					var i, j;
					var boughtProductName = new Array();
					var boughtProductIds = new Array();
					var boughtProductQuantity = new Array();
					var boughtProductPrice = new Array();
					var productPrice=new Array();
					
					for (i = 1; i < tbl.rows.length; i++) {
						boughtProductName[i] = tbl.rows[i].cells[0].innerHTML;
						for (j = 0; j < product.length; j++) {
							if (boughtProductName[i] == product[j]) {
								boughtProductIds[i] = id[j];
								productPrice[i] = price[j];
							}
						}
						boughtProductQuantity[i] = tbl.rows[i].cells[1].innerHTML;
						boughtProductPrice[i]=boughtProductQuantity[i]*productPrice[i];
					}
					boughtProductQuantity.join();
					boughtProductName.join();
					boughtProductIds.join();
					boughtProductPrice.join();
					productPrice.join();
				
				$.ajax({
	                type: "post",
	                url: "IvrsServlet", //this is my servlet
	                data: {'req_type':'process','boughtProductName':boughtProductName,'boughtProductIds':boughtProductIds,'groupId':<%=groupId%>,'boughtProductPrice':boughtProductPrice,'boughtProductQuantity':boughtProductQuantity,'messageId':<%=messageId%>,'productPrice':productPrice},
	                success: function(){      
	                	
	                },
	                error:function(){
	                	console.log(request.responsetext);
	                }
	               
	            });
			}
			}
			window.location.href='IvrsServlet?req_type=voiceMessage&groupId='+<%=groupId%>+'#processed';
	}

	function addcountProcessOrEdit() 
	{
		if(setError===1){
			alert("Please enter Price for products in the product form !");
		}
		else{

			var existingRowCount=document.getElementById('orderList').getElementsByTagName('tbody').length;
			var product = document.getElementById("product");
			productName[i] = product.options[product.selectedIndex].text;
			var quantity = document.getElementById("quantity");
			quantityValue[i] = quantity.options[quantity.selectedIndex].text;
			var tableRef = document.getElementById('orderList').getElementsByTagName('tbody')[0];
			var newRow = tableRef.insertRow(tableRef.rows.length);
			var newCell1 = newRow.insertCell(0);
			var newText1 = document.createTextNode(productName[i]);
			var newCell2 = newRow.insertCell(1);
			var newText2 = document.createTextNode(quantityValue[i]);
			newCell1.appendChild(newText1);
			newCell2.appendChild(newText2);}
	}
	//Function to Update Message Comments
 	/*$(document).ready(function(){
 		$(".comments").blur(function(){
 			
 			var id=$(this).attr("id");
 			var comment=$(this).val();
 			console.log(id);
 			$.ajax({
 				url: 'IvrsServlet',
 				type: 'POST',
 				data: {'req_type':'updateMsgComment','messageId':id,'messageComments':comment},
 				success: function(){
 					
 					$("#update-comment-"+id).fadeIn(100).text("Updated").fadeOut(3000);
 				}
 			});
 		});
 	});*/
</script>
</head>

<body style="background-color:transparent;">
<% 
//validating user on loading the file
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
    requestDispatcher.forward(request, response);  
}
%>
<% 
int countpros=productBean.getCount_products_price();
int countprice=productBean.getCount_price_is_null();
if(countprice!=countpros){
%>

<script>
var setError=1;
</script>
<%} %>


<div id="orderMaking">
<form id="order"  method="post">
<table>
	<tr>
		<th>MEMBER</th>
		<th class="order-th">DATE </th>		
		<th class="order-th">COMMENTS</th>
	</tr>
	<tr>
		<th>सदस्य</th>
		<th class="order-th">दिनांक</th>
		<th class="order-th">टिप्पणी</th>
	</tr>
	<tr>
		<td class="order-th"><%=memberName%></td>
		<td class="order-th"><%=dateTime%></td>
		<td class="order-th"><span class="comment-area" >
		<textarea name="comments" class="comments" id="<%=messageId%>" ><%=comments%></textarea></span></td>
		
	</tr>
	<tr>
	<td class="order-td"></td>
	</tr>
	<tr>
		<th colspan="3">MESSAGE / संदेश</th>		
	</tr>
	<tr>
		<td colspan="3">
			<audio controls>
           				<source src="<%=msgUrl%>" type="audio/wav" ></source>
           			 	<p>Your browser does not support this audio format.</p>
            </audio>
    	</td>
	</tr>
	<tr>
		<td class="order-td">
		</td>
	</tr>
	<tr>
		<th>PRODUCT</th>
		<th class="style-th">QUANTITY</th>
		<th class="order-th-3">OTHER</th>
	</tr>
	
	<tr>
		<th>उत्पाद</th>
		<th class="style-th">मात्रा</th>
		<th class="order-th-3">QTY.</th>
		
	</tr>
	<tr>
		<td>
            <span>
           		<select id="product" class="product">
            	<%
            	int a=0;
            	while(a < productDetails.length){ %>
            		<option value="<%=productDetails[a][0]%>"><%=productDetails[a][1]%></option>
            	<% 
            	a++;
            	}%>           
          		</select>
           </span>
        </td>
        <td>
            <span>
           		<select id="quantity" class="quantity">
            	<%
            	int b=0;
            	while(b < productQuantity.length){ %>
            		<option value="<%=productQuantity[b][0]%>"><%=productQuantity[b][1]%></option>
            	<%
            	b++;
            	}%>           
          		</select>
           </span>
        </td>
        	<td>
			<input type="text" class="quan-poe" placeholder="Qty" id="quan"></input>
		</td>
	</tr>
	<tr>
	<td colspan="3">
		<div>
			<table id="orderList" class="orderList">
				<tbody id="tableOrder">
				<tr>
					<th  class="orderList-1">Product</th>
					<th class="orderList-2" >Quantity</th>
					<th><img src="img/arrowdown.jpg" id="arrowdown" class="arrow" onclick="addcountProcessOrEdit()"/></th>
					<th><img src="img/arrowup.jpg" onclick="removeRow()" id="arrowup" class="arrow"/></th>	
					<th><img src="img/arrowdown.jpg" class="arrow" onclick="addDiffCount()"/></th>		
					
				</tr>
				<%
				Object[][] savedOrder=orderBean.getSaved_order();
				for(int c=0;savedOrder!=null && c<savedOrder.length;c++ ){
					%>
				<tr>
					<td><%=savedOrder[c][2] %></td>
					<td><%=savedOrder[c][3] %></td>
				</tr>			
				<% }%>				
				</tbody>
			</table>	
		</div>
	</td>
	</tr>
	</table>
	<table class="table">
	<tr>
	</tr>
	</table>
	<div class="div">
			<!--  <input class="add-button" type="button" value="Save" onclick="countSum(0)"></input>-->						
			<input class="add-button" type="button" value="Process" onclick="countSum(1)"></input>			
			<input class="add-button" type="button" value="Close" class="close-button-poe" onclick="window.location.href='IvrsServlet?req_type=voiceMessage&groupId=<%=groupId%>#saved'"></input>
	</div>
	</form>
</div>
</body>
	<%
	}
	catch(Exception e)
	{
		e.printStackTrace();
		//redirects to Error page in case of any exception
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("Error.html");  
	    requestDispatcher.forward(request, response);  
	}
	%>
</html>