package com.iitb.MessageModel;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;


/**
 * 
 * To log activities related to calling and SMS
 */
public class ActivityLog {

	public static void main(String[] args) {
//		logIncomingCall("123123", "111111111", "mum", "vf", "2", "1");
		
	}
	
	/** To log an incoming call in the database
	 * 
	 * @param kookoo_call_id unique kookoo ID
	 * @param caller_id 
	 * @param caller_circle
	 * @param caller_operator
	 * @param groups_id group of member
	 * @param member_id
	 * @param called_number which kookoo number was called
	 */
	public static void logIncomingCall(String kookoo_call_id,String caller_id, String caller_circle, String caller_operator,String groups_id, String called_number){
		String callLogQuery="INSERT INTO `incoming_call`(`caller_id`,`caller_circle`,`caller_operator`,`kookoo_call_id`,`groups_id`,kookoo_number)"
				+ "VALUES('"+caller_id+"','"+caller_circle+"','"+caller_operator+"','"+kookoo_call_id+"',"+groups_id+",'"+called_number+"');";
		System.out.println("ActivityLog  logIncomingCall"+callLogQuery);
		
		
		try {
			DataService.runQuery(callLogQuery);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/** To log all outgoing SMSs
	 * 
	 * @param groups_id
	 * @param sms_content
	 * @param receiver_number
	 */
	public static void logOutgoingSMS(String groups_id,String sms_content, String receiver_number , String response){
		
		
		String smsLogQuery="INSERT INTO `outgoing_sms`(`groups_id`,`sms_content`,`receiver_number`,`response`)VALUES('"+groups_id+"','"+sms_content+"','"+receiver_number+"' ,'"+response+"');";
		try {
			DataService.runQuery(smsLogQuery);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
public static void logOutgoingtextSMS(String groups_id,String sms_content, String receiver_number , String response){
		
	    String msg_id="";
		String textsmsLogQuery="INSERT INTO `text_outgoing_sms`(`sms_content`,`groups_id`,`response`)VALUES('"+sms_content+"','"+groups_id+"','"+response+"');";
		System.out.println(textsmsLogQuery);
		try {
			DataService.runQuery(textsmsLogQuery);
			String getGroupsid="SELECT max(`msg_id`) as msg_id FROM `text_outgoing_sms` WHERE `groups_id`= '"+groups_id+"'ORDER BY TIME DESC;";
			System.out.println(getGroupsid);
			try{
			ResultSet message_id =DataService.getResultSet(getGroupsid);
			while(message_id.next()){
				 msg_id=message_id.getString("msg_id");
				 String smsLogQuery="INSERT INTO `outgoings_sms`(`msg_id`,`receiver_number`)VALUES('"+msg_id+"','"+receiver_number+"');";
					try {
						DataService.runQuery(smsLogQuery);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
			}
			catch(Exception e){
				e.printStackTrace();
				}
			
			}
			
		 catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
	}
	
	/**
	 * To log all incoming ids
	 * @param groups_id
	 * @param kookoo_id unique kookoo generated id
	 * @param status whether it was answered, busy, etc
	 * @param phone_number number which was dialed
	 * @param start_time 
	 * @param ringing_time
	 * @param duration
	 * @param caller_id number from which call was dialed
	 * @param status_details refer kookoo status details
	 * @return void
	 */
	public static void logOutgoingCall(String groups_id ,String kookoo_id ,String status ,String phone_number ,String start_time ,String ringing_time ,String duration ,String caller_id ,String status_details ){
		String outCallLogQuery="INSERT INTO `outgoing_call`"
				+ "(`groups_id`,`kookoo_id`,`status`,`phone_number`,`start_time`,`ringing_time`,`duration`,`caller_id`,`status_details`)"
				+ "VALUES("+groups_id+",'"+kookoo_id+"','"+status+"','"+phone_number+"','"+start_time+"','"+ringing_time+"','"+duration+"','"+caller_id+"','"+status_details+"');";
		try {
			System.out.println(outCallLogQuery);
			DataService.runQuery(outCallLogQuery);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
