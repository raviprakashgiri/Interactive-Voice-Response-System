package com.iitb.SettingsModel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;

public class BillSettings {
	/* Returns the bill settings of a particular organization
	 * BillSettings.jsp
	 * 
	 */
	public Object[][] getBillSettings(String orgId)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		try
		{
			Integer orgid=Integer.parseInt(orgId);
			String get="Select * from bill_settings where org_id='"+orgid+"'";
			ResultSet resultSet=DataService.getResultSet(get);
			Object[][] billSettings=DataService.getDataFromResultSet(resultSet);
			
			return billSettings;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return null;
	}
	/* Updates the billSettings of the organization
	 * BillSettings.jsp
	 * 
	 */
	public boolean updateBillSettings(String orgId,String orgName,String orgAddLine1,String orgAddLine2,String orgAddCity,String orgContact,String orgExtra,String orgFooter1,String orgFooter2) throws SQLException{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
	
		try{
			String in="fail";
			System.out.println(orgId);
			String get="Select * from bill_settings where org_id='"+orgId+"'";
			System.out.println(get);
			ResultSet resultSet=DataService.getResultSet(get);
			while(resultSet.next()){
				if(resultSet.getString("org_id").equals(orgId)){
					String query="update bill_settings set org_id='"+orgId+"',org_name='"+orgName+"',org_add_line1='"+orgAddLine1+"',org_add_line2='"+orgAddLine2+"',org_add_city='"+orgAddCity+"',org_contact='"+orgContact+"',org_extra='"+orgExtra+"',org_footer1='"+orgFooter1+"',org_footer2='"+orgFooter2+"' where org_id="+orgId;

					System.out.println(query);
					DataService.runQuery(query);
					in="success";
					System.out.println("hiiii");
					break;
				}
			}
			if(in.equals("fail")){
				String query="insert into bill_settings values('"+orgId+"','"+orgName+"','"+orgAddLine1+"','"+orgAddLine2+"','"+orgAddCity+"','"+orgContact+"','"+orgExtra+"','"+orgFooter1+"','"+orgFooter2+"')";

				System.out.println(query);
				DataService.runQuery(query);	
			}
			return true;

		}
		catch(SQLException e){
			e.printStackTrace();
			connObj.rollback();
			return false;
		}

	}
	/* Function to get Bill Id for the order
	 * ViewPrintBill.jsp
	 *
	 */
	public String getBillId(String messageId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String billId=null;
		try
		{
			String getBillIdQuery="Select bill_id_no from bill_id where msg_id="+messageId;
			ResultSet resultSet=DataService.getResultSet(getBillIdQuery);
			resultSet.next();
			
			billId=resultSet.getString("bill_id_no");
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return billId;
    }
	
	/* Function to get Bill total 
	 * ViewPrintBill.jsp
	 * 
	 */
	public String getBillTotal(String messageId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String billTotal=null;
		try
		{
			String totalQuery="Select SUM(product_price) as total from processedOrder where message_id="+messageId;
			ResultSet resultSet=DataService.getResultSet(totalQuery);
			resultSet.next();
			
			billTotal=resultSet.getString("total");
			
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return billTotal;
    }

}
