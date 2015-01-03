<!DOCTYPE html>
<!-- 
Document : Upload.jsp
Modified By : Nachiketh(Conversion to MVC)
 -->

<%@page import="com.iitb.globals.*"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.iitb.MemberBean.MemberBean"%>

<jsp:useBean id="upload" class="com.iitb.MessageBean.UploadBean"
	scope="request"></jsp:useBean>
<jsp:useBean id="loginUser" class="com.iitb.AuthenticatorBean.LoginBean"
	scope="session" />
<jsp:useBean id="groupBean" class="com.iitb.GroupBean.GroupBean"
	scope="request" />
<jsp:useBean id="member" class="com.iitb.MemberBean.MemberBean"
	scope="request"></jsp:useBean>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/Main.css">
<link rel="stylesheet" href="css/jquery-ui.css" />

<script type="text/javascript" src="js/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/Validate.js"></script>

<script>
function toggle(source) {
	console.log(source);
	  checkboxes = document.getElementsByClassName('case');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}

	$(function() {
		$( "#tabs" ).tabs();
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
            
            MemberBean memberBean = (MemberBean) request.getAttribute("memberBean");
        	
			 String groupId= groupBean.getGroups_id();            
            Object [][] members = memberBean.getMember_details();
            System.out.println("Member Bean is retrieved");
          //  System.out.println("Bla Bla ====" + members[0][1]);
            
            out.print("var availableTags = [");
            if(members==null){
            	System.out.println("Member Bean nt there");
            }
            for(int i=0;members!=null && i<members.length;i++){
            	out.print("{label: \""+members[i][1]+"\", value:\""+members[i][2] +"\"},");
          //  System.out.println("Bla Bla ====" + members[0][1]);
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

function callSMSURL(message,number,responses){
	//console.log("call sms called");
	 //console.log('number is'+number);
$.ajax({
	url: 'IvrsServlet',
	type: 'POST',
	data: {'smsContent':message,'receiverNumber':number,'response':responses,'req_type':'sendSMS','groupsId':'<%=groupId%>'},
	success: function(data){
		alert(data);
		
	}
});
$("#number").val(null);
$("#sms-message").val(null);
}
function checkNubmer(elemNum){
	var number=elemNum.val();
//            console.log(number);
var numflag=true;
if(number.length==0){
	return true;
}
else if(number.length<=10){
	numflag=false;
}
else if(isNaN(number)){ 
	numflag=false;
}
if(!numflag){
	elemNum.val(null);
	elemNum.attr("placeholder","Invalid phone number");
}
return numflag;
}

   
   
   
   function callVoiceURL(audioURL,number){
   	var msgURL="http://qassist.cse.iitb.ac.in/Downloads/audio-download/kookoo_audio1382515015596.wav";
   	var receiverNumber="09773232509";
   	receiverNumber=$("#voice-number").val();
//        console.log(kookooURL);
$.ajax({
	url : 'IvrsServlet',
	type: 'POST',
	data: {'req_type':'newCall','receiver_number':receiverNumber,'message_url':msgURL},
	success: function(data){
		alert(data);
	}
}).fail(function( jqXHR, textStatus ) {
	alert( "Request failed: " + textStatus );
});
}

  $(function() {
	  $( "#broadcast-call-dialog" ).dialog({
	    	resizable: false,
	    	height:480,
	    	width:710,
	    	autoOpen: false,
	    	modal: true,
	    });
  });

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

<style type="text/css">
td {
	padding: 5px;
	margin: 2px;
	display: block;
	float: left
}

strong {
	font-size: 1.5em;
}
</style>

</head>

<body>

<% 

if(loginUser.getUsername()==null){
  
  String refresh=request.getParameter("refresh");
  String flag="0";
  if(refresh!=null){
	  flag="1";
  }
  
}
%>
<%
if(loginUser.getUsername()==null || loginUser.getParent_org()==null || loginUser.getOrg_id()==null)
{ 
	RequestDispatcher requestDispatcher=request.getRequestDispatcher("Login.jsp");  
	requestDispatcher.forward(request, response);  
}

%>

	<%
	
try{
	
%>
	<div id="content">
		<div id="tabs" class="tabs" style="height:90%;">
			<ul>
				<li><a href="#voice">Voice Message</a></li>
				<li><a href="#text">Text Message</a></li>
				<li><a href="#video">Video Link</a></li>
			</ul>
			<div id="video">
				<form ENCTYPE="multipart/form-data" action="IvrsServlet"
					method="post" name="videoyoutube" id="videoyoutube">
					<table>
						<input type="hidden" name="tempflag" id="tempflag"
							value="mrequest" />
						<input type="hidden" name="req_type" id="req_type"
							value="videoyoutube" />
						<tr>
							<td>VideoName:</td>
							<td><input type="text" name="videoname" id="videoname"
								value="" required /></td>

						</tr>
						<tr>
							<td>VideoLink:</td>
							<td><input type="text" name="videolink" id="videolink"
								value="" required /></td>
						</tr>
						<td><input type="submit" value="Add Video Link" style="background-color:cadetblue"/></td>
					</table>
				</form>

			</div>
			<div id="voice">

				<br>
				<!-- <form ENCTYPE="multipart/form-data" action="IvrsServletMulti" method="post" name="BroadcastForm" id="BroadcastForm" onsubmit="return check();"> -->
				<table>
					<td>&nbsp;</td>
					<tr>
						<%
						
						
						String broadcastURL = upload.getBroadcast_url();
					
						Object [][] data = upload.getData();
						
						String idMessage = upload.getId_message();
				
	            	 %>
						<h3>Select Your Prefrence :</h3>
						<a class="record-upload" style="color: #ffffff;"
							href="Recorder/index.html" target='content-iframe' id="record" >&nbsp;&nbsp;&nbsp;Record&nbsp;&nbsp;&nbsp;</a>

						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="record-upload" style="color: #ffffff;"
							href="newFileUpload.jsp" target='content-iframe' id="upload">&nbsp;&nbsp;&nbsp;Upload&nbsp;&nbsp;&nbsp;</a>
						<br>
						<br> Last Recorded Message :
						<br>
						<audio controls>
							<source src="<%=broadcastURL%>" type="audio/wav" />
							Your browser does not support this audio format.
						</audio>
						<a href="<%=broadcastURL%>" target="_blank"
							title="Right Click Save Link as">Download</a>

					</tr>
					<br>
					<br>
					<br>

					<tr>
						<td><input title="Manage Broadcast Settings and Broadcast"
							type="button" onclick="broadcastCall1();" value="Broadcast" style="background-color:cadetblue;"></a>
							</button></td>
					</tr>
				</table>

				<div id="broadcast-call-dialog" class="broadcast-call-dialog">
					<form ENCTYPE="multipart/form-data" action="IvrsServlet"
						method="post" name="BroadcastForm" id="BroadcastForm"
						onsubmit="return check1();">
						<table>
							<tr>
								<td><b> Menu For Language:</b> <br> <br> <input
									type="checkbox" name="language" id="language" value="4"
									<%if(data[0][0].equals("4")){out.print("checked");}%> />Hindi<br>
									<input type="checkbox" name="language" id="language" value="5"
									<%if(data[0][0].equals("5")){out.print("checked");}%> />Marathi<br>
									<input type="checkbox" name="language" id="language" value="6"
									<%if(data[0][0].equals("6")){out.print("checked");}%> />English<br>
									<br></td>
								<td></td>
								<td><b>Response Type:</b> <br>
									<br> <input type="checkbox" name="response" value="1"
									<%if(data[0][2].equals("1")){out.print("checked");}%> />SemiStructured(Question)<br>
									<input type="checkbox" name="response" value="2"
									<%if(data[0][2].equals("2")){out.print("checked");}%> />Unstructured(Feedback)<br>
									<input type="checkbox" name="response" value="3"
									<%if(data[0][2].equals("3")){out.print("checked");}%> />Structured(Response)<br>
									<br></td>
								<td>
									<div class="all-members">
										<span class="box view-all" style="border: 1px solid black;">Click
											to select students</span>
										<div id="effects2">
											<table class="display-members">
												<tr>
												
													<td colspan="4"><input type="checkbox" id="selectall"
														onclick="toggle(this);" /> Select All</td>
													
												</tr>
												
												<%
									 for(int i=0;members!=null && i<members.length;){
									%>
												<tr>
													<td><input type="checkbox" class="case"
														name="selectedMember" id="selectedMember"
														value="<%=members[i][0]%>" /></td>
													<td class="display-members-td-2"><%=members[i][1]%></td>
													<td class="display-members-td-3"></td>
													<%i++; 
										if(i<members.length){
											System.out.println("in 1st if "+i);
										%>
													<td><input type="checkbox" class="case"
														name="selectedMember" id="selectedMember"
														value="<%=members[i][0]%>" /></td>
													<td class="display-members-td-2"><%=members[i][1]%></td>
													<%}else { break;}
										%>
													<%i++;
										if(i<members.length){
											System.out.println("in 2st if "+i);
										%>
													<td><input type="checkbox" class="case"
														name="selectedMember" id="selectedMember"
														value="<%=members[i][0]%>" /></td>
													<td class="display-members-td-2"><%=members[i][1]%></td>
													<% } 
										else {break;}
										i++;
										%>
												</tr>
												<%
									}
									%>
											</table>
										</div>
									</div>
							<tr>

								<td><br> When you want to broadcast the call</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="tr" name="now" id="now"
									value="newCall" checked />Now</td>
								<td><input type="checkbox" class="tr" name="scheduled"
									id="scheduled" value="scheduled" onclick="scheduledTimes();" />Scheduled
									Times</td>
							</tr>
							<tr>
								<td><div id="scheduledTimes"></div></td>
							</tr>
							<td>How many BackUp Call do you want: <br> <br> <select name="backup_calls"
								id="backup_calls" onchange="dropDowns1();">
									<option value="0">0 backupcall</option>
									<option value="1">1 backupcall</option>
									<option value="2">2 backupcall</option>
									<option value="3">3 backupcall</option>
									<option value="4">4 backupcall</option>
									<option value="5">5 backupcall</option>
							</select>
								<div id="myDiv"></div>
							</td>
							<br>
							<br>
							<td></td>
							</tr>
							<tr>
								<td><input type="hidden" name="filePresent"
									id="filePresent" value="" /> <input type="hidden"
									name="fileName" id="fileName" value="" /> <input type="hidden"
									name="group_id" id="group_id" value=<%=groupId%>> <input
									type="hidden" name="tempflag" id="tempflag" value="mrequest" />
									<input type="hidden" name="req_type" id="req_type"
									value="broadcast" /></td>
							<tr>
								<td><br> <input type="submit"
									value="Place Call" onclick="return submitCall();"
									<%if(data[0][3].equals("0")){out.print("disabled");} %> /> <%if(data[0][3].equals("0")){ %>
									<b><font class="span">your broadcast feature is
											disabled.</font></b> <%} %></td>
							</tr>
							<%
									int count = upload.getCount();
									int total = upload.getTotal();	
								%>
							<tr>
								<td>Unreceived Call:<%=count%>
								</td>


								<td>DND number:<%=total%>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>

			<div id="text">
				<h3 class="head">TextMessage </h3>
				<div id="body-content" class="body-content">
					<br>
					<table>
						<tr>
							<td>Message to be sent :</td>
							<td><textarea name="message" rows="5" cols="30"
									id="sms-message" onkeyup="countChar(this)" required></textarea></td>
							<td><span id="msgNum"></span>/<span id="charNum"></span></td>

						</tr>
					</table>
					<table>
						<tr>
							Message response :--
							<br>
							<input type="radio" id="radio1" name="value" value="order">Order
							<br>
							<input type="radio" id="radio2" name="value" value="feedback">Feedback
							<br>
							<input type="radio" name="value" id="radio3" value="response">Response
							<br>
							<input type="radio" name="value" id="radio4" value="noresponse">No
							Response
							<br>
							<br>
						</tr>
						<tr>
							<td><button title="Adds Message Id to Message"
									onclick="addText(event)" value=<%= idMessage %> style="background-color:cadetblue;">Add
									MESSAGE ID</button></td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td>
							<button onclick="displayVideos('videosList');" style="background-color: cadetblue;" title="Videos List">Videos List</button>
							
						</tr>
					</table>
					<div id="videosList" style="display: none;">
						<%
                         	Object vid[][] = upload.getVideo_id();
                         System.out.println("================================"+vid.length);
                         
       	                 %>
						<table>
							<tr>Video Name
							</tr>
							<%
       	                 	for(int i=0;i<vid.length;i++){
       	                 		
       	                 %>
							<tr>
								<td><input type="checkbox" name="video" id="videoname"
									value="<%=vid[i][1]%>" /><%=vid[i][0] %></td>
								<% out.println("<BR>"); %>
							</tr>
						</table>
						<%} %>
						<input type="button" onclick="myFunction()" value="Add Links" style="background-color:cadetblue">
					</div>
					<tr>
						<td><br></td>
						<td style="color:cadetblue;">Select recepients :</td>
					</tr>
					<div class="all-members">
						<span class="box view-all">Click to view all students</span>
						</td>

						<div id="effects2">
							<table class="display-members">
								<tr>
									<td><input type="checkbox" name="selectedMembers"
										value="all" id="selectAll" /></td>
									<td>Select All</td>
								</tr>
								<% 
						for(int i=0;members!=null && i<members.length;i++){
						out.println("<tr>");
						out.println("<td><input type=\"checkbox\" name=\"selectedMembers\" value=\""+members[i][2]+"\"/></td>");
						out.println("<td>"+members[i][1]+"</td>");
						out.println("</tr>");
						}
								System.out.println("after dipslay member ");
					%>
							</table>
						</div>
						<br> <br>
						<table>
							<tr>
								<td><label for="tags">Choose by members by typing
										names: </label></td>

								<td><input id="tags" size="50" /></td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td><div id="selected">
										<ul></ul>
									</div></td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
							<tr>
								<td>Enter number to send:</td>
								<td><input type="tel" name="number" id="number" required /></td>
							</tr>
							<tr>
								<td>(10-digit number and starting with zero)</td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
							<tr>
								<td><input type="submit" value="Send SMS" class="add-button"
									onclick="SMSwithJSP();" style="background-color:cadetblue;"/></td>
							</tr>
						</table>

						<div id="selectedNumbers" class="done"></div>
					</div>
				</div>
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