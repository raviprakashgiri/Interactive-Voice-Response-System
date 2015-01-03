<!DOCTYPE html>
<%-- 
Document   : ManipulateGroups.jsp
@author    : Teena Soni (MVC Conversion)
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.iitb.globals.*"%>

<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean" scope="request" />
<jsp:useBean id="memberBean" class="com.iitb.MemberBean.MemberBean" scope="request" />
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 	<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
 	<script type="text/javascript" src="js/1.10.4.jquery-ui.js"></script>
	<script type="text/javascript" src="js/Validate.js"></script>

	<link rel="stylesheet" type="text/css" href="css/Main.css">
  	<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
 
<title>Add Groups</title>
</head>

<body >
<%if(loginUser.getUsername()==null){
	session.invalidate();
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
	requestDispatcher.forward(request, response);  
}	
		
	String memberNumber=request.getParameter("memberNumber");
	String manipulated=request.getParameter("manipulate");
	String orgId = loginUser.getOrg_id();
	System.out.println(orgId);
%>
 <div id="manipulateGroups">
 		<form action="IvrsServlet" method="POST" name="checkForm" id="checkForm">
		<% 
			if(Integer.parseInt(manipulated)==0){
		%>
		<p>Add New Group(s)</p>
		<br>
		<br>
	<div class="add-new-grp" style="align:center;border-style:solid" >
					
     				<%try{
     					Object[][] manipulateAdd=groupBean.getManipulate_add();
         			if(manipulateAdd==null){
						%>
						<span class="span">The member is present in all groups !</span>
						<%          				
         				}
         			else{%>
         				 <table>
                      <tr>
                            <td><input type="checkbox" onClick="checkAllToAdd(this);" />
							<b>&nbsp;&nbsp;Select All</b><br/></td>
			          </tr>
	         			<%Integer i=0; 
	         			do{
    		 	 			%><tr>
    	 		 			<td><input  type="checkbox" id="<%=manipulateAdd[i][0]%>" name="notInGroups" class="notInGroups" value="<%=manipulateAdd[i][0]%>"/><%=manipulateAdd[i][0]%></td>
    	 		 			</tr>			
    	 	 				<%
    	 	 				i++;
      	   					}while(manipulateAdd[i][0]!=null);
	         			%></table><%
        				}
     				}
    	   	 		catch(Exception e){
        			}
         			%>
       	</div>
		<table>
		<tr>
		<td><input type="submit" value="Add" class="add-button" /></td>
		<td><input type="button" value="Close" class="add-button" onclick="location.href='IvrsServlet?req_type=globalGroupChange'" ></td>
		</tr>
		<tr class="style-tr"></tr>
		</table>
		<input type="hidden" name="memberNumber" value="<%=memberNumber%>"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="hidden" name="req_type" value="addMultiGroups"/>
		
	<% }%>
	<% if(Integer.parseInt(manipulated)==1){%>
		<p>Delete Group(s)</p><br><br>
		<div class="del-grp" style="width:350px;align:center;height:150px;border-style:solid">
     				<%try{
    	 			
     					Object[][] manipulateDelete=groupBean.getManipulate_delete();
         			if(manipulateDelete==null){
						%><br>
						<span class="span">The member is present in no group(s) !</span>
						<%          				
         				}
         			else{%>
         	             <table>
                         <tr>
                         	<td><input type="checkbox" onClick="checkAllToDelete(this);" />
							<b>&nbsp;&nbsp;Select All</b><br/></td>
                         </tr>
	         			<%
	         			Integer j=0;
	         			do{
    		 	 			%>
    		 	 			<tr>
    	 		 			<td><input type="checkbox" id="<%=manipulateDelete[j][0]%>" name="inGroups" class="inGroups" value="<%=manipulateDelete[j][0]%>"/><%=manipulateDelete[j][0]%>
    	 		 			</td>
    	 		 			</tr>			
    	 	 				<%
    	 	 				j++;
      	   					}while(manipulateDelete[j][0]!=null);
	         			%>
	         			</table>
	         			<%
        				}
     				}
    	   	 		catch(Exception e){
        			}
         			%>
       	</div>
		<table>
		<tr>
		<td><input type="submit" value="Delete" class="add-button"/></td>
		<td><input type="button" value="Close" class="add-button" onclick="location.href='IvrsServlet?req_type=globalGroupChange'"></td>
		</tr>
		<tr class="tr"></tr>
		</table>
	    <input type="hidden" name="memberNumber" value="<%= memberNumber%>"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="hidden" name="req_type" value="deleteMultiGroups"/>
		<% }%>
		</form>
 </div>

</body>
</html>
