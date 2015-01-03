<!DOCTYPE html>
<!-- 
Document : SystemSettings.jsp
Modified By : Ravi Prakash Giri
 -->

<%@page import="com.iitb.globals.*"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="settings" class="com.iitb.SettingsBean.SettingsBean"
	scope="request"></jsp:useBean>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean"
	scope="session" />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="css/Main.css">
<link rel="stylesheet" href="css/jquery-ui.css" />

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/Validate.js"></script>
<script>
	$(function() {
		$("#tabs").tabs();
		$("#report-tabs").tabs();
		$("#confirm-delete-group-dialog").dialog({
			resizable : false,
			autoOpen : false,
			modal : true,
			buttons : {
				"Delete Group" : function() {
					$(this).dialog("close");
					deleteGroup(
<%=request.getParameter("group_id")%>
	);
				},
				Cancel : function() {
					$(this).dialog("close");
				}
			}
		});

		$("#edit-member-dialog").dialog(
				{
					resizable : false,
					height : 400,
					width : 500,
					autoOpen : false,
					modal : true,
					buttons : {
						"Update Details" : function() {
							var memberId = $("#member_id").val();
							var memberName = $("#member-name").val();
							var memberNumber = $("#member-number").val();
							var memberUsername = $("#member-username").val();
							var memberPassword = $("#member-password").val();
							var userLogin = $('#user-login').is(':checked');
							updateMemberDetails(memberId, memberName,
									memberNumber, memberUsername,
									memberPassword, userLogin);
						},
						Cancel : function() {
							$(this).dialog("close");
						}
					}
				});
	});

	$(document)
			.ready(
					function() {
						var flag =
<%String refresh = request.getParameter("refresh");
			if (refresh != null) {
				out.print("true");
			} else
				out.print("false");%>
	;
						if (flag) {
							window.top.location.reload();
						}

						//This is the delete group dialog 
						$("#delete-group-button").click(function() {
							$("#confirm-delete-group-dialog").dialog("open");
						});

						var dialog = $("#dialog");

						$(function() {
							dialog.dialog({
								autoOpen : false,
								width : '70%'
							});
						});
						$("#addMemberButton").click(function() {
							dialog.dialog("open");
						});
						var publishersDialog = $("#publishers-dialog");

						$(function() {
							publishersDialog.dialog({
								autoOpen : false,
								width : '70%'
							});
						});
						$("#addPublishersButton").click(function() {
							publishersDialog.dialog("open");
						});
					});
</script>
</head>
<body onload="disableDropdown()">

	<%
		
		
		
		if (loginUser.getUsername() == null) {

			refresh = request.getParameter("refresh");

			String flag = "0";
			if (refresh != null) {
				flag = "1";
			}

		}
	%>

	<%
		if (loginUser.getUsername() == null
				|| loginUser.getParent_org() == null
				|| loginUser.getOrg_id() == null) {
			RequestDispatcher requestDispatcher = request
					.getRequestDispatcher("Login.jsp");
			requestDispatcher.forward(request, response);
		}
	%>


	<%
		try {
	%>
	<div id="tabs">
		<ul>
			<li><a href="#settings">Settings</a></li>
		</ul>

		<div id="settings">
			<form ENCTYPE="multipart/form-data" action="IvrsServlet"
				method="post" name="global_group_settings" id="globalgroupSettings"
				onsubmit="check();">
				<table>


					<%
						Object[][] data = settings.getSystem_data();
							String data1 = data[0][10].toString();
							String data2 = data[0][9].toString();
							String data3 = data[0][8].toString();
							String data4 = data[0][5].toString();
							String data5 = data[0][4].toString();
							String data6 = data[0][11].toString();
							String data7 = data[0][12].toString();
							String data8 = data[0][13].toString();
							String data9 = data[0][14].toString();
							String data10 = data[0][15].toString();
							System.out.println(data[0][15] + "============================"
									+ data10);
					%>

					<tr>
						<td>Email Address&nbsp;:</td>
						<td><input type="email" name="email_id" id="email_id"
							class="table-input-1" value="<%=data[0][2]%>" required /></td>

					</tr>
					<tr>
						<td>Welcome Message&nbsp;</td>
						<td><input type="file" name="welcome_message"
							id="welcome_message"></td>
					</tr>
					<%
						if (!data[0][0].equals("")) {
					%>
					<tr>
						<td><audio controls>
								<source src="<%=data[0][0]%>" type="audio/wav"></source>

							</audio> <a href="<%=data[0][0]%>" target="_blank"
							title="Right Click Save Link as">Download&nbsp;</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
				</table>
				<%
					}
				%>
				<table>

					<tr>
						<b>OUTGOING CALL SETTINGS</b>
					</tr>
					<tr>
						<td>Language&nbsp;<br> <input type="checkbox"
							name="language" id="language" value="4"
							<%if (data[0][1].equals("4")) {
					out.print("checked");
				}%> />Hindi&nbsp;<br>
							<input type="checkbox" name="language" id="language" value="5"
							<%if (data[0][1].equals("5")) {
					out.print("checked");
				}%> />Marathi&nbsp;<br>
							<input type="checkbox" name="language" id="language" value="6"
							<%if (data[0][1].equals("6")) {
					out.print("checked");
				}%> />English&nbsp;<br>

						</td>
						<td></td>
						<td>Response&nbsp;<br> <input type="checkbox"
							name="response1" value="1"
							<%if (data[0][3].equals("1")) {
					out.print("checked='checked'");
				}%> />SemiStructured&nbsp;(Order)<br>
							<input type="checkbox" name="response1" value="2"
							<%if (data[0][3].equals("2")) {
					out.print("checked='checked'");
				}%> />Unstructured&nbsp;(Feedback)<br>
							<input type="checkbox" name="response1" value="3"
							<%if (data[0][3].equals("3")) {
					out.print("checked='checked'");
				}%> />Structured&nbsp;(Response)<br>
						</td>
					</tr>


					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td><b>INCOMING CALL SETTINGS</b></td>
					</tr>
					<tr>
						<td>Language Incoming&nbsp;<br> <input type="checkbox"
							name="languagein" id="language" value="4"
							<%if (data[0][6].equals("4")) {
					out.print("checked='checked'");
				}%> />Hindi&nbsp;<br>
							<input type="checkbox" name="languagein" id="language" value="5"
							<%if (data[0][6].equals("5")) {
					out.print("checked='checked'");
				}%> />Marathi&nbsp;<br>
							<input type="checkbox" name="languagein" id="language" value="6"
							<%if (data[0][6].equals("6")) {
					out.print("checked='checked'");
				}%> />English&nbsp;<br>
							<input type="hidden" name="filePresent" id="filePresent" value="">
						</td>
						<td></td>
						<td>Response Incoming&nbsp;<br> <input
							type="checkbox" name="responsein" value="1"
							<%if (data[0][7].equals("1")) {
					out.print("checked='checked'");
				}%> />SemiStructured&nbsp;(Order)<br>
							<input type="checkbox" name="responsein" value="2"
							<%if (data[0][7].equals("2")) {
					out.print("checked='checked'");
				}%> />Unstructured&nbsp;(Feedback)<br>
							<input type="checkbox" name="responsein" value="3"
							<%if (data[0][7].equals("3")) {
					out.print("checked='checked'");
				}%> />Structured&nbsp;(Response)<br>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
				</table>
				<table>
					<tr>
						<td>Order Cancellation&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><select id='ordercancel' class="table-input-1"
							name='ordercancel'>

								<option value='0'
									<%if (data2.equals("0")) {
					out.print("selected");
				}%>>Disable</option>
								<option value='1'
									<%if (data2.equals("1")) {
					out.print("selected");
				}%>>Enable</option>

						</select></td>
					</tr>
				</table>
				
				<table>

					<tr>
						<td>Broadcast Enabler&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><select id='broadcast' class="table-input-1"
							name='broadcast' onchange="disableDropdown();">
								<option value='0'
									<%if (data5.equals("false")) {
					out.print("selected");
				}%>>Disable</option>
								<option value='1'
									<%if (data5.equals("true")) {
					out.print("selected");
				}%>>Enable</option>
						</select></td>
					</tr>

				</table>

				<table>
				
				

					<div id="Latest_broadcast_div" >

						<tr id="Latest_broadcastdiv">
							<td>Latest broadcast enabler:</td>
							<td><select name="Latest_broadcast" class="table-input-1"
								id="Latest_broadcast" style="width: auto;">
									<option value="0"
										<%if (data1.equals("0")) {
					out.print("selected");
				}%>
										>Disable</option>
									<option value="1"
										<%if (data1.equals("1")) {
					out.print("selected");
				}%>
										>Enable</option>

							</select></td>
						</tr>
					</div>
					<div id="Previous_broadcast_div">

						<tr id="Previous_broadcastdiv">
							<td>Previous broadcast enabler:</td>
							<td><select name="Previous_broadcast" class="table-input-1"
								id="Previous_broadcast" style="width: auto; display:block; ">
									<option value="0"
										<% if (data4.equals("false")) {
					out.print("selected");
				}%>>Disable</option>
									<option value="1"
										<% if (data4.equals("true")) {
					out.print("selected");
				}%>>Enable</option>

							</select></td>
						</tr>
					</div>
					
					
					<div id="Repeat_broadcast_div">

						<tr id="Repeat_broadcastdiv">
							<td>Repeat broadcast enabler:</td>
							<td><select name="repeat_broadcast" class="table-input-1"
								id="repeat_broadcast" style="width: auto;">
									<option value="0"
										<%if (data3.equals("0")) {
					out.print("selected");
				}%>>Disable</option>
									<option value="1"
										<%if (data3.equals("1")) {
					out.print("selected");
				}%>>Enable</option>

							</select></td>
							<br>
							<br>
						</tr>
					</div>
					
				<br/>
					
								
					
					<tr>
						<td>Feedback Enabler &nbsp;</td>
						<td><select id='feedback' class="table-input-1"
							name='feedback' style="width: auto;">
								<option value='0'
									<%if (data6.equals("0")) {
					out.print("selected");
				}%>>Disable</option>
								<option value='1'
									<%if (data6.equals("1")) {
					out.print("selected");
				}%>>Enable</option>
						</select></td>
					</tr>
					
					
					<tr>
						<td>Response Enabler &nbsp;</td>
						<td><select id='response' class="table-input-1"
							name='response' style="width: auto;">
								<option value='0'
									<%if (data7.equals("0")) {
					out.print("selected");
				}%>>Disable</option>
								<option value='1'
									<%if (data7.equals("1")) {
					out.print("selected");
				}%>>Enable</option>
						</select></td>
					</tr>
					
					
				<!-- 	<tr>
						 <td>Bill Enabler &nbsp;</td> 
						<td><select id='bill' class="table-input-1"
							name='bill' style="width: auto;" onchange="disableBilldown();">
								<option value='0'
									<%if (data8.equals("0")) {
					out.print("selected");
				}%>>Disable</option>
								<option value='1'
									<%if (data8.equals("1")) {
					out.print("selected");
				}%>>Enable</option>
						</select></td>
					</tr>
					
					
					<tr id="enableSave">
						<td>Save Enabler &nbsp;</td>
						<td><select id='save' class="table-input-1"
							name='save' style="width: auto;">
								<option value='0'
									<%if (data9.equals("0")) {
					out.print("selected");
				}%>>Disable</option>
								<option value='1'
									<%if (data9.equals("1")) {
					out.print("selected");
				}%>>Enable</option>
						</select></td>
					</tr>
					
					 -->
						<tr>
						<td>Reject Enabler &nbsp;</td>
						<td><select id='reject' class="table-input-1"
							name='reject' style="width: auto;">
								<option value='0'
									<%if (data10.equals("0")) {
					out.print("selected");
				}%>>Disable</option>
								<option value='1'
									<%if (data10.equals("1")) {
					out.print("selected");
				}%>>Enable</option>
						</select></td>
					</tr>
					
					<tr>
					<td><br></td>
					</tr>
					
					<tr>
						<td><input type="hidden" name="req_type" id="req_type"
							value=""></td>
						<td><input type="submit" value="Save Settings"
							class="add-button" onclick="return SaveSettings2();" /></td>


						<td><input type="button" value="Default Settings"
							class="add-button" onclick="defaultSet();" /></td>

					</tr>
				</table>
				<br>
			</form>
			<!-- Confirm dialog to delete group -->
			<div id="confirm-delete-group-dialog" title="Delete Group ?">
				<p>
					<span class="ui-icon ui-icon-alert"
						style="float: left; margin: 0 7px 20px 0;"></span>The group will
					be deleted permanently.The members of this group will be added to
					Parent group.<br> You want to delete?
				</p>
			</div>
		</div>
	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("Error.html");
		}
	%>
</body>
</html>
