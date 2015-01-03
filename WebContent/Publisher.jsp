<!DOCTYPE html>
<%--
Document   : Publisher.jsp
--%>

<%@page import="com.iitb.globals.*"%>
<%@page  language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />
<jsp:useBean id="publisherBean" class="com.iitb.PublisherBean.PublisherBean" scope="request"/>
<%
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
    requestDispatcher.forward(request, response);  
}
%>

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
    	deleteGroup(<%=request.getParameter("groupId")%>);
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
        var memberId=$("#memberId").val();
        var memberName=$("#memberName").val();
        var memberNumber=$("#memberNumber").val();
        var memberUsername=$("#memberUsername").val();
        var memberPassword=$("#memberPassword").val();
        var userLogin=$("#userLogin").val();
        updateMemberDetails(memberId,memberName,memberNumber,memberUsername,memberPassword,userLogin);
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

function addPublishersInBulk(){
	console.log("======================");
	 $("#status").text("");
	 var memberName=$("#publisher-Name").val();
	 var memberNumber=$("#publisher-Number").val();
	 var groupId=<%= request.getParameter("groupId")%>;
	 var nameflag=true,numflag=true;
	 if(memberName.length==0){
	   nameflag=false;
	   $("#publisher-Name").val(null);
	   $("#publisher-Name").attr("placeholder","Please enter a name");
	 }
	 if(memberNumber.length==0){
	   numflag=false;
	   $("#publisher-Number").val(null);
	   $("#publisher-Number").attr("placeholder","Invalid Phone number");
	   
	 }
	 if(numflag&&nameflag){
	   console.log(memberName);
	   console.log(memberNumber);
	   
	   $.ajax({
	    url: 'IvrsServlet',
	    type: 'POST',
	    data: {'req_type':'addNewPublisher','memberName':memberName,'memberNumber':memberNumber,'groupId':groupId,'memberRole':'publisher'},
	    error: function(){
	      $("#status").text("error");
	    },
	    success: function(data){
	      $("#status").text(data);
	      if(data=='Success'){
	        $("#publisher-Name").val("");
	        $("#publisher-Number").val("");
	        $("#status").text("Members added successfully");
	        $("#done").css({'display':'block'});
	      }
	    }
	  });
	}
	}

function checkboxValue()

{
	checkSession('<%=loginUser.getUsername()%>');
    var checkboxs=document.getElementsByName("checkbox");

    var okay=false;
    for(var i=0,l=checkboxs.length;i<l;i++)
    {
        if(checkboxs[i].checked)
        {
            okay=true;
        }
        
    }
    
    if(document.getElementById("selectedGroup").value=="selectGroup"){
    	document.getElementById("selectedGroup").focus();
    	return false;
    }
    if(okay){
    	alert("publisher deleted succesfully.");
    	return true;
    }
    else{ 
    	alert("Please Select publisher.");
    	return false;
    }
    }
</script>
</head>

<body onload = "checkSession('<%=loginUser.getUsername()%>');">

<%
try{
%>
  <div id="tabs" class="tabs">
    <ul>
      
      <li><a href="#publishers">Experts</a></li>
      <!-- <li><a href="#reports">Reports</a></li>
      <li><a href="#settings">Settings</a></li> -->
    </ul>
    <div id="members">
      <div id="options" class="options">
      <table>
         	<td>
				</select>
          	</td>
          	</tr>
          	</table>
      </form>
    	<div id="edit-member-dialog" class="edit-member-dialog">
    	</div>
    </div>
    <div id="publishers">
      <div id="publishers-options">
        <button id="addPublishersButton">Add new Experts</button>
        <table><td>&nbsp;&nbsp;</td></table>
      </div>
      <table>
      		<td>&nbsp;&nbsp;</td>
        <tr>
          <td>&nbsp;&nbsp;</td>
          <th></th>
          <th id="publisherName" class="name-col">Name</th>
          
          <th id="publisherNumber" class="num-col">Number</th>
          <th></th>
          <!-- <th>Role</th> -->
        </tr>
       <!--    <tr>
          <td>&nbsp;</td>
          <th></th>
          <th id="publisherName" class="name-col">नाम </th>
          
          <th id="publisherNumber" class="num-col">संख्या </th>
          <th></th>
         <!-- <th>भूमिका</th>  --> 
        </tr>  -->
                
     <% 
        Integer i;
        Object[][] pub = publisherBean.getPublisher_details();
        %>
                
        <input type="checkbox" onClick="checkedAll();" /> <b>&nbsp;&nbsp;Select All</b> <br/>
        
        <%
        for(i=0;i<pub.length;i++){
        %>
        
        
        <form action='IvrsServlet' method='POST' name='checkForm' id='checkForm'>
         <tr>
          <td><input type="checkbox" name="checkbox" value="<%=pub[i][0]%>"/></td>
          <td>&nbsp;</td>
          <td><%=pub[i][1]%></td>
          <td><%=pub[i][2]%></td>
          <td>&nbsp;</td>
         <td><%--=pub[i][3]--%></td>
          </tr>
       
        <%
        }
        %>
      </table>
      <br>
    <input type="hidden" value="deletePublisher" name="req_type" id="req_type"/>  
    
  <input type="submit" value="Delete" id="selectedGroup" onclick="return checkboxValue();" class="add-button"/>  
      <div id="publishers-dialog" title="Add Publisher">
        <p>Add new Experts</p>
        <form>
          Please enter the names of the members separated by ENTER: <br><br>
          <textarea name="memberName" id="publisher-Name" rows="5" cols="40" required></textarea>
          <br><br>
          Please enter the numbers of the members separated by ENTER <br><br>
          <textarea name="memberNumber" id="publisher-Number" rows="5" cols="40" required></textarea>
          <br>
          <br>
           <input type="button" name="submit" value="Add"  onclick="addPublishersInBulk();" class="add-button"/>
          <button value="Done" onclick="refreshManage();" id="done" class="done">Done</button>
          <p><span id="status"></span></p>
        </form>
      </div>
    </div>
</div>
<%
	}
	catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("Error.html");
	}
	%>
</body>
</html>