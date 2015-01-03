package com.iitb.Controller;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions;
import com.iitb.dbUtilities.IvrsUtilityFunctions;
import com.iitb.dbUtilities.DataService;


public class IvrsServletMulti 
{
	
	public void videoYoutube(String videoname,String videolink,String videonamelink)
	{
		try{
			String Video= "INSERT INTO video(videoname,videolink)VALUES('"
			+ videoname
			+ "','"
			+ videonamelink
			+"');";
System.out.println(Video);
DataService.runQuery(Video);
//	String update ="update pending_call set status=";
}

		catch(Exception e){
	e.printStackTrace();
}

	}
	
	public String message(String org_name,String group_id,String language,String responsetype,String backupcall_number,String backupcall_time1,String backupcall_time2,String backupcall_time3,String backupcall_time4,String backupcall_time5, String scheduled_time1, String scheduled_time2, String scheduled_time3)throws SQLException
	{
		String broadcastId="";
		try
		{
		
			
			String getLatestBroadcastMsgQuery ="(SELECT message_location , publisher_number from publisher_message where org_name LIKE '"+org_name+"'order by timestamp desc)";
			System.out.println(getLatestBroadcastMsgQuery );
			ResultSet latestBroadcastMsgQueryResult=DataService.getResultSet(getLatestBroadcastMsgQuery);
        	if(latestBroadcastMsgQueryResult.next())
        	{
        		String broadcastURL=latestBroadcastMsgQueryResult.getString(1);
        		String publisher_number=latestBroadcastMsgQueryResult.getString(2);
        		System.out.print("broadcast="+broadcastURL);
        		String insertOrderQuery = "INSERT INTO broadcast(broadcast_location,groups_id, publisher_number,language,response,counter,backup_call_time1, backup_call_time2 ,backup_call_time3 ,backup_call_time4 ,backup_call_time5,scheduled_call_time1,scheduled_call_time2,scheduled_call_time3 ) VALUES('"
    					+ broadcastURL
    					+ "','"
    					+ group_id
    					+ "','"
    					+ publisher_number
    					+"','"
    					+language
    					+"','"
    					+responsetype
    					+"','"
    					+backupcall_number
    					+"','"
    					+backupcall_time1
    					+"','"
    					+backupcall_time2
    					+"','"
    					+backupcall_time3
    					+"','"
    					+backupcall_time4
    					+"','"
    					+backupcall_time5
    					+"','"
    					+scheduled_time1
    					+"','"
    					+scheduled_time2
    					+"','"
    					+scheduled_time3
    				    +"');";
        		
        		System.out.println(insertOrderQuery);
    			
    			DataService.runQuery(insertOrderQuery);
        		//Code to insert the values into latest_broadcast table. if already row is existing for that group, then it will update the row.
        		//Author Sravan Kumar
        		String checkLatestBroadcast = "select broadcast_location from latest_broadcast where groups_id="+group_id;
        		System.out.println("checkLatestBroadcast   "+checkLatestBroadcast);
        		ResultSet rs = DataService.getResultSet(checkLatestBroadcast);
        		
        		System.out.println("new IvrsUtilityFunctions().getRows(rs)==0 "+(new IvrsUtilityFunctions().getRows(rs)==0));
        		
        		if(new IvrsUtilityFunctions().getRows(rs)==0){
        		
        		String latestBroadcastQuery = "INSERT INTO latest_broadcast(broadcast_location,groups_id, publisher_number,language,response,counter,backup_call_time1, backup_call_time2 ,backup_call_time3 ,backup_call_time4 ,backup_call_time5 ) VALUES('"
    					+ broadcastURL
    					+ "','"
    					+ group_id
    					+ "','"
    					+ publisher_number
    					+"','"
    					+language
    					+"','"
    					+responsetype
    					+"','"
    					+backupcall_number
    					+"','"
    					+backupcall_time1
    					+"','"
    					+backupcall_time2
    					+"','"
    					+backupcall_time3
    					+"','"
    					+backupcall_time4
    					+"','"
    					+backupcall_time5
    				    +"');" ;
        		System.out.println(latestBroadcastQuery);
        		DataService.runQuery(latestBroadcastQuery);
        		}else{
        			String latestBroadcastQuery = "Update latest_broadcast set " +
        					"broadcast_location='"+broadcastURL+
        					"', publisher_number='"+publisher_number+
        					"', language='"+language+
        					"', response='"+responsetype+
        					"', backup_call_time1='"+backupcall_time1+
        					"', backup_call_time2='"+backupcall_time2+
        					"', backup_call_time3='"+backupcall_time3+
        					"', backup_call_time4='"+backupcall_time4+
        					"', backup_call_time5='"+backupcall_time5+
        					"' where groups_id="+group_id;
            		System.out.println("checkLatestBroadcast2else   "+latestBroadcastQuery);
            		DataService.runQuery(latestBroadcastQuery);
        		}
    			
        		
    			String broadcast_id="select broadcast_id from broadcast where broadcast_location='"+broadcastURL+"'";
    			System.out.println(broadcast_id);
    			rs=DataService.getResultSet(broadcast_id);
    			while(rs.next()){
    				 broadcastId=rs.getString("broadcast_id");
    			}
    			
    			
        	}
        	
        	
		}
		
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
		
		return broadcastId;
	
	}
	
	
	
	public void selected(String selectedMembers[],String group_id, String callNow[],String language, String responsetype, String broadcastId, String backupcall_number,String backupcall_time1,String backupcall_time2, String backupcall_time3, String backupcall_time4, String backupcall_time5, String scheduled_time1, String scheduled_time2, String scheduled_time3  )
	{
		try
		{
			System.out.println("broadcastId====="+broadcastId);
		for (int i = 0; selectedMembers!=null && i < selectedMembers.length; i++) {
			String getMemberNumber = "SELECT member_number FROM `member` where groups_id="
					+ group_id
					+ " AND member_id="
					+ selectedMembers[i] + ";";
			System.out.println("member" + getMemberNumber);
			ResultSet memberNumbers = DataService
					.getResultSet(getMemberNumber);
			while (memberNumbers.next()) {
				String number = memberNumbers.getString(1);
				String sid = "";
				if(!(callNow==null)){
				sid = KooKooFunctions.placeCall(number,group_id, language, responsetype);
		System.out.println("sid=="+sid);
		String pending_call= "INSERT INTO pending_call(sid,member_number,broadcast_id ,groups_id,call_status,counter,backup_call_time1,backup_call_time2,backup_call_time3,backup_call_time4,backup_call_time5)VALUES('"
				+ sid
				+ "','"
				+ number
				+ "',"
				+ broadcastId
				+",'"
				+ group_id
				+"','"
				+""
				+"','"
				+backupcall_number
				+"','"
				+backupcall_time1
				+"','"
				+backupcall_time2
				+"','"
				+backupcall_time3
				+"','"
				+backupcall_time4
				+"','"
				+backupcall_time5
				+"');";
	System.out.println(pending_call);
	DataService.runQuery(pending_call);
//	String update ="update pending_call set status=";
				}
	
	String scheduled_call= "INSERT INTO scheduled_call(sid,member_number,broadcast_id ,groups_id,call_status,counter,scheduled_call_time1,scheduled_call_time2,scheduled_call_time3)VALUES('"
			+ sid
			+ "','"
			+ number
			+ "','"
			+ broadcastId
			+"',"
			+ group_id
			+",'"
			+""
			+"',"
			+3
			+",'"
			+scheduled_time1
			+"','"
			+scheduled_time2
			+"','"
			+scheduled_time3
			/*+"','"
			+backupcall_time4
			+"','"
			+backupcall_time5*/
			+"');";
System.out.println(scheduled_call);
DataService.runQuery(scheduled_call);
			}
			
			
			}	
	}
			catch(Exception e)
			{
				e.printStackTrace();
			}


	}
	
	
	

}
