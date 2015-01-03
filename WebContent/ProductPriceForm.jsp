<%@page import="com.iitb.globals.ConfigParams"%>
<%@page  language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<%
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
    requestDispatcher.forward(request, response);  
}
%>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
  <link rel="stylesheet" type="text/css" href="css/Main.css">
  <link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
  
  <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
  <script type="text/javascript" src="js/jquery-ui.js"></script>
  <script type="text/javascript" src="js/Validate.js"></script>

  <script>
  $(function() {
    $( "#tabs" ).tabs();
    
    $( "#confirm-delete-group-dialog" ).dialog({
    	resizable: false,
    	autoOpen: false,
    	modal: true,
    	buttons: {
    	"Delete Group": function() {
    	$( this ).dialog( "close" );
    	deleteGroup(<%=request.getParameter("group_id")%>);
    	},
    	Cancel: function() {
    	$( this ).dialog( "close" );
    	}
    	}
    	});
    
    $( "#edit-member-dialog" ).dialog({
    	resizable: false,
    	height:400,
    	width:500,
    	autoOpen: false,
    	modal: true,
    	buttons: {
		"Update Details": function(){
        var member_id=$("#member_id").val();
        var member_name=$("#member-name").val();
        var member_number=$("#member-number").val();
        var member_username=$("#member_username").val();
        var member_password=$("#member-password").val();
        var userLogin=$("#user-login").val();
        updateMemberDetails(member_id,member_name,member_number,member_username,member_password,userLogin);
       	},
    	Cancel: function() {
    	$( this ).dialog( "close" );
    	}
    	}
    	});
  }); 

  $(document).ready(function(){
	  var flag=<%String refresh=request.getParameter("refresh");
		if(refresh!=null){
		 	 out.print("true");
 			}
 			else out.print("false");%>;
	  if(flag){
		  window.top.location.reload();
	  }
	  
	  //This is the delete group dialog 
	  $("#delete-group-button").click(function(){
		     $("#confirm-delete-group-dialog").dialog( "open" );
	   });
	  
    var dialog=$( "#dialog" );

    $(function(){
      dialog.dialog({
        autoOpen: false,
        width: '70%'
      });
    });
    $("#addMemberButton").click(function(){
     dialog.dialog( "open" );
   });
    var publishers_dialog=$( "#publishers-dialog" );

    $(function(){
      publishers_dialog.dialog({
        autoOpen: false,
        width: '70%'
      });
    });
    $("#addPublishersButton").click(function(){
     publishers_dialog.dialog( "open" );
   });
  });
</script>
<script type="text/javascript" src="js/Validate.js"></script>
<!-- Code to check all the checkboxes -->
</head>
<body>
<table>
      <div id="select-container">
		</div>
	  <button id="add" onclick="addSelect('select-container');">Add Dropdown</button>
      <div id="quantity"><br><P>
            <form id="form1" name="form1" method="post" action="IvrsServlet">
      		<input name="quantity" type="text" id="quantity" required/><br><P>
        	<div id="div2"></div>
        	<P><br>
        	<p><input type="button" value="Add" class="add-button" onclick="generateRow1()"/></p>
        	<input type="hidden" name="req_type" value="ProductQuantity" />
			<input type="submit" name="Submit" value="Submit" class="add-button"/>
      <table>  
      </form>
      </table>
      </div>
      </table>
      <br>
   		<input type="hidden" value="productDetail" name="req_type" id="req_type"/>  
 		<input type="submit" value="SAVE" class="add-button" /> 
    </div>
</form>    
</div>

</body>
</html>