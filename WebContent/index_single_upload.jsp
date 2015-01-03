<%@ page language="java"%>
<HTml>
<HEAD>
<TITLE>Display file upload form to the user</TITLE>

</HEAD>
<% //  for uploading the file we used Encrypt type of multipart/form-data and input of file type to browse and submit the file %>
<BODY>
	<FORM ENCTYPE="multipart/form-data" ACTION="addFiles.jsp" METHOD=POST>
		<br>
		<br>
		<br>
		<center>
			<table border="2">
				<tr>
					<center>
						<td colspan="2"><p align="center">
								<B>PROGRAM FOR UPLOADING THE FILE</B>
							<center></td>
				</tr>
				<tr>
					<td><b>Choose the file To Upload:</b></td>
					<td><INPUT NAME="file" TYPE="file" id="file"> <input
						type="hidden" name="UploadDelete" id="UploadDelete" value="Upload">
					</td>
				</tr>

				<tr>
					<td colspan="2"><p align="right">
							<INPUT TYPE="submit" VALUE="Send File">
						</p></td>
				</tr>
				<table>
					</center>
					</FORM>
</BODY>
</HTML>