package com.iitb.WellinfoModel;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;
import com.mysql.jdbc.Connection;

public class WellInformation
{
	/* Returns the District Names 
	 * WellInformation.jsp
	 * @author:Nachiketh
	 */
	
	public String[] districtName()throws SQLException 
	{
		
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String[] districtName=null;
		try
		{
			String getDistrictName="Select Distinct district from well_data";
			ResultSet resultDistrictName=DataService.getResultSet(getDistrictName);
	
			resultDistrictName.last();
			Integer districtcount=resultDistrictName.getRow();
			int i=0;
			resultDistrictName.beforeFirst();
			districtName=new String[districtcount];
			while(resultDistrictName.next())
			{
				districtName[i]=resultDistrictName.getString("district");
				i++;
			}
			connObj.commit();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return districtName;
	}
	
	
	/* Returns the Tehsil Names  
	 * WellInformation.jsp
	 * @author:Nachiketh
	 */
	
	
	public String[] districtToTehsil()throws SQLException 
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String[] districtToTehsil=null;	
		Integer tehsilCount;
		int j = 0;
		try
		{
			String districtname[] = districtName();
			String getTehsilName="Select distinct tehsil from well_data where district='"+districtname[0]+"'";
			ResultSet resultTehsilName=DataService.getResultSet(getTehsilName);
			
			resultTehsilName.last();
			tehsilCount=resultTehsilName.getRow();
			districtToTehsil=new String[tehsilCount];
			resultTehsilName.beforeFirst();
			while(resultTehsilName.next())
			{
				districtToTehsil[j]=resultTehsilName.getString("tehsil");	
				j++;
			}
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return districtToTehsil;
	}
	
	
	/* Returns the Village Names 
	 * WellInformation.jsp
	 * @author:Nachiketh
	 */
	
	
	public String[] tehsilToVillage()throws SQLException 
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String[] tehsilToVillage=null;	
		Integer villageCount;
		int k = 0;
		try
		{
			String  districtToTehsil[] = districtToTehsil();
			String getVillageName="Select distinct village from well_data where tehsil='"+districtToTehsil[0]+"'";
			
			ResultSet resultVillageName=DataService.getResultSet(getVillageName);
			resultVillageName.last();
			villageCount=resultVillageName.getRow();
			tehsilToVillage=new String[villageCount];
			resultVillageName.beforeFirst();
			while(resultVillageName.next())
			{
				tehsilToVillage[k]=resultVillageName.getString("village");	
				k++;
			}
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return tehsilToVillage;
	}
}