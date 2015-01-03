package com.iitb.MessageModel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;

import com.iitb.Controller.DateHelper;
import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;

// this model stores all the functions related to incoming and outgoing calls and messages.

public class IncomingOutgoing {
	Connection connObj ;
	Savepoint savepoint1;
	
	/*
	 * This method validates the format of the date entered.
	 * Manage.jsp - > reports tab -> Incoming-calls tab
	 * 
	 */
	public String addTimeInformationToQuery(String aQuery, String aFromDate, String aToDate, String aVar){
		
		boolean isValidFromDate = DateHelper.getDate(aFromDate) != null
				? true
				: false;
		boolean isValidToDate = DateHelper.getDate(aToDate) != null
				? true
				: false;
		
		if (!isValidFromDate) {
			if (isValidToDate) {
				aQuery += " AND "+aVar+" between "
						+ "'0000-00-00'" + " AND " + "'"
						+ aToDate + "'";
			}
		} else { //from date is valid
			if (isValidToDate) { //both dates are valid
				aQuery += " AND "+aVar+" between " + "'"
						+ aFromDate + "'" + " AND " + "'" + aToDate + "'";
			} else { //toDate is invalid
				aQuery += " AND "+aVar+" between " + "'"
						+ aFromDate + "'" + " AND "
						+ "'2099-12-31'";
			}
		}
		aQuery += "  ORDER BY "+aVar+" DESC LIMIT 10;";
		if((!isValidFromDate && !isValidToDate)){
		aQuery=null;
		
		}
		return aQuery;
	}
	
	/*
	 * This method returns all the incoming calls according to the dates given.
	 * Manage.jsp - > reports tab -> Incoming-calls tab
	 * @author:Teena Soni
	 */
	public Object[][] getIncomingCalls(String groupId,String iFromDate,String iToDate) throws SQLException
	{
		System.out.println("test1");
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] incoming=null;
		try {
			System.out.println("test2");
			int a=0;

			String getIncomingCallLogQuery = "SELECT `caller_id`,`time` FROM `incoming_call` where groups_id="
					+ groupId;
			System.out.println("test55");
			getIncomingCallLogQuery = addTimeInformationToQuery(getIncomingCallLogQuery,iFromDate,iToDate,"time");
			//end of query
			System.out.println("test3"+ getIncomingCallLogQuery);
			if(getIncomingCallLogQuery!=null){
				System.out.println("test4");
			System.out.println("getIncomingCallLogQuery    "+ getIncomingCallLogQuery);
			ResultSet getIncomingCallLog = DataService.getResultSet(getIncomingCallLogQuery);

			int n=DataService.getRowCount(getIncomingCallLogQuery);
			incoming=new Object[n][4];

			while(getIncomingCallLog.next()){
				
				incoming[a][0]=getIncomingCallLog.getString("caller_id");
				incoming[a][1]=getIncomingCallLog.getString("time");


				String getMemberNameQuery="SELECT `member_name` FROM `member_details` where member_number="+incoming[a][0]+";";
				ResultSet getMemberName=DataService.getResultSet(getMemberNameQuery);
				String memberName="";
				if(getMemberName.next()){
					memberName=getMemberName.getString("member_name");
				}
				incoming[a][2]=memberName;
				a++;
				
			}
			connObj.commit();
			}
			System.out.println("test5");
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
		return incoming;

	}
	
	/*
	 * This method returns all the outgoing calls according to the dates given.
	 * Manage.jsp - > reports tab -> Incoming-calls tab
	 * @author:Teena Soni
	 */
	public Object[][] getOutgoingCalls(String groupId,String oFromDate,String oToDate) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] outgoing=null;
		try {
			int b=0;

			String getOutgoingCallLogQuery = "SELECT `phone_number`,`status`,`timestamp`,`duration` FROM `outgoing_call` where groups_id="
					+ groupId;									
			getOutgoingCallLogQuery = addTimeInformationToQuery(getOutgoingCallLogQuery, oFromDate, oToDate, "timestamp");
			
			ResultSet getOutgoingCallLog = DataService.getResultSet(getOutgoingCallLogQuery);
			
			if(getOutgoingCallLogQuery!=null){
			System.out.println(getOutgoingCallLogQuery);
			

			int m=DataService.getRowCount(getOutgoingCallLogQuery);
			outgoing=new Object[m][5];

			while(getOutgoingCallLog.next()){
				
				outgoing[b][0]=getOutgoingCallLog.getString("phone_number");
				outgoing[b][1]=getOutgoingCallLog.getString("status");
				outgoing[b][2]=getOutgoingCallLog.getString("timestamp");
				outgoing[b][3]=getOutgoingCallLog.getString("duration");
				String memberName="";

				String getMemberNameQuery="SELECT `member_name` FROM `member` where member_number="+outgoing[b][0]+";";
				ResultSet getMemberName=DataService.getResultSet(getMemberNameQuery);
				if(getMemberName.next()){
					memberName=getMemberName.getString("member_name");
				}
				outgoing[b][4]=memberName;
				b++;	
				
			}
			System.out.println("Outgoingcalls finished!!");
			connObj.commit();
			}} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
		return outgoing;
	}
	
	/*
	 * This method returns all the pending calls according to the dates given.
	 * Manage.jsp - > reports tab -> Incoming-calls tab
	 * @author:Teena Soni
	 */
	public Object[][] getPendingCalls(String groupId) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] pending=null;
		try {
			int c=0;

			String getPendingCallLogQuery="SELECT `sid`,`call_status`,`member_number` FROM `pending_call` where groups_id="+groupId+" and sid='Phone number in DND list';"; 
			ResultSet getPendingCallLog=DataService.getResultSet(getPendingCallLogQuery);

			int n=DataService.getRowCount(getPendingCallLogQuery);
			pending=new Object[n][4];

			while(getPendingCallLog.next()){

				pending[c][0]=getPendingCallLog.getString("sid");
				pending[c][1]=getPendingCallLog.getString("call_status");
				pending[c][2]=getPendingCallLog.getString("member_number");
				String memberName="";
				String getMemberNameQuery="SELECT `member_name` FROM `member` where member_number="+pending[c][2]+";";
				ResultSet getMemberName=DataService.getResultSet(getMemberNameQuery);
				if(getMemberName.next()){
					memberName=getMemberName.getString("member_name");
				}
				pending[c][3]=memberName;
				getMemberName.close();
				c++;
				
				}
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
		return pending;
	}
	/* Function to get all OUTGOING messages of a group 
	 * OutgoingMessages.jsp
	 * @author:Rasika Mohod
	 */
	public Object[][] getOutgoingMessages(String groupId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] outgoingMessages = null;
    	int i=0;
    	try 
    	{
    		String getMessagesQuery="SELECT `msg_id`,`sms_content`,date_format(`time`,'%d-%m-%y/' '%r') as date,`response` FROM `text_outgoing_sms` where groups_id="+groupId+" ORDER BY time DESC;";
    		ResultSet rs=DataService.getResultSet(getMessagesQuery);
    		
    		int n=DataService.getRowCount(getMessagesQuery);
    		outgoingMessages=new Object[n][4];
			
    		while(rs.next())
    		{
    			outgoingMessages[i][0]=rs.getString("msg_id");
    			outgoingMessages[i][1]=rs.getString("sms_content");
    			outgoingMessages[i][2]=rs.getString("date");
    			outgoingMessages[i][3]=rs.getString("response");
    			i++;
    		}
    		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return outgoingMessages;
    }
}
