<!DOCTYPE html >

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<html>
<head>
<script type="text/javascript">
function callSMSURL(message,number){
    message=message.replace(/ /g,"%20");
    
    var kookooURL="http://www.kookoo.in/outbound/outbound_sms.php?phone_no="+number+"&api_key=KK4063496a1784f9f003768bd6e34c185b&message="+message+"&callback=?";
//   console.log(kookooURL);
   $.ajax({
               url: kookooURL,
               type: 'GET',
               data: '',
               success: function(data){
                   alert("Message Sent");
                       console.log(data);
                       
               }
           }).fail(function( jqXHR, textStatus ) {
               alert( "Request failed: " + textStatus );
               });
           $("#number").val(null);
           $("#sms-message").val(null);
}
</script>
</head>
</html>