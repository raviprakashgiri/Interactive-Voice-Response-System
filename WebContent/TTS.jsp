<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <form method="post" action="Test2.jsp" id="formevent" name="formevent"> --%>
	<form action="Test3.jsp" method= "post" >
	    <input type="hidden" id="AJAX" name="AJAX" value="on"> 
	    <p>
	    <table width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td>Select a Voice</td>
	      <td>Type the text to synthesise (max 70 chars)</td>
	    </tr>
	    <tr>
	      <td>
	        <select id='voice' name='voice'>
			  	<optgroup label="DHVANI">
		            <option value='hindi'>Hindi</option>
			    	<option value='marathi'>Marathi</option>
			  	</optgroup>
			 	<optgroup label="FESTIVAL">
		            <option value='fshin'>Hindi</option>
		            <option value='fsmr'>Marathi</option>
		      		<option value='fseng'>English</option>
		 		</optgroup>	
			</select>
	      </td>
	      <td>
	      	<input type=text id="UserText" name="UserText" size="70" maxLength="70" value="Type your text here.">
	      </td>
	      <td>
			<input type="submit" id="submit" name="submit" value="say it!">
	      </td>	
	    </tr> 
	    </table>
	    </p>
	</form>
</body>
</html>