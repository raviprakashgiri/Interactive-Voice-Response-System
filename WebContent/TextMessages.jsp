<!DOCTYPE html>

<!-- 
Document : TextMessages.jsp  
@author  : Rasika Mohod  (MVC Conversion)
 -->

<%@page  language="java" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean" scope="request" />
<jsp:useBean id="messageBean" class="com.iitb.MessageBean.VoiceTextMessagesBean" scope="request" />
<jsp:useBean id="memberBean" class="com.iitb.MemberBean.MemberBean" scope="request" />
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean" scope="session" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
      <script src="js/validate.js"></script>
    <link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <!-- <script src="js/popup.js"></script> -->
    <link rel="stylesheet" type="text/css" href="css/Main.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	<script src="js/jquery-1.9.1.js"></script>
    <script src="js/validate.js"></script>
    <script src="js/jquery-ui.js"></script>
	<script src="js/jquery-ui.js"></script>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="js/Validate.js"></script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="js/validate.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" href="css/jquery-ui.css" />
    <link rel="stylesheet" href="css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="css/Main.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
	
<script type="text/javascript">
	    $(document).ready(function()
	    {
	        $("iframe").height($(document).height()-100);
	        $(".group-header").click(function()
	        {
	            var elem=$(this).next();
	            $(this).next().slideToggle();
	        });
	        $( "#all-groups" ).accordion({ collapsible: true });
	    });
     	$(document).ready(function(){
     		$(".comments").blur(function(){
     			
     			var id=$(this).attr("id");
     			var comment=$(this).val();
     			console.log(id);
     			$.ajax({
     				url: 'IvrsServlet',
     				type: 'POST',
     				data: {'req_type':'updateMessageComment','messageId':id,'messageComments':comment},
     				success: function(){
     					
     					$("#update-comment-"+id).fadeIn(100).text("Updated").fadeOut(3000);
     				}
     			});
     		});
     	});
     	
     	$(document).ready(function()
     	{
     		$(".defaultcomments").blur(function()
     		{
       			var id=$(this).attr("id");
     			var comment=$(this).val();
     			console.log(id);
     			$.ajax
     			({
     				url: 'IvrsServlet',
     				type: 'POST',
     				data: {'req_type':'updateDefaultMessageComment','messageId':id,'messageComments':comment},
     				success: function()
     				{
     					$("#update-comment-"+id).fadeIn(100).text("Updated").fadeOut(3000);
     				}
     			});
     		});
     	});
	     	
		$(function()
		{
			$( "#tabs" ).tabs();
			 $("#report-tabs").tabs();
		}); 
		$(document).ready(function()
			{
			$(".view-all").click(function()
			{
				$( ".display-members" ).toggle('blind', {}, 500 );
			});
			
			$('#selectAll').click(function (event)
			{
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
	            if(membersData!=null){
	            while(a < membersData.length)
	            {
	            	out.print("{label: \""+membersData[a][1]+"\", value:\""+membersData[a][2]+"\"},");
	            	a++;
	            }}
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

		$(document).ready(function(){
		$("select").change(function(){
				var id=$(this).attr("class");
				var statusId=$(this).val();
				console.log("Status changed" + statusId);
				
				$.ajax({
					url: 'IvrsServlet',
					type: 'POST',
					data: {'req_type':'updateMessageStatus','messageId':id,'statusId':statusId},
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
	

	try{
	%>
	<div id="content">
		<!-- Start of tabs division -->
		<div id="tabs">  
			<ul>
				<li><a href="#inbox">Inbox<br></a></li>
				<li><a href="#accepted">Accepted<br></a></li>
				<li><a href="#rejected">Rejected<br></a></li>
				<li><a href="#response">Response(Yes/No)<br></a></li>
   				<li><a href="#feedback">Feedback<br></a></li>
   				<li><a href="#default">Default Message<br></a>
   			</ul>
   			
<!-- INBOX  MESSAGES -->

	<div id="inbox"> <!-- Start of Inbox Division -->
	 <button id="bar-name" class="btn btn-info add-button" style="margin-bottom:20px;"><a class="voice-inbox"href="IvrsServlet?groupId=<%=groupBean.getGroups_id()%>&req_type=downloadMessages" >Download All Messages</a></button>
	
		<table>
		<tr>
			<th>DATE</th>
			<th>MEMBER</th>
			<th>MSG ID</th>	
			<th>MESSAGE</th>
			<th>STATUS</th>
			<th>COMMENTS</th>
		</tr>
		<!-- <tr>
			<th>दिनांक</th>
			<th>सदस्य</th>
			<th>संदेश आईडी</th>
			<th>संदेश</th>
			<th>स्थिति</th>
			<th>टिप्पणी</th>
		</tr>  -->
		
		<%
		Object[][] inboxMessage=messageBean.getInbox_messages();
		Integer j=0;
		while(inboxMessage!=null && j < inboxMessage.length) {
			%>
			<tr  >
				<td><%=inboxMessage[j][4]%></td>
				<td><%=inboxMessage[j][6]%></td>
				<td><%=inboxMessage[j][5] %>
				<td><%=inboxMessage[j][0]%>
            	</td>
            	<td>
            	<%
            	//Condition if message is not assigned to any status (accepted/rejected) yet then options provided to accpet/reject
            	if(inboxMessage[j][2].toString().equals("0")){
            	%>
            		<select name="status" class="<%=inboxMessage[j][5]%>">
        			<option value="0" selected>Select action</option>            		
        			<option value="1">Accept</option>
        			<option value="2">Reject</option>
        			</select>
            <%	}	
            	//If no action is selected then cancelled
            	else {
            		%>
            		Cancelled
            	<%}%>
            	<td><span class="comment-area"><textarea name="comments" id="<%=inboxMessage[j][5]%>"><%=inboxMessage[j][3]%></textarea></span></td>
            	<td><span id="update-comment-<%=inboxMessage[j][5]%>"></span></td>
		<%
		j++;
		}
		%>
		</table>
		<div id="display-content">
		</div>
		</div><!-- End of Inbox Division -->
		
<!-- DEFAULT MESSAGES -->	


<div id="default"> <!-- Start of Default Division -->
	<table>
		<tr>
			<th>DATE</th>
			<th>MEMBER</th>
			<th>MSG ID</th>	
			<th>MESSAGE</th>
			<th>COMMENTS</th>
		</tr>
		<!--  <tr>
			<th>दिनांक</th>
			<th>सदस्य</th>
			<th>संदेश आईडी</th>
			<th>संदेश</th>
			<th>टिप्पणी</th>
		</tr>-->
		
		<%
		Object[][] defaultMessage=messageBean.getDefault_messages();
		Integer k=0;
		while(defaultMessage!=null && k < defaultMessage.length) {
			%>
			<tr >
				<td><%=defaultMessage[k][3]%></td>
				<td><%=defaultMessage[k][0]%></td>
				<td><%=defaultMessage[k][2] %>
				<td><%=defaultMessage[k][1]%>
            	</td>
            	
            	<td><span class="comment-area"><textarea name="defaultcomments" class="defaultcomments" id="<%=defaultMessage[k][2]%>"><%=defaultMessage[k][5]%></textarea></span></td>
            	<td><span id="update-comment-<%=defaultMessage[k][2]%>"></span></td>
		<%
		k++;
		}
		%>
		</table>
		<div id="display-content">
		</div>
</div><!-- End of Default Division -->


<!-- ACCEPTED MESSAGES -->	


<div id="accepted"><!-- Start of Accepted Division -->
		<table>
			<tr>
				<th>DATE</th>	
				<th></th>	
				<th>MEMBER</th>
				<th></th>
				<th>MSG ID</th>
				<th></th>	
				<th>MESSAGE</th>
		        <th></th>	
			    <th>COMMENTS</th>
			</tr>
		<!-- 	<tr>
				<th>दिनांक</th>
				<th></th>	
				<th>सदस्य</th>
				<th></th>	
				<th>संदेश आईडी</th>
				<th></th>	
				<th>संदेश</th>
				<th></th> 
				 <th>टिप्पणी</th>
			</tr>  -->
		<%
		Object[][] acceptedMessage=messageBean.getAccepted_messages();
		Integer l=0;
		while(acceptedMessage!=null && l < acceptedMessage.length) {
			%>
			
		  <tr>
				<td><%=acceptedMessage[l][4]%></td>
				<td></td>
				<td><%=acceptedMessage[l][6]%></td>
				<td></td>
				<td><%=acceptedMessage[l][5]%></td>
				<td></td>
				<td><%=acceptedMessage[l][0]%>
            	</td>
            	<td></td>
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=acceptedMessage[l][5]%>"><%=acceptedMessage[l][3]%></textarea></span></td>
            	<td><span id="update-comment-<%=acceptedMessage[l][5]%>"></span></td>
		<%
		l++;
		}
		%>
		</table>
		<div id="display-content">	
			</div>
			</div><!-- End of Accepted Division -->
			
						
<!-- REJECTED MESSAGES -->


	<div id="rejected"><!-- Start of Rejected Division -->
		<table>
			<tr>
				<th>DATE</th>
				<th></th>		
				<th>MEMBER</th>
				<th></th>
				<th>MSG ID</th>
				<th></th>	
				<th>MESSAGE</th>
				<th></th>	
				<th>COMMENTS</th>
			</tr>
		<!-- 	<tr>
				<th>दिनांक</th>
				<th></th>	
				<th>सदस्य</th>
				<th></th>	
				<th>संदेश आईडी</th>
				<th></th>	
				<th>संदेश</th>
				<th></th>	
				<th>टिप्पणी</th>
			</tr>  -->
			
		<%
		Object[][] rejectedMessage=messageBean.getRejected_messages();
		Integer m=0;
		while(rejectedMessage!=null && m < rejectedMessage.length) {	
			%>
			<tr>
				<td><%=rejectedMessage[m][4]%></td>
				<td></td>
				<td><%=rejectedMessage[m][6]%></td>
					<td></td>
					<td><%=rejectedMessage[m][5]%></td>
					<td></td>
				<td><%=rejectedMessage[m][0]%>
            	</td>
            		<td></td>
            	<td><span class="comment-area"><textarea name="comments" class="comments" id="<%=rejectedMessage[m][5]%>"><%=rejectedMessage[m][3]%></textarea></span></td>
            	<td><span id="update-comment-<%=rejectedMessage[m][5]%>"></span></td>
  		<%
  		m++;
  		}
		%>
		</table>
		<div id="display-content">
			</div>
		</div><!-- End of Rejected Division -->
		
<!-- RESPONSE YES?NO -->

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
         		 		<th id="mem-name">DATE</th>
          				<td>&nbsp;</td>
          				<th id="mem-name">NAME</th>
          				<td>&nbsp;</td>	 
                        <th id="msg_id">MSG ID</th>
          				<td>&nbsp;</td>
        			 	<th id="mem-response">REPONSE</th>
        			</tr>
        		<!-- 	<tr>
			        	 <td>&nbsp;</td>
				         <th></th>
				         <th>दिनांक</th>
				         <td>&nbsp;</td>
				         <th>नाम</th>
				         <td>&nbsp;</td>
					  	 <th>संदेश आईडी</th>
						 <td>&nbsp;</td>
					     <th>प्रतिक्रिया</th>
			        </tr>  -->
        <% 
        Object[][] responseYes=messageBean.getResponse_yes();
		Integer n=0;
		while(responseYes!=null && n < responseYes.length) {
          out.println("<form action='IvrsServlet' method='POST'>");
          out.println("<td><input type=\"checkbox\" name=\"selectedMembers\" value=\""+responseYes[n][0]+"\"/></td>");
          out.println("<td>&nbsp;</td>");
          out.println("<td>"+responseYes[n][4]+"</td>");
          out.println("<td>&nbsp;</td>");
          out.println("<td>"+responseYes[n][0]+"</td>");
          out.println("<td>&nbsp;</td>");
          out.println("<td>"+responseYes[n][3]+"</td>");
          out.println("<td>&nbsp;</td>");
          out.println("<td>"+responseYes[n][2]+"</td>");
          out.println("</tr>");
          n++;
        }
        %>
        		</table>
        	</div>
            <div id="outgoing-calls">
                 <table>
        			<tr>    
        				<th></th> 
         		 		<th id="mem-name">DATE</th>
                        <th id="mem-name">NAME</th>
                        <th id="msg_id">MSG ID</th>
        			  	<th id="mem-response">REPONSE</th>
        			</tr>
        		<!-- 	<tr>
				        <th></th>
				        <th>दिनांक</th>
				        <th>नाम</th>
						<th>संदेश आईडी</th>
					    <th>प्रतिक्रिया</th>
				    </tr>  -->
        <% 
        Object[][] responseNo=messageBean.getResponse_no();
		Integer o=0;
		while(responseNo!=null && o < responseNo.length) {
        	  out.println("<form action='IvrsServlet' method='POST'>");
	          out.println("<td><input type=\"checkbox\" name=\"selectedMembers\" value=\""+responseNo[o][0]+"\"/></td>");         
	          out.println("<td>"+responseNo[o][4]+"</td>");
	          out.println("<td>"+responseNo[o][0]+"</td>");
	          out.println("<td>"+responseNo[o][3]+"</td>");
	          out.println("<td>"+responseNo[o][2]+"</td>");
	          out.println("<td>&nbsp;</td>");
	          out.println("</tr>");
	          o++;
        }
        %>
        </table>
        	</div>
   	     </div>
     </div><!-- End of Response Division -->
     
     
<!-- FEEDBACK MESSAGES -->


	<div id="feedback"><!-- Start of Feedback Division -->
      <table>
		<tr>
			<th>DATE</th>
			<th></th>		
			<th>MEMBER</th>
			<th></th>
			<th>MSG ID</th>
			<th></th>
			<th>MESSAGE</th>
		</tr>
		<!-- <tr>
			<th>दिनांक</th>
			<th></th>
			<th>सदस्य</th>
			<th></th>
			<th>संदेश आईडी</th>
			<th></th>
			<th>संदेश</th>
		</tr>  -->
		<%
		Object[][] feedback=messageBean.getFeedback_messages();
		Integer p=0;
		while(feedback!=null && p < feedback.length) {
			%>
			<tr>
				<td><%=feedback[p][2]%></td>
				<td></td>
				<td><%=feedback[p][4]%></td>
				<td></td>
				<td><%=feedback[p][3]%></td>
            	<td></td>
            	<td><%=feedback[p][0]%></td>
            </tr>
		<%
		p++;
		}
		%>
		</table>
     	</div>
    </div><!-- End of Feedback Division -->
    </div><!-- End of tabs Division -->
    <%
    
	}
		catch(Exception e){
			e.printStackTrace();
			response.sendRedirect("Error.html");
		}
	}
	%>
	</body>
	</html>