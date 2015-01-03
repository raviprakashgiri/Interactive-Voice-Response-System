
function checkSession(a){
	if(a=='null'){
		alert("Session Expired.. Please login again");
		window.parent.parent.window.location ="Login.jsp";
	}
}
//Used to check if valid date had been entered in DatePick.jsp and FullReportDate.jsp
function checkvalid(input){
	if(input)
		alert("Enter valid date");
}

function checkAllToAdd(source) {
	//alert("working");
	checkboxes = document.getElementsByClassName('notInGroups');
	for(var i=0, n=checkboxes.length;i<n;i++) {
		// alert(i);
		checkboxes[i].checked = source.checked;
	}
}




function checkAllToDelete(source) {
	checkboxes = document.getElementsByClassName('inGroups');
	for(var i=0, n=checkboxes.length;i<n;i++) {
		checkboxes[i].checked = source.checked;
	}
}


function resetLowerBound(){
	lowerBound=-10;
	$("table > tbody").html("");
}


function Update(whatUpdate,idOfUpdatable)
{
	var xmlhttp;
	if(document.getElementById(idOfUpdatable).value==""){
		alert("Please enter "+idOfUpdatable);
		return;
	}
	var valueOfUpdatable = document.getElementById(idOfUpdatable).value;
	alert(valueOfUpdatable);

	if (window.XMLHttpRequest)
	{// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else
	{// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET","IvrsServlet?req_type="+whatUpdate+"&value="+valueOfUpdatable,true);
	//alert("IvrsServlet?req_type="+whatUpdate+"value="+valueOfUpdatable);
	xmlhttp.send();
	alert("done");
}


function getData(req_type,org_id){

	lowerBound+=10;

	$.ajax({
		url: 'IVRSDataServlet',
		data: {'req_type':req_type,'lowerBound':lowerBound,'org_id':org_id},
		type: 'POST',
		success: function(resp){
			$("#"+req_type+" > table").append(resp);
		}
	});
	return false;
}

function SaveSettings(){
	//check();
	document.getElementById("req_type").value="file_upload_fromForm";
	//alert(document.getElementById("req_type").value);
	//var language = document.getElementsByName("language");
	//var response = document.getElementsByName("response1");

	if(document.getElementById('file_upload').value!=""){
		//alert('yes');
		var size = document.getElementById('file_upload').files[0].size;
		//alert(size);
		var Extension = document.getElementById("file_upload").value.split('.').pop().toLowerCase();
		if(size<(1024 * 1024 * 2)){
			if(Extension == "wav"){
				alert("Your changes are updated successfully..");
				return true;
			}else{
				alert("Please select file in wav format.");
				return false;
			}

		}else{
			alert("Please select below 2MB data file.");
			return false;
		}

	}
	else if(document.getElementById('file_upload').value==""){
		alert("Please select a file to upload.");
		return false;
	}else{
		alert("your settings have been saved successfully..");
	}

}


function SaveSettings1(){
	//check();
	document.getElementById("req_type").value="global_group_settings";
	//alert(document.getElementById("req_type").value);

	var language = document.getElementsByName("language");
	var languagein = document.getElementsByName("languagein");
	var response = document.getElementsByName("response1");
	//alert(document.getElementById('welcome_message').value);
	var responsein = document.getElementsByName("responsein");
	//alert(response);
	var respinOkay=false;
	var langinOkay=false;
	var langOkay=false;
	var respOkay=false;
	for(var i=0,l=language.length;i<l;i++)
	{
		if(language[i].checked)
		{
			langOkay=true;
		}
	}
	for(var i=0,l=languagein.length;i<l;i++)
	{
		if(languagein[i].checked)
		{
			langinOkay=true;
		}
	}
	for(var i=0,l=response.length;i<l;i++)
	{
		if(response[i].checked)
		{
			respOkay=true;
		}
	}
	for(var i=0,l=responsein.length;i<l;i++)
	{
		if(responsein[i].checked)
		{
			respinOkay=true;
		}
	}
	if(!langOkay){
		alert("Please select language.");
		return false;
	}
	if(!langinOkay){
		alert("Please select incoming language.");
		return false;
	}
	if(!respOkay){
		alert("Please select Response type.");
		return false;
	}
	if(!respinOkay){
		alert("Please select incoming Response type.");
		return false;
	}
	if(document.getElementById('welcome_message').value!=""){
		//alert('yes');
		var size = document.getElementById('welcome_message').files[0].size;
		//alert(size);
		var Extension = document.getElementById("welcome_message").value.split('.').pop().toLowerCase();
		if(size<(1024 * 1024 * 2)){
			if(Extension == "wav"){

				document.getElementById("filePresent").value="filePresent";

				alert("Your changes are updated successfully..");
				return true;
			}else{
				alert("Please select file in wav format.");
				return false;
			}

		}else{
			alert("Please select below 2MB data file.");
			return false;
		}

	}
	alert("your settings have been saved successfully..");

}


function SaveSettings2(){
	//check();
	document.getElementById("req_type").value="globalGroupSettings";
	//alert(document.getElementById("req_type").value);

	var language = document.getElementsByName("language");
	var languagein = document.getElementsByName("languagein");
	var response = document.getElementsByName("response1");
	//alert(document.getElementById('welcome_message').value);
	var responsein = document.getElementsByName("responsein");
	//alert(response);
	var respinOkay=false;
	var langinOkay=false;
	var langOkay=false;
	var respOkay=false;
	for(var i=0,l=language.length;i<l;i++)
	{
		if(language[i].checked)
		{
			langOkay=true;
		}
	}
	for(var i=0,l=languagein.length;i<l;i++)
	{
		if(languagein[i].checked)
		{
			langinOkay=true;
		}
	}
	for(var i=0,l=response.length;i<l;i++)
	{
		if(response[i].checked)
		{
			respOkay=true;
		}
	}
	for(var i=0,l=responsein.length;i<l;i++)
	{
		if(responsein[i].checked)
		{
			respinOkay=true;
		}
	}
	if(!langOkay){
		alert("Please select language.");
		return false;
	}
	if(!langinOkay){
		alert("Please select incoming language.");
		return false;
	}
	if(!respOkay){
		alert("Please select Response type.");
		return false;
	}
	if(!respinOkay){
		alert("Please select incoming Response type.");
		return false;
	}
	if(document.getElementById('welcome_message').value!=""){
		//alert('yes');
		var size = document.getElementById('welcome_message').files[0].size;
		//alert(size);
		var Extension = document.getElementById("welcome_message").value.split('.').pop().toLowerCase();
		if(size<(1024 * 1024 * 2)){
			if(Extension == "wav"){

				document.getElementById("filePresent").value="filePresent";

				alert("Your changes are updated successfully..");
				return true;
			}else{
				alert("Please select file in wav format.");
				return false;
			}

		}else{
			alert("Please select below 2MB data file.");
			return false;
		}

	}
	alert("your settings have been saved successfully..");

}



function SaveSettings4(){
	//check();
	//document.getElementById("req_type").value="file_upload_fromForm";
	//alert(document.getElementById("req_type").value);
	//var language = document.getElementsByName("language");
	//var response = document.getElementsByName("response1");
	
    if(document.getElementById('file_upload').value!=""){
    	//alert('yes');
    	var size = document.getElementById('file_upload').files[0].size;
    	//alert(size);
    	var Extension = document.getElementById("file_upload").value.split('.').pop().toLowerCase();
    	if(size<(1024 * 1024 * 2)){
            if(Extension == "wav"){
            	alert("Your changes are updated successfully..");
                return true;
            }else{
            	alert("Please select file in wav format.");
            	return false;
            }
        
    }else{
    	alert("Please select below 2MB data file.");
    	return false;
    }
    	
    }
    else if(document.getElementById('file_upload').value==""){
    	alert("Please select a file to upload.");
    	return false;
    }else{
    alert("your settings have been saved successfully..");
    }
    
}


//used in Upload.jsp to send broadcast text message
function SMSwithJSP(){
	var smsflag=false;
	
	var order = document.getElementById("radio1").checked;
	var feedback = document.getElementById("radio2").checked;
	var response = document.getElementById("radio3").checked;
	var no_response = document.getElementById("radio4").checked;
	if(order == true){
	var responses = $("#radio1").val();	
	   //alert(responses);
	if(checkNubmer($("#number"))&&checkMessage()){
	var message=$("#sms-message").val();
	var number=$("#number").val();
	//alert(number);
	if(number.length!=0){
	smsflag=true;
	
	// callSMSURL(message , number);
	callSMSURL(message , number , responses);
	callSMSURLJSP(message, number);
	}
	if(!smsflag){
	               
	           }
	           
	           $(":checkbox").each(function(){
	           	if(this.checked){
	           	var num=$(this).val();
	           	smsflag=true;
	           	if(num=="all"){
	           	//callSMSURL(message , num , responses);
	           	}
	           	else 
	           		callSMSURLJSP(message, num);
	           	callSMSURL(message , num, responses);
	           	 console.log(num);
	           	}
	           });
	       }
	}
	else if(feedback == true){
	var responses = $("#radio2").val();
	//alert(responses);
	
	if(checkNubmer($("#number"))&&checkMessage()){
	var message=$("#sms-message").val();
	//alert(message);
	    //document.write(message);
	var num = $("#selectedNumbers").val
	var number=$("#number").val();
	//alert("number="+num);
	if(number.length!=0){
	smsflag=true;

	callSMSURL(message , number , responses);
	callSMSURLJSP(message, number);}
	if(!smsflag){
	               // alert("Please select number to send");
	           }
	           
	           $(":checkbox").each(function(){
	           	if(this.checked){
	           	var num=$(this).val();
	           	smsflag=true;
	           	if(num=="all"){
	           	//callSMSURL(message , num ,responses);
	           	}
	           	else 
	           	callSMSURLJSP(message, num);
	           	callSMSURL(message , num , responses);
	           	 console.log(num);
	           	}
	           });
	       }
	}
	else if(response == true){
	var responses = $("#radio3").val();
	      //  alert(responses);	
	        if(checkNubmer($("#number"))&&checkMessage()){
	var message=$("#sms-message").val();
	//alert(message);
	    //document.write(message);
	var number=$("#number").val();
	//alert(number);
	if(number.length!=0){
	smsflag=true;
	callSMSURL(message , number , responses);
	callSMSURLJSP(message, number);
	}
	if(!smsflag){
	               // alert("Please select number to send");
	           }
	           
	           $(":checkbox").each(function(){
	           	if(this.checked){
	           	var num=$(this).val();
	           	smsflag=true;
	           	if(num=="all"){
	           	//callSMSURL(message , num, responses);
	           	}
	           	else 
	           		callSMSURLJSP(message, num);
	           	callSMSURL(message , num , responses);
	           	 console.log(num);
	           	}
	           });
	       }
	}
	else if(no_response=true){
		var responses = $("#radio4").val();
        if(checkNubmer($("#number"))&&checkMessage()){
            var message=$("#sms-message").val();
            var number=$("#number").val();

            if(number.length!=0){
              smsflag=true;

              callSMSURL(message , number , responses);
          	callSMSURLJSP(message, number);
            }
            if(!smsflag){
               // alert("Please select number to send");
           }
           
           $(":checkbox").each(function(){
           	if(this.checked){
           	var num=$(this).val();
           	smsflag=true;
           	if(num=="all"){
           	//callSMSURL(message , num, responses);
           	}
           	else 
           	callSMSURLJSP(message, num);
           	callSMSURL(message , num , responses);
           	 console.log(num);
           	}
           });
       }
	}
	  
	else{
	    	alert("please select the message type");
	    }
	    
	      
	}
	
	//used in Upload.jsp
	function callSMSURLJSP(message, number){
	console.log("call sms called");

	$.ajax({
	
	url: 'http://www.kookoo.in/outbound/outbound_sms.php?phone_no='+number+'&api_key=KK4063496a1784f9f003768bd6e34c185b&message='+message+'&callback=?',
	type: 'POST',
	data: '',
	success: function(data){
	
	}
	});
		$("#sms-message").val(null);
		alert("Message Sent");
	}

function showHideDivs(id,className) {
	if($('.'+className)){
		var obj = $('.'+className);
	}

	for(var i=0;i<obj.length;i++){
		if(obj[i] == document.getElementById(id)){
			var isHidden = obj[i].style.display;
			if(obj[i] == document.getElementById(id)){
				//$(obj[i]).show(2000);//.delay(2000);
				if(isHidden=='none'){
					$(obj[i]).show(500);//.delay(2000);
					//show(id);
				}
				else{
					$(obj[i]).hide(500);//.delay(2000);
				}
			}

		}
		else{
			$(obj[i]).hide(2000);//.delay(2000);
			//show(id);
		}
	}
}




function submitCall(){
	var backup_calls = parseInt(document.getElementById("backup_calls").value);
	var language = document.getElementsByName("language");
	var response = document.getElementsByName("response");
	//var member_id = document.getElementById("selectedMember").value;
	//document.getElementById("groups_id").value = document.getElementById("selectedMember").value;
	var members = document.getElementsByName("selectedMember");
	var langOkay=false;
	var respOkay=false;
	var memberOkay = false;
	for(var i=0,l=language.length;i<l;i++)
	{
		if(language[i].checked)
		{
			langOkay=true;
		}
	}
	for(var i=0,l=response.length;i<l;i++)
	{
		if(response[i].checked)
		{
			respOkay=true;
		}
	}
	 for(var i=0,l=members.length;i<l;i++)
	    {
	        if(members[i].checked)
	        {
	        	memberOkay=true;
	        }
	    }
	if(!langOkay){
		alert("Please select language.");
		return false;
	}
	if(!respOkay){
		alert("Please select Response type.");
		return false;
	}
	/*if(backup_calls==0){
		alert('Please select number of backup calls you want');
		return false;	
	}
	if(groups_id=="selectedMember"){
		alert('Please select Member to broadcat.');
		return false;	
	}*/
	if(!memberOkay){
		alert("Please select atleast one member.");
		return false;
	}
	if(backup_calls!=0){
		for(var i=1;i<backup_calls+1;i++)
		{

			if(document.getElementById("backup_call_time"+i).value=='0'){
				//alert(document.getElementById("backup_call_time"+i).value);
				alert('Please select broadcast time for Backup call '+i);
				return false;
			}
		}
	}
	//SaveSettings4();
}

function dropDowns(){
	var a = document.getElementById("backup_calls").value;
	var number = parseInt(a);
	//alert(a);
	//alert(number);
	var string ='<b>Please select the time( समय का चयन करें  ):</b><br>';
	for(var i=1;i<number+1;i++){
		string = string+'<select name="backup_call_time'+i+'" id="backup_call_time'+i+'" style="width:auto">'
		+'<option value="0">Select Time</option>'
		+'<option value="10 AM">10 AM</option>'
		+'<option value="11 PM">11 AM</option>'
		+'<option value="12 PM">12 PM</option>'
		+'<option value="1 PM">1 PM</option>'
		+'<option value="2 PM">2 PM</option>'
		+'<option value="3 PM">3 PM</option>'
		+'<option value="4 PM">4 PM</option>'
		+'<option value="5 PM">5 PM</option>'
		+' <option value="6 PM">6 PM</option>'
		+'<option value="7 PM">7 PM</option>'
		+'<option value="8 PM">8 PM</option>'
		+'<option value="9 PM">9 PM</option>'
		+' </select>';
	}
	document.getElementById("myDiv").innerHTML=string;
}



function broadcastCall(groups_id,msgURL,publisher_number){
	//groupList();
	var content= document.getElementById("content").value.toString();
	$( "#broadcast-call-dialog" ).dialog("open");
	$("#broadcast-call-dialog").html('<form ENCTYPE="multipart/form-data" action="IvrsServletMulti" method="post" name="BroadcastForm" id="BroadcastForm" onsubmit="return check();">'
			+'<table>'
			+'<input type="hidden" name="req_type" id="req_type" value="broadcastFromSentItems"/>'					
			+'</table>'
			+' <tr>'
			+' <b>Language:</b><br>'
			+'<input type="checkbox" name="language" id ="language" value="4" />&nbsp;Hindi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
			+'<input type="checkbox" name="language" id ="language" value="5" />&nbsp;Marathi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
			+' <input type="checkbox" name="language"  id ="language" value="6" />&nbsp;English'
			+' <br>'
			+' <br>'       
			+' <b>Response:</b><br>'
			+'<input type="checkbox" name="response" id ="response" value="1" />SemiStructured(Order)<br>'
			+'<input type="checkbox" name="response" id ="response" value="2" />Unstructured(Feedback)<br>'
			+'<input type="checkbox" name="response" id ="response" value="3" />Structured(Response)<br>'
			+'</br>'
			+'<b>Select Group to broadcast:</b>'
			+content+'</br>'
			+'<b>How many BackUp Call do you want():</b> <br>'
			+'<td><select name="backup_calls" id="backup_calls" onchange="dropDowns();" style="width:auto">'
			+'<option value="0">Select</option>'
			+'<option value="1">1</option>'
			+'<option value="2">2</option>'
			+'<option value="3">3</option>'
			+'<option value="4">4</option>'
			+'<option value="5">5</option>'
			+' </select>'
			+' </br>'

			+'<br>'

			+'<div id="myDiv"></div>'
			+'			<input type="hidden" name="groups_id" id="groups_id" value="'+groups_id+'"/>'
			+'			<input type="hidden" name = "msgURL" id ="msgURL" value="'+msgURL+'">'
			+'			<input type="hidden" name = "publisher_number" id ="publisher_number" value="'+publisher_number+'">'
			+'			<br>'
			+'		<input type="submit" value="Place Call" onclick="return submitCall();"/><!-- onclick="broadcastVoiceMessage();" --></td>'
			+'	</tr>'



			+'	</table>'
			+'</form>');	
}



function changeIvrsSettings(){
	alert("Your Settings are updated Successfully.");
	parent.location.reload();
}



function restoreDefaults(reqType,type) {
	var xmlhttp;

	//var valueOfUpdatable = document.getElementById(idOfUpdatable).value;
	//alert(reqType);
	var language = document.getElementById("ln").value;
	//alert(language);

	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("response").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("GET", "IvrsServlet?req_type=" + reqType + "&ln="
			+ language, true);
	//alert("IvrsServlet?req_type="+reqType+"&ln="+language);
	xmlhttp.send();

	alert("Your IVRS menu changed to "+type);
}

//used in manage.jsp for selecting multiple members
checked=false;

function checkedAll () {
	var aa= document.getElementById('checkForm');
	if (checked == false)
	{
		checked = true;
	}
	else
	{
		checked = false;
	}
	for (var i =0; i < aa.elements.length; i++) 
	{
		aa.elements[i].checked = checked;
	}
}
//Code to check all the checkboxes -->

function changeViewAdd(){
	document.getElementById('addGroups').style.display='block';
}

function checkboxValue()
{

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
		alert("Please select a group to change");
		document.getElementById("selectedGroup").focus();
		return false;
	}
	if(okay){
		alert("Group has been changed Successfully.");
		return true;
	}
	else{ 
		alert("Please Select members to change the group.");
		return false;
	}

}



function disableButton(a) {
	document.getElementById(a).disabled = true;
	document.getElementById(a).value = "Processing...";
	document.getElementById("response").style.display = "none";
	document.getElementById("ivrsMenuSettings").submit();

}


function check1(){

	if(document.getElementById("filePresent").value=="" && document.getElementById('broadcast_message').value==""){
		alert("Your changes are updated successfully..");
	}
	var size = document.getElementById('broadcast_message').files[0].size;
	var filePath = document.getElementById("broadcast_message").value;
	var Extension = filePath.split('.').pop().toLowerCase();
	var filename = filePath.match(/[-_\w]+[.][\w]+$/i)[0];
	filename = filename.replace("."+Extension,"");
	//alert("filename   "+ filename);
	

	if(size<(1024 * 1024 * 2)){
		if(Extension == "mp3" || Extension == "wav"){

			document.getElementById("filePresent").value="filePresent";
			document.getElementById("fileName").value=filename;
			alert("Your changes are updated successfully..");
			return true;
		}else{
			alert("Please select file in mp3/wav format.");
			return false;
		}

	}else{
		alert("Please select below 2MB data file.");
		return false;
	}

}





function check(){

	if(document.getElementById("filePresent").value=="" && document.getElementById('welcome_message').value==""){
		alert("Your changes are updated successfully..");
	}  

	var size = document.getElementById('welcome_message').files[0].size;
	var Extension = document.getElementById("welcome_message").value.split('.').pop().toLowerCase();

	if(size<(1024 * 1024 * 2)){
		if(Extension == "wav"){

			document.getElementById("filePresent").value="filePresent";
			alert("Your changes are updated successfully..");
			return true;
		}else{
			alert("Please select file in wav format.");
			return false;
		}

	}else{
		alert("Please select below 2MB data file.");
		return false;
	}

}



function defaultSet(){
	//alert("Default settings saved : defaultmail@gmail.com language: response:");
	document.getElementById("req_type").value="default";
	//alert(document.getElementById("req_type").value);
	document.getElementById("globalgroupSettings").submit();
	alert("Your settings have been changed successfully to defaultsettings..");
}

function disableDropdown(){
	console.log(document.getElementById("broadcast").value);

	if(document.getElementById("broadcast").value=='0'){
		console.log("Inside 0");
		document.getElementById("Previous_broadcast").value='0';
		document.getElementById("Previous_broadcastdiv").style.display='none';
		document.getElementById("repeat_broadcast").value='0';
		document.getElementById("Repeat_broadcastdiv").style.display ='none';
		//Latest_broadcast
		document.getElementById("Latest_broadcast").value='0';
		document.getElementById("Latest_broadcastdiv").style.display ='none';
	}
	if(document.getElementById("broadcast").value=='1'){
		//document.getElementById("Previous_broadcast").value='1';
		console.log("Inside 1");
		document.getElementById("Previous_broadcastdiv").style.display='block';
		document.getElementById("Repeat_broadcastdiv").style.display='block';
		document.getElementById("Latest_broadcastdiv").style.display='block';
	}
	
	disableBilldown();
}

function disableBilldown(){
	
	if(document.getElementById("bill").value=='0'){
		console.log("Inside 0");
		document.getElementById("save").value='0';
		document.getElementById("save").style.display='none';
		
	}
	if(document.getElementById("bill").value=='1'){
		//document.getElementById("Previous_broadcast").value='1';
		console.log("Inside 1");
		document.getElementById("save").style.display='block';
		
	}
}



//Checks all products on the form
//used in ProductForm.jsp
function checkAllToDelete1(source) {
	checkboxes = document.getElementsByClassName('existingProducts');
	for ( var i = 0, n = checkboxes.length; i < n; i++) {
		checkboxes[i].checked = source.checked;
	}
}

//Checks all quantities on the form
//used in ProductForm.jsp
function checkAllToDelete2(source) {
	checkboxes = document.getElementsByClassName('existingQuans');
	for ( var i = 0, n = checkboxes.length; i < n; i++) {
		checkboxes[i].checked = source.checked;
	}
}



function refreshManage() {
	$("#dialog").dialog("close");
	location.reload();
}






function generateRow() {
	var field_area = document.getElementById('addhere');
	var li = document.createElement("li");
	var input = document.createElement("input");
	input.id = 'products';
	input.setAttribute("name", "products");
	input.setAttribute("style", "border-radius:4px;margin-top:2px;padding-left:3px;");
	input.type = "text"; //Type of field - can be any valid input type like text,file,checkbox etc.
	input.placeholder = "Name of product";
	li.appendChild(input);
	field_area.appendChild(li);
	//create the removal link
	var removalLink = document.createElement('img');
	removalLink.setAttribute("src", "img/delete.jpg");
	removalLink.setAttribute("style",
	"width:20px;height:20px;margin-left:1%;vertical-align:middle;");
	removalLink.onclick = function() {
		this.parentNode.parentNode.removeChild(this.parentNode);
	};
	li.appendChild(removalLink);
	return false;
}




function delet(){
	var del=document.getElementById('del');
	del.onclick = function() {
		this.parentNode.parentNode.remove(this.parentNode);
	};
	return false;
}

function rem(){
	var dele=document.getElementById('dele');
	dele.onclick = function() {
		this.parentNode.parentNode.remove(this.parentNode);
	};
	return false;
}



//for adding products and quantities
//used by ProductForm.jsp
var coun1=0;	
var coun2=0;
function generateRow2(inside,tblname) {
	var name=new Array();
	var isthereinput=document.getElementById(tblname).rows.length-1;		
	if(isthereinput > 0){
		var names=new Array();
		if(inside=="products"){
			var id;
			var num=document.getElementsByName('products').length;
			for(var io=0;io<num;io++){
				id='products'+io;
				name[io]=document.getElementById(id).value;
			}
			var len=document.getElementsByName('updateProductsList').length;

			for( var q=0;q<len;q++){
				idd='updateProductsList'+q;
				names[q]=document.getElementById(idd).value;	
			}
		}
		if(inside=="quantity"){
			var id;
			var num=document.getElementsByName('quantity').length;

			for(var io=0;io<num;io++){
				id='quantity'+io;
				name[io]=document.getElementById(id).value;
			}

			var len=document.getElementsByName('updateQuansList').length;

			for( var q=0;q<len;q++){
				idd='updateQuansList'+q;
				names[q]=document.getElementById(idd).value;	

			}

		}
		for(var j=0;j<names.length;j++){
			for(var ko=0;ko<name.length;ko++){
				if(name[ko].toUpperCase()==names[j].toUpperCase()){
					alert('Please enter a different value. This value "'+name[ko]+'"  already exists !');
					return false;
				}
			}
		}

		var removalLink = document.createElement('img');
		removalLink.setAttribute("src", "img/delete.jpg");
		removalLink.setAttribute("style",
		"width:20px;height:20px;vertical-align:middle;");
		var tableRef = document.getElementById(tblname)
		.getElementsByTagName('tbody')[0];
		var newRow = tableRef.insertRow(tableRef.rows.length);
		var newCell1 = newRow.insertCell(0);
		if(inside=="products"){

			newCell1.innerHTML = "<input type='text' name='"+inside+"' id="+inside+""+coun1+" placeholder='Name' style='border-radius:4px;margin-top:2px;padding-left:3px;' required>";
			coun1++;
			var newCell2=newRow.insertCell(1);
			newCell2.innerHTML = "<input type='number' name='price' id='price'"+coun1+" placeholder='Price' style='border-radius:4px;margin-top:2px;padding-left:3px;' required>";
			var newCell3 = newRow.insertCell(2);
			//	newCell2=removalLink;
			//	newCell1.appendChild(newText1);
			newCell3.appendChild(removalLink);

			removalLink.onclick = function() {
				this.parentNode.parentNode.remove(this.parentNode);
				coun1--;
			};

		}
		if(inside=="quantity"){
			newCell1.innerHTML = "<input type='number' name='"+inside+"' id="+inside+""+coun2+" placeholder='Quantity' style='border-radius:4px;margin-top:2px;padding-left:3px;' required>";
			coun2++;
			var newCell2 = newRow.insertCell(1);
			//	newCell2=removalLink;
			//	newCell1.appendChild(newText1);
			newCell2.appendChild(removalLink);
			removalLink.onclick = function() {
				this.parentNode.parentNode.remove(this.parentNode);
				coun2--;
			};

		}

		//create the removal link
		return false;
	}
	if(isthereinput==0){
		var removalLink = document.createElement('img');
		removalLink.setAttribute("src", "img/delete.jpg");
		removalLink.setAttribute("style",
		"width:20px;height:20px;vertical-align:middle;");
		var tableRef = document.getElementById(tblname)
		.getElementsByTagName('tbody')[0];
		var newRow = tableRef.insertRow(tableRef.rows.length);
		var newCell1 = newRow.insertCell(0);
		if(inside=="products"){

			newCell1.innerHTML = "<input type='text' name='"+inside+"' id="+inside+""+coun1+" style='border-radius:4px;margin-top:2px;padding-left:3px;' required>";
			coun1++;
			var newCell2=newRow.insertCell(1);
			newCell2.innerHTML = "<input type='number' name='price' id='price'"+coun1+" style='border-radius:4px;margin-top:2px;padding-left:3px;' required>";
			var newCell3 = newRow.insertCell(2);
			//	newCell2=removalLink;
			//	newCell1.appendChild(newText1);
			newCell3.appendChild(removalLink);
			removalLink.onclick = function() {
				this.parentNode.parentNode.remove(this.parentNode);
				coun2--;
			};

		}
		if(inside=="quantity"){
			newCell1.innerHTML = "<input type='number' name='"+inside+"' id="+inside+""+coun2+" style='border-radius:4px;margin-top:2px;padding-left:3px;' required>";
			coun2++;
			var newCell2 = newRow.insertCell(1);
			//	newCell2=removalLink;
			//	newCell1.appendChild(newText1);
			newCell2.appendChild(removalLink);
			//create the removal link
			removalLink.onclick = function() {
				this.parentNode.parentNode.remove(this.parentNode);
				coun2--;
			};

		}
		return false;
	}
	return false;
}

//Used in ProductForm.jsp
function checker(name1,name2){
	var names=new Array();
	var name=new Array();
	var id;
	var num=document.getElementsByName(name1).length;

	for(var io=0;io<num;io++){
		id=name1+io;
		name[io]=document.getElementById(id).value;
	}

	var len=document.getElementsByName(name2).length;

	for( var q=0;q<len;q++){
		idd=name2+q;
		names[q]=document.getElementById(idd).value;	

	}

	for(var j=0;j<names.length;j++){
		for(var ko=0;ko<name.length;ko++){
			if(name[ko].toUpperCase()==names[j].toUpperCase()){
				alert('Please enter a different value. This value "'+name[ko]+'"  already exists !');
				return false;
			}
			
		}
	}
	return true;
};	

function addSelect(divname) {
	var newDiv=document.createElement('div');
	var html = '<select>', dates = dateGenerate(), i;
	for(i = 0; i < 4; i++) {
		html += "<option value='"+dates[i]+"'>"+dates[i]+"</option>";
	}
	html += '</select>';
	newDiv.innerHTML= html;
	document.getElementById(divname).appendChild(newDiv);
}


function validateForm(pass)
{
	var x=document.forms["login"]["pass2"].value;
	var y = document.forms["login"]["pass3"].value;
	if (x != y)
	{
		alert("New password mismatch");
		return false;
	}
	if(document.getElementById('pass1').value!=pass)
	{
		alert("Old Password does not Match");
		return false;

	}

	alert("your password updated successfully..");
}



function countChar(val) {

	var len = val.value.length;  
	if(len<=160){    
		$('#msgNum').text(1);
		$('#charNum').text(160-(len%160));
	}
	else if(len>160 && len<=305){  
		Math.floor($('#msgNum').text(2));
		$('#charNum').text(305-len);
	}
	else if(len>305){    
		len=len-305;
		var a=152-(len%152);
		$('#msgNum').text(Math.ceil((len/152)+2));
		if(a==152){
			$('#charNum').text('0');
		}    
		else{
			$('#charNum').text(a);
		}
	}
};



function displayVideos(id){
	var div = document.getElementById(id);
	if(div.style.display=="none"){
		div.style.display="";
	}else{
		div.style.display="none";
	}    
}


function addText(event) {
	var targ = event.target || event.srcElement;
	document.getElementById("sms-message").value += targ.value || targ.innerText;
}

function myFunction()
{
	//alert("video link");
	var video = document.getElementsByName('video');

	var txt = "";
	var i;
	for (i=0;i<video.length;i++)
	{
		if (video[i].checked)
		{
			txt = txt + video[i].value + " ";
		}
	}
	document.getElementById("sms-message").value += txt;
	//alert(txt);
}




function dropDowns1(){
	var a = document.getElementById("backup_calls").value;
	var number = parseInt(a);
	//alert(a);
	//alert(number);
	var string ='Please select the time ( समय का चयन करें ):<br>';
	for(var i=1;i<number+1;i++){
		string = string+'<select name="backup_call_time'+i+'" id="backup_call_time'+i+'" style="width:auto">'
		+'<option value="0">Hours</option>'
		+'<option value="7 AM">7 AM</option>'
		+'<option value="8 AM">8 AM</option>'
		+'<option value="9 AM">9 AM</option>'
		+'<option value="10 AM">10 AM</option>'
		+'<option value="11 PM">11 AM</option>'
		+'<option value="12 PM">12 PM</option>'
		+'<option value="1 PM">1 PM</option>'
		+'<option value="2 PM">2 PM</option>'
		+'<option value="3 PM">3 PM</option>'
		+'<option value="4 PM">4 PM</option>'
		+'<option value="5 PM">5 PM</option>'
		+' <option value="6 PM">6 PM</option>'
		+'<option value="7 PM">7 PM</option>'
		+'<option value="8 PM">8 PM</option>'
		+'<option value="9 PM">9 PM</option>'
		+' </select>';
		string = string+'<select name="backup_call_time_min'+i+'" id="backup_call_time_min'+i+'" style="width:auto">'
		+'<option value="0">Mins</option>'
		+'<option value="0">00</option>'
		+'<option value="1">01</option>'
		+'<option value="2">02</option>'
		+'<option value="3">03</option>'
		+'<option value="4">04</option>'
		+'<option value="5">05</option>'
		+' <option value="6">06</option>'
		+'<option value="7">07</option>'
		+'<option value="8">08</option>'
		+'<option value="9">09</option>'
		+'<option value="10">10</option>'
		+'<option value="11">11</option>'
		+'<option value="12">12</option>'
		+'<option value="13">13</option>'
		+'<option value="14">14</option>'
		+'<option value="15">15</option>'
		+' <option value="16">16</option>'
		+'<option value="17">17</option>'
		+'<option value="18">18</option>'
		+'<option value="19">19</option>'
		+'<option value="20">20</option>'
		+'<option value="21">21</option>'
		+'<option value="22">22</option>'
		+'<option value="23">23</option>'
		+'<option value="24">24</option>'
		+'<option value="25">25</option>'
		+'<option value="26">26</option>'
		+'<option value="27">27</option>'
		+'<option value="28">28</option>'
		+'<option value="29">29</option>'
		+'<option value="30">30</option>'
		+'<option value="31">31</option>'
		+'<option value="32">32</option>'
		+'<option value="33">33</option>'
		+'<option value="34">34</option>'
		+'<option value="35">35</option>'
		+' <option value="36">36</option>'
		+'<option value="37">37</option>'
		+'<option value="38">38</option>'
		+'<option value="39">39</option>'
		+'<option value="40">40</option>'
		+'<option value="41">41</option>'
		+'<option value="42">42</option>'
		+'<option value="43">43</option>'
		+'<option value="44">44</option>'
		+'<option value="45">45</option>'
		+'<option value="46">46</option>'
		+'<option value="47">47</option>'
		+'<option value="48">48</option>'
		+'<option value="49">49</option>'
		+'<option value="50">50</option>'
		+'<option value="51">51</option>'
		+'<option value="52">52</option>'
		+'<option value="53">53</option>'
		+'<option value="54">54</option>'
		+'<option value="55">55</option>'
		+'<option value="56">56</option>'
		+'<option value="57">57</option>'
		+'<option value="58">58</option>'
		+'<option value="59">59</option>'

		+' </select> &nbsp;&nbsp;';
	}
	document.getElementById("myDiv").innerHTML=string;
}


function scheduledTimes(){
	//var a = document.getElementById("backup_calls").value;
	var number = parseInt('3');
	//alert(a);
	//alert(number);
	var string ='Please select the times ( समय का चयन करें  ):<br>';
	for(var i=1;i<number+1;i++){
		string = string+'<br><select name="shceduled_time'+i+'" id="shceduled_time'+i+'" style="width:auto">'
		+'<option value="0">Select Time</option>'
		+'<option value="7 AM">7 AM</option>'
		+'<option value="8 AM">8 AM</option>'
		+'<option value="9 AM">9 AM</option>'
		+'<option value="10 AM">10 AM</option>'
		+'<option value="11 PM">11 AM</option>'
		+'<option value="12 PM">12 PM</option>'
		+'<option value="1 PM">1 PM</option>'
		+'<option value="2 PM">2 PM</option>'
		+'<option value="3 PM">3 PM</option>'
		+'<option value="4 PM">4 PM</option>'
		+'<option value="5 PM">5 PM</option>'
		+' <option value="6 PM">6 PM</option>'
		+'<option value="7 PM">7 PM</option>'
		+'<option value="8 PM">8 PM</option>'
		+'<option value="9 PM">9 PM</option>'
		+' </select>';
		string = string+'<select name="shceduled_time_min'+i+'" id="shceduled_time_min'+i+'" style="width:auto">'
		+'<option value="0">Select Minutes</option>'
		+'<option value="0">00</option>'
		+'<option value="1">01</option>'
		+'<option value="2">02</option>'
		+'<option value="3">03</option>'
		+'<option value="4">04</option>'
		+'<option value="5">05</option>'
		+' <option value="6">06</option>'
		+'<option value="7">07</option>'
		+'<option value="8">08</option>'
		+'<option value="9">09</option>'
		+'<option value="10">10</option>'
		+'<option value="11">11</option>'
		+'<option value="12">12</option>'
		+'<option value="13">13</option>'
		+'<option value="14">14</option>'
		+'<option value="15">15</option>'
		+' <option value="16">16</option>'
		+'<option value="17">17</option>'
		+'<option value="18">18</option>'
		+'<option value="19">19</option>'
		+'<option value="20">20</option>'
		+'<option value="21">21</option>'
		+'<option value="22">22</option>'
		+'<option value="23">23</option>'
		+'<option value="24">24</option>'
		+'<option value="25">25</option>'
		+'<option value="26">26</option>'
		+'<option value="27">27</option>'
		+'<option value="28">28</option>'
		+'<option value="29">29</option>'
		+'<option value="30">30</option>'
		+'<option value="31">31</option>'
		+'<option value="32">32</option>'
		+'<option value="33">33</option>'
		+'<option value="34">34</option>'
		+'<option value="35">35</option>'
		+' <option value="36">36</option>'
		+'<option value="37">37</option>'
		+'<option value="38">38</option>'
		+'<option value="39">39</option>'
		+'<option value="40">40</option>'
		+'<option value="41">41</option>'
		+'<option value="42">42</option>'
		+'<option value="43">43</option>'
		+'<option value="44">44</option>'
		+'<option value="45">45</option>'
		+'<option value="46">46</option>'
		+'<option value="47">47</option>'
		+'<option value="48">48</option>'
		+'<option value="49">49</option>'
		+'<option value="50">50</option>'
		+'<option value="51">51</option>'
		+'<option value="52">52</option>'
		+'<option value="53">53</option>'
		+'<option value="54">54</option>'
		+'<option value="55">55</option>'
		+'<option value="56">56</option>'
		+'<option value="57">57</option>'
		+'<option value="58">58</option>'
		+'<option value="59">59</option>'

		+' </select><br>';
	}
	if(document.getElementById("scheduled").checked==true){
		document.getElementById("scheduledTimes").innerHTML=string;
		document.getElementById("scheduledTimes").style.display='block';
	}else{
		document.getElementById("scheduledTimes").style.display='none';
	}
}

//Function to add products and quantity in ProcessOrEdit.jsp
var setError=0;
var sum=0;
var i=0;
var product_name=new Array();
var quantity_value=new Array();

function addcountProcessOrEdit() 
{
	if(setError===1){
		alert("Please enter Price for products in the product form !");
	}
	else{

		var existingRowCount=document.getElementById('orderList').getElementsByTagName('tbody').length;
		var product = document.getElementById("product");
		productName[i] = product.options[product.selectedIndex].text;
		var quantity = document.getElementById("quantity");
		quantityValue[i] = quantity.options[quantity.selectedIndex].text;
		var tableRef = document.getElementById('orderList').getElementsByTagName('tbody')[0];
		var newRow = tableRef.insertRow(tableRef.rows.length);
		var newCell1 = newRow.insertCell(0);
		var newText1 = document.createTextNode(productName[i]);
		var newCell2 = newRow.insertCell(1);
		var newText2 = document.createTextNode(quantityValue[i]);
		newCell1.appendChild(newText1);
		newCell2.appendChild(newText2);}
}

//Function to remove products and quantity in GenerateBill.jsp & ProcessOrEdit.jsp
function removeRow()
{
		var tbl = document.getElementById('orderList')
				.getElementsByTagName('tbody')[0];
		var lastRow = tbl.rows.length;
		if (lastRow > 1)
			tbl.deleteRow(lastRow - 1);

}

//Function to add products and different quantity in GenerateBill.jsp & ProcessOrEdit.jsp
function addDiffCount()
{
	if(setError===1)
	{
		alert("Please enter Price for products in the product form !");
	}
	else
	{
		var product = document.getElementById("product");
		product_name[i] = product.options[product.selectedIndex].text;
		var product_quant = document.getElementById("quan").value;
		if(product_quant=="")
		{
			alert("Please enter a value !"); 	
		return false;
		}
//		product_quant = product.options[product.selectedIndex].text;
		var tableRef = document.getElementById('orderList').getElementsByTagName('tbody')[0];
		var newRow = tableRef.insertRow(tableRef.rows.length);
		var newCell1 = newRow.insertCell(0);
		var newText1 = document.createTextNode(product_name[i]);
		var newCell2 = newRow.insertCell(1);
		var newText2 = document.createTextNode(product_quant);
		newCell1.appendChild(newText1);
		newCell2.appendChild(newText2);
		i++;
	}
}




var sum=0;
var product_name=new Array();
var quantity_value=new Array();
var i=0;
var setError=0;
//Function to add products and quantity in GenerateBill.jsp
	function addcountGenerateBill() 
	{
		if(setError===1){
			alert("Please enter Price for products in the product form !");
		}
		else{
	
			var existingRowCount=document.getElementById('orderList').getElementsByTagName('tbody').length;
			var product = document.getElementById("product");
			product_name[i] = product.options[product.selectedIndex].text;
			var quantity = document.getElementById("quantity");
			quantity_value[i] = quantity.options[quantity.selectedIndex].text;
			var tableRef = document.getElementById('orderList').getElementsByTagName('tbody')[0];
			var newRow = tableRef.insertRow(tableRef.rows.length);
			var newCell1 = newRow.insertCell(0);
			var newText1 = document.createTextNode(product_name[i]);
			var newCell2 = newRow.insertCell(1);
			var newText2 = document.createTextNode(quantity_value[i]);
			newCell1.appendChild(newText1);
			newCell2.appendChild(newText2);}
	}

function broadcastCall1(){
	//groupList();
	//var content= document.getElementById("content").value.toString();
	$( "#broadcast-call-dialog" ).dialog("open");
	$("#broadcast-call-dialog").show();
}

//Validates phonenumber
//used in BillSettings.jsp
function phonenumber(inputtxt)  
{  
	var phoneno = /^\d{10}$/;  

	if(inputtxt.value.match(phoneno))
	{  
		document.getElementById("submit").disabled=false;


	}  
	else  
	{  
		alert("Enter valid number"); 
		document.getElementById("submit").disabled=true;

	}  
}  
//checks if bill is updated successfully
//used in BillSettings.jsp 
function updatebill(x)
{
	if(x)
		alert("Bill Settings have been updated successfully");
}
//reloads Dashboard.jsp after creating a new group
//used in Dashboard.jsp
function success(){
	window.top.location.reload();
}
//used in send sms functionality in upload.jsp
function checkMessage(){
	var message=$("#sms-message").val();
	var msgflag=true;
	if(message.length==0){
		msgflag=false;
	}
	if(!msgflag){
		$("#sms-message").val(null);
		//$("#sms-message").attr("placeholder","Invalid Message");
		alert('Please enter message text.');
	}
	return msgflag;

}
function broadcastSMS(){
	console.log("Broadcast called");
	var smsflag=false;
	if(checkNubmer($("#number"))&&checkMessage()){
		var message=$("#sms-message").val();
		var number=$("#number").val();
		if(number.length!=0){
			smsflag=true;
			//  console.log(number);
			callSMSURL(message, number);
		}
		if(!smsflag){
			// alert("Please select number to send");
		}

		$(":checkbox").each(function(){
			if(this.checked){
				var num=$(this).val();
				smsflag=true;
				if(num=="all"){

				}
				else 
					callSMSURL(message, num);
				console.log(num);
			}
		});
	}


}

function broadcastVoiceMessage(){
	if(checkNubmer($("#voice-number"))){
		var number=$("#voice-number").val();
		var audioURL="http://qassist.cse.iitb.ac.in/Downloads/audio-download/kookoo_audio1382515015596.wav";
		callVoiceURL(audioURL, number);
	}
}


function deleteGroup(group_id){
	$.ajax({
	      url: 'IvrsServlet',
	      type: 'POST',
	      data: {'req_type':'deleteGroup','group_id':group_id},
	      success: function(data){
	    	  window.top.location.reload();
	        }
	      
	    });
}


function updateMemberDetails(member_id,member_name,member_number,username,password,userLogin){
	$.ajax({
		url: 'IvrsServlet',
		type: 'POST',
		data: {'req_type':'updateMemberDetails', 'member_id':member_id,'member_name':member_name,'member_number':member_number,'username':username,'password':password,'userLogin':userLogin},
		success: function(data){
			//alert(data);
			
		}
	});
}






 		// used in manage.jsp for editing member details
 		   
function editMembers(memberId,memberName,memberNumber,memberAddress){
	$( "#edit-member-dialog" ).dialog("open");
	$("#edit-member-dialog").html('<form><input type="hidden" id="memberId" value="'+memberId+'">'
			+'<table>'
			+'<tr><td><label for="name">Name</label></td>'
			+'<td><input type="text" value="'+memberName+'" name="memberName" id="memberName" class="text ui-widget-content ui-corner-all" /></tr>'
			+'<tr><td><label for="number">Number</label><br>'
			+'<td><input type="text" value="'+memberNumber+'" name="memberNumber" id="memberNumber" class="text ui-widget-content ui-corner-all" readonly/></tr>'
			+'<tr><td><label for="memberAddress">Member Address</label>'
			+'<td><input type="text" name="memberAddress" id="memberAddress" value="'+memberAddress+'" class="text ui-widget-content ui-corner-all" />'
			+'<tr><td><label for="username">Username</label>'
			+'<td><input type="username" name="memberUsername" id="memberUsername" value="" class="text ui-widget-content ui-corner-all" />'
			+'<tr><td><label for="password">Password</label>'
			+'<td><input type="password" name="memberPassword" id="memberPassword" value="" class="text ui-widget-content ui-corner-all" /></td></tr>'
			+'<tr><td><label>Assign Login *</label></td><td><input type="checkbox" name="userLogin" id="userLogin"></td></tr></table>'
			+'</form> *This will send an SMS to the user with his credentials');	
}
  
 		  
 		  // used in ManipulateGroups.jsp
 		 $(function() {
 		    $( "#manipulateGroups" ).dialog({ 
 		    	dialogClass: 'no-close',
 		    	position :[300,70],
 		    	resizeable:false, 
 		    	height : 300,
 				width : 350
 		    	
 		    	});
 			});
 			





