package com.iitb.KookooFunctionsTextToSpeechModel;

import java.io.BufferedReader;
import java.net.URLEncoder;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.Authenticator;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.iitb.dbUtilities.DataService;
import com.iitb.AuthenticatorBean.*;
import com.iitb.globals.*;

/**
 * This class takes care of intimating the KooKoo server with our requests.
 * @author $ujen
 *
 */
public class KooKooFunctions {
	public static void main(String[] args) throws Exception {
		//		sendSMS("9833149825", "This is testing from java");
		//		placeCall("9833149825");
	}

	static ReadPropertyFile rd=new ReadPropertyFile();
	static String kookooNumber=ConfigParams.KOOKOONUMBER;


	/**
	 * To send out an sms message 
	 * @param number
	 * @param message
	 * @return response code : 200 is success
	 * @throws Exception
	 */
	public static int sendSMS(String number, String message) throws Exception{

		Proxy netmon = new Proxy(Proxy.Type.HTTP, new InetSocketAddress("172.17.166.10",80));
		Authenticator.setDefault(new ProxyAuthenticator(ConfigParams.LDAPUSER, ConfigParams.LDAPPASS));

		String url = "http://www.kookoo.in/outbound/outbound_sms.php";
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection(netmon);

		//add request header

		con.setRequestMethod("GET");
		//		con.setRequestProperty("User-Agent", "Mozilla/5.0");
		//		con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
		//		message=message.replaceAll(" ", "%20");
		String urlParameters = "phone_no="+number+"&api_key=KK4063496a1784f9f003768bd6e34c185b&unicode=true&message="+message+"&callback=?";
		System.out.println("Message3 content in kookoo functions : "+message);	
		// Send post request	
		con.setDoOutput(true);
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		wr.writeBytes(urlParameters);
		wr.flush();
		wr.close();

		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'POST' request to URL : " + url);
		System.out.println("Post parameters : " + urlParameters);
		System.out.println("Response Code : " + responseCode);

		BufferedReader in = new BufferedReader(
				new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		//print result
		System.out.println(response.toString());
		return responseCode;
	}

	/**
	 * To place a broadcast call to specified number 
	 * @param number
	 */
	public static String placeCall(String number , String group_id , String language , String responsetype){

		System.out.println(language);

		System.out.println("group_idgroup_idgroup_idgroup_idgroup_id  KOKKOO"+group_id);
		System.out.println(responsetype);
		String language_response=language+"x"+responsetype+"x"+group_id;
		// String language_response ="";

		try{
			Proxy netmon = new Proxy(Proxy.Type.HTTP, new InetSocketAddress("172.17.166.10",80));
			Authenticator.setDefault(new ProxyAuthenticator(ConfigParams.LDAPUSER, ConfigParams.LDAPPASS));

			String url = "http://www.kookoo.in/outbound/outbound.php";
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection(netmon);

			//add reuqest header
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", "Mozilla/5.0");
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
			String urlParameters="phone_no=0"+number
					+ "&api_key=KK4063496a1784f9f003768bd6e34c185b&outbound_version=2&"
					+ "caller_id="+kookooNumber+"&"
					+"url="+ConfigParams.IVRSLINK+"LanguageCheck.jsp?language="+language_response+
					"&groups_id="+group_id
					+ "&callback_url="+ConfigParams.BROADCASTCALLBACKURL;


			/* String urlParameters="phone_no=0"+number
				+ "&api_key=KK4063496a1784f9f003768bd6e34c185b&outbound_version=2&"
				+ "caller_id="+kookooNumber+"&"
				+"url="+ConfigParams.IVRSLINK+"RegisteredUser.jsp"+
				"&"
				+ "callback_url="+ConfigParams.BROADCASTCALLBACKURL; */
			System.out.println("Broadcast URL : "+urlParameters);

			// Send post request	
			con.setDoOutput(true);	
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(urlParameters);

			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			//				System.out.println("\nSending 'POST' request to URL : " + url);
			//				System.out.println("Post parameters : " + urlParameters);
			//				System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(
					new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();


			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			System.out.println(response);
			int message=response.indexOf("<message>");
			System.out.println(message);
			int message_end=response.indexOf("</message>");
			System.out.println(message_end);
			String sid =response.substring(message+9, message_end);
			//   int s_id = Integer.parseInt(sid);
			// System.out.println(sid1);

			String timeStamp = new SimpleDateFormat("[dd-MM-yyyy | HH:mm:ss]").format(Calendar.getInstance().getTime());
			System.out.println(timeStamp +" Placed call to : "+number+" Response code : "+responseCode);
			//print result
			//return responseCode;
			return sid;


		}catch(Exception e){
			e.printStackTrace();
			return "";

		}
	}


	public static String placeCalled(String number , String group_id , String language , String responsetype){

		System.out.println(language);

		System.out.println("group_idgroup_idgroup_idgroup_idgroup_id  KOKKOO"+group_id);
		System.out.println(responsetype);
		String language_response=language+"x"+responsetype+"x"+group_id;
		// String language_response ="";

		try{
			Proxy netmon = new Proxy(Proxy.Type.HTTP, new InetSocketAddress("172.17.166.10",80));
			Authenticator.setDefault(new ProxyAuthenticator(ConfigParams.LDAPUSER, ConfigParams.LDAPPASS));

			String url = "http://www.kookoo.in/outbound/outbound.php";
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection(netmon);

			//add reuqest header
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", "Mozilla/5.0");
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
			String urlParameters="phone_no=0"+number
					+ "&api_key=KK4063496a1784f9f003768bd6e34c185b&outbound_version=2&"
					+ "caller_id="+kookooNumber+"&"
					+"url="+ConfigParams.IVRSLINK+"LanguageChecked.jsp?language="+language_response+
					"&groups_id="+group_id
					+ "&callback_url="+ConfigParams.BROADCASTCALLBACKURL;


			/* String urlParameters="phone_no=0"+number
				+ "&api_key=KK4063496a1784f9f003768bd6e34c185b&outbound_version=2&"
				+ "caller_id="+kookooNumber+"&"
				+"url="+ConfigParams.IVRSLINK+"RegisteredUser.jsp"+
				"&"
				+ "callback_url="+ConfigParams.BROADCASTCALLBACKURL; */
			System.out.println("Broadcast URL : "+urlParameters);

			// Send post request	
			con.setDoOutput(true);	
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(urlParameters);

			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			//				System.out.println("\nSending 'POST' request to URL : " + url);
			//				System.out.println("Post parameters : " + urlParameters);
			//				System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(
					new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();


			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			System.out.println(response);
			int message=response.indexOf("<message>");
			System.out.println(message);
			int message_end=response.indexOf("</message>");
			System.out.println(message_end);
			String sid =response.substring(message+9, message_end);
			//   int s_id = Integer.parseInt(sid);
			// System.out.println(sid1);

			String timeStamp = new SimpleDateFormat("[dd-MM-yyyy | HH:mm:ss]").format(Calendar.getInstance().getTime());
			System.out.println(timeStamp +" Placed call to : "+number+" Response code : "+responseCode);
			//print result
			//return responseCode;
			return sid;


		}catch(Exception e){
			e.printStackTrace();
			return "";

		}
	}

	public String PublisherCheck(String caller_id) throws SQLException{
		String result = " " ;
		String publisher_query="Select publisher_id from publisher where publisher_number like '%"+caller_id+"';";
		ResultSet publisher = DataService.getResultSet(publisher_query);
		if(publisher.next()){
			result = "true" ;
			return result;
		}
		else{
			result = "false";
			return result;

		}

	}
	
	public String MemberCheck(String caller_id) throws SQLException{
        String result="";
    	String query="SELECT * FROM member WHERE member_number LIKE '%"+caller_id+"';";
       	System.out.println(query);
        ResultSet memberCheck=DataService.getResultSet(query);
        if(memberCheck.next()){
        	result = "true";
        	return result ;
        }
        else{
        	result="false";
        	return result ;
        }
		
	}
	
	public String getGlobalSettingValue() throws SQLException {
		// TODO Auto-generated method stub
		 String result ="";
		 String welcomeMsgPath="";
			
			 String getWelcomeMsgQuery="SELECT broadcast_call,welcome_msg_location,Previous_broadcast,repeat_broadcast FROM globalsettings"; // To get welcome msg path 
	        
			 System.out.println( getWelcomeMsgQuery);
			 
			 ResultSet welcomeMsgQueryResult=DataService.getResultSet(getWelcomeMsgQuery);
			
	         while(welcomeMsgQueryResult.next()){
	        	 System.out.println( getWelcomeMsgQuery);
	        	 String broadcast_call_values=welcomeMsgQueryResult.getString("broadcast_call");
             	System.out.println("value======"+broadcast_call_values);
             	 welcomeMsgPath=welcomeMsgQueryResult.getString("welcome_msg_location");
             	System.out.println(welcomeMsgPath);
               	String Previous_broadcast=welcomeMsgQueryResult.getString("Previous_broadcast");
             	System.out.println(Previous_broadcast);
             	String repeat_broadcast = welcomeMsgQueryResult.getString("repeat_broadcast");
             	System.out.println(repeat_broadcast);
             	
             	result=broadcast_call_values+","+welcomeMsgPath+","+Previous_broadcast+","+repeat_broadcast;
             	return result;	
	         }
		return result;
	}
	
public String getOrderValue() throws SQLException{
		
		String value_orderCancel= "";
    		String order_cancel="Select order_cancel from globalsettings";
			ResultSet orderCancel = DataService.getResultSet(order_cancel);
            
            if(orderCancel.next()){
            	value_orderCancel= orderCancel.getString("order_cancel");
            	return value_orderCancel;
            }
            
            return value_orderCancel;
	}
	
	public String GetLanguageResponse() throws SQLException{
		String languageResponse="";
		String SelectLanguageResponse = "SELECT `languagein` ,`responsein` FROM globalsettings";
		ResultSet result = DataService.getResultSet(SelectLanguageResponse);
		
		if(result.next()){
			String language = result.getString("languagein");
			System.out.println(language);
			String dataresponse = result.getString("responsein");
			System.out.print(dataresponse);
			languageResponse=language+","+dataresponse;
			return languageResponse;
		}
		return languageResponse;
	}
	
	public String GetBroadcastMsg(String groups_id) throws SQLException{
		String broadcast="";
		 String getLatestBroadcastMsgQuery="SELECT broadcast_location FROM phone_broadcast_msg WHERE groups_id="+"groups_id"+" ORDER BY TIMESTAMP DESC";
	     
    	 // String getLatestBroadcastMsgQuery="SELECT broadcast_location  FROM latest_broadcast WHERE groups_id="+groups_id;       
    	System.out.println(getLatestBroadcastMsgQuery);
    	ResultSet latestBroadcastMsgQueryResult=DataService.getResultSet(getLatestBroadcastMsgQuery);
    	if(latestBroadcastMsgQueryResult.next()){
    		String broadcastURL=latestBroadcastMsgQueryResult.getString(1);
    		System.out.println(broadcastURL);
    		return broadcast;
    		// latest broadcast message will play
    		
    	}
		return broadcast;
		
	}
	
	public String GetLatestBroadcastMsg(String groups_id) throws SQLException{
		String broadcastURL = "" ;
		String getLatestBroadcastMsgQuery="SELECT broadcast_location FROM latest_broadcast WHERE groups_id="+groups_id;
     	System.out.println(getLatestBroadcastMsgQuery);
	ResultSet latestBroadcastMsgQueryResult=DataService.getResultSet(getLatestBroadcastMsgQuery);
	// latest broadcast message 
	if(latestBroadcastMsgQueryResult.next()){
		 broadcastURL=latestBroadcastMsgQueryResult.getString(1);
		System.out.println(broadcastURL);
		return broadcastURL;
	}
		return broadcastURL;
	}
	
	public String GetTimerValue() throws SQLException{
		String value = "";
		String time= "select timer ,time , status from globalsettings";
    	ResultSet time_status=DataService.getResultSet(time);
    	if(time_status.next()){
    		String timer = time_status.getString("timer");
    		 String tymm = time_status.getString("time");
    		 int tym = Integer.parseInt(tymm);
    		 System.out.print("tym="+tym);
    		 String states = time_status.getString("status");
    	     value = timer+","+tymm+","+states ;
    		 return value;
	      }
    	return value;
	}
		
	public int getRows(ResultSet res) {
		int totalRows = 0;
		try {
			res.last();
			totalRows = res.getRow();
			res.beforeFirst();
		} catch (Exception ex) {
			return 0;
		}
		return totalRows;
	}

	public String[] GetData() {
	     
		String[] name=null;
		String[] dataname = null;
		String[] data= null;
		ResultSet rs ;
		String query="SELECT groups_id , groups_name FROM groups";
		System.out.println(query);
		try {
			//System.out.println(query);
			rs = DataService.getResultSet(query);
			int rows = getRows(rs);
			data = new String[rows];
			name = new String[rows];
			dataname = new String[rows];
			int i = 0;
			while (rs.next()) {
				data[i] = rs.getString("groups_id");
				name[i] =rs.getString("groups_name");
				dataname[i]=data[i]+name[i];
				i++;
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dataname;

		//return data;
		
	}
	public String CheckGroup_id(String group_id) throws SQLException{
		String result= "false";
		String find_groups_id = "SELECT * FROM groups WHERE groups_id="+group_id;
        System.out.println(find_groups_id);
        ResultSet rs = DataService.getResultSet(find_groups_id);
        if(rs.next()){
        	result="true";
        	return result ;
        }
		return result;
	}
}
