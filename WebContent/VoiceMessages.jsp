<!DOCTYPE html>

<!-- 
Document : VoiceMessages.jsp  
 -->
 
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean" scope="request" />
<jsp:useBean id="messageBean" class="com.iitb.MessageBean.VoiceTextMessagesBean" scope="request" />
<jsp:useBean id="memberBean" class="com.iitb.MemberBean.MemberBean" scope="request" />
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />
<jsp:useBean id="settings" class="com.iitb.SettingsBean.SettingsBean" scope="request" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	<script src="js/jquery-1.9.1.js"></script>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script type="text/javascript" src="js/Validate.js"></script>	
    
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" href="css/jquery-ui.css" />
    <link rel="stylesheet" href="css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="css/Main.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
	
	
<script type="text/javascript">
    $(document).ready(function(){
        
        $("iframe").height($(document).height()-100);
        $(".group-header").click(function(){
            var elem=$(this).next();
            $(this).next().slideToggle();

        });
        $( "#all-groups" ).accordion({ collapsible: true });
        
    });
    //Function to Update Message Comments
     	$(document).ready(function(){
     		$(".comments").blur(function(){
     			
     			var id=$(this).attr("id");
     			var comment=$(this).val();
     			console.log(id);
     			$.ajax({
     				url: 'IvrsServlet',
     				type: 'POST',
     				data: {'req_type':'updateMsgComment','messageId':id,'messageComments':comment},
     				success: function(){
     					
     					$("#update-comment-"+id).fadeIn(100).text("Updated").fadeOut(3000);
     				}
     			});
     		});
     	});
	$(function() {
		$( "#tabs" ).tabs();
		 $("#report-tabs").tabs();
		 
	}); 
	
	 $('#selectedGroup').click(function(){
	var e = document.getElementById("selectedGroup");
	 var selectValue = e.options[e.selectedIndex].value;
	 xmlhttp.open("GET","DummyFile.jsp?memberNumber="+selectValue+"",true);
		xmlhttp.send();
	 });
	 
	$(document).ready(function(){
		$(".view-all").click(function(){
			
			$( ".display-members" ).toggle('blind', {}, 500 );
		});
		
		$('#selectAll').click(function (event) {

			var selected = this.checked;
           // Iterate each checkbox
           $(':checkbox').each(function () {    this.checked = selected; console.log($(this).val());});

       });
		$("#sms-message").keyup(function(){
			var remLen=160-$(this).val().length;
			if(remLen>=0){
				$("#chars-remaining").text(remLen);
			}
			else{
				$("#chars-remaining").text("Limit exceeded");
				$(this).val($(this).val().substring(0, 160)); 
			}
		});
		
            // Now starts the JS code for the sms part 
            var numbers = split("");
            
            <%
            String member=request.getParameter("member");
            		if(member==null){
            			member="true";
            		}
    		String groupId=groupBean.getGroups_id();
            Object[][] membersData=memberBean.getMember_details();
            
          	Integer a=0;
            out.print("var availableTags = [");
            while(membersData!=null && a < membersData.length)
            {
            	out.print("{label: \""+membersData[a][1]+"\", value:\""+membersData[a][2]+"\"},");
            	a++;
            }
            out.print("];");
            %>
            function split( val ) {
            	return val.split( /,\s*/ );
            }
            function extractLast( term ) {
            	return split( term ).pop();
            }

            $( "#tags" )
			// don't navigate away from the field on tab when selecting an item
			.bind( "keydown", function( event ) {
				if ( event.keyCode === $.ui.keyCode.TAB &&
					$( this ).data( "ui-autocomplete" ).menu.active ) {
					event.preventDefault();
			}
		})
			.autocomplete({
				minLength: 0,
				source: function( request, response ) {
					// delegate back to autocomplete, but extract the last term
					response( $.ui.autocomplete.filter(
						availableTags, extractLast( request.term ) ) );
				},
				focus: function() {
					// prevent value inserted on focus
					return false;
				},
				select: function( event, ui ) {
					$("#selected>ul").append("<li class=\"list\">"+ui.item.label+": "+ui.item.value+";</li> ");
					$("#selectedNumbers").append(ui.item.value+";");
					
					this.value="";    
					return false;
				}
			});
			$("button").click(function(){
				alert($("#selected").text());
			});
		});
	$(document).on("click",".list",function(){
		console.log($(this).text());
		$(this).remove();
	});
	
	//Function to Update Message Status (Rejected/Accepted)
	$(document).ready(function(){
	$("#status").change(function(){
			var id=$(this).attr("class");
			var statusId=$(this).val();
			console.log("Status changed" + statusId);
			
			$.ajax({
				url: 'IvrsServlet',
				type: 'POST',
				data: {'req_type':'updateMsgStatus','messageId':id,'statusId':statusId},
				success: function(){
					window.location.reload();
				}
			});
		});
	});
	function checkMember(input){
		
		if(!input){
			alert("No members in this group");
		}
	}
	
	$(function(){
		$("#record").on('click', function(e){
        e.preventDefault();
        $('<div/>', {'class':'myDlgClass', 'id':'link-'+($(this).index()+1)})
        .html($('<iframe/>', {
            'src' : $(this).attr('href'),
            'style' :'width:100%; height:100%;border:none;'
        })).appendTo('body')
        .dialog({
            'title' : $(this).text(),
            'width' : 500,
            'height' :350,
            buttons: [ { 
                    text: "Close",
                    click: function() { $( this ).dialog( "close" ); } 
                } ]
        });
    });
});


$(function(){
		$("#upload").on('click', function(e){
        e.preventDefault();
        $('<div/>', {'class':'myDlgClass', 'id':'link-'+($(this).index()+1)})
        .html($('<iframe/>', {
            'src' : $(this).attr('href'),
            'style' :'width:100%; height:100%;border:none;'
        })).appendTo('body')
        .dialog({
            'title' : $(this).text(),
            'width' : 500,
            'height' :350,
            buttons: [ { 
                    text: "Close",
                    click: function() { $( this ).dialog( "close" ); } 
                } ]
        });
    });
});

</script>
</head>

<body onload="checkMember(<%=member%>)">
<%
//validating user on loading the file
	if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
	{
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
	    requestDispatcher.forward(request, response);
	}
	if(member.equalsIgnoreCase("true"))
	{
	
%>

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
	<div id="content" class="content-dash">
	<!-- Start of tabs division -->
		<div id="tabs">  	
			<ul>
				<li><a href="#inbox">Inbox<br></a></li>
				
				<%
				
				if(data8.equals("1")){
				%>
				<!--  <li><a href="#accepted">Accepted<br>(स्वीकृत)</a></li>-->
				
				<%
				if(data9.equals("1")){
				%>
				
				<li><a href="#saved">Saved<br></a></li>
				<% } %>
				
				<li><a href="#processed">Processed<br></a></li>
				<% } %>
				
				
				<%
				if(data10.equals("1")){
				%>
				
				<li><a href="#reject">Rejected<br></a></li>
				<% } %>
				
				
				<%
				if(data7.equals("1")){
				%>
				
				<li><a href="#response">Response(Yes/No)<br></a></li>
   				
   				<%
				}
				if(data6.equals("1")){
				%>
				
   				<li><a href="#feedback">Feedback<br></a></li>
   				<%} %>
   				
   			</ul>
   			
   			
<!-- INBOX  MESSAGES -->

	<div id="inbox"> <!-- Start of Inbox Division -->
	
	<button id="bar-name" class="add-button"><a class="voice-inbox" href="IvrsServlet?groupId=<%=groupBean.getGroups_id()%>&req_type=downloadMessages">Download All Messages</a></button>

<form ENCTYPE="multipart/form-data" action="IvrsServlet" method="POST" name="dummyFileUpload" id="newfileupload">
	<div class="pull-right">
	<%
					System.out.println(" group id "+groupId);
					String orgId=loginUser.getOrg_id();				
								
        		Object[][] members = memberBean.getMember_details();
        	
        		Integer i;
        		if(members!=null)
        		{
        		%><table><tr><td>
        			<!-- <select name="selectedGroup" id="selectedGroup" style="height:27px;width:180px" required>
							<%for(i=0;i<members.length;i++){
							%>
							<option value="<%=members[i][2]%>"><%=members[i][1] %></option>
							<%
							}	
							%>
					</select>  -->
					<input type="hidden" name="groupId" id="groupId" value="<%=groupId%>"/>
            		<input type="hidden" name="req_type" id = "req_type" value="dummyFileUpload">
            <%
        		}
        %>
        </td>
        <!-- <td>
		<button type="submit" >Generate Dummy File</button>
		</td> -->
	</tr>
	</table>
</form>
     <!--  >button><a href="RecorderNew/index.html" target='content-iframe' id="record" >Record</a></button-->  

	</div>
	 </form> 
	 
		<table>
			<tr>
				<th>DATE</th>
				<th>ORDER ID</th>		
				<th>MEMBER</th>
				<th>MESSAGE</th>
				<% if(data10.equals("1")){ %>
				<th>STATUS</th>
				<% } else {%>
				<th>  </th>
				<%} %>
				
				<th>COMMENTS</th>
				<!-- <th>BILL</th>  -->
			</tr>
			<!-- <tr>
				<th>दिनांक</th>
				<th>आदेश आईडी</th>
				<th>सदस्य</th>
				<th >संदेश</th>
				<% if(data10.equals("1")){ %>
				<th >स्थिति</th>
				<% } else {%>
				<th>  </th>
				<%} %>
				<th >टिप्पणी</th>
				<th> </th>
			</tr>	 -->	
		<%
		Object[][] inboxMessage=messageBean.getInbox_messages();
		Integer j=0;
		while(inboxMessage!=null && j < inboxMessage.length) {			
		%>
			<tr>	
				<td><%=inboxMessage[j][4]%></td>				
				<td><%=inboxMessage[j][5]%></td>				
				<td><%=inboxMessage[j][6]%></td>
				<td><audio controls>           				
           				<source src="<%=inboxMessage[j][0]%>" type="audio/wav"></source>
           			 	<p>Your browser does not support this audio format.</p>
            		</audio>            		
            		<a href="<%=inboxMessage[j][0]%>" target="_blank" title="Right Click Save Link as">Download</a>
            	</td>
            	<td>
            	<%
            	//Condition if message is not assigned to any status (accepted/rejected) yet then options provided to accept/reject
            	if(inboxMessage[j][2].toString().equals("0")){
            	%>            		
            		<% if(data10.equals("1")){ %>
            		<select name="status" class="<%=inboxMessage[j][5]%>" id="status">
        			<option value="0" selected>Select action</option>   
        			<option value="2">Reject</option>
        			</select>            
        			<%} %>
            	<%}
            	//If no action is selected then cancelled
            	else{
            	%>
            		Cancelled
            	<%}
            	if(inboxMessage[j][3]!=null){
            	%>	            	
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=inboxMessage[j][5]%>"><%=inboxMessage[j][3]%></textarea></span></td>   
            	<%} 
            	else{
            	%>   
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=inboxMessage[j][5]%>"></textarea></span></td>  
            	<%
            	}
            	%>    	
            	<td><span id="update-comment-<%=inboxMessage[j][5]%>"></span></td> 
            	 
            	 <% if(data8.equals("1") && data9.equals("1"))       { %>
            	 <td class="style-td">
        	<a class="add-button" href="IvrsServlet?memberName=<%=inboxMessage[j][6]%>&groupId=<%=groupId%>&msgUrl=<%=inboxMessage[j][0]%>&messageId=<%=inboxMessage[j][5]%>&dateTime=<%=inboxMessage[j][4]%>&memberNumber=<%=inboxMessage[j][1]%>&comments=<%=inboxMessage[j][3]%>&req_type=generateBill">&nbsp;Generate&nbsp;</a>
        </td>
        <%}  else if(data8.equals("1") && data9.equals("0")){ %>             				
        
        		
        	
				<td class="style-td">
        	<a class="add-button" href="IvrsServlet?memberName=<%=inboxMessage[j][6]%>&groupId=<%=groupId%>&msgUrl=<%=inboxMessage[j][0]%>&messageId=<%=inboxMessage[j][5]%>&dateTime=<%=inboxMessage[j][4]%>&memberNumber=<%=inboxMessage[j][1]%>&comments=<%=inboxMessage[j][3]%>&req_type=processOrEdit">&nbsp;Generate&nbsp;</a>
        </td>
        
        <% } %>


		<%
			j++;
		}
	
		%>
		</table>		
		<div id="display-content">
		</div>
	</div><!-- End of Inbox Division -->	
	
							
<!-- ACCEPTED MESSAGES 	

				<%
				if(data8.equals("1")){
				%>
				
    <div id="accepted"> <!-- Start of Accepted Division 
		<table>
			<tr>
				<th >DATE</th>		
				<th >MEMBER</th>
				<th>MESSAGE</th>
				<th >COMMENTS</th>
				<th ></th>
				<th >BILL</th>
			</tr>
			<tr>
				<th >दिनांक</th>
				<th >सदस्य</th>
				<th >संदेश</th> 
				<th >टिप्पणी</th> 
				<th></th>
				<th >मात्रा</th>
			</tr> 
		<%	
		Object[][] acceptedMessage=messageBean.getAccepted_messages();
		Integer k=0;
		while(acceptedMessage!=null && k < acceptedMessage.length) {
		%>
           <tr>
				<td><%=acceptedMessage[k][4]%></td>
				<td><%=acceptedMessage[k][6]%></td>
				<td><audio controls>
           				<source src="<%=acceptedMessage[k][0]%>" type="audio/wav" ></source>
           			 	<p>Your browser does not support this audio format.</p>
            		</audio>
            		<a href="<%=acceptedMessage[k][0]%>" target="_blank" title="Right Click Save Link as">Download</a>
            	</td>
            	<%
            	if(acceptedMessage[k][3]!=null){
            	%>
            	<td><span class="comment-area" ><textarea name="comments" class="comments" id="<%=acceptedMessage[k][5]%>" ><%=acceptedMessage[k][3]%></textarea></span></td>
            	<%
				}
            	else{
            	%>
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=acceptedMessage[k][5]%>"></textarea></span></td>
            	<%}
            	%>
            <th ></th>
        <td class="style-td">
        	<a class="add-button" href="IvrsServlet?memberName=<%=acceptedMessage[k][6]%>&groupId=<%=groupId%>&msgUrl=<%=acceptedMessage[k][0]%>&messageId=<%=acceptedMessage[k][5]%>&dateTime=<%=acceptedMessage[k][4]%>&memberNumber=<%=acceptedMessage[k][1]%>&comments=<%=acceptedMessage[k][3]%>&req_type=generateBill">&nbsp;Generate&nbsp;</a>
        </td>
		<%
		k++;
		}
		%>
		</table>
		<div id="display-content">	
		</div>
	</div> Start of Accepted Division -->
	
	<%
				}
				%>
				
	
<!-- REJECTED MESSAGES -->

<%
				if(data10.equals("1")){
				%>
				
	<div id="reject"><!-- Start of Rejected Division -->
		<table>
			<tr>
				<th >DATE</th>		
				<th >MEMBER</th>
				<th >MESSAGE</th>
				<th >COMMENTS</th>
			</tr>
		<!-- 	<tr>
				<th >दिनांक</th>
				<th >सदस्य</th>
				<th >संदेश</th>
				<th >टिप्पणी</th>
			</tr> -->		
		<%
		Object[][] rejectedMessage=messageBean.getRejected_messages();
		Integer l=0;
		while(rejectedMessage!=null && l < rejectedMessage.length) {
			%>
			<tr>
				<td><%=rejectedMessage[l][4]%></td>
				<td><%=rejectedMessage[l][6]%></td>
				<td><audio controls>
           				<source src="<%=rejectedMessage[l][0]%>" type="audio/wav"></source>
           			 	<p>Your browser does not support this audio format.</p>
            		</audio>
            		<a href="<%=rejectedMessage[l][0]%>" target="_blank" title="Right Click Save Link as">Download</a>
            	</td>
            	<%
            		if(rejectedMessage[l][3]!=null){
            	%>
            	
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=rejectedMessage[l][5]%>"><%=rejectedMessage[l][3]%></textarea></span></td>
            	<%
            		}
            		else{
            	%>
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=rejectedMessage[l][5]%>"></textarea></span></td>
            	<%} %>
            	<td><span id="update-comment-<%=rejectedMessage[l][5]%>"></span></td>            				
			<%
			l++;
			}
			%>
		</table>
		<div id="display-content">
		</div>
		</div> <!-- Start of Rejected Division -->
		<%
				}	%>
				
		
<!-- RESPONSE YES?NO -->

<%
				if(data7.equals("1")){
				%>
				
		<div id="response"><!-- Start of Response Division -->
           <div id="report-tabs">
           		<ul>
                  <li><a href="#incoming-calls">Yes</a></li>
                  <li><a href="#outgoing-calls">No</a></li>
             	</ul>
    			<div id="incoming-calls">
               		<table>
        				<tr>
	        				<td>&nbsp;</td>
	        				<th></th>
	         		 		<th id="mem-name" >Name</th>
	          				<td>&nbsp;</td>
	         			 	<th id="mem-number" >Number</th>
	          				<td>&nbsp;</td>
	        			  	<th id="mem-response" >Response</th>
        				</tr>
        			<!-- 	<tr>
        	 				<td>&nbsp;</td>
          					<th></th>
          					<th >नाम</th>
          					<td>&nbsp;</td>
							<th >संख्या</th>
							<td>&nbsp;</td>
	    					<th >प्रतिक्रिया</th>
        				</tr>  -->
        <% 
        Object[][] responseYes=messageBean.getResponse_yes();
		Integer m=0;
		while(responseYes!=null && m < responseYes.length) {
	        	out.println("<form action='IvrsServlet' method='POST'>");
	          out.println("<tr>");
	          out.println("<td><input type=\"checkbox\" name=\"selectedMembers\" value=\""+responseYes[m][0]+"\"/></td>");
	          out.println("<td>&nbsp;</td>");
	          out.println("<td>"+responseYes[m][0]+"</td>");
	          out.println("<td>&nbsp;</td>");
	          out.println("<td>"+responseYes[m][1]+"</td>");
	          out.println("<td>&nbsp;</td>");
	          out.println("<td>"+responseYes[m][2]+"</td>");
	          out.println("</tr>");
	          m++;
        }
        %>
        </table>
       	</div>
        <div id="outgoing-calls">
        <table>
        <tr>
	          <td>&nbsp;</td>
	          <th></th>
	          <th id="mem-name" >Name</th>
	          <th id="mem-number" >Number</th>
	          <th id="mem-response" >Response</th>
        </tr>
       	<!-- <tr>
	        <td>&nbsp;</td>
	        <th></th>
	        <th >नाम</th>
			<th >संख्या</th>
		    <th >प्रतिक्रिया</th>          
        </tr>  -->        
        <%
        Object[][] responseNo=messageBean.getResponse_no();
		Integer n=0;
		while(responseNo!=null && n < responseNo.length) {
	        out.println("<form action='IvrsServlet' method='POST'>");
	        out.println("<tr>");
	        out.println("<td><input type=\"checkbox\" name=\"selectedMembers\" value=\""+responseNo[n][0]+"\"/></td>");
	        out.println("<td>"+responseNo[n][0]+"</td>");
	        out.println("<td>"+responseNo[n][1]+"</td>");
	        out.println("<td>"+responseNo[n][2]+"</td>");
	        out.println("<td>&nbsp;</td>");
	        out.println("</tr>");
	        n++;
        }        
        %>
        </table>
        	</div>
   	     </div>
     </div><!-- End of Response Division -->
     
     <%
				}
				%>
				
<!-- FEEDBACK -->

<%
				if(data6.equals("1")){
				%>
				
<div id="feedback"><!-- Start of Feedback Division -->
          	<table>
		<tr>
			<th >DATE</th>
			<th></th>
			<th >MEMBER</th>
			<th >MESSAGE</th>
		</tr>
		<!-- <tr>
			<th >दिनांक</th>
			<th></th>
			<th >सदस्य</th>
			<th >संदेश</th>
		</tr>  -->
		<%
		Object[][] feedback=messageBean.getFeedback_messages();
		Integer o=0;
		while(feedback!=null && o < feedback.length) {
			%>
			<tr>
				<td ><%=feedback[o][4]%></td>
				<th></th>
				<td ><%=feedback[o][6]%></td>
				<td ><audio controls>
           				<source src="<%=feedback[o][0]%>" type="audio/wav"></source>
           			 	<p>Your browser does not support this audio format.</p>
            		</audio>
            	</td>
		<%
		o++;
		}
		%>
		</table>
     	</div><!-- End of Feedback Division -->
     	
     	<%
				}
				%>
				
<!-- Processed  ORDERS -->

<%
				if(data8.equals("1")){
				%>
				
		<div id="processed"><!-- Start of Processed Orders Division -->
		<table>
		<tr>
		<th >DATE</th>		
		<th >MEMBER</th>
		<th >MESSAGE</th>
		<th >COMMENTS</th>
		<th ></th>
		<th  >BILL</th>
		</tr>
		<!-- <tr>
		<th >दिनांक</th>
		<th >सदस्य</th>
		<th >संदेश</th>
		<th >टिप्पणी</th>
		<th ></th>
		<th>मात्रा</th>
		</tr>  -->
		<%
		Object[][] processedMessage=messageBean.getProcessed_messages();
		Integer p=0;
		while(processedMessage!=null && p < processedMessage.length) {
			%>
			<tr>
				<td><%=processedMessage[p][4]%></td>
				<td><%=processedMessage[p][6]%></td>
				<td><audio controls>
           				<source src="<%=processedMessage[p][0]%>" type="audio/wav"></source>
           			 	<p>Your browser does not support this audio format.</p>
            		</audio>
            		<a href="<%=processedMessage[p][0]%>" target="_blank" title="Right Click Save Link as">Download</a>
            	</td>
            	<%
            	if(processedMessage[p][3]!=null){
            	%>
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=processedMessage[p][5]%>"><%=processedMessage[p][3]%></textarea></span></td>
            	<%
            	} 
            	else{
            	%>
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=processedMessage[p][5]%>"></textarea></span></td>
            	<%
            	}%>
            	<td><span id="update-comment-<%=processedMessage[p][5]%>"></span></td>
            	 <td class="style-td"><a class="add-button" <% out.print("href='IvrsServlet?messageId="+processedMessage[p][5]+"&memberName="+processedMessage[p][6]+"&memberAddress="+processedMessage[p][7]+"&orderTime="+processedMessage[p][4]+"&groupId="+groupId+"&req_type=viewBill' target='_blank'");%>>&nbsp;&nbsp;View/Print&nbsp;&nbsp;</a></td>    	
		<%
		p++;
		}
		%>
		</table>
		<div id="display-content">
		</div>
		</div><!-- End of Processed Orders Division -->
		<%
				}
				%>
				
		
<!-- Saved  ORDERS -->

<%
				if(data8.equals("1") && data9.equals("1")){
				%>
				
	<div id="saved"><!-- Start of Saved  Orders Division -->
		<table>
			<tr>
				<th >DATE</th>		
				<th >MEMBER</th>
				<th >MESSAGE</th>
				<th >COMMENTS</th>
				<th ></th>
				<th >BILL</th>
			</tr>
			<!-- <tr>
				<th >दिनांक</th>
				<th >सदस्य</th>
				<th >संदेश</th>
				<th >टिप्पणी</th>
				<th ></th>
				<th>मात्रा</th>
			</tr>  -->
		<%
		Object[][] savedMessage=messageBean.getSaved_messages();
		Integer q=0;
		while(savedMessage!=null && q < savedMessage.length) {
			%>
			<tr>
				<td><%=savedMessage[q][4]%></td>
				<td><%=savedMessage[q][6]%></td>
				<td><audio controls>
           				<source src="<%=savedMessage[q][0]%>" type="audio/wav"></source>
           			 	<p>Your browser does not support this audio format.</p>
            		</audio>
            		<a href="<%=savedMessage[q][0]%>" target="_blank" title="Right Click Save Link as">Download</a>
            	</td>
            	<%
					if(savedMessage[q][3]!=null){            	
            	%>
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=savedMessage[q][5]%>"><%=savedMessage[q][3]%></textarea></span></td>
            	<%
					} 
					else {
         
						%>
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=savedMessage[q][5]%>"></textarea></span></td>
            	<%} %>
            	<td><span id="update-comment-<%=savedMessage[q][5]%>"></span></td>
                <td class="style-td"><a class="add-button" <% out.print("href='IvrsServlet?messageId="+savedMessage[q][5]+"&memberName="+savedMessage[q][6]+"&groupId="+groupId+"&orderTime="+savedMessage[q][4]+"&comments="+savedMessage[q][3]+"&msgUrl="+savedMessage[q][0]+"&req_type=processOrEdit'"); %>>&nbsp;&nbsp;Process/Edit&nbsp;&nbsp;</a></td>           	
		<%
		q++;
		}
}
		%>
		</table>
		<div id="display-content">
		</div>
	   </div><!-- End of Saved  Orders Division -->
	</div><!-- End of tabs division -->
	<%
	}
				%>
				
    </div>
</body>
</html>