package com.iitb.PublisherModel;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;
import com.mysql.jdbc.Connection;




public class NewUpdateLogin {
	
	

	/* Method to verify and update the username
	 * 
	 *
	 */
	public boolean verifyUsername(String user1, String user2, String pass1)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		boolean var = false;
		try
		{
		String query = "SELECT org_id,org_password FROM organization where org_username='"+user1+ "';";
		ResultSet rs = DataService.getResultSet(query);
		if (rs.next()) {

			if (rs.getString("org_password").equals(pass1)) {
			
			   query = "update organization set org_username='"+user2+"' where org_username='"+user1+"';";
			   System.out.println(query);
			   DataService.runQuery(query);
			   var = true;
			   //response.sendRedirect("Login.jsp");

			} 
			
		}
			/*else {
				return false;
				//response.sendRedirect("Login.jsp?auth=failed");
			}

		}else {
			return false;
			//response.sendRedirect("Login.jsp?auth=failed");
		}*/

		connObj.commit();
	}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
	
		return var;
	
	}
	
	
	

	/* Method to verify the old password and update the new one
	 * UpdateLoginCredentials.jsp
	 * 
	 */
	public boolean verifyPassword(String user1, String pass1, String pass2)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		boolean var = false;
		try
		{
		String query = "SELECT org_id,org_password FROM `organization` where org_username='"+ user1 + "';";
		ResultSet rs = DataService.getResultSet(query);
		if (rs.next()) {

			if (rs.getString("org_password").equals(pass1)) {
			    query = "update organization set org_password ='"+pass2+"' where org_username='"+ user1+"';";
				DataService.runQuery(query);
				var = true;
			}
	}
		
		
	connObj.commit();
	
		
	
}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		
	
		return var;
	}
	
}
