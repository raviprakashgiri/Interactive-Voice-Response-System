package com.iitb.SettingsModel;

import java.sql.*;

import com.iitb.dbUtilities.*;
import com.mysql.jdbc.Connection;


public class NewSettings 
{
	public Object[][] getData( String welcome_msg_location, String language, String email_id, String response, String broadcast_call,String Previous_broadcast, String languagein, String responsein, String repeat_broadcast,String order_cancel, String Latest_broadcast)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String query="SELECT welcome_msg_location,language,email_id,response,broadcast_call,Previous_broadcast,languagein,responsein,repeat_broadcast,order_cancel,Latest_broadcast FROM globalsettings;";
		System.out.println("test");
		Object data[][] = null; 
		try {
			System.out.println("Query : "+query);
			System.out.println("test");
			
			ResultSet	rs = DataService.getResultSet(query);
			System.out.println("test");
			 
				System.out.println("test");
				data = DataService.getDataFromResultSet(rs);
	
			System.out.println("Rs is not null and data has  : "+data[0][2]);
			System.out.println("going to controller");
			connObj.commit();
			} 
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		return data;
		
	}

}
