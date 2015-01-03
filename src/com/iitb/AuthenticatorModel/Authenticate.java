package com.iitb.AuthenticatorModel;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.AuthenticatorBean.*;
import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;
/*
 * This model is used by Login.jsp and Dashboard.jsp * 
 *  
 */
public class Authenticate {	
	
	/* Authenticates the user and sets the login credentials in loginUser bean
	 * Login.jsp
	 * @author:Ravi Prakash Giri
	 */
	public LoginBean authenticate(String user,String password) throws SQLException{	
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		//System.out.println("k");
		LoginBean loginUser=new LoginBean();

		try{
				String query = "SELECT org_id,org_name,org_password,parent_org FROM `organization` where org_username='"
					+ user + "';";
			ResultSet rs = DataService.getResultSet(query);
			if (rs.next()) {
				//System.out.println("testing rpg");
				if (rs.getString("org_password").equals(password)) {
					String orgId = rs.getString("org_id");
					loginUser.setOrg_id(orgId);
					String orgName=rs.getString("org_name");
					loginUser.setOrg_name(orgName);
					String parentOrg = rs.getString("parent_org");
					loginUser.setParent_org(parentOrg);
					loginUser.setUsername(user);
					System.out.println("set loginUser");
					return loginUser;
					
				}
				else{
					System.out.println("no loginUser 1"+loginUser.getUsername());
					return loginUser;
				}
			}
			else{
				System.out.println("no loginUser 2");
				return loginUser;
			}
		}
		catch(SQLException e){
			e.printStackTrace();
			connObj.rollback();
			System.out.println("Rollback hua !");
		}
		System.out.println("no loginUser 3");
		return loginUser;
	}
	
}
