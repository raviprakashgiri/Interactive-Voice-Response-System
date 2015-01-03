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

public class VoiceMessages
{
	/* Function to get all INBOX voice messages of a group 
	 * VoiceMessages.jsp
	 * 
	 */
	public Object[][] getInboxMessages(String groupId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] inboxMessages = null;
    	int i=0;
    	Savepoint savepoint = connObj.setSavepoint("savepoint");
		try 
		{		
			
				String getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,date_format(`timestamp`,'%d-%m-%y/' '%r') as date,message_id	FROM `message` where groups_id="+groupId+" and (status_id=0 OR status_id =3) ORDER BY timestamp DESC;";
				ResultSet rs=DataService.getResultSet(getMessagesQuery);
				
				int n=DataService.getRowCount(getMessagesQuery);
				inboxMessages=new Object[n][7];
			
				while(rs.next())
				{
					inboxMessages[i][0]=rs.getString("message_location");
					inboxMessages[i][1]=rs.getString("member_number");
					inboxMessages[i][2]=rs.getString("status_id");
					inboxMessages[i][3]=rs.getString("comments");
					inboxMessages[i][4]=rs.getString("date");
					inboxMessages[i][5]=rs.getString("message_id");
					String memberNumber=rs.getString("member_number");
					
					String getMemberNameQuery="SELECT  member_name FROM member where member_number='"+memberNumber+"';";
					ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
					
					String memberName="";
					if(memberNameQueryResult.next())
					{
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
	/*shraddha*/
	public Object[][] getDetails(String groupId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] inboxMessages = null;
    	int i=0;
    	Savepoint savepoint = connObj.setSavepoint("savepoint");
		try 
		{		
			
			//	String getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,date_format(`timestamp`,'%d-%m-%y/' '%r') as date,message_id	FROM `message` where groups_id="+groupId+" and (status_id=0 OR status_id =3) ORDER BY timestamp DESC;";
				String getMessagesQuery="SELECT member.MEMBER_NAME, member.MEMBER_NUMBER , member_details.MEMBER_ADDRESS FROM member LEFT JOIN member_details "+" ON member.MEMBER_DETAIL_ID=member_details.MEMBERS_DETAIL_ID where groups_id="+groupId+";";
			//	String getBelongingGroupsList="SELECT DISTINCT groups.GROUPS_NAME, groups.GROUPS_ID FROM groups LEFT JOIN member "+" ON member.GROUPS_ID=groups.GROUPS_ID WHERE groups.org_id="+orgId+" AND member.member_number ="+ result[i][1];
				
				
				ResultSet rs=DataService.getResultSet(getMessagesQuery);
				
				int n=DataService.getRowCount(getMessagesQuery);
				inboxMessages=new Object[n][10];
			
				while(rs.next())
				{
					inboxMessages[i][0]=rs.getString("member_name");
					inboxMessages[i][1]=rs.getString("member_number");
					inboxMessages[i][2]=rs.getString("member_address");
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
	/* Function to get all ACCEPTED voice messages of a group
	 * VoiceMessages.jsp
	 * 
	 */
    public Object[][] getAcceptedMessages(String groupsId) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] acceptedMessages = null;
    	Savepoint savepoint = connObj.setSavepoint("savepoint");
    	int j=0;
    	try 
    	{
    		String getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,`timestamp`,message_id	FROM `message` where groups_id="+groupsId+" and status_id=1 ORDER BY timestamp DESC;";
    		ResultSet rs=DataService.getResultSet(getMessagesQuery);
    		
    		int n=DataService.getRowCount(getMessagesQuery);
    		acceptedMessages=new Object[n][7];
			
        	while(rs.next())
        	{
        		acceptedMessages[j][4]=rs.getString("timestamp");
        		acceptedMessages[j][0]=rs.getString("message_location");
    			acceptedMessages[j][1]=rs.getString("member_number");
    			acceptedMessages[j][3]=rs.getString("comments");
    			acceptedMessages[j][5]=rs.getString("message_id");
    			String memberNumberAcc=rs.getString("member_number");
    			
    			String getMemberNameQuery="SELECT  member_name FROM member where member_number="+memberNumberAcc+";";
    			ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
    			
    			String memberNameAcc="";
    			if(memberNameQueryResult.next()){
    				memberNameAcc=memberNameQueryResult.getString("member_name");
    			}
    			
    			acceptedMessages[j][6]=memberNameAcc;
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
    /* Function to get all REJECTED voice messages of a group
     * VoiceMessages.jsp
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
    		String getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,`timestamp`,message_id	FROM `message` where groups_id="+groupId+" and status_id=2 ORDER BY timestamp DESC;";
   	     	ResultSet rs=DataService.getResultSet(getMessagesQuery);
   	     	
   	     	int n=DataService.getRowCount(getMessagesQuery);
   	        rejectedMessages=new Object[n][7];
   	     	
   	     	while(rs.next())
   	     	{
   	     		rejectedMessages[k][4]=rs.getString("timestamp");
   	     		rejectedMessages[k][0]=rs.getString("message_location");
	   			rejectedMessages[k][1]=rs.getString("member_number");
	   			rejectedMessages[k][3]=rs.getString("comments");
	   			rejectedMessages[k][5]=rs.getString("message_id");
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
    /* Function to get all RESPONSE (YES) messages of a group
     * VoiceMessages.jsp
	 * 
     */
    public Object[][] getResponseYes(String groupId) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] responseYes = null;
    	int l=0;
    	try
    	{
    		String getMessagesQuery="SELECT member_name, member_number , member_response FROM `response` where group_id='"+groupId+"'AND member_response='Yes'";	    	        
    	    ResultSet rs=DataService.getResultSet(getMessagesQuery);
    	    
    	    int n=DataService.getRowCount(getMessagesQuery);
    	    responseYes=new Object[n][3];
			
    	    while(rs.next()){
    	    	responseYes[l][0]=rs.getString("member_name");
    	    	responseYes[l][1]=rs.getString("member_number");
    	    	responseYes[l][2]=rs.getString("member_response");
	            l++;
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
     * VoiceMessages.jsp
	 * 
     */
    public Object[][] getResponseNo(String groupId) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	Object[][] responseNo = null;
    	int m=0;
    	try 
    	{
            String getMessagesQuery="SELECT member_name, member_number , member_response FROM `response` where group_id='"+groupId+"'AND member_response='NO'";
            ResultSet rs=DataService.getResultSet(getMessagesQuery);
            
            int n=DataService.getRowCount(getMessagesQuery);
            responseNo=new Object[n][3];
			
            while(rs.next()){
            	responseNo[m][0]=rs.getString("member_name");
            	responseNo[m][1]=rs.getString("member_number");
            	responseNo[m][2]=rs.getString("member_response");
	            m++;
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
    /* Function to get all FEEDBACK voice messages of a group 
     * VoiceMessages.jsp
	 * 
     */
    public Object[][] getFeedback(String groupId) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
    	Object[][] feedbackMessages = null;
    	int o=0;
    	try 
    	{
    		String getMessagesQuery="SELECT `feedbackmessage_location`,`member_number`,`status_id`,`comments`,`timestamp`,'feedback_id' FROM `feedbackmessage` where groups_id="+groupId+" ORDER BY timestamp DESC;";
    		ResultSet rs=DataService.getResultSet(getMessagesQuery);
    		
    		int n=DataService.getRowCount(getMessagesQuery);
    		feedbackMessages=new Object[n][7];
    		
    		while(rs.next()){
    			feedbackMessages[o][4]=rs.getString("timestamp");
    			feedbackMessages[o][0]=rs.getString("feedbackmessage_location");
    			feedbackMessages[o][1]=rs.getString("member_number");
    			feedbackMessages[o][3]=rs.getString("comments");
    			feedbackMessages[o][5]=rs.getString("feedback_id");
    			String memberNumber=rs.getString("member_number");
    			
    			String getMemberNameQuery1="SELECT member_name FROM member where member_number="+memberNumber+";";
    			ResultSet memberNameQueryResult1=DataService.getResultSet(getMemberNameQuery1);
    			
    			String memberName="";
    			if(memberNameQueryResult1.next()){
    				memberName=memberNameQueryResult1.getString("member_name");
    			}
    			
    			feedbackMessages[o][6]=memberName;
    			o++;
    		}
    		connObj.commit();
    	}
    	catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
    	return feedbackMessages;
    }
    /* Function to get all PROCESSED voice messages of a group 
     * VoiceMessages.jsp
	 * 
     */
    public Object[][] getProcessedMessages(String groupId) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
    	Object[][] processedMessages = null;
    	int p=0;
    	try 
    	{
    		String getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,`timestamp`,message_id	FROM `message` where groups_id="+groupId+" and status_id=5 ORDER BY timestamp DESC;";
  	      	ResultSet rs=DataService.getResultSet(getMessagesQuery);
  	      	
  	      	int n=DataService.getRowCount(getMessagesQuery);
  	      	processedMessages=new Object[n][8];
  	    	
  	    	while(rs.next()){
  	    		processedMessages[p][4]=rs.getString("timestamp");
  	    		processedMessages[p][0]=rs.getString("message_location");
	  			processedMessages[p][1]=rs.getString("member_number");
	  			processedMessages[p][3]=rs.getString("comments");;
	  			processedMessages[p][5]=rs.getString("message_id");
	  			String memberNumberPro=rs.getString("member_number");
	  			
	  			String getMemberNameQuery="SELECT  member_name FROM member where member_number="+memberNumberPro+";";
	  			String getMemberAddQuery="SELECT  `member_address` FROM member_details where member_number="+memberNumberPro+";";
	  			ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
	  			String memberNamePro="";
	  			ResultSet memberAddQueryResult=DataService.getResultSet(getMemberAddQuery);
	  			System.out.println(getMemberAddQuery);	  			
	  			String memberAddress="";
	  			
	  			if(memberAddQueryResult.next()){
	  				memberAddress=memberAddQueryResult.getString("member_address");
	  			}
	  			if(memberNameQueryResult.next()){
	  				memberNamePro=memberNameQueryResult.getString("member_name");
	  			}
	  			
	  			processedMessages[p][6]=memberNamePro;
	  			processedMessages[p][7]=memberAddress;
	  			p++;
  	    	}
  	    	connObj.commit();
    	}
    	catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
    	return processedMessages;
    }
    /* Function to get all SAVED voice messages of a group
     * VoiceMessages.jsp
	 * 
     */
    public Object[][] getSavedMessages(String groupId) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
    	Object[][] savedMessages = null;
    	int q=0;
    	try 
    	{
   	     	String getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,`timestamp`,message_id	FROM `message` where groups_id="+groupId+" and status_id=4 ORDER BY timestamp DESC;";
   	     	ResultSet rs=DataService.getResultSet(getMessagesQuery);
   	     	
   	     	int n=DataService.getRowCount(getMessagesQuery);
   	     	savedMessages=new Object[n][7];
			
   	    	while(rs.next()){
   	    		savedMessages[q][4]=rs.getString("timestamp");
   	    		savedMessages[q][0]=rs.getString("message_location");
   	    		savedMessages[q][1]=rs.getString("member_number");
   	    		savedMessages[q][3]=rs.getString("comments");;
   	    		savedMessages[q][5]=rs.getString("message_id");
	   			String memberNumberSvd=rs.getString("member_number");
	   			
	   			String getMemberNameQuery="SELECT  member_name FROM member where member_number="+memberNumberSvd+";";
	   			ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
	   			String memberNameSvd="";
	   			if(memberNameQueryResult.next()){
	   				memberNameSvd=memberNameQueryResult.getString("member_name");
	   			}
	   			savedMessages[q][6]=memberNameSvd;
	   			q++;
   	    	}
   	    	connObj.commit();
    	}
    	catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
    	return savedMessages;
    }
    /* Function to update message's comment
     * VoiceMessages.jsp
	 * 
     */
    public void updateMsgComment(String messageId,String messageComments) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	try 
    	{
    		String updateCommentsQuery="UPDATE `message` SET `comments` = '"+messageComments+"' WHERE message_id="+messageId+";";
			DataService.runQuery(updateCommentsQuery);
			System.out.println("Comment updated..!!");
    		connObj.commit();
    	}
    	catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
    }
    /* Function to update message's status (accepted/rejected)
     * VoiceMessages.jsp
	 * 
     */
    public void updateMsgStatus(String messageId,String statusId) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	try 
    	{
    		String updateCommentsQuery="UPDATE `message` SET `status_id` = '"+statusId+"' WHERE message_id="+messageId+";";
			DataService.runQuery(updateCommentsQuery);
			
    		connObj.commit();
    	}
    	catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
    }
    /* Function to update feedback comments 
     * VoiceMessages.jsp
	 * 
     *  (not used anywhere till date:- 6/6/14 )
     * */
	public void UpdateFeedbackComment(String messageId,String messageComments) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
    	try
    	{
    		String updateCommentsQuery="UPDATE `feedbackmessage` SET `comments` = '"+messageComments+"' WHERE feedback="+messageId+";";
			DataService.runQuery(updateCommentsQuery);
			
    		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
    }
	 /* Function to get all PROCESSED  messages of a group 
     * GroupOrderSummary
	 * m
     */
    public Object[][] getProcessedMessages(String groupId,String fromDate,String toDate) throws SQLException
    {
    	Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
    	Object[][] processedMessages = null;
    	int p=0;
    	try 
    	{
    		String getMessagesQuery="SELECT `member_number`,message_id,`timestamp` FROM `message` where groups_id="+groupId+" and status_id=5 and message.timestamp>='"+fromDate+" 00:00:00' and message.timestamp<='"+toDate+" 23:59:59';";
    		String getMessage="SELECT `member_number`,message_id,message.timestamp FROM `message` WHERE groups_id="+groupId+" AND status_id=5 AND message.timestamp>= '"+fromDate+" 00:00:00' AND message.timestamp<='"+toDate+" 23:59:59' ORDER BY message.timestamp;";
    		System.out.println(getMessage);
    		ResultSet rs=DataService.getResultSet(getMessage);
  	      	
  	      	int n=DataService.getRowCount(getMessage);
  	      	processedMessages=new Object[n][5];
  	    	p=0;
  	    	while(rs.next()){
  	    		System.out.println("in here"+p);
  	    		processedMessages[p][3]=rs.getString("timestamp");
  	    		System.out.println(processedMessages[p][3]);
	  			processedMessages[p][2]=rs.getString("member_number");
	  			System.out.println(processedMessages[p][2]);
	  			processedMessages[p][0]=rs.getString("message_id");
	  			System.out.println(processedMessages[p][0]);
	  			String memberNumberPro=rs.getString("member_number");
	  			
	  			
	  			String getMemberNameQuery="SELECT  member_name FROM member where member_number="+memberNumberPro+";";
	  			String getMemberAddQuery="SELECT  `member_address` FROM member_details where member_number="+memberNumberPro+";";
	  			ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
	  			ResultSet memberAddQueryResult=DataService.getResultSet(getMemberAddQuery);
	  			System.out.println(getMemberAddQuery);
	  			String memberNamePro="";
	  			String memberAddress="";
	  			if(memberNameQueryResult.next()){
	  				memberNamePro=memberNameQueryResult.getString("member_name");
	  				
	  			}
	  			if(memberAddQueryResult.next()){
	  				memberAddress=memberAddQueryResult.getString("member_address");
	  			}
	  			processedMessages[p][1]=memberNamePro;
	  			processedMessages[p][4]=memberAddress;
	  			System.out.println(processedMessages[p][1]);
	  			p++;
  	    	}
  	    	connObj.commit();
    	}
    	catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
    	return processedMessages;
    }
}
