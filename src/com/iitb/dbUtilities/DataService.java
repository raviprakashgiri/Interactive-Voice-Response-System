package com.iitb.dbUtilities;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import com.iitb.globals.ReadPropertyFile;
	public class DataService {
		
	    private static Connection con;
	    String data[][]=null;
	 
	    /**   create Database object   */
	    public DataService() {
	    }
	    /**
	     * to get a result set of a query
	     * @param query custom query
	     * @return a result set of custom query
	     * @throws SQLException throws an exception if an error occurs
	     */
	    public static ResultSet getResultSet(String query) throws SQLException {
	        con = MysqlConnect.getDbCon().conn;
	        ResultSet rs;
	        PreparedStatement st = con.prepareStatement(query);
	        rs = st.executeQuery();
	        return rs;
	    }
	 
	    /**
	     * to run an update query such as update, delete
	     * @param query custom query
	     * @throws SQLException throws an exception if an error occurs
	     */
	    public static int runQuery(String query) throws SQLException {
	        con = MysqlConnect.getDbCon().conn;
	        PreparedStatement st = con.prepareStatement(query);
	        int num = st.executeUpdate();
	        System.out.println("num  "+num);
	        return num;
	    }
	    
	    /**
	     * to get the ResultSet in the form of 2d Object array
	     * @param ResultSet custom ResultSet.
		*/
		public static Object[][] getDataFromResultSet(ResultSet rs) {
				Object[][] returnArray = null;
				int rowcount = 0;
				int colcount = 0;
				int rows = 0;

				try {
				
					if (rs.next()) {
						colcount = rs.getMetaData().getColumnCount();				
						rs.first();
						rs.last();
						rowcount = rs.getRow();
						rs.beforeFirst();
						returnArray = new Object[rowcount][colcount];

						while (rs.next()) {

							for (int k = 0; k < colcount; k++) {
								String ColmnName = rs.getMetaData().getColumnName(k+1);
								if(ColmnName.indexOf("blob")!=-1){
									if(rs.getBlob(k + 1)!=null){
										Blob blob = rs.getBlob(k + 1);
										byte[] bdata = blob.getBytes(1, (int) blob.length());
										String text = new String(bdata);
										returnArray[rows][k] = text;
									}else{
										returnArray[rows][k] = "";
									}
								}else{
									try{
										returnArray[rows][k] = rs.getObject(k + 1);
									}catch (Exception e) {
										System.out.println("");
									}
								}
							}
							rows++;
						}
					}

				} catch (SQLException ex) {
					
					System.out.println("Error"+ex);
				} catch (Exception ex) {
					System.out.println("error"+ex);

				} finally {
					

					if (rs != null) {
						try {
							rs.close();
						} catch (SQLException ex) {
							System.out.println("Can not close resultset"+ ex);
						}
					}
				}
				return returnArray;
			}
		
		/**
		 *  to replace all ' to '' for inserting data in a correct format.
		 *	@param ResultSet custom ResultSet.
		 */
		
		public String getQueryString(String Param){
			String returnString = "";
			returnString = Param.replaceAll("'", "''");
			return returnString;
		}
		/**
		 * To get the column count in a table
		 * @param tableName
		 * @return
		 */
		
		public int getColumnCount(String tableName){
			String query = "select * from "+tableName;
			int colCount=0;
			try {
				ResultSet rs = getResultSet(query);
				ResultSetMetaData md = rs.getMetaData();
				colCount = md.getColumnCount();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			return colCount;
		}
		public String[] getColumnNames(String tableName){
			String query = "select * from "+tableName;
			String colName="";
			String[] columnNames=null;
			int colCount = 0;
			try {
				ResultSet rs = getResultSet(query);
				ResultSetMetaData md = rs.getMetaData();
				colCount = getColumnCount(tableName);
				columnNames =new String[colCount];
				for(int i=0;i<colCount;i++){
				colName = md.getColumnName(i+1);
				columnNames[i]=colName;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return columnNames;
			
		}
		
/*
 * to find how many rows are there in resultset
 * 
 */
		public static int getRowCount(String query){
			int size = 0;
		    try {
		    	ResultSet resultSet = DataService.getResultSet(query);
		        resultSet.last();
		        size = resultSet.getRow();
		        resultSet.beforeFirst();
		    }
		    catch(Exception ex) {
		        return 0;
		    }
		    return size;
		}
}