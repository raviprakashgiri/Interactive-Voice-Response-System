<!DOCTYPE html>

<!-- 
Document : NamesOfWell.jsp
Modified By : Nachiketh(Conversion to MVC)
 -->

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.iitb.WellinfoBean.*"%>
<%@page import="com.iitb.globals.*"%>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean"
	scope="session" />


<html>

<head>
<link rel="stylesheet" type="text/css" href="css/Main.css">
</head>

<body>
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
		String findTehsil = (String) session.getAttribute("findTehsil");
		String findVillage = (String) session.getAttribute("findVillage");
		String getWellData = (String) session.getAttribute("getWellData");

		WellDataBean wellData = (WellDataBean) request
				.getAttribute("wellDataBean");

		//Displaying the Thesil name
		if (findTehsil.equals("1")) {

			Object tehsilNames[][] = wellData.getTehsil_names();
	%>
	<select name="tehsilview" id="tehsilview" class="view">
		<option value='0'>Select</option>
		<%
			for (int i = 0; tehsilNames != null && i < tehsilNames.length; i++) {
		%>
		<option value='<%=tehsilNames[i][0]%>'><%=tehsilNames[i][0]%></option>
		<%
			}

				System.out.println("DONE TEHSIL !");
		%>
	</select>
	<%
		}
	%>

	<%
		//Displaying the Village name
		if (findVillage.equals("1")) {

			Object villageName[][] = wellData.getVillage_name();
	%>
	<select name="villageview" id="villageview" class="view">
		<option value='0'>Select</option>
		<%
			for (int i = 0; villageName != null && i < villageName.length; i++) {
		%>
		<option value='<%=villageName[i][0]%>'><%=villageName[i][0]%></option>
		<%
			}
				System.out.println("DONE VILLAGE !");
		%>
	</select>
	<%
		}
	%>


	<%
		//Displaying the Well data
		if (getWellData.equals("1")) {

			Object wellInfo[][] = wellData.getWell_data();

			if (wellInfo.length == 0) {
	%>
	<span class="span-nfw">Data Not Found !</span>

	<%
		} else {
	%>
	<table class="td">
		<tr>
			<th class="td">		Well name/number	</th>
			<th class="td">Water Level</th>
			<th class="td">Record Date</th>
		<tr>
			<%
				for (int i = 0; wellInfo != null && i < wellInfo.length; i++) {
			%>
		
		<tr>
			<td class="td">&nbsp;&nbsp;<%=wellInfo[i][0]%></td>
			<td class="td">&nbsp;&nbsp;<%=wellInfo[i][1]%></td>
			<td class="td">&nbsp;&nbsp;<%=wellInfo[i][2]%></td>
		</tr>
		<%
			}
				}
			}
		%>
	</table>

</body>
</html>