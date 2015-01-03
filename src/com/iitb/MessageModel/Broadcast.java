package com.iitb.MessageModel;

import java.sql.*;

import com.iitb.globals.*;
import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;


public class Broadcast
{
	
	public String getMsgLocation()throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		String broadcastURL="";
		try
		{
			
			String orgName= ConfigParams.ORGNAME;
			String getLatestBroadcastMsgQuery ="(SELECT message_location  from publisher_message where org_name like '"+orgName+"' order by timestamp desc)";
        	 
        	System.out.println("getLatestBroadcastMsgQuery  "+getLatestBroadcastMsgQuery);
			ResultSet latestBroadcastMsgQueryResult=DataService.getResultSet(getLatestBroadcastMsgQuery);
        	if(latestBroadcastMsgQueryResult.next()){
        	broadcastURL=latestBroadcastMsgQueryResult.getString("message_location");
        		
        		System.out.print("broad="+broadcastURL);
        	
        				}
        	connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		
		
		return broadcastURL;
		
		
	}
	
	public Object[][] getDataFromGlobalSettings()throws SQLException
	{
		Object data[][] = null;
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		
		try
		{
			String queryForResponse="SELECT language,email_id,response,broadcast_call FROM globalsettings";
    		ResultSet	rsForResponse = DataService.getResultSet(queryForResponse);
    		System.out.println("queryForResponse  "+queryForResponse);
    		data = DataService.getDataFromResultSet(rsForResponse);
    		
    		connObj.commit();
		}
		catch(Exception e)
		{
			
			e.printStackTrace();
			connObj.rollback();
		}
		
		
		return data;
	}
	
	
	public String getMsgId()throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		String messageId="";
		try
		{
		
		String msgId = "select max(msg_id) as max1 from text_outgoing_sms";
	    ResultSet Fetch_msgid=DataService.getResultSet(msgId);
	    
	    if(Fetch_msgid.next())
		 messageId=Fetch_msgid.getString("max1");
	    
		System.out.print("jdjh=="+messageId);
		connObj.commit();
		}
		catch(Exception e)
		{
			connObj.rollback();
			e.printStackTrace();
		}
		
		return messageId;
		
		
	}
	
	    
	public Object[][] getVideoDetails()throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		
		Object videoDetails[][] = null;
		try
		{
			String videoquery="SELECT videoname,videolink FROM `video` ";
               ResultSet videors=DataService.getResultSet(videoquery);
               videoDetails = DataService.getDataFromResultSet(videors);
               connObj.commit();
	    }
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		
		return videoDetails;
		
		
	}
	
	
	
	public int getCount(String groupId)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		
		int count =0;
		try
		{
		String unpickedCall="SELECT * FROM pending_call where groups_id="+groupId;
		System.out.println("unpickedcall=="+unpickedCall);
		ResultSet number=DataService.getResultSet(unpickedCall);
		while(number.next()){
		count++;	
		}
		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		
		return count;
	}
	
	
	public int getTotal(String groupId)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		
		int total =0;
		try
		{
			
			String DNDNumber="SELECT * FROM pending_call WHERE groups_id="+groupId+ " AND sid LIKE '%DND%' ";
			System.out.println("DNDNumber=="+DNDNumber);
			ResultSet numberOfDNd=DataService.getResultSet(DNDNumber);
			while(numberOfDNd.next()){
			total++;	
			}
			connObj.commit();
		}
		catch(Exception e)
		{
			
			e.printStackTrace();
			connObj.rollback();
		}
		
		return total;
	}

	
	

}
