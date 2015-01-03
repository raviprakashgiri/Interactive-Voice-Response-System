package com.iitb.WellinfoModel;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;
import com.mysql.jdbc.Connection;

public class Namesforwell {
	
	
	
	public Object[][] tehsil(String districtname)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object tehsilnames[][] = null;
		try
		{
		
		String tehsil = "SELECT distinct tehsil FROM well_data where district ='"+districtname+"'";
		System.out.println(tehsil);
		ResultSet results=DataService.getResultSet(tehsil);
		tehsilnames = DataService.getDataFromResultSet(results);
		
		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		
		return tehsilnames;
		
		
		
	}
	
	
	

	public Object[][] village(String districtname, String tehsilname)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object villagename[][] = null;
		try
		{
		
			String village = "SELECT distinct village FROM well_data where tehsil ='"+tehsilname+"' and district='"+districtname+"'";
			//System.out.println(village);
			ResultSet results=DataService.getResultSet(village);
			villagename = DataService.getDataFromResultSet(results);
			
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		
		return villagename;
		
		
		
	}
	
	
	
	
	public Object[][] welldata(String districtname, String tehsilname, String village_name, String fromdate, String todate)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object welldata[][] = null;
		try
		{
		
			String getData="Select well_number, water_level, date from well_data where district='"+districtname+"' and tehsil='"+tehsilname+"' and village='"+village_name+"' and date between '"+fromdate+"' and '"+todate+"' order by date";
			ResultSet rs= DataService.getResultSet(getData);
			welldata = DataService.getDataFromResultSet(rs);
		connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		
		return welldata;
		
		
		
	}
	
	

}
