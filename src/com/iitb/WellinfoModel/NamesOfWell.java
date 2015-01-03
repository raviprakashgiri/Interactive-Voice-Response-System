package com.iitb.WellinfoModel;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;
import com.mysql.jdbc.Connection;

public class NamesOfWell 
{
	
	/* Returns the Tehsil Names of a particular District
	 * NamesOfWell.jsp
	 * @author:Nachiketh
	 */
	public Object[][] getTehsil(String districtName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		Object tehsilNames[][] = null;
		try
		{
			String tehsil = "SELECT distinct tehsil FROM well_data where district ='"+districtName+"'";
			ResultSet results=DataService.getResultSet(tehsil);
			tehsilNames = DataService.getDataFromResultSet(results);
			
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return tehsilNames;
	}
	
	
	/* Returns the Village Names of a particular District and Tehsil
	 * NamesOfWell.jsp
	 * @author:Nachiketh
	 */
	
	public Object[][] getVillage(String districtName, String tehsilName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		Object villageName[][] = null;
		try
		{
		
			String village = "SELECT distinct village FROM well_data where tehsil ='"+tehsilName+"' and district='"+districtName+"'";
			ResultSet results=DataService.getResultSet(village);
			villageName = DataService.getDataFromResultSet(results);
			
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return villageName;
	}
	
	/* Returns the Well Data
	 * NamesOfWell.jsp
	 * @author:Nachiketh
	 */
	
	public Object[][] getWellData(String districtName, String tehsilName, String villageName, String fromDate, String toDate)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object wellData[][] = null;
		try
		{
		
			String getData="Select well_number, water_level, date from well_data where district='"+districtName+"' and tehsil='"+tehsilName+"' and village='"+villageName+"' and date between '"+fromDate+"' and '"+toDate+"' order by date";
			ResultSet rs= DataService.getResultSet(getData);
			wellData = DataService.getDataFromResultSet(rs);
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return wellData;		
	}
}
