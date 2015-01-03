package com.iitb.PublisherModel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.DataServiceConnect;
import com.iitb.dbUtilities.MysqlConnect;

public class PublisherDetails {
	Connection connObj ;
	/*
	 * This method returns the details of all the publishers and their numbers.
	 * Publisher.jsp
	 * 
	 */
	public Object[][] getPublisherDetails() throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] publisherDetails=null;
        try {
			String query="SELECT * FROM `publisher`";
			ResultSet rs=(ResultSet) DataService.getResultSet(query);
			publisherDetails = (Object[][]) DataService.getDataFromResultSet(rs);
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
			
		}
        return publisherDetails;
       
	}
	/*
	 * This method deletes multiple publishers as per the selection.
	 * Publisher.jsp
	 * 
	 */
	public void deletePublisher(String[] selectedPublishers,int i) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		try {
			System.out.println("delete");
			String query="delete from publisher where publisher_id="+selectedPublishers[i];
			DataService.runQuery(query);
			System.out.println(query);
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
		
	}
	
	/*
	 * This method adds new publishers and their number.
	 * Pubisher.jsp
	 * 
	 */
	public void insertPublisher(String mem_name,String mem_number) throws SQLException{
		System.out.println("kkkkkkkk");
		DataServiceConnect dsc=new DataServiceConnect();
		dsc.insertIntoPublisher(mem_name, mem_number);
		System.out.println("insert call ");
	}
	

}
