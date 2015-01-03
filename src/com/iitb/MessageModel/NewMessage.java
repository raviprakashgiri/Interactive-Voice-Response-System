package com.iitb.MessageModel;

import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;

public class NewMessage {
	
	
	public void newMess(String messageLocation, String orgName)
	{
		String query = "INSERT INTO publisher_message (publisher_number, message_location, org_name) VALUES ('7506080175','" + messageLocation+"','" + orgName+"');";
		System.out.println(query);
		try {
			DataService.runQuery(query);
		} catch(SQLException e)  {
			e.printStackTrace();
		}
	}
	
	
	public void mUpload()
	{
		String global_setting_id = "Select global_setting_id from globalsettings;";
		
	}
	

}
