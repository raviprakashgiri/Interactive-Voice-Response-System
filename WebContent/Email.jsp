<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 
Document: Email.jsp
Author: Mehul Smriti Raje
-->

<%@page import="com.iitb.globals.*"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean"
	scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
  <link rel="stylesheet" type="text/css" href="css/Main.css">
  <link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
  
  <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
  <script type="text/javascript" src="js/jquery-ui.js"></script>
  <script type="text/javascript" src="js/Validate.js"></script>

<title>Email</title>
</head>


<script language="javascript" type="text/javascript">
$(function() {
    $( "#tabs" ).tabs();
});

	var i = 1;

	/*Function to add another file selector
	*On clicking button 'add'
	*/
	function addRow() {
		var original = document.getElementById('att0');
		var clone = original.cloneNode(true);
		clone.name = "att"+i;
		clone.id="att"+i;
		i++;
		document.getElementById('files').appendChild(clone);
	}

	/*Function to removee a file selector
	*On clicking button 'sub'
	*/	
	function removeRow() {
		document.getElementById('att' + (--i)).remove();
	}
	
	/*Function to enable choosing of recipients
	*On clicking button 'to'
	*/
	function transport()
	{
		//document.getElementById("right").style.display="block";
		$( "#right" ).dialog("open");
		$("#right").show();
	}
	 $(function () {
		  $( "#right" ).dialog({
		    	resizable: false,
		    	height:350,
		    	width:710,
		    	autoOpen: false,
		    	modal: true,
		    });
	  });
	
	/*
	*Function to choose all the members of all groups as recipients
	*On clicking button 'all'
	*/
	function selectAll()
	{
		var a=new Array();
		a=document.getElementsByName("allGroups");
		for(var i=0;i<a.length;i++)
		{	
			a[i].checked=true;
			var b=document.getElementsByName(a[i].value);
			for(var j=0;j<b.length;j++)
			{
				b[j].checked=true;
			}
		}
		
	}
	
	/*Function to unselect all the chosen recipients
	*On clicking button 'dAll'
	*/
	function deselectAll()
	{
		var a=new Array();
		a=document.getElementsByName("allGroups");
		for(var i=0;i<a.length;i++)
		{	
			a[i].checked=false;
			var b=document.getElementsByName(a[i].value);
			for(var j=0;j<b.length;j++)
			{
				b[j].checked=false;
			}
		}
	}
	
	var ids="";
	
	/*Function to finish selection of recipients
	*On clicking button 'done'
	On click, the checkboxes vanish
	*/
	function doneSelection()
	{
		var a=new Array();
		a=document.getElementsByName("allGroups");
		for(var i=0;i<a.length;i++)
		{
			var b=document.getElementsByName(a[i].value);
				for(var j=0;j<b.length;j++)
				{
					if(b[j].checked)
						ids+=b[j].value+",";
				}
		}
		document.getElementById("to").value=ids;

		
		if(ids.length==0)
			alert("Please select recipients!");
		else
			$( "#right" ).dialog("close");
			//document.getElementById("right").style.display="none";
	}
	
	/*Function called when submit button is clicked
	*On clicking button 'email'
	*/
	function view() {

			var x="IvrsServlet?req_type=sendMail&indi_send="+ids;
			document.getElementById("mailform").setAttribute("action",x);
	}

	/*Function to select the members of a particular group as recipients
	*On clicking checkbox for particular group
	*/	
	function selectGroup(x)
	{
		var a=new Array();
		a=document.getElementsByName(x);
		
		var state=document.getElementById(x).checked;
		for(var i=0;i<a.length;i++)
				a[i].checked=state;		
	}
	 
	

</script>
<body>
	<%
		if (loginUser.getUsername() == null
				|| loginUser.getParent_org() == null
				|| loginUser.getOrg_id() == null) {
			RequestDispatcher rd = request
					.getRequestDispatcher("Login.jsp");
			rd.forward(request, response);
		}

		String req_type = request.getParameter("req_type");
		String subject = "";
		String content = "";

		/*This request type processes requests to email the price list of vegetables
		 * ProductForm.jsp
		 * IvrsServlet
		 * @uthor: Mehul Smriti Raje
		 */
		if (req_type.equals("list")) {
			content = request.getParameter("list");
			String temp[] = content.split(",");
			content = "The new price list is:<br/>";
			for (int i = 0; i < temp.length; i++)
				content += temp[i] + "<br/>";
			subject = "Price List";
		}

		/*This request type processes requests to email the bills of purchases
		 * ViewPrintBill.jsp
		 * IvrsServlet
		 * @uthor: Mehul Smriti Raje
		 */
		else if (req_type.equals("bill")) {
			content = request.getParameter("bill");
			String temp[] = content.split(",");
			content = "";
			for (int i = 0; i < temp.length; i++)
				content += temp[i] + "<br/>";
			subject = "Billing Details";
		}
	%>

	<!-- This div forms the email form -->
	<div id="tabs" class="tabs">
	<ul>
      
      <li><a href="#sendemail">Send Email <br></a></li>
      <!-- <li><a href="#reports">Reports</a></li>
      <li><a href="#settings">Settings</a></li> -->
    </ul>
	<div id="left" style="width: 60px">
		<form method="post" id="mailform" enctype="multipart/form-data">
			<table style="border: none">
				<tr>
					<td>To:</td>
					<td><input type="text" id="to" name="to" size=40
						style="display: none" /> <input type="button" id="choose" style="background-color:cadetblue;"
						name="choose" value="Select Recipients" onClick="transport()" /></td>
				</tr>
				<tr>
					<td>Subject:</td>
					<td><textarea id="sub" name="subject" cols=60 rows=1><%=subject%></textarea></td>
				</tr>
				<tr>
					<td valign='top'>Description:</td>
					<td><textarea name="desc" id="desc" cols=60 rows=10><%=content%></textarea></td>
				</tr>
			</table>

			<div id="files">
				<input type="file" id="att0" name="att0" size="20" />
				<!-- <input type="button" name="add_file" id="attach-button"
						onClick="document.getElementById('att').click()" value="Attachment" /> -->
				<!--<textarea name="list" id="list"></textarea>-->
			</div>

			<input type="button" id="add" style="background-color:cadetblue;" name="add" value="+" onClick="addRow()" />
			<input type="button" id="sub" style="background-color:cadetblue;" name="sub" value="-" onClick="removeRow()" /> 
				<input type="hidden" name="req_type" id = "sendMail" value="sendMail">
				<br>
				&nbsp;
				<button type="submit" name="email" class="btn btn-info" style="width:200px;"
				id="email" onclick="view()">Send Email<br></button>
		</form>
	</div>
</div>

	<%
		String url = "jdbc:mysql://10.129.1.106/advisorysystem";
		String username = "ivrs_root";
		String password = "ivrs_123";
		Statement stmt1 = null, stmt2 = null;
		Connection con = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, username, password);
			stmt1 = con.createStatement();
			stmt2 = con.createStatement();
		} catch (Exception e) {
			out.println("Not connected");
		}
	%>

	<!-- This div allows the admin to choose the recipients -->
	<div id="right" style="display: none;" style="width:40px">
		<h3>Select Recipients:</h3>
		<form name="fillform">
			<input type="button" id="all" style="background-color:cadetblue;" value="Select All" onClick="selectAll()" />
			<input type="button" id="dAll" style="background-color:cadetblue;" value="Deselect All" onClick="deselectAll()" />
			
			<table>
				<%
					//obtaining the group ids and group names of all groups
					ResultSet rs = null;
					try {
						rs = stmt1
								.executeQuery("select groups_id, groups_name from groups");
					} catch (Exception e) {
						out.println("none");
					}
					while (rs.next()) {
						int x = Integer.parseInt(rs.getString("groups_id"));
						String y = "selectGroup(" + x + ")";
				%>
				<tr>
					<td><input type="checkbox" name="allGroups" id=<%=x%>
						value=<%=x%> onClick=<%=y%>></td>
					<td><%=rs.getString("groups_name")%></td>
				</tr>
				<tr>
					<!-- Inner table for each group -->
					<td></td>
					<td>
						<div id=<%=x%>>
							<table>
								<%
									//obtaining the ids and names of all the members of each group
										ResultSet inner = null;
										try {
											inner = stmt2
													.executeQuery("SELECT  m.member_name as name, m.member_detail_id as id"+
															" FROM member m, member_details md"+
															" WHERE m.member_detail_id=md.members_detail_id AND groups_id="+x+ 
															" AND member_email_id like '%@%';");
										} catch (SQLException e) {
											System.out.println("none");
										}

										while (inner.next()) {
								%>
								<tr>
									<td><input type="checkbox" name=<%=x%>
										value=<%=inner.getString("id")%>></td>
									<td><%=inner.getString("name")%>
								</tr>
								<%
									}
								%>
							</table>
						</div>
					</td>
				</tr>
				<%
					}
				%>

			</table>
			
		</form>
		<br>
		<input type="button" id="done" style="background-color:cadetblue;" value="Done" onClick="doneSelection()" />
	</div>


</body>
</html>