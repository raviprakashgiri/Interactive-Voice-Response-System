<%@page import="com.iitb.MessageModel.ActivityLog"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.ResultSet"%>
<% 

   // all information get from kookoo
    
	String kookoo_id=request.getParameter("sid");
	String status=request.getParameter("status");
	String phone_number=request.getParameter("phone_no");
	String start_time=request.getParameter("start_time");
	String ringing_time=request.getParameter("ringing_time");
	String duration=request.getParameter("duration");
	String caller_id=request.getParameter("caller_id");
	String status_details=request.getParameter("status_details");
	String query= "SELECT groups_id from member where member_number="+phone_number;
	ResultSet getOutgoingCallLog=DataService.getResultSet(query);
	if(getOutgoingCallLog.next()){
		String groups_id=getOutgoingCallLog.getString("groups_id");
		
	// call Activitylog.java
	ActivityLog.logOutgoingCall(groups_id, kookoo_id, status, phone_number, start_time, ringing_time, duration, caller_id, status_details);
    String update_pending_table= "update pending_call set call_status='"+status+"' where sid ='"+kookoo_id+"'";  
    System.out.println(update_pending_table);
    try {
		DataService.runQuery(update_pending_table);
	} catch (Exception e) {
		System.out.println("Error During query:"+update_pending_table);
		e.printStackTrace();
	}
	}
%>