<!DOCTYPE html>
<%-- 

--%>

<%@page import="com.iitb.globals.*" %>
<%@page import="com.iitb.Controller.*" %>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="groupbean" class="com.iitb.GroupBean.GroupBean" scope="request" />
<jsp:useBean id="memberBean" class="com.iitb.MemberBean.MemberBean" scope="request" />
<jsp:useBean id="incomingOutgoingBean" class="com.iitb.MessageBean.IncomingOutgoingBean" scope="request"/>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

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
    $( "#tabs" ).tabs();
    $("#report-tabs").tabs();
    $( "#confirm-delete-group-dialog" ).dialog({
    	resizable: false,
    	autoOpen: false,
    	modal: true,
    	buttons: {
    	"Delete Group": function() {
    	$( this ).dialog( "close" );
    	deleteGroup(<%=groupbean.getGroups_id()%>);
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
        var memberAddress=$("#memberAddress").val();
        var memberUsername=$("#memberUsername").val();
        var memberPassword=$("#memberPassword").val();
        var userLogin=$('#userLogin').is(':checked');
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

function checkgroup(inputtxt)  
{  
   
    
  if(inputtxt==0)
        {  
	  alert("Parent group cannot be deleted");
	  document.getElementById("delete-group-button").disabled=true;
       
       
        }  
      else  
        {  
      
        document.getElementById("delete-group-button").disabled=false;
        
        }  
}  

function addNewMember(){
	   var memberName=$("#memberName").val();
	   var memberNumber=$("#memberNumber").val();
	   var groupId=<%=groupbean.getGroups_id()%>;
	   var nameflag=false,numflag=false;
	   
	   if(isNaN(memberNumber)||memberNumber.length!=10){
	    $("#memberNumber").attr("placeholder","Invalid Phone number");
	    $("#memberNumber").val(null);
	  }
	  else {
	    numflag=true;
	  }
	  if(memberName.length==0||!isNaN(memberName)){
	    $("#memberName").val(null);
	    $("#memberName").attr("placeholder","Invalid name");
	  }
	  else{
	    nameflag=true;
	  }
	  if(nameflag&&numflag){
	    
	    var memberRole=$("#memberRole").val();
	    $.ajax({
	      url: 'IvrsServlet',
	      type: 'POST',
	      data: {'req_type':'addNewMember','memberName':memberName,'memberNumber':memberNumber,'groupId':groupId,'memberRole':memberRole},
	      success: function(data){
	        $("#status").text("Added Member successfully. Click Add to add more Members or Done to save and exit");
	        if(data=='Sucess'){
	          $("#memberName").val("");
	          $("#memberNumber").val("");
	          $("#done").css({'display':'block'});
	        }
	      }
	    });
	  }
	}
	

	function addMembersInBulk(role){
	 $("#status").text("");
	 var memberName=$("#memberName").val();
	 var memberNumber=$("#memberNumber").val();
	 var memberAddress = $('#memberAddress').val();
	 var memberEmailId = $('#memberEmailId').val();
	 var groupId=<%= groupbean.getGroups_id()%>;
	 var nameflag=true,numflag=true;
	 if(memberName.length==0){
	   nameflag=false;
	   $("#memberName").val(null);
	   $("#memberName").attr("placeholder","Please enter a name");
	 }
	 if(memberNumber.length==0){
	   numflag=false;
	   $("#memberNumber").val(null);
	   $("#memberNumber").attr("placeholder","Invalid Phone number");
	   
	 }
	 if(numflag&&nameflag){
	   console.log(memberName);
	   console.log(memberNumber);
	   
	   $.ajax({
	    url: 'IvrsServlet',
	    type: 'POST',
	    data: {'req_type':'addNewMember','memberName':memberName,'memberNumber':memberNumber,'memberAddress':memberAddress,'memberEmailId':memberEmailId,'groupId':groupId,'memberRole':role},
	    error: function(){
	      $("#status").text("error");
	    },
	    success: function(data){
	      alert(data);
	      refreshManage();
	      if(data=='Success'){
	        $("#memberName").val("");
	        $("#memberNumber").val("");
	        $("#status").text("Members added successfully");
	        $("#done").css({'display':'block'});
	      }
	    }
	  }).fail(function( jqXHR, textStatus ) {
	    alert( "Request failed: " + textStatus );
	    $("#status").text("error")
	  });
	}
	}
	
	function deleteGroup(groupId) {
		$.ajax({

			url : 'IvrsServlet',
			type : 'POST',
			data : {
				'req_type' : 'deleteGroup',
				'groupId' : groupId
			},
			success : function(data) {
				alert("The group has been deleted successfully");
				//window.top.location.reload();
			}

		});
		      
	}
	
	
	function updateMemberDetails(memberId,memberName,memberNumber,username,password,userLogin){
		$.ajax({
			url: 'IvrsServlet',
			type: 'POST',
			data: {'req_type':'updateMemberDetails', 'memberId':memberId,'memberName':memberName,'memberNumber':memberNumber,'username':username,'password':password,'userLogin':userLogin},
			success: function(data){
				alert(data);
			}
		});
	}
	
	

</script>
</head>

<body onload="checkSession('<%=loginUser.getUsername()%>');">
<%
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{
	 RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
     requestDispatcher.forward(request, response);  
}
if(loginUser.getUsername()==null)
{  
	  //String refresh=request.getParameter("refresh");
	  String flag="0";
	  if(refresh!=null)
	  {
		  flag="1";
	  }
}
%>


	<div id="tabs" class="tabs">
		<ul>
			<li><a href="#members">Members &nbsp;&nbsp;</a></li>
			<li><a href="#reports">Reports&nbsp;&nbsp;</a></li>
			<li><a href="#settings">Settings&nbsp;&nbsp;</a></li>
		</ul>
		<div id="members">
			<div id="options" class="options">
				<button id="addMemberButton">Add new members &nbsp;</button>
				Message format to add a new member to this group : smvdu
				<%=ConfigParams.getOrgabb()%>
				G<%=groupbean.getGroups_id()%>
				<span style="color: red">
					Name Surname <br> *Please note you have to enter your name and
					your surname
				</span>
			</div>
			<form action='IvrsServlet' method='POST' name='checkForm'
				id='checkForm'>
				<table>
					<%
        		    String groupId=groupbean.getGroups_id();
					System.out.println(" group id "+groupId);
					String orgId=loginUser.getOrg_id();				
								
        		Object[][] members = memberBean.getGroup_member_details();
        	
        		Integer i;
        		if(members!=null)
        		{
        %>
        <tr><button id="bar-name" class="add-button"><a class="voice-inbox" href="IvrsServlet?groupId=<%=groupId%>&req_type=downloadDetails">Download All Member Details</a></button>	</tr>
					<br>
					<tr>
					<tr>
						<!-- <td>&nbsp;</td> -->
						<th class="checkform-table-th-1" colspan="2"></th>
						<th class="checkform-table-th-2">Name</th>
						<th class="checkform-table-th-2">Number</th>
						<th class="checkform-table-th-2">Address</th>
						

					</tr>
					<!--  <tr>
						<th class="checkform-table-th-1" colspan="2"></th>
						<th class="checkform-table-th-2">नाम</th>
						<th class="checkform-table-th-2">संख्या</th>
						<th class="checkform-table-th-2">पता</th>
					</tr>-->
					<input type="checkbox" onClick="checkedAll();" />
					<b>&nbsp;&nbsp;Select All</b>
					<br />
					<% 
        		for(i=0;i<members.length;i++){
         %>
					<tr>
						<td><input type="checkbox" name="checkbox" id="checkbox"
							value="<%=members[i][0]%>" /></td>
						<!-- <td>&nbsp;</td> -->
						<td colspan="2"><%=members[i][1] %></td>
						<td class="style-number"><%=members[i][2]%>&nbsp;</td>
						<!-- <td style="max-width:42px;"><%=members[i][2] %></td> -->	
						<td style="align:leftl;"><%=members[i][3] %>&nbsp;</td>					
					</tr>
					<tr>
					</tr>
					<%  }
        %>

				</table>
				<table>
					<%
        		Object[][] changeGroup = groupbean.getChange_group();
					System.out.println("change group "+changeGroup.length);
        		Integer j;
        		
        		
        %>
					<tr style="vertical-align:top">
						<td><select name="selectedGroup" id="selectedGroup" class="table-input-1">
						<option value="selectGroup">--Select Group--</option>
								<%for(j=0;j<changeGroup.length;j++){ 
								System.out.println(changeGroup[j][1]);%>
								<option value="<%=changeGroup[j][0]%>"><%=changeGroup[j][1]%></option>
								<% } %>
						</select></td>
						<td><input type="hidden" value="changeGroup" name="req_type"
							id="req_type" /> <input type="submit" value="Change group" class="add-button"
							onclick="return checkboxValue();" />
						<!-- onclick="return checkboxValue();" --></td>
					</tr>
					<%
        	
        		}
        		else {
        		%>
					<h1>No members are there in this group.</h1>
					<%
        		
        	}
        %>
				</table>
			</form>
			<div id="dialog" title="Add Member">
				<p>Add new members</p>
				<form>
					Please enter the names of the members separated by ENTER: <br>
					<br>
					<textarea name="memberName" id="memberName" class="mem-name-manage"
						rows="5" cols="40" required></textarea>
					<br>
					<br> Please enter the numbers of the members separated by
					ENTER <br>
					<br>
					<textarea name="memberNumber" id="memberNumber"
						class="mem-number-manage" rows="5" cols="40" required></textarea>
						<br><br>
						Please enter the address of the members
					separated by ENTER(Not necessary) <br> <br>
					<textarea name="memberAddress" id="memberAddress" rows="5" cols="40"
						required></textarea>
						<br> Please enter the email addresses of the members separated by
					ENTER (Not necessary)<br>
					<br>
					<textarea name="memberEmailId" id="memberEmailId"
						class="mem-number-manage" rows="5" cols="40" required></textarea>
						<br>
					<br> <br> <input class="addmembersinbulk" type="button"
						name="submit" value="Add" onclick="addMembersInBulk('member');" />
					<button value="Done" onclick="refreshManage();" id="done"
						class="done">Done</button>
					<p>
						<span id="status"></span>
					</p>
				</form>
			</div>
			<div id="edit-member-dialog" class="edit-member-dialog"></div>
		</div>
		<div id="reports">
			<div id="report-tabs">
				<ul>
					<li><a href="#incoming-calls">Incoming calls</a></li>
					<li><a href="#outgoing-calls">Outgoing calls</a></li>
				</ul>
				
				<%
					//the parameters submitted on click of find button will be sent here
					//we can fetch them and mutate the query			
					String iFromDate = null; //initial fromdate
					String iToDate = null; //initial todate
					try {
						iFromDate = request.getParameter("ifromdate");
						System.out.println("i "+iFromDate);
						iToDate = request.getParameter("itodate");
						System.out.println(iToDate);
					} catch (Exception e) {
						
					}
					finally{
						iFromDate = iFromDate == null ? "" : iFromDate;
						iToDate = iToDate == null ? "" : iToDate;
					}
				%>
				
				<div id="incoming-calls">
					<form name="incomingcall" id="incomingcall" action="IvrsServlet" method="POST">
					
						<table id="tab" class="reporting"  >
						
							<input type="hidden" name="groupId" id="groupId" value="<%=groupId%>" />
							<input type="hidden" name="req_type" id="req_type" value="manageIncomingCalls" />
							<div style="margin-top: 10px;">
                                
								<span
									style="color: '#888888'; font-size: 15px; margin-top: 10px;">
									From </span><br>
							</div>
							<div>
								<span
									style="color: '#888888'; font-size: 15px; margin-top: 10px;"><input
									type="date" id='ifromdate' name='ifromdate' class="table-input-1" value="<%=iFromDate%>"/></span><br>
							</div>
							<div>
								<span
									style="color: '#888888'; font-size: 15px; margin-top: 10px;">
									To </span><br>
							</div>
							<div>
								<span
									style="color: '#888888'; font-size: 15px; margin-top: 10px;"><input
									type="date" id='itodate' name='itodate' class="table-input-1" value="<%=iToDate%>"/></span><br>
							</div>
							<div style="margin-top: 10px;">
                
								<input type="submit" value="find"  class="add-button"/> <!-- change@shan -->
							</div>
							</table>
							</form>
						<table>	
						<tr>
							<th>Date - Time</th>
							<th>Name</th>
							<th>Number</th>
						</tr>
						<!-- <tr>
							<th>दिनांक - समय</th>
							<th>नाम</th>
							<th>संख्या</th>
						</tr> -->
				
				
				
				
						
						<%
    Object[][] incoming = incomingOutgoingBean.getIncoming_calls();
						//System.out.println("incoming "+incoming.length);
	Integer l;
	if(incoming!=null){
	for(l=0;l<incoming.length;l++){
		System.out.println("Incoming for loop !!");
    		%>
						<tr>
							<td><%=incoming[l][1] %></td>
							<td><%=incoming[l][2] %></td>
							<td><%=incoming[l][0] %></td>
						</tr>
						<%}}
    %>
					</table>
				</div>
				
				<%
					String oFromDate = ""; //initial fromdate
					String oToDate = ""; //initial todate
					try {
						oFromDate = request.getParameter("ofromdate");
						System.out.println("o "+oFromDate);
						oToDate = request.getParameter("otodate");
						System.out.println("o "+oToDate);
					} catch (Exception e) {
	
					}
					finally{
						oFromDate = oFromDate == null ? "" : oFromDate;
						oToDate = oToDate == null ? "" : oToDate;
					}
				%>
				
				
					<div id="outgoing-calls">
					<form name="outgoingcall" id="outgoingcall"
						action="IvrsServlet" method="POST">
						<table class="reporting">
							<input type="hidden" name="groupId" id="groupId"
								value="<%=groupId%>" />
							<input type="hidden" name="req_type" id="req_type"
								value="manageOutgoingCalls" />
							<div style="margin-top: 10px;">

								<span
									style="color: '#888888'; font-size: 15px; margin-top: 10px;">
									From </span><br>
							</div>
							<div>
								<span
									style="color: '#888888'; font-size: 15px; margin-top: 10px;"><input
									type="date" id='ofromdate' name='ofromdate' class="table-input-1" value="<%=oFromDate%>"/></span><br>
							</div>
							<div>
								<span
									style="color: '#888888'; font-size: 15px; margin-top: 10px;">
									To </span><br>
							</div>
							<div>
								<span
									style="color: '#888888'; font-size: 15px; margin-top: 10px;"><input
									type="date" id='otodate' name='otodate' class="table-input-1" value="<%=oToDate%>"/></span><br>
							</div>
							<div style="margin-top: 10px;">

								<input type="submit" value="find" class="add-button" />
							</div>
							</table>
							</form>
							
							<table class="reporting">
								<tr>
									<th>Date - Time</th>
									<th>Name</th>
									<th>Number</th>
									<th>Status</th>
									<th>Duration (sec)</th>
								</tr>
								<!-- <tr>
									<th>दिनांक - समय</th>
									<th>नाम</th>
									<th>संख्या</th>
									<th>स्थिति</th>
									<th>अवधि</th>
								</tr> -->

				<%
				Object[][] outgoing = incomingOutgoingBean.getOutgoing_calls();
				//System .out.println("outgoing "+outgoing.length);
Integer m;
if(outgoing!=null){
for(m=0;m<outgoing.length;m++){
System.out.println("Outgoing for loop!!");
				%>
						<tr>
							<td><%=outgoing[m][2]%></td>
							<td><%=outgoing[m][4] %></td>
							<td><%=outgoing[m][0]%></td>
							<td><%=outgoing[m][1] %></td>
							<td><%=outgoing[m][3]%></td>
						</tr>
						<%}}
    	%>
						<%
    Object[][] pending = incomingOutgoingBean.getPending_calls();
						//System .out.println("pending "+pending.length);
   	Integer n;
   	if(pending!=null){
   	for(n=0; n<pending.length;n++){
    	
   		System.out.println("Pending for loop!!");
    			%>


						<tr>
							<td></td>
							<td><%=pending[n][3]%></td>
							<td><%=pending[n][1]%></td>
							<td>DND number</td>
						</tr>
						<%}}
    	
 %>
					</table>
				</div>
			</div>
		</div>

		<div id="settings">
			<form ENCTYPE="multipart/form-data" action="IvrsServlet"
				method="post" name="group_settings" id="groupSettings"
				onsubmit="check();">
				<table>
				
        <%
        Object[][] settings = groupbean.getManage_settings();
		Integer k;
		if(settings!=null)
		{
		for(k=0;k<settings.length;k++){
			System.out.println("Settings for loop!!");
        
        %>
					<tr>
						<td>Group Number </td>
						<td><input type="hidden" name="groups_id"
							value="<%=groupId%>" id="groups_id" required><%=groupId%></td>

					</tr>
					<tr>
						<td>Group Name </td>
						<td><input type="text" name="groups_name" id="groups_name"
							value="<%=settings[k][0]%>" id="groups_name" required class="table-input-1"/></td>
					</tr>	
					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>				
					<tr>
						<td><input type="hidden" name="req_type"
							value="saveSettings" >
							 
							</td>
							
						<td><input type="submit" value="Save Settings" class="add-button"/></td>
						</form>
						<form>
						<%if(!groupId.equals("0")){ %>
						<td><input type="button" value="Delete Group" class="add-button"
							id="delete-group-button" onclick="checkgroup(<%=groupbean.getGroups_id()%>)"/></td>
							<%} %>
					</tr>
					<%}%>
				</table>
			</form>
			<%if(!groupbean.getGroups_id().equalsIgnoreCase("0")){
				%>
			<!-- Confirm dialog to delete group -->
			<div id="confirm-delete-group-dialog" title="Delete Group ?">
				<p>
					<span class="ui-icon ui-icon-alert"></span>The group will be
					deleted permanently.The members of this group will be added to
					Parent group.<br> You want to delete?
				</p>
			</div>
			<% }}
			%>
		</div>
	</div>
	
</body>
</html>
