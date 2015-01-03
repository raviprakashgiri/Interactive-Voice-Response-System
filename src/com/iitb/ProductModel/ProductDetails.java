package com.iitb.ProductModel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;

public class ProductDetails
{
	
	Savepoint savepoint1;
						
	
		/* Returns product_name,product_price and product_id as a table
		 * ProcessOrEdit.jsp,GenetrateBill.jsp, ProductForm.jsp
		 * 
		 */
		public Object[][] getProductDetail() throws SQLException{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			try{
			String query = "SELECT * FROM `product_name` order by products_name";
			ResultSet resultSet = DataService.getResultSet(query);
			Object productName[][]=DataService.getDataFromResultSet(resultSet);
			return productName;
		}
		catch(SQLException e){
			e.printStackTrace();
			connObj.rollback();
			System.out.println("Rollback hua !");
			}
			return null;
		}
		/* Returns product_qty and product_qty_id as a table 
		 * GenerateBill.jsp,ProcessOrEdit.jsp,ProductForm.jsp
		 * @author:Rasika Mohod 
		 */
		public Object[][] getProductQuantityDetails() throws SQLException
		{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			try
			{
				String getQuansList = "Select * from product_quantity ORDER BY product_qty";
				ResultSet resultSetcheck2 = DataService.getResultSet(getQuansList);
				Object productQuan[][]=DataService.getDataFromResultSet(resultSetcheck2);
				
				return productQuan;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback();
			}
			return null;
		}
		/* Function to get count of product with prices
		 * GenerateBll.jsp,ProcessOrEdit.jsp 
		 * @author:Rasika Mohod
		 */
		public int countProducts() throws SQLException
	    {
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;			        
			connObj.setAutoCommit(false);
			int count=0;
			try
			{
				String query="select price from product_name";
				ResultSet resultSet=DataService.getResultSet(query);
				resultSet.last();
				count=resultSet.getRow();
				connObj.commit();
			}
			catch(Exception e)
			{
				e.printStackTrace();
				connObj.rollback();
			}
			return count;
	    }
		/* Function to get prices of products 
		 * GenerateBll.jsp,ProcessOrEdit.jsp 
		 * @author:Rasika Mohod 
		 */
		public int countPrice() throws SQLException
	    {
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;			        
			connObj.setAutoCommit(false);
			int count=0;
			try
			{
				String query="select price from product_name where price <> 'null'";
				ResultSet resultSet=DataService.getResultSet(query);
				resultSet.last();
				count=resultSet.getRow();
				
				connObj.commit();
			}
			catch(Exception e)
			{
				e.printStackTrace();
				connObj.rollback();
			}
			return count;
	    }
		/*
		 * Returns list of product names and their ids that have been processed
		 * OrderSummary.jsp , FullOrderSummary.jsp
		 * @author:Richa Nigam
		 */
		public Object[][] getProcessedProductList() throws SQLException
		{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			savepoint1=connObj.setSavepoint("savepoint1");
			try
			{
				String distinctPros = "Select DISTINCT product_name, product_id from processedOrder";
				ResultSet resultSet=DataService.getResultSet(distinctPros);
				Object data[][]=DataService.getDataFromResultSet(resultSet);
				return data;
			}
			catch(SQLException e){
				e.printStackTrace();
				connObj.rollback(savepoint1);
			}
			return null;
		}
		/* Returns an Object Array containing a list of units in which the products are sold
		 * OrderSummary.jsp , FullOrderSummary.jsp
		 * @author:Richa Nigam
		 */
		public Object[][] getProductQuantity()throws SQLException
		{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			try{
	
				String quantity = "Select Distinct product_quantity from processedOrder";
				ResultSet resultSet=DataService.getResultSet(quantity);
				Object productQuan[][]=DataService.getDataFromResultSet(resultSet);
				return productQuan;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback(savepoint1);
			}
			return null;
		}
		/* Updates product_qty in the product_quantity table
		 * ProductForm.jsp
		 * @author:Richa Nigam
		 */
		public void updateQuantity(String updateQuans[]) throws SQLException
		{
			Connection connObj;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			Savepoint savepoint1=connObj.setSavepoint("savepoint1");
			try
			{
				String getIds="Select product_qty_id from product_quantity ";
				ResultSet resultSet=DataService.getResultSet(getIds);
				Object quanIds[][]=DataService.getDataFromResultSet(resultSet);
				
				for(int i=0;updateQuans!=null && i<updateQuans.length;i++)
				{
					String updQuery="update product_quantity set product_qty='"+updateQuans[i]+"' where product_qty_id="+quanIds[i][0].toString();
					DataService.runQuery(updQuery);
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback(savepoint1);
			}
		}
		/* Inserts a new product_qty in the product_quantity table
		 * ProductForm.jsp
		 * @author:Richa Nigam
		 */
		public void insertQuantity(String productQuantity[])throws SQLException		
		{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			try
			{
				for(int k=0;productQuantity!=null && k<productQuantity.length;k++)
				{

					System.out.println(productQuantity[k]);
					String insertOrderQuery1="INSERT INTO product_quantity (product_qty) VALUES('"+productQuantity[k]+"')";
					System.out.print(insertOrderQuery1);

					DataService.runQuery(insertOrderQuery1);
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback();
			}
		}
		/* Deletes a  product_qty in the product_quantity table
		 * ProductForm.jsp
		 * @author:Richa Nigam
		 */
		public void deleteQuantity(String delQuans[]) throws SQLException
		{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			try
			{
				for(int i=0;delQuans!=null && i<delQuans.length;i++)
				{
				String delQuery="delete from product_quantity where product_qty_id="+delQuans[i];
				DataService.runQuery(delQuery);
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback();
			}
		}
		/* Updates product_price in product_name table
		 * ProductForm.jsp
		 * @author:Richa Nigam
		 */
		public void updatePrice(String updatePrice[], String updatePriceId[]) throws SQLException
		{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);

			Savepoint savepoint1=connObj.setSavepoint("savepoint1");
			try{
			for(int i=0;updatePrice!=null && i<updatePrice.length;i++){
				String updQuery="update product_name set price='"+updatePrice[i]+"' where product_id="+updatePriceId[i];
				System.out.println(updQuery);
				DataService.runQuery(updQuery);
			
			}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback(savepoint1);
			}
		}
		/* Updates product_name in product_name table
		 * ProductForm.jsp
		 * @author:Richa Nigam
		 */
		public void updateProduct(String updatePros[])throws SQLException 
		{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			Savepoint savepoint1=connObj.setSavepoint("savepoint1");
			try{
			String getIds="Select product_id from product_name ";
			ResultSet resultSet=DataService.getResultSet(getIds);
			Object productId[][]=DataService.getDataFromResultSet(resultSet);
			for(int i=0;updatePros!=null && i<updatePros.length;i++){
				String delQuery="update product_name set products_name='"+updatePros[i]+"' where product_id="+productId[i][0];
				System.out.println(delQuery);
				DataService.runQuery(delQuery);
				System.out.println(productId[i][0]);	
			}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback(savepoint1);
			}
		}
		/* Deletes product in product_name table
		 * ProductForm.jsp
		 * @author:Richa Nigam
		 */
		public void deleteProduct(String delPros[])throws SQLException
		{
			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			try{
				for(int i=0;delPros!=null && i<delPros.length ;i++)
				{
					String delQuery="delete from product_name where product_id="+delPros[i];
					DataService.runQuery(delQuery);
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback();
			}
		}

		/* Inserts product in product_name table 
		 * ProductForm.jsp
		 * @author:Richa Nigam
		 */
		public void insertProduct(String productsName[],String price[]) throws SQLException {

			Connection connObj ;
			connObj = MysqlConnect.getDbCon().conn;	       
			connObj.setAutoCommit(false);
			try{
				
			for(int i=0;productsName!=null && i<productsName.length;i++){
				System.out.println(productsName[i]);		
				String insertOrderQuery1="INSERT INTO product_name (products_name,price) VALUES('"+productsName[i]+"','"+price[i]+"')";
				System.out.print(insertOrderQuery1);
				DataService.runQuery(insertOrderQuery1);
			}

			}
			catch(SQLException e)
			{
				e.printStackTrace();
				connObj.rollback();
			}
		}
}

