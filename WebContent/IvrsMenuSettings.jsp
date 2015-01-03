<!DOCTYPE html >

<!-- 
Document : IvrsMenuSettings.jsp

 -->

<%@ page import="com.iitb.SettingsBean.IvrsMenuSettingsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean"
	scope="session" />
<jsp:useBean id="ivrsMenuSetting"
	class="com.iitb.SettingsBean.IvrsMenuSettingsBean" scope="session" />



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IVRS Menu Settings</title>

<link rel="stylesheet" type="text/css" href="css/Main.css" />
<link rel="stylesheet" href="css/jquery-ui.css" />

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/Validate.js"></script>
<script type="text/javascript">
	$(function() {
		
			    $( "#tabs" ).tabs();
		$("#record").on('click', function(e) {
			e.preventDefault();
			$('<div/>', {
				'class' : 'myDlgClass',
				'id' : 'link-' + ($(this).index() + 1)
			}).html($('<iframe/>', {
				'src' : $(this).attr('href'),
				'style' : 'width:100%; height:100%;border:none;'
			})).appendTo('body').dialog({
				'title' : $(this).text(),
				'width' : 500,
				'height' : 350,
				buttons : [ {
					text : "Close",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});
		});
	});
	$(function() {
		$('a').on('click', function(e) {
			e.preventDefault();
			$('<div/>', {
				'class' : 'myDlgClass',
				'id' : 'link-' + ($(this).index() + 1)
			}).html($('<iframe/>', {
				'src' : $(this).attr('href'),
				'style' : 'width:100%; height:100%;border:none;'
			})).appendTo('body').dialog({
				'title' : $(this).text(),
				'width' : 500,
				'height' : 350,
				buttons : [ {
					text : "Close",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});
		});
	});
</script>
<style>
#login table tr{
vertical-align:top;
}
#record{
background-color:cadetblue;
}
#record1{
background-color:cadetblue;
}
#upload{
background-color:cadetblue;
}
</style>
</head>

<body>
<div id="tabs" class="tabs">
	<%
		if (loginUser.getUsername() == null
				|| loginUser.getParent_org() == null
				|| loginUser.getOrg_id() == null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("Login.jsp");
			requestDispatcher.forward(request, response);

		}

		IvrsMenuSettingsBean ivrsMenuSettings = (IvrsMenuSettingsBean) request
				.getAttribute("IvrsMenuSettingsBean");

		try {
			String welcome_message = ivrsMenuSettings.getWelcome_message();
			String farewell = ivrsMenuSettings.getFarewell();
			String semi_structured_main = ivrsMenuSettings
					.getSemi_structured_main();
			String structured_main = ivrsMenuSettings.getStructured_main();
			String unstructured_main = ivrsMenuSettings
					.getUnstructured_main();
			String structured_one = ivrsMenuSettings.getStructured_one();
			String structured_two = ivrsMenuSettings.getStructured_two();
			String semi_structured_one = ivrsMenuSettings
					.getSemi_structured_one();
			String semi_structured_two = ivrsMenuSettings
					.getSemi_structured_two();

			String semi_structured_three = (String) ivrsMenuSettings
					.getSemi_structured_three();
			String semi_structured_recording = (String) ivrsMenuSettings
					.getSemi_structured_recording();
			String semi_structured_cancelled = (String) ivrsMenuSettings
					.getSemi_structured_cancelled();
			String semi_structured_confirm = (String) ivrsMenuSettings
					.getSemi_structured_confirm();
			String semi_structured_rerecord = (String) ivrsMenuSettings
					.getSemi_structured_rerecord();
			String unstructured_feedback_record = (String) ivrsMenuSettings
					.getUnstructured_feedback_record();
			String semi_strucutred_recorded = (String) ivrsMenuSettings
					.getSemi_structured_recorded();

			String structured_answer_yes = (String) ivrsMenuSettings
					.getStructured_answer_yes();
			String structured_answer_no = (String) ivrsMenuSettings
					.getStructured_answer_no();
			String unstructured_recorded = (String) ivrsMenuSettings
					.getUnstructured_recorded();
			String unstructured_confirm = (String) ivrsMenuSettings
					.getUnstructured_confirm();
			String unstructured_rerecord = (String) ivrsMenuSettings
					.getUnstructured_rerecord();
			String semi_structured = (String) ivrsMenuSettings
					.getSemi_structured();
			String unstructured = (String) ivrsMenuSettings
					.getUnstructured();
			String structured = (String) ivrsMenuSettings.getStructured();
			String press = (String) ivrsMenuSettings.getPress();
			String one = (String) ivrsMenuSettings.getOne();
			String two = (String) ivrsMenuSettings.getTwo();
			String three = (String) ivrsMenuSettings.getThree();
			String for_text = (String) ivrsMenuSettings.getFor_text();
			String languageToDIsplay = ivrsMenuSettings
					.getLanguage_to_display();
			String language = (String) session.getAttribute("ln");
	%>


	<div id="response">
		<!-- <div id="header"><h1 class="heading">Rural IVRS</h1></div> -->

		<div>
<ul >	<li><a href="#ivrs">IVRS Menu Settings <%=languageToDIsplay%></a>
		</li>
				</ul>
			<div id='login' class="login-ivrs">
			

				<form action="IvrsServlet" method="POST" id="ivrsMenuSettings" style="width:850px;"  >

					<table style="width:850px;"  >
						<tr style="width:850px;" >
							<td style="width:188px;">Order <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br> <%
								}
							%>:
							</td>
							<td style="width:428px;"><input type="text" name="mainMenuOne" class="table-input-1" class="table-input-1" id="mainMenuOne"
								value="<%=semi_structured%>" size="33" readonly="readonly"><br></br></td>
							<td style="width:108px;">&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record1" style="color:white;">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td style="width:116px;">&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_structured&ln=<%=language%>"
								target='content-iframe' id="upload" style="color:white;">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>


						</tr>

						<tr >
							<td>Feedback <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuOne" class="table-input-1" id="mainMenuOne"
								value="<%=unstructured%>" size="33" readonly="readonly"><br></br></td>
							<td >&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record1">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td >&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=unstructured&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>


						</tr>

						<tr >
							<td>Response <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuOne" class="table-input-1" id="mainMenuOne"
								value="<%=structured%>" size="33" readonly="readonly"><br></br></td>
							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record1">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=structured&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>


						</tr>

						<tr >
							<td>Press <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuOne" class="table-input-1" id="mainMenuOne"
								value="<%=press%>" size="33" readonly="readonly"><br></br></td>
							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record1">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=pressR&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>


						</tr>

						<tr>
							<td>One <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuOne" class="table-input-1" id="mainMenuOne"
								value="<%=one%>" size="33" readonly="readonly"><br></br></td>
							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record1">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=oneR&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>


						</tr>

						<tr>
							<td>Two <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuOne" class="table-input-1" id="mainMenuOne"
								value="<%=two%>" size="33" readonly="readonly"><br></br></td>
							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record1">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=twoR&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>


						</tr>

						<tr>
							<td>Three <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuOne" class="table-input-1" id="mainMenuOne"
								value="<%=three%>" size="33" readonly="readonly"><br></br></td>
							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record1">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=threeR&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>


						</tr>
						<tr>
							<td>For <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuOne" class="table-input-1" id="mainMenuOne"
								value="<%=for_text%>" size="33" readonly="readonly"><br></br></td>
							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record1">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=forR&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>


						</tr>


						<tr>
							<td>Thanking message <%
								if (language.equals("mr")) {
							%><br> <%
								} else if (language.equals("hi")) {
							%><br> <%
								}
							%>:
							</td>
							<td><input type="text" name="thankingMessage" class="table-input-1"
								id="thankingMessage" value="<%=farewell%>" size="33" readonly="readonly"><br>
								<br /></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=thanks_msg&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td colspan="4"><b><br>Semi Structured(Order) Menu <%
								if (language.equals("mr")) {
							%><%
								} else if (language.equals("hi")) {
							%><%
								}
							%>&nbsp;:<br>
							</b><br> <br /></td>
						</tr>



						<tr>
							<td>Key Press 1 <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="semi_structured_one" class="table-input-1" class="table-input-1"
								id="semi_structured_one" value="<%=semi_structured_one%>"
								size="33" readonly="readonly"><br></br></td>
							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								shref="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_structured_one&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td>Key Press 2 <%
								if (language.equals("mr")) {
							%><br> <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="semi_structured_two" class="table-input-1"
								id="semi_structured_two" value="<%=semi_structured_two%>"
								size="33" readonly="readonly"><br></br></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_structured_two&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td>id of cancellation <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br> <%
								}
							%>:
							</td>

							<td><input type="text" name="semi_structured_three" class="table-input-1"
								id="semi_structured_three" value="<%=semi_structured_three%>"
								size="33" readonly="readonly"><br></br></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_structured_three&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td>For order record <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="semi_structured_recording"
								id="semi_structured_recording" class="table-input-1"
								value="<%=semi_structured_recording%>" size="33" readonly="readonly"><br></br>
							</td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_structured_recording&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td>Order cancelled <%
								if (language.equals("mr")) {
							%><br> <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="semi_structured_cancelled"
								id="semi_structured_cancelled" class="table-input-1"
								value="<%=semi_structured_cancelled%>" size="33" readonly="readonly"><br></br>
							</td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_structured_cancelled&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>

						<tr>
							<td>Order confirmation <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="semi_structured_confirm"
								id="semi_structured_confirm" class="table-input-1"
								value="<%=semi_structured_confirm%>" size="33" readonly="readonly"><br></br>
							</td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_structured_confirm&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>

						<tr>
							<td>Rerecord order <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br> <%
								}
							%>:
							</td>
							<td><input type="text" name="semi_structured_rerecord"
								id="semi_structured_rerecord" class="table-input-1"
								value="<%=semi_structured_rerecord%>" size="33" readonly="readonly"><br></br>
							</td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_structured_rerecord&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>

						<tr>
							<td>Order recorded <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="semi_strucutred_recorded"
								id="semi_strucutred_recorded" class="table-input-1"
								value="<%=semi_strucutred_recorded%>" size="33" readonly="readonly"><br></br>
							</td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=semi_strucutred_recorded&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>
						<tr>
							<td colspan="4"><b><br>Unstructured (Feedback) Menu <%
								if (language.equals("mr")) {
							%><%
								} else if (language.equals("hi")) {
							%> <%
								}
							%>&nbsp;:<br>

							</b> <br> <br /></td>
						</tr>

						<tr>
							<td>Main menu two <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuTwo" id="mainMenuTwo" class="table-input-1"
								value="<%=unstructured_main%>" size="33" readonly="readonly"><br></br></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=unstructured_main&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>
						<tr>
							<td>Feedback Record <%
								if (language.equals("mr")) {
							%><br> <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="unstructured_feedback_record"
								id="unstructured_feedback_record" class="table-input-1"
								value="<%=unstructured_feedback_record%>" size="33" readonly="readonly"><br></br>
							</td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=unstructured_feedback_record&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>

						<tr>
							<td>Feedback Recorded <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="unstructured_recorded" class="table-input-1"
								id="unstructured_recorded" value="<%=unstructured_recorded%>"
								size="33" readonly="readonly"><br></br></td>
							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=unstructured_recorded&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>
						</tr>

						<tr>
							<td>Confirm Feedback <%
								if (language.equals("mr")) {
							%><br> <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="unstructured_confirm" class="table-input-1"
								id="unstructured_confirm" value="<%=unstructured_confirm%>"
								size="33" readonly="readonly" ><br></br></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=unstructured_confirm&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>

						<tr>
							<td>Feedback rerecord <%
								if (language.equals("mr")) {
							%><br> <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="unstructured_rerecord" class="table-input-1"
								id="unstructured_rerecord" value="<%=unstructured_rerecord%>"
								size="33" readonly="readonly"><br></br></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=unstructured_rerecord&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>


						<tr>
							<td colspan="4"><b><br>Structured(Response) Menu <%
								if (language.equals("mr")) {
							%><%
								} else if (language.equals("hi")) {
							%><%
								}
							%>&nbsp;:<br>


							</b><br> <br /></td>
						</tr>
						<tr>
							<td>Main menu three <%
								if (language.equals("mr")) {
							%><br> <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="mainMenuThree" class="table-input-1"
								id="mainMenuThree" value="<%=structured_main%>" size="33" readonly="readonly" /><br>
								<br /></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=structured_main&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td>Positive response <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="responsePositive" class="table-input-1"
								id="responsePositive" value="<%=structured_one%>" size="33"
								readonly="readonly" /><br> <br /></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=structured_one&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td>Negative response <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="responseNegative" class="table-input-1"
								id="responseNegative" value="<%=structured_two%>" size="33"
								readonly="readonly" /><br> <br /></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=structured_two&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td>Positive answer <%
								if (language.equals("mr")) {
							%><br>  <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="structured_answer_yes" class="table-input-1"
								id="structured_answer_yes" value="<%=structured_answer_yes%>"
								size="33" readonly="readonly" /><br> <br /></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=structured_answer_yes&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
						<tr>
							<td>Negative answer <%
								if (language.equals("mr")) {
							%><br> <%
								} else if (language.equals("hi")) {
							%><br>  <%
								}
							%>:
							</td>
							<td><input type="text" name="structured_answer_no" class="table-input-1"
								id="structured_answer_no" value="<%=structured_answer_no%>"
								size="33" readonly="readonly"/><br> <br /></td>

							<td>&nbsp;&nbsp;&nbsp;<a class="style"
								href="Recorder/index.html" target='content-iframe' id="record">&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>
							</td>
							<td>&nbsp;&nbsp;&nbsp; <a class="style"
								href="FileUploadForm.jsp?fileName=structured_answer_no&ln=<%=language%>"
								target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
							</td>

						</tr>
					</table>



					<input type="hidden" name="req_type" id="req_type"
						value="ivrsUpdate" /> <input type="hidden" name="ln" id="ln"
						value="<%=language%>" /> <!-- input type="submit" name="but1"
						id="but1" class="add-button" value="Submit"
						onclick="disableButton('but1');location.href='#top'" /-->&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="Restore Defaults" class="add-button"
						onclick="restoreDefaults('restoreDefaults','defaults');location.href='#top';" />
					&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="Record_Submit" class="add-button"
						onclick="restoreDefaults('recordedVoices','your voice');location.href='#top';" />

				</form>

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
