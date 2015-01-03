package com.iitb.SettingsModel;

import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;
import com.iitb.globals.*;
import com.iitb.KookooFunctionsTextToSpeechModel.*;
import com.mysql.jdbc.Connection;


public class IvrsMenuSettings
{
	
	String filePath=ConfigParams.LANGUAGEDIR;
	TextToSpeech tts = new TextToSpeech();
	
	
	/* Sets the English Semi Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public void setSemiStructured(int orgId,int h1,int h2,int h3,String option,String text,String voice,String fileName )throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update en_semi_structured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"english/"+fileName+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		try 
		{
			tts.convertText("english", text.getBytes("UTF-8"), filePath+"english", fileName);
		} 
		catch (UnsupportedEncodingException e1) 
		{
			e1.printStackTrace();
		}
		try 
		{
			DataService.runQuery(query);
			connObj.commit();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	/* Gets the English Semi Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public String getSemiStructured(int orgId,int h1,int h2,int h3,String option)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from en_semi_structured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		String semiStructured = "";
		try
		{
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next())
			{
				semiStructured = rs.getString(option);
			}
			connObj.commit();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return semiStructured;
	}

	
	/* Sets the English Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public void setStructured(int orgId,int h1,int h2,int h3,String option,String text,String voice,String fileName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update en_structured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"english/"+fileName+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		try
		{
			tts.convertText("english", text.getBytes("UTF-8"), filePath+"english", fileName);
		}
		catch (UnsupportedEncodingException e1)
		{
			e1.printStackTrace();
		}
		
		try 
		{
			DataService.runQuery(query);
			connObj.commit();
		} 
		catch (SQLException e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	/* Gets the English Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	
	public String getStructured(int orgId,int h1,int h2,int h3,String option)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from en_structured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		String structured = "";
		try
		{
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next())
			{
				structured = rs.getString(option);
			}
			connObj.commit();
		} 
		catch (SQLException e) {
			e.printStackTrace();
			connObj.rollback();
		}
		
		return structured;
	}
	
	
	
	/* Sets the English UnStructured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public void setUnstructured(int orgId,int h1,int h2,int h3,String option,String text,String voice,String fileName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update en_unstructured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"english/"+fileName+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		try 
		{
			tts.convertText("english", text.getBytes("UTF-8"), filePath+"english", fileName);
		} 
		catch (UnsupportedEncodingException e1) 
		{
			e1.printStackTrace();
		}
		
		try 
		{
			DataService.runQuery(query);
			connObj.commit();
		} 
		catch (SQLException e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	/* gets the English UnStructured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public String getUnstructured(int orgId,int h1,int h2,int h3,String option)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from en_unstructured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		String unstructured = "";
		try 
		{
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next())
			{
				unstructured = rs.getString(option);
				connObj.commit();
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return unstructured;
	}
	
	/* Sets the English Standard 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public void setStandard(int orgId,String columnName,String text,String voice,String fileName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update en_standard set "+columnName+" = '"+text+"',"+voice+"='"+filePath+"english/"+fileName+"' where org_id="+orgId;
		
		try {
			tts.convertText("english", text.getBytes("UTF-8"), filePath+"english", fileName);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	/* Gets the English Standard 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public String getStandard(int orgId,String columnName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+columnName+" from en_standard  where org_id="+orgId;
		String standard = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
				standard = rs.getString(columnName);
				connObj.commit();
				}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		return standard;
	}
	
	
	/* Sets the Hindi Semi Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	
	public void setSemiStructuredHindi(int orgId,int h1,int h2,int h3,String option,String text,String voice,String fileName )throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update hi_semi_structured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"hindi/"+fileName+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		try {
			tts.convertText("hindi", text.getBytes("UTF-8"), filePath+"hindi/", fileName);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	/* Gets the Hindi Semi Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public String getSemiStructuredHindi(int orgId,int h1,int h2,int h3,String option)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from hi_semi_structured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		String semiStructuredHindi = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
			semiStructuredHindi = rs.getString(option);
			connObj.commit();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		
		return semiStructuredHindi;
	}
	
	
	/* Sets the Hindi  Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public void setStructuredHindi(int orgId,int h1,int h2,int h3,String option,String text,String voice,String fileName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update hi_structured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"hindi/"+fileName+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		try {
			tts.convertText("hindi", text.getBytes("UTF-8"), filePath+"hindi/", fileName);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	/* Gets the Hindi  Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public String getStructuredHindi(int orgId,int h1,int h2,int h3,String option)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from hi_structured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		String structuredHindi = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
				structuredHindi = rs.getString(option);
				connObj.commit();
				}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		
		return structuredHindi;
	}
	
	
	/* Sets the Hindi  UnStructured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public void setUnstructuredHindi(int orgId,int h1,int h2,int h3,String option,String text,String voice,String fileName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update hi_unstructured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"hindi/"+fileName+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		try {
			tts.convertText("hindi", text.getBytes("UTF-8"), filePath+"hindi/", fileName);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
	
	}

	
	
	
	/* Gets the Hindi  UnStructured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public String getUnstructuredHindi(int orgId,int h1,int h2,int h3,String option)throws SQLException 
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from hi_unstructured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		String unstructuredHindi = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
				unstructuredHindi = rs.getString(option);
				}
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		return unstructuredHindi;
	}
	
	
	
	
	/* Sets the Hindi  Standard 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public void setStandardHindi(int orgId,String columnName,String text,String voice,String fileName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update hi_standard set "+columnName+" = '"+text+"',"+voice+"='"+filePath+"hindi/"+fileName+"' where org_id="+orgId;
		System.out.println(query);
		
		try {
			tts.convertText("hindi", text.getBytes("UTF-8"), filePath+"hindi/", fileName);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	
	
	
	/* Gets the Hindi  Standard 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public String getStandardHindi(int orgId,String columnName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+columnName+" from hi_standard  where org_id="+orgId;
		String standardHindi = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
				standardHindi = rs.getString(columnName);
				}
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		return standardHindi;
	}
	
	
	//Hindi Ends
	
	
	
	/* Sets the Marathi  Semi Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public void setSemiStructuredMarathi(int orgId,int h1,int h2,int h3,String option,String text,String voice,String filename )throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String query="update mr_semi_structured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"marathi/"+filename+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		System.out.println(query);
		try {
			tts.convertText("marathi", text.getBytes("UTF-8"), filePath+"marathi/", filename);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	
	/* Gets the Marathi Semi Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
		public String getSemiStructuredMarathi(int orgId,int h1,int h2,int h3,String option)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from mr_semi_structured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		String semiStructuredMarathi = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
			semiStructuredMarathi = rs.getString(option);
			}
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		
		return semiStructuredMarathi;
	}
	
		
		
		/* Sets the Marathi Semi Structured 
		 * IvrsMenuSettings.jsp
		 * 
		 */
		
	public void setStructuredMarathi(int orgId,int h1,int h2,int h3,String option,String text,String voice,String filename)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update mr_structured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"marathi/"+filename+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;

		try {
			tts.convertText("marathi", text.getBytes("UTF-8"), filePath+"marathi/", filename);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	
	/* Gets the Marathi Semi Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public String getStructuredMarathi(int orgId,int h1,int h2,int h3,String option)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from mr_structured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		String structuredMarathi = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
				structuredMarathi = rs.getString(option);
				}
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		
		return structuredMarathi;
	}
	
	
	/* Sets the Marathi Un Structured 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public void setUnstructuredMarathi(int orgId,int h1,int h2,int h3,String option,String text,String voice,String filename)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String query="update mr_unstructured set "+option+" = '"+text+"',"+voice+" ='"+filePath+"marathi/"+filename+"' where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		System.out.println(query);
		try {
			tts.convertText("marathi", text.getBytes("UTF-8"), filePath+"marathi/", filename);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
	}
	
	
	/* Gets the Marathi Un Structured 
	 * IvrsMenuSettings.jsp
	 * @author:Nachiketh
	 */
	
	public String getUnstructuredMarathi(int orgId,int h1,int h2,int h3,String option)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+option+" from mr_unstructured  where h_1= "+h1+" AND h_2= "+h2+" AND h_3="+h3+" AND org_id="+orgId;
		
		String unstructuredMarathi = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
				unstructuredMarathi = rs.getString(option);
				}
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}
		
		return unstructuredMarathi;
	}
	
	
	
	/* Sets the Marathi Standard 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	
	public void setStandardMarathi(int orgId,String columnName,String text,String voice,String fileName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="update mr_standard set "+columnName+" = '"+text+"',"+voice+"='"+filePath+"marathi/"+fileName+"' where org_id="+orgId;
		
		try {
			tts.convertText("marathi", text.getBytes("UTF-8"), filePath+"marathi/", fileName);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			DataService.runQuery(query);
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}		
	}
	
	
	
	/* Gets the Marathi Standard 
	 * IvrsMenuSettings.jsp
	 * 
	 */
	public String getStandardMarathi(int orgId,String columnName)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		
		String query="select "+columnName+" from mr_standard  where org_id="+orgId;
		System.out.println(query);
		String standardMarathi = "";
		try {
			ResultSet rs = DataService.getResultSet(query);
			if(rs.next()){
				standardMarathi = rs.getString(columnName);
				}
			connObj.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			connObj.rollback();
		}		
		return standardMarathi;
	}
}
