<!DOCTYPE html>

<!-- 
Document : OutgoingMessage.jsp  
@author  : Rasika Mohod  (MVC Conversion)
 -->

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />
<jsp:useBean id="inoutBean" class="com.iitb.MessageBean.IncomingOutgoingBean" scope="request" />



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" type="text/css" href="css/Main.css">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />

		<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="js/jquery-ui.js"></script>
        <script type="text/javascript">
	$(function() {
		$("#tabs").tabs();
	});
	function checkMessage(input){
		
		if(!input){
			
			alert("No outgoing messages");
		}
	}
	</script>
    </head>
    <%
    String message=request.getParameter("message");
    if(message==null){
    	message="true";
    }
    %>
    <body onload="checkMessage(<%=message%>)">
    <%
try{
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
    requestDispatcher.forward(request, response);  
}
if(message.equalsIgnoreCase("true")){
Object[][] outgoingSms=inoutBean.getOutgoing_messages();
if(outgoingSms.length==0){
	
	
}
else{
%>
<div id="tabs" class="tabs">
<ul>
<li><a href="#outgoing">Outgoing Messages&nbsp;</a></li>
</ul>
       
		<table>
		<tr>
			<th class="style-td">DATE&nbsp;</th>		
			<th class="style-td">MSG ID&nbsp;</th>
			<th class="style-td">MESSAGE&nbsp;</th>
			<th class="style-td">RESPONSE&nbsp;</th>
		</tr>
		<!-- <tr>
			<th class="style-td">दिनांक&nbsp;</th>
			<th class="style-td">सदस्य&nbsp;</th>
			<th class="style-td">संदेश&nbsp;</th>
			<th class="style-td">प्रतिक्रिया&nbsp;</th>
		</tr>  -->
		<%
	
		Integer i=0;
		
		while(outgoingSms!=null && i < outgoingSms.length) {
		%>
			<tr>
				<td class="style-td"><%=outgoingSms[i][2]%>&nbsp;</td>
				<td class="style-td"><%=outgoingSms[i][0]%>&nbsp;</td>
				<td class="style-td-msg"><%=outgoingSms[i][1]%>&nbsp;</td>
				<td class="style-td-msg"><%=outgoingSms[i][3]%>&nbsp;</td>
			</tr>
		<%
			i++;
		}
		%>
		</table>
		</div>
		<%
		}
	}
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