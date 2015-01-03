package com.iitb.OrderModel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;

public class OrderModel
{
	
	/* Function to Process Order directly from Accepted orders
	 * GenerateBill.jsp
	 * 
	 */
	public void processOrder(String messageId,String boughtProductName,String boughtProductIds,String boughtProductQuantity,String boughtProductPrice,String productPrice) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
		try
		{
			Integer i;
			
			String timestamp="Select timestamp from message where message_id="+messageId;
			ResultSet getDate=DataService.getResultSet(timestamp);
			getDate.next();
			
			String dateIs=getDate.getString("timestamp");
			
			String[] boughtProductNameArray= boughtProductName.split(",");
			String[] productPriceArray=productPrice.split(",");
			String[] boughtProductIdsArray= boughtProductIds.split(",");
			String[] boughtProductQuantityArray= boughtProductQuantity.split(",");
			String[] boughtProductPriceArray= boughtProductPrice.split(",");
			
			String insertBillId="Insert into bill_id (msg_id) values('"+messageId+"')";
			DataService.runQuery(insertBillId);
			
			for(i=1;i<boughtProductNameArray.length;i++)
			{
				String query="insert into processedOrder values ('"+messageId+"','"+boughtProductIdsArray[i]+"','"+boughtProductNameArray[i]+"','"+boughtProductQuantityArray[i]+"','"+boughtProductPriceArray[i]+"','"+productPriceArray[i]+"','"+dateIs+"')";
				DataService.runQuery(query);
			}
			
			String updateStatus="update message set status_id=5 where message_id="+messageId;
			DataService.runQuery(updateStatus);
			
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
    }
	/* Function to Save Order from Accepted Order
	 * GenerateBill.jsp
	 * 
	 */
	public void saveOrder(String messageId,String groupId,String boughtProductName,String boughtProductIds,String boughtProductQuantity,String boughtProductPrice,String productPrice) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
		try
		{
			Integer i;
			
			String timestamp="Select timestamp from message where message_id="+messageId;
			ResultSet getDate=DataService.getResultSet(timestamp);
			getDate.next();
			
			String dateIs=getDate.getString("timestamp");
			
			String[] boughtProductNameArray= boughtProductName.split(",");
			String[] productPriceArray=productPrice.split(",");
			String[] boughtProductIdsArray= boughtProductIds.split(",");
			String[] boughtProductQuantityArray= boughtProductQuantity.split(",");
			String[] boughtProductPriceArray= boughtProductPrice.split(",");
			
			for(i=1;i<boughtProductNameArray.length;i++)
			{
				String query="insert into processedOrder values ('"+messageId+"','"+boughtProductIdsArray[i]+"','"+boughtProductNameArray[i]+"','"+boughtProductQuantityArray[i]+"','"+boughtProductPriceArray[i]+"','"+productPriceArray[i]+"','"+dateIs+"')";
				DataService.runQuery(query);
			}
			
			String updateStatus="update message set status_id=4 where message_id="+messageId;
			DataService.runQuery(updateStatus);

			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
    }
	/* Function to Edit or Save Order from Saved Order
	 * GenerateBill.jsp
	 * 
	 */
	public void editSaveOrder(String messageId,String groupId,String boughtProductName,String boughtProductIds,String boughtProductQuantity,String boughtProductPrice,String productPrice) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
		try
		{
			Integer i;
			String timestamp="Select timestamp from message where message_id="+messageId;
			ResultSet getDate=DataService.getResultSet(timestamp);
			getDate.next();
			String dateIs=getDate.getString("timestamp");
			
			String[] boughtProductNameArray= boughtProductName.split(",");
			String[] productPriceArray=productPrice.split(",");
			String[] boughtProductIdsArray= boughtProductIds.split(",");
			String[] boughtProductQuantityArray= boughtProductQuantity.split(",");
			String[] boughtProductPriceArray= boughtProductPrice.split(",");
			
			String query="delete from processedOrder where message_id="+messageId;
			DataService.runQuery(query);
			
			for(i=1;i<boughtProductNameArray.length;i++)
			{
				String queryInsert="insert into processedOrder values ('"+messageId+"','"+boughtProductIdsArray[i]+"','"+boughtProductNameArray[i]+"','"+boughtProductQuantityArray[i]+"','"+boughtProductPriceArray[i]+"','"+productPriceArray[i]+"','"+dateIs+"')";
				DataService.runQuery(queryInsert);
			}
			
			String updateStatus="update message set status_id=4 where message_id="+messageId;
			DataService.runQuery(updateStatus);
			
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
    }
	/* Function to Process Final Order from Saved Order to Processed Order
	 * ProcessOrEdit.jsp 
	 * 
	 */
	public void processFinalOrder(String messageId,String groupId,String boughtProductName,String boughtProductIds,String boughtProductQuantity,String boughtProductPrice,String productPrice) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");
		try
		{
			Integer i;
			
			String timestamp="Select timestamp from message where message_id="+messageId;
			ResultSet getDate=DataService.getResultSet(timestamp);
			getDate.next();
			String dateIs=getDate.getString("timestamp");

			String[] boughtProductNameArray= boughtProductName.split(",");
			String[] productPriceArray=productPrice.split(",");
			String[] boughtProductIdsArray= boughtProductIds.split(",");
			String[] boughtProductQuantityArray= boughtProductQuantity.split(",");
			String[] boughtProductPriceArray= boughtProductPrice.split(",");
			
			String query="delete from processedOrder where message_id="+messageId;
			DataService.runQuery(query);
			
			for(i=1;i<boughtProductNameArray.length;i++)
			{
				String queryInsert="insert into processedOrder values ('"+messageId+"','"+boughtProductIdsArray[i]+"','"+boughtProductNameArray[i]+"','"+boughtProductQuantityArray[i]+"','"+boughtProductPriceArray[i]+"','"+productPriceArray[i]+"','"+dateIs+"')";
				DataService.runQuery(queryInsert);
			}
			
			String updateStatus="update message set status_id=5 where message_id="+messageId;
			DataService.runQuery(updateStatus);
			
			String insertBillId="Insert into bill_id (msg_id) values('"+messageId+"')";
			DataService.runQuery(insertBillId);
			
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
    }
	/* Returns a 2D Object Array where 1st index corresponds to a product and 2nd index corresponds to unit quantity
	 * OrderSummary.jsp and FullOrderSummary.jsp
	 * 
	 */
	public Object[][] getTotalUnitSold(String fromDate,String toDate,Object product[][],Object quantity[][])throws SQLException{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		
		try{

			Integer i;
			Integer j;
			System.out.println("Finding total unit sold");


			System.out.println("Products : "+product.length);
			System.out.println("Quantities : "+quantity.length);
			Object totalUnitSold[][]=new Object[product.length][quantity.length];
			for(j=0;j<product.length;j++){
				for(i=0;i<quantity.length;i++){

					String getQuantity = "Select COUNT(product_quantity)as tot from processedOrder where product_quantity='"
							+ quantity[i][0].toString()
							+ "'and product_id='"
							+ product[j][1].toString()
							+ "' and (ordertime >='"
							+ fromDate + " 00:00:00' and ordertime <='" + toDate + " 23:59:59') and product_name='"+product[j][0].toString()+"' and message_id in (Select message_id from message where status_id=5)";
					ResultSet rs=DataService.getResultSet(getQuantity);
					totalUnitSold[j][i]=DataService.getDataFromResultSet(rs)[0][0];
					System.out.println(totalUnitSold[j][i]);
				}
			}
			return totalUnitSold;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			connObj.rollback();
			// savepoint nt done
		}
		return null;
	}
	/* 
	 * The method calculates the total quantity of a each product sold.
	 * OrderSUmmary.jsp and FullOrderSummary.jsp
	 * 
	 */
	public Float[] getTotalQuanitySold(String fromDate,String toDate,Object totalUnitSold[][],Object quantity[][])throws SQLException
	{
		Connection connObj;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		try
		{
			Integer i;Integer j;
			Float totalQuantitySold[]=null;
			totalQuantitySold=new Float[totalUnitSold.length];
			for(j=0;j<totalUnitSold.length;j++)
			{
				totalQuantitySold[j]=0.0f;
				for(i=0;i<quantity.length;i++)
				{
					totalQuantitySold[j]=totalQuantitySold[j]+Float.parseFloat(totalUnitSold[j][i].toString())*Float.parseFloat(quantity[i][0].toString());
				}
			}
			return totalQuantitySold;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();//savepoint;
		}
		return null;

	}
	/* Function to get saved orders to print bill
	 * ViewPrintBill.jsp
	 * 
	 */
	public Object[][] getSavedOrder(String messageId) throws SQLException
    {
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] savedOrder=null;
		try
		{
			String query="Select * from processedOrder where message_id="+messageId;
			ResultSet rs=DataService.getResultSet(query);
			savedOrder=DataService.getDataFromResultSet(rs);
			
			connObj.commit();
			return savedOrder;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
			return null;
		}
    }
}
