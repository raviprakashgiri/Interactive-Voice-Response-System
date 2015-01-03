package com.iitb.MessageModel;
/*
 * Model for TextMessages.jsp
 * @author:Rasika Mohod
 */
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;

public class TextMessages
{
	/* Function to get all INBOX text messages of a group
	 * TextMessages.jsp
	 * 
	 */
	public Object[][] getInboxMessages(String groupId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
    	Object[][] inboxMessages = null;
    	int i=0;
		try 
		{
			String getMessagesQuery="SELECT `member_order`,`member_number`,`status_id`,`comments`,date_format(`timestamp`,'%d-%m-%y/' '%r') as date, `msg_id` FROM `message_order` where groups_id="+groupId+" and (status_id=0 OR status_id =3) ORDER BY timestamp DESC;";
			ResultSet rs=DataService.getResultSet(getMessagesQuery);
			
			int n=DataService.getRowCount(getMessagesQuery);
			inboxMessages=new Object[n][7];
			
			while(rs.next())
			{				
				inboxMessages[i][0]=rs.getString("member_order");
				inboxMessages[i][1]=rs.getString("member_number");
				inboxMessages[i][2]=rs.getString("status_id");
				inboxMessages[i][3]=rs.getString("comments");
				inboxMessages[i][4]=rs.getString("date");
				inboxMessages[i][5]=rs.getString("msg_id");
				String memberNumber=rs.getString("member_number");
				
				String getMemberNameQuery="SELECT  member_name FROM member where member_number="+memberNumber+";";
				ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
				
				String memberName="";
				if(memberNameQueryResult.next()){
					memberName=memberNameQueryResult.getString("member_name");
				}
				
				inboxMessages[i][6]=memberName;
				i++;
			}
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
		return inboxMessages;
    }
	/* Function to get all ACCEPTED text messages of a group 
	 * TextMessages.jsp
	 * 
	 */
	public Object[][] getAcceptedMessages(String groupId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
    	Object[][] acceptedMessages = null;
    	int j=0;
		try 
		{
			String getMessagesQuery="SELECT `member_order`,`member_number`,`status_id`,`comments`,date_format(`timestamp`,'%d-%m-%y/' '%r') as date,`msg_id` FROM `message_order` where groups_id="+groupId+" and status_id=1 ORDER BY timestamp DESC;";
			ResultSet rs=DataService.getResultSet(getMessagesQuery);
			
			int n=DataService.getRowCount(getMessagesQuery);
			acceptedMessages=new Object[n][7];
			
			while(rs.next()){
				acceptedMessages[j][0]=rs.getString("member_order");
				acceptedMessages[j][1]=rs.getString("member_number");
				acceptedMessages[j][2]=rs.getString("status_id");
				acceptedMessages[j][3]=rs.getString("comments");
				acceptedMessages[j][4]=rs.getString("date");
				acceptedMessages[j][5]=rs.getString("msg_id");
				String memberNumber=rs.getString("member_number");
				
				String getMemberNameQuery="SELECT  member_name FROM member where member_number="+memberNumber+";";
				ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
				
				String memberName="";
				if(memberNameQueryResult.next()){
					memberName=memberNameQueryResult.getString("member_name");
				}
				
				acceptedMessages[j][6]=memberName;
				j++;
			}
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
		return acceptedMessages;
    }
	/* Function to get all REJECTED text messages of a group 
	 * TextMessages.jsp
	 * 
	 */
	public Object[][] getRejectedMessages(String groupId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
    	Object[][] rejectedMessages = null;
    	int k=0;
    	try 
    	{
   	     	String getMessagesQuery="SELECT `member_order`,`member_number`,`status_id`,`comments`,date_format(`timestamp`,'%d-%m-%y/' '%r') as date,`msg_id` FROM `message_order` where groups_id="+groupId+" and status_id=2 ORDER BY timestamp DESC;";
   	     	ResultSet rs=DataService.getResultSet(getMessagesQuery);
   	     	
   	     	int n=DataService.getRowCount(getMessagesQuery);
   	        rejectedMessages=new Object[n][7];
			
   	     	while(rs.next())
   	     	{
   	     	    rejectedMessages[k][0]=rs.getString("member_order");
   	     	    rejectedMessages[k][1]=rs.getString("member_number");
   	     	    rejectedMessages[k][3]=rs.getString("comments");
   	     	    rejectedMessages[k][4]=rs.getString("date");
   	     	    rejectedMessages[k][5]=rs.getString("msg_id");
	   			String memberNumber=rs.getString("member_number");
	   			
	   			String getMemberNameQuery="SELECT  member_name FROM member where member_number="+memberNumber+";";
	   			ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
	   			
	   			String memberName="";
	   			if(memberNameQueryResult.next()){
	   				memberName=memberNameQueryResult.getString("member_name");
	   			}
	   			
	   			rejectedMessages[k][6]=memberName;
	   			k++;
   	     	}
   	     connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
		return rejectedMessages;
    }
	/* Function to get all DEFAULT text messages of a group 
	 * TextMessages.jsp
	 * 
	 */
	public Object[][] getDefaultMessages(String groupId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] defaultMessages = null;
    	int l=0;
    	try 
    	{
    		String getMessagesQuery="SELECT `member_name`,`default_message`,`msg_id`,date_format(`timestamp`,'%d-%m-%y/' '%r') as date,`status_id`,`comments` FROM `message_default` where groups_id="+groupId+" and (status_id=0 OR status_id =3) ORDER BY timestamp DESC;";
    		ResultSet rs=DataService.getResultSet(getMessagesQuery);
    		
    		int n=DataService.getRowCount(getMessagesQuery);
    		defaultMessages=new Object[n][6];
			
    		while(rs.next()){
    			defaultMessages[l][3]=rs.getString("date");
    			defaultMessages[l][2]=rs.getString("msg_id");
    			defaultMessages[l][1]=rs.getString("default_message");
    			defaultMessages[l][0]=rs.getString("member_name");
    			defaultMessages[l][5]=rs.getString("comments");
    			
    			l++;
    		}
    		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return defaultMessages;
    }
	/* Function to get all RESPONSE (YES) messages of a group 
	 * TextMessages.jsp
	 * 
	 */
	public Object[][] getResponseYes(String groupId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] responseYes = null;
    	int m=0;
    	try
    	{
           String getMessagesQuery="SELECT member_name, member_number , member_response , msg_id , date_format(`timestamp`,'%d-%m-%y/' '%r') as date FROM `message_response` where groups_id='"+groupId+"' AND member_response='Yes'";
           ResultSet rs=DataService.getResultSet(getMessagesQuery);
           
           int n=DataService.getRowCount(getMessagesQuery);
           responseYes=new Object[n][5];
           
            while(rs.next())
            {
            	responseYes[m][0]=rs.getString("member_name");
            	responseYes[m][1]=rs.getString("member_number");
            	responseYes[m][2]=rs.getString("member_response");
            	responseYes[m][3]=rs.getString("msg_id");
            	responseYes[m][4]=rs.getString("date");
	            m++;
            }
            connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return responseYes;
    }
	/* Function to get all RESPONSE (NO) messages of a group
 	 * TextMessages.jsp
	 * 
	 */
 	public Object[][] getResponseNo(String groupId) throws SQLException
    {
 		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] responseNo = null;
    	int o=0;
    	try 
    	{
            String getMessagesQuery="SELECT member_name, member_number , member_response,msg_id,date_format(`timestamp`,'%d-%m-%y/' '%r') as date FROM `message_response` where groups_id='"+groupId+"'AND member_response='NO'";
            ResultSet rs=DataService.getResultSet(getMessagesQuery);
            
            int n=DataService.getRowCount(getMessagesQuery);
            responseNo=new Object[n][5];
            
            while(rs.next())
            {
            	responseNo[o][0]=rs.getString("member_name");
            	responseNo[o][1]=rs.getString("member_number");
            	responseNo[o][2]=rs.getString("member_response");
            	responseNo[o][3]=rs.getString("msg_id");
            	responseNo[o][4]=rs.getString("date");
	            o++;
            }
            connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return responseNo;
    }
 	/* Function to get all FEEDBACK text messages of a group
 	 * TextMessages.jsp
	 * 
	 */
 	public Object[][] getFeedback(String groupId) throws SQLException
    {
 		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
    	Object[][] feebackMessages = null;
    	int p=0;
    	try 
    	{
    		String getMessagesQuery="SELECT `member_feedback`,`member_number`,date_format(`timestamp`,'%d-%m-%y/' '%r'),`msg_id` FROM `message_feedback` where groups_id="+groupId+" ORDER BY timestamp DESC;";
    		ResultSet rs=DataService.getResultSet(getMessagesQuery);
    		
    		int n=DataService.getRowCount(getMessagesQuery);
    		feebackMessages=new Object[n][5];
    		
    		while(rs.next())
    		{
    			feebackMessages[p][2]=rs.getString("member_number");
    			feebackMessages[p][0]=rs.getString("member_feedback");
    			feebackMessages[p][1]=rs.getString("member_number");
    			feebackMessages[p][3]=rs.getString("msg_id");
    			String memberNumber=rs.getString("member_number");
    			
    			String getMemberNameQuery="SELECT member_name FROM member where member_number="+memberNumber+";";
    			ResultSet memberNameQueryResult1=DataService.getResultSet(getMemberNameQuery);
    			
    			String memberName="";
    			if(memberNameQueryResult1.next()){
    				memberName=memberNameQueryResult1.getString("member_name");
    			}
    			
    			feebackMessages[p][4]=memberName;
    			p++;
    		}
    		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
		return feebackMessages;
    }
 	/* Function to update message's comment
 	 * TextMessages.jsp
	 * 
	 */
 	public void UpdateMessageComment(String messageComments,String messageId) throws SQLException
    {
 		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	try 
    	{
    		String updateCommentsQuery="UPDATE `message_order` SET `comments` = '"+messageComments+"' WHERE msg_id="+messageId+";";
			DataService.runQuery(updateCommentsQuery);
    		
    		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
    }
 	/* Function to update default message's comment 
 	 * TextMessages.jsp
	 * 
	 */public void UpdateDefaultMessageComment(String messageComments,String messageId) throws SQLException
    {
 		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	try 
    	{
    		String updateCommentsQuery="UPDATE `message_default` SET `comments` = '"+messageComments+"' WHERE msg_id="+messageId+";";
			DataService.runQuery(updateCommentsQuery);
			
    		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
    }
 	/* Function to update inbox message's status (rejected/accepted)
	 * TextMessages.jsp
	 * 
	 */
	public void UpdateMessageStatus(String statusId,String messageId) throws SQLException
    {
 		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	try 
    	{
    		String updateCommentsQuery="UPDATE `message_order` SET `status_id` = '"+statusId+"' WHERE msg_id="+messageId+";";
			DataService.runQuery(updateCommentsQuery);
			
    		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
    }
}
