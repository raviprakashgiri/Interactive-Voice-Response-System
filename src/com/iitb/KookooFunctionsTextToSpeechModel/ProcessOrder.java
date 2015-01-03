package com.iitb.KookooFunctionsTextToSpeechModel;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.Authenticator;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.MalformedURLException;
import java.net.Proxy;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.AuthenticatorBean.ProxyAuthenticator;
import com.iitb.globals.ConfigParams;
import com.iitb.MessageModel.ActivityLog;
import com.iitb.MessageModel.DownloadFile;
import com.iitb.dbUtilities.DataService;

/** This is to process the order when a user calls and gets a confirmation sms for his order
 * 
 * @author $ujen
 *
 */
public class ProcessOrder {

	/**
	 * To store the order in database
	 * @param path kookoo url
	 * @param caller_id number of caller
	 * 
	 */
	
	public static void main(String[] args) {
		storeOrder(
				"http://recordings.kookoo.in/vishwajeet/kookoo_audio1382279270371.wav","56",
				"9833149825");
	}
	public static void storeOrder(String path, String Groupss_id, String caller_id) {

		try {
//			String fileName = DownloadFile.downloadAudio(path);
			
			//testing code to be removed
			System.out.println("store");
			String fileName="";
			
			String location = "http://qassist.cse.iitb.ac.in/Downloads/audio-download/"
					+ fileName;
			System.out.println(location);
			//for testing kookoo's cache
			location=path; //same as kookoo url 
			
			
			try {

				// to store order
				
					String insertOrderQuery = "INSERT INTO `message`(`message_location`,`groups_id`,`member_number`) VALUES('"
							+ location
							+ "','"
							+ Groupss_id
							+ "','"
							+ caller_id
							+ "');";
					System.out.println(insertOrderQuery);
					DataService.runQuery(insertOrderQuery);
					// to generate order id
					String getOrderIDQuery = "SELECT message_id from message where member_number='"
							+ caller_id + "' ORDER BY timestamp DESC;";
					ResultSet orderIDResultSet = DataService.getResultSet(getOrderIDQuery);
					if (orderIDResultSet.next()) {
						String order_id = orderIDResultSet.getString(1);
						System.out.println("message stored sending confirmation message");
						sendConfirmationSMS(order_id, caller_id, Groupss_id);
						DownloadFile.downloadRemainingFiles();
						System.out.println(order_id);
					}
				
			} catch (Exception e) {
				System.out.println(e);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}

	}
	
	/**
	 * To send confirmation sms to number who recorded order
	 * @param order_id system generated
	 * @param number receiver's number
	 * @throws Exception 
	 */
	public static void sendConfirmationSMS(String order_id, String receiver_number, String groups_id) throws Exception{
		
		String sms_content="Your%20order%20id%20is%20"+order_id;
		Proxy netmon = new Proxy(Proxy.Type.HTTP, new InetSocketAddress("172.17.166.10",80));
		Authenticator.setDefault(new ProxyAuthenticator("2011ecs32", "Ravi12!@?"));
		String url="http://www.kookoo.in/outbound/outbound_sms.php?phone_no="+receiver_number+"&"
				+ "api_key=KK4063496a1784f9f003768bd6e34c185b&message="+sms_content+"&callback=?";
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection(netmon);
 
		// optional default is GET
		con.setRequestMethod("GET");
 
		//add request header
		con.setRequestProperty("User-Agent", "Mozilla/5.0");
 
		int responseCode = con.getResponseCode();
		System.out.println("\nFor SMS Sending 'GET' request to URL : " + url);
		System.out.println("Response Code : " + responseCode);
 
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer kookooresponse = new StringBuffer();
 
		while ((inputLine = in.readLine()) != null) {
			kookooresponse.append(inputLine);
		}
		in.close();
		if(responseCode==200){
			sms_content=sms_content.replaceAll("%20", " ");
			ActivityLog.logOutgoingSMS(groups_id, sms_content, receiver_number , "null");
			System.out.println("message sent");
				
		}
		else {
			
		}
	}
	
	/**
	 * To cancel the order
	 * @param orderID
	 */
	public static void cancelOrder(String message_id){
		String cancelOrderQuery="UPDATE message SET status_id=3 where message_id="+message_id+";";
		try {
			DataService.runQuery(cancelOrderQuery);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void cancelOrder(String message_id, String Register_number){
		System.out.println("cancel");
		String cancelOrderQuery="UPDATE message SET status_id=3 where (message_id="+message_id+" && member_number="+Register_number+");)";
		try {
			DataService.runQuery(cancelOrderQuery);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
	public static void storeMessage(String caller_id , String message , String time , String name , String group_id , String org_abbreviation){
		try{
			
			String insertInboundSms="INSERT INTO 'afc'.'user_registration'('user_number','user_message','sms_time') values('"+caller_id+"','"+message+"','"+time+"')";
			DataService.runQuery(insertInboundSms);
			
			String getOrgName="(SELECT org_database FROM organization WHERE org_abbreviation ='"+org_abbreviation+"')";
			ResultSet orgNameResultSet = DataService.getResultSet(getOrgName);
			if (orgNameResultSet.next()) {
				String org_DB = orgNameResultSet.getString("org_name");
				System.out.println("message stored sending confirmation message");
				System.out.println(org_DB);
				String insertMember="INSERT INTO '"+org_DB+"'.member('member_name','member_number','group_id') VALUES('"+name+"','"+caller_id+"','"+group_id+"')";
				DataService.runQuery(insertMember);
			}
			
			
		}
		catch(Exception ee){
			
			ee.printStackTrace();
			
		}
	}
		
						
	public static void PublisherPhoneMessage(String path , String caller_id , String group_id){
		String location=path;
		try {
			String fileName = DownloadFile.downloadAudio(path);			
		//	location =(ConfigParams.PUBLICLINKFORAUDIO+ "/publisher/" +fileName);
			//location =(ConfigParams.PUBLICLINKFORAUDIO+"/"+ fileName);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}try {

			
				String insertOrderQuery = "INSERT INTO `broadcast`(`broadcast_location`,`groups_id`,`publisher_number`) VALUES('"
						+ location
						+ "','"
						+ group_id
						+ "','"
						+ caller_id
						+ "');";
				System.out.println(insertOrderQuery);
				DataService.runQuery(insertOrderQuery);
				
				String BroadcastMessage = "INSERT INTO `phone_broadcast_msg`(`broadcast_location`,`groups_id`,`publisher_number`) VALUES('"
						+ path
						+ "','"
						+ group_id
						+ "','"
						+ caller_id
						+ "');";
				System.out.println(BroadcastMessage);
				DataService.runQuery(BroadcastMessage);
				// to generate order id
			/*	String getOrderIDQuery = "SELECT broadcast_id from broadcast where publisher_number='"
						+ caller_id + "' ORDER BY timestamp DESC;";
				ResultSet orderIDResultSet = DataService.getResultSet(getOrderIDQuery);
				if (orderIDResultSet.next()) {
					String order_id = orderIDResultSet.getString(1);
					System.out.println("message stored sending confirmation message");
					//sendConfirmationSMS(order_id, caller_id, groups_id);
					//DownloadFile.downloadRemainingFiles();
					System.out.println(order_id);
				}*/
		//	}
				try{
					String getMemberNumber="SELECT member_number FROM `member` where groups_id="+group_id+";";
					System.out.println("member"+getMemberNumber);
					ResultSet memberNumbers=DataService.getResultSet(getMemberNumber);
					while (memberNumbers.next()) {
						String number=memberNumbers.getString(1);
						String getLanguageRespone="SELECT language , response FROM globalsettings";
						ResultSet values=DataService.getResultSet(getLanguageRespone);
						if(values.next()){
							String language = values.getString("language");
							System.out.print("language ==== "+language);
							String responsetype = values.getString("response");
						    System.out.print("response ===== "+responsetype);
						//String language="4";
						//String responsetype="2";
						String sid= KooKooFunctions.placeCalled(number, group_id , language , responsetype);
						System.out.println("sid=="+sid);
						}
				//	String update ="update pending_call set status=";
						
					}
					}catch(Exception e){
						e.printStackTrace();
					}
		} catch (Exception e) {
			System.out.println(e);
		}
		
	}
	
	
	public static void storePublisherFeedback(String path , String caller_id){
		
		try {
//			String fileName = DownloadFile.downloadAudio(path);
			
			//testing code to be removed
			String fileName="";
			
			String location = "http://qassist.cse.iitb.ac.in/Downloads/publisher/"
					+ fileName;
			//for testing kookoo's cache
			location=path; //same as kookoo url 
			String org_name=ConfigParams.ORGNAME;
			String insertQuery = "INSERT INTO publisher_message (publisher_number, message_location , org_name) VALUES('"
					                  +caller_id
					                  +"','"
					                  + location
					                  +"', '"
					                  + org_name
					                  +"');";
			System.out.println(insertQuery);
			DataService.runQuery(insertQuery);
			/*	try {

				// to store order
				  ResultSet rs = DataService.getResultSet("SELECT groups_id from publisher where publisher_number="
								+ caller_id + ";");
				 if (rs.next()) {
					 String groups_id = rs.getString(1);
					 System.out.println("new group"+groups_id);
					String insertOrderQuery = "INSERT INTO `broadcast`(`broadcast_location`,`groups_id`,`publisher_number`) VALUES('"
							+ location
							+ "','"
							+ groups_id
							+ "','"
							+ caller_id
							+ "');";
					DataService.runQuery(insertOrderQuery);
					// to generate order id
					String getOrderIDQuery = "SELECT broadcast_id from broadcast where publisher_number='"
							+ caller_id + "' ORDER BY timestamp DESC;";
					ResultSet orderIDResultSet = DataService.getResultSet(getOrderIDQuery);
					if (orderIDResultSet.next()) {
						String order_id = orderIDResultSet.getString(1);
						System.out.println("message stored sending confirmation message");
						//sendConfirmationSMS(order_id, caller_id, groups_id);
						//DownloadFile.downloadRemainingFiles();
						System.out.println(order_id);
					}
					}
				} catch (Exception e) {
					System.out.println(e);
				}*/
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println(e);
			}

		}
		

		
	public static void storeFeedback(String path,String Groupss_id, String caller_id) {

		try {
//			String fileName = DownloadFile.downloadAudio(path);
			
			//testing code to be removed
			String fileName="";
			System.out.println("datastore");
			String location = "http://qassist.cse.iitb.ac.in/Downloads/feedback-download/"
					+ fileName;
			//for testing kookoo's cache
			location=path; //same as kookoo url 
			
			
			try {

				// to store order
			
						String insertOrderQuery = "INSERT INTO `feedbackmessage`(`feedbackmessage_location`,`groups_id`,`member_number`) VALUES('"
							+ location
							+ "','"
							+ Groupss_id
							+ "','"
							+ caller_id
							+ "');";
					System.out.println(insertOrderQuery);
					DataService.runQuery(insertOrderQuery);
					// to generate order id
					String getOrderIDQuery = "SELECT feedback_id from feedbackmessage where member_number='"
							+ caller_id + "' ORDER BY timestamp DESC;";
					ResultSet orderIDResultSet = DataService.getResultSet(getOrderIDQuery);
					if (orderIDResultSet.next()) {
						String order_id = orderIDResultSet.getString(1);
						System.out.println("message stored sending confirmation message");
						//sendConfirmationSMS(order_id, caller_id, groups_id);
						//DownloadFile.downloadRemainingFiles();
						System.out.println(order_id);
					}
				
			} catch (Exception e) {
				System.out.println(e);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}

	}
	
}
