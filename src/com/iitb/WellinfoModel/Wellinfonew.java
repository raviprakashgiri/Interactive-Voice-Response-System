package com.iitb.WellinfoModel;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;
import com.mysql.jdbc.Connection;

public class Wellinfonew
{
	
	public String[] DistrictName()throws SQLException 
	{
		
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String[] districtname=null;
	try
	{
		connObj.setAutoCommit(false);
		String getdistrictname="Select Distinct district from well_data";
	ResultSet resultdistrictname=DataService.getResultSet(getdistrictname);

	resultdistrictname.last();
	Integer districtcount=resultdistrictname.getRow();
	int i=0;
	resultdistrictname.beforeFirst();

			districtname=new String[districtcount];
			while(resultdistrictname.next()){
				districtname[i]=resultdistrictname.getString("district");
				i++;
			}
			
			connObj.commit();
			
	}
	catch(SQLException e)
	{
		e.printStackTrace();
		connObj.rollback();
	}
	
	return districtname;
	
	
	}
	
	public String[] DistrictToTehsil()throws SQLException 
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String[] districttotehsil=null;	
		Integer tehsilcount;
		int j = 0;
	try
	{
		String districtname[] = DistrictName();
		String gettehsilname="Select distinct tehsil from well_data where district='"+districtname[0]+"'";
		System.out.println(gettehsilname);
		ResultSet resulttehsilname=DataService.getResultSet(gettehsilname);
		resulttehsilname.last();
		tehsilcount=resulttehsilname.getRow();
		districttotehsil=new String[tehsilcount];
		resulttehsilname.beforeFirst();
		while(resulttehsilname.next()){
			districttotehsil[j]=resulttehsilname.getString("tehsil");	
			j++;
					}

		connObj.commit();
		
			
	}
	catch(Exception e)
	{
		e.printStackTrace();
		connObj.rollback();
	}
	
	return districttotehsil;
	
	
	}
	
	
	public String[] TehsilToVillage()throws SQLException 
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String[] tehsiltovillage=null;	
		Integer villagecount;
		int k = 0;
		try
		{
			String  districttotehsil[] = DistrictToTehsil();
			String getvillagename="Select distinct village from well_data where tehsil='"+districttotehsil[0]+"'";
			System.out.println(getvillagename);
			ResultSet resultvillagename=DataService.getResultSet(getvillagename);
			resultvillagename.last();
			villagecount=resultvillagename.getRow();
			tehsiltovillage=new String[villagecount];
			resultvillagename.beforeFirst();
			while(resultvillagename.next()){
				tehsiltovillage[k]=resultvillagename.getString("village");	
				k++;
			}

			connObj.commit();
			connObj.rollback();
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return tehsiltovillage;
	}
}