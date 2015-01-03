package com.iitb.SettingsModel;

import java.sql.*;

import com.iitb.dbUtilities.*;
import com.mysql.jdbc.Connection;


public class SystemSettings 
{
	/* Returns the present value of settings 
	 * SystemSettings.jsp
	 * 
	 */
	public Object[][] getSystemData( )throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String query="SELECT welcome_msg_location,language,email_id,response,broadcast_call,Previous_broadcast,languagein,responsein,repeat_broadcast,order_cancel,Latest_broadcast,enable_feedback,enable_response,enable_bill,enable_save,enable_reject FROM globalsettings;";
		System.out.println("test");
		Object systemData[][] = null; 
		try {
			System.out.println("Query : "+query);
			System.out.println("test");
			
			ResultSet	rs = DataService.getResultSet(query);
			System.out.println("test");
			 
				System.out.println("test");
				systemData = DataService.getDataFromResultSet(rs);
	
			System.out.println("Rs is not null and data has  : "+systemData[0][2]);
			System.out.println("going to controller");
			connObj.commit();
			} 
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		return systemData;
		
	}

}
