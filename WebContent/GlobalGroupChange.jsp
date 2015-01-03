<!DOCTYPE html>
<%-- 
Document   : GlobalGroupChange.jsp
Author     : Ravi & Neel + Deepesh
--%>

<%@page import="com.iitb.globals.*"%>
<%@page import="java.util.ArrayList;"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean"
	scope="request" />
<jsp:useBean id="memberBean" class="com.iitb.MemberBean.MemberBean"
	scope="request" />
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean"
	scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/Main.css">

<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
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
    	position:[300,70],
    	resizable: false,
    	height:300,
    	width:400,
    	autoOpen: false,
    	modal: true,
    	buttons: {
		"Update Details": function(){
        var memberId=$("#memberId").val();
        var memberName=$("#memberName").val();
        var memberNumber=$("#memberNumber").val();
        var memberAddress=$("#memberAddress").val();
        var memberUsername=$("#memberUsername").val();
        var memberPassword=$("#memberPassword").val();
        var userLogin=$('#userLogin').is(':checked');

        //alert(userLogin);
       
        updateMemberDetails(memberId,memberName,memberNumber,memberAddress,memberUsername,memberPassword,userLogin);
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
	 $("#status").text("");
	 var memberName=$("#publisherName").val();
	 var memberNumber=$("#publisherNumber").val();
	 var groupId=<%= request.getParameter("groupId")%>;
	 var nameflag=true,numflag=true;
	 if(memberName.length==0){
	   nameflag=false;
	   $("#publisherName").val(null);
	   $("#publisherName").attr("placeholder","Please enter a name");
	 }
	 if(memberNumber.length==0){
	   numflag=false;
	   $("#publisherNumber").val(null);
	   $("#publisherNumber").attr("placeholder","Invalid Phone number");
	   
	 }
	 if(numflag&&nameflag){
	   console.log(memberName);
	   console.log(memberNumber);
	   
	   $.ajax({
	    url: 'IvrsServlet',
	    type: 'POST',
	    data: {'req_type':'addNewMember','memberName':memberName,'memberNumber':memberNumber,'groupId':groupId,'memberRole':'publisher'},
	    error: function(){
	      $("#status").text("error");
	    },
	    success: function(data){
	      $("#status").text(data);
	      if(data=='Success'){
	        $("#publisherName").val("");
	        $("#publisherNumber").val("");
	        $("#status").text("Members added successfully");
	        $("#done").css({'display':'block'});
	      }
	    }
	  });
	}
	}



function updateMemberDetails(memberId,memberName,memberNumber,memberAddress,username,password,userLogin){
    	$.ajax({
		url: 'IvrsServlet',
		type: 'POST',
		data: {'req_type':'updateMemberDetails', 'memberId':memberId,'memberName':memberName,'memberNumber':memberNumber,'memberAddress':memberAddress,'username':username,'password':password,'userLogin':userLogin},
		success: function(data){
			//alert(data);
		
		}
	});
      }

$( "#addGroups" ).dialog({ autoOpen: false });
$( "#addGroup" ).on('click',function()
{
    $( "#addGroups" ).dialog( "open" );
});

</script>
</head>
<body onload="checkSession('<%=loginUser.getUsername()%>');">

	<% 
// This validation is for checking session
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
     requestDispatcher.forward(request, response);  

}
	try{
%>
	<div id="tabs" class="tabs">
		<ul>
			<li><a href="#members">Students&nbsp;</a></li>
		</ul>
		<div id="members">
			<div id="options" class="options">
				Message format to add a new student to this parent group : SMVDU
				<%=ConfigParams.getOrgabb()%><span class="span"> Name Surname&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>X</b>: Cannot Assign Login
					<br> *Please note you have to enter your name and your surname
				</span><br> Number to send this message : 0-922-750-7512 (please enter
				the 0)
			</div>
			<br>
			<br>
			<form action='IvrsServlet' method='POST' name='checkForm'
				id='checkForm'>
				<table align:center;style="color:#39836B">
					<tr>
						<th id='mem-name' class="mem-name">Name</th>
						<th id='mem-number' class="mem-number">Number</th>
						<th id='group-name' class="group-name">Group Name</th>
						<th class="group-membership" colspan="3">Group Memberships</th>
					</tr>
					<!-- <tr>
						<th id='mem-name' class="mem-name">नाम</th>
						<th id='mem-number' class="mem-number">संख्या</th>
						<th id='group-name' class="group-name">समूह का नाम</th>
						<th colspan="3" class="group-membership">समूह सदस्यता</th>
					</tr>  -->
					<%
        ArrayList<Object[][]> groupDetails=groupBean.getArray_list();
        Object[][] result=memberBean.getMember_details();
        Object[][] groupNames =  groupDetails.get(0);
        Object[][] groupNumbers = groupDetails.get(1);
		//for(int jk=0;jk<result.length;jk++){
		//	for(int kl;kl<result[jk].length;kl++){
		//		System.out.println(result[jk][kl]);
		//	}
		//}
        
        Integer i;
		System.out.println(result.length);
		
		for(i=0;i< result.length;i++){
		%>
					<tr>
						<td><%=result[i][2]%></td>
						<td><%=result[i][1]%></td>
						<td class="style-td"><select class="select">
								<% Integer j=0;
					while(groupNames[i][j]!=null){
						
						System.out.println(groupNumbers[i][j].toString());
						
					%>
								<option>
									<%=groupNames[i][j]%>
								</option>
								<%j++;} %>
						</select></td>
						<%
          	 
          	 /* Check condition if the groups are not the parent group (for edit) 
          	  * @author: Ravi
          	  */
          j=0;
            boolean parent=false;
          
          while(groupNumbers[i][j]!=null){ 
        	 String group= groupNumbers[i][j].toString();
        	
          		if(group.equalsIgnoreCase("0"))
          		{
          				parent=true;
          				break;
          		}
          		j++;
          		
          	}
          %>
						<td class="style-td"><a class="add-del-edit"
							style="color: #ffffff;"
							<% out.print("href='IvrsServlet?req_type=manipulateAdd&memberNumber="+result[i][1].toString()+"&manipulate=0' target='content-iframe'"); %>>&nbsp;&nbsp;Add&nbsp;&nbsp;</a></td>
						<td class="style-td"><a class="add-del-edit"
							style="color: #ffffff;"
							<% out.print("href='IvrsServlet?req_type=manipulateDelete&memberNumber="+result[i][1].toString()+"&manipulate=1' target='content-iframe'"); %>>&nbsp;&nbsp;Delete&nbsp;&nbsp;</a></td>
						<%if(loginUser.getParent_org().equals("0")){ 
			   if(!parent){%>
						<td class="style-td"><span style=''
							onclick="editMembers('<%=result[i][0].toString()%>','<%=result[i][2].toString()%>','<%=result[i][1].toString()%>','<%=result[i][4].toString()%>')"><a
								class="add-del-edit" style="color: #ffffff;" href="#">&nbsp;&nbsp;Edit&nbsp;&nbsp;</a></span></td>
						<%
						System.out.println("my address:-"+result[i][4]);}else{
							%>
							<td style='text-align:center;'><img title="Cannot Assign Login" src="img/transicross1.jpg"></td>
							<%
           } }%>
					</tr>
					<tr class="style-tr-ggc"></tr>
					<%
      	}
        %>
				</table>
			</form>
			<div id="edit-member-dialog" class="edit-member-dialog"></div>
		</div>
	</div>
	<%
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
