package com.iitb.dbUtilities;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;

/**
 * @auhtor Sujen Shah
 * This class was created prior to DataService.
 * It provides the basic structure of the queries for inserting into member, group, publisher table.
 */
public class DataServiceConnect {

	private static final String NULL = null;

	public static void main(String[] args) {
		DataServiceConnect d=new DataServiceConnect();
		//d.insertIntoOrg("Test", "asd@gmail.com", "123123", "qwe", "qwe", "1111111111");
//		d.insertIntoGroups("Test", "1", NULL);
		d.insertIntoMembers("sujen", "9833149825", "2");
	}
	
	public DataServiceConnect(){
		
	}
	
	/**
	 * Basic query structure
	 * @param tableName
	 * @param columnTypes
	 * @param values
	 */
	private void insert(String tableName,String columnTypes,String values){
        try{
        
        String query="INSERT INTO `"+tableName+"` ("+columnTypes+") VALUES ("+values+");";
        System.out.println(query);
        DataService.runQuery(query);
            
        }catch(Exception e){
            System.err.println(e);
        }
    }
	
	/**
     * To insert into groups table
     * @param 
     * @return void
     * 
     */
    public void insertIntoGroups(String groupName,String orgId,String parent_groupID){
        String tableName="groups";
        String columnTypes="groups_name, org_id, parent_id";
        String values="'"+groupName+"',"+"'"+orgId+"',";
        if(parent_groupID!=null){
            values+="'"+parent_groupID+"'";
        }
        else{
            values+="NULL";
        }
        insert(tableName, columnTypes, values);
 
    }
    
    /**
     * To insert into organization table
     * @param 
     * @return void
     * 
     */
    public void insertIntoOrg(String orgName,String orgUsername,String orgPass, String org_fname,String org_lname, String org_mobile){
        String tableName="organization";
        String columnTypes="org_name, org_username, org_password, org_fname, org_lname, org_number";
        String values="'"+orgName+"',"+"'"+orgUsername+"','"+orgPass+"','"+org_fname+"','"+org_lname+"','"+org_mobile+"'";
//         System.out.println(values);
        
        insert(tableName, columnTypes, values);
 
    }
    /**
     * To insert into member table
     * @param 
     * @return void
     * 
     */
    public void insertIntoMembers(String mem_name,String mem_number, String group_id){
        String tableName="member";
        String columnTypes="member_name, member_number, groups_id";
        String values="'"+mem_name+"',"+"'"+mem_number+"','"+group_id+"'";
        insert(tableName, columnTypes, values);
    }
    
    /**
     * To insert into publisher table
     * @param 
     * @return void
     * 
     */
    public void insertIntoPublisher(String mem_name,String mem_number, String group_id){
        String tableName="publisher";
        String columnTypes="publisher_name, publisher_number, groups_id";
        String values="'"+mem_name+"',"+"'"+mem_number+"','"+group_id+"'";
        insert(tableName, columnTypes, values);
    }
    
    public void insertIntoPublisher(String mem_name,String mem_number) throws SQLException{
        String tableName="publisher";
        String columnTypes="publisher_name, publisher_number";
        String values="'"+mem_name+"',"+"'"+mem_number+"'";
        // Edited code!!
        // Adding multiple publishers with same number not allowed 
        // @author:Teena Soni
        String query="select * from publisher where publisher_number="+mem_number+" ";
        ResultSet rs=DataService.getResultSet(query);
        if(!rs.next())
        {
        	System.out.println("rs is not null");
        insert(tableName, columnTypes, values);
        }
    }
    
    
    /**
     * To update the settings of a particular group 
     * @param 
     * @return void
     * 
     */
    public void updateGroupSettings(String groups_id,String groups_name,String language,String delivery_type,String backup_calls,String allow_forwarding,String email_id,String welcome_message_name ){
    	String updateSettingQuery="UPDATE `groups` SET `groups_name` = '"+groups_name + "',"
    			+ "`language` = '"+language + "', `delivery_type` = "+delivery_type + ", `backup_calls` = "+backup_calls + ", "
    			+ "`allow_forwarding` = "+allow_forwarding + ", `email_id` = '"+email_id + "', `welcome_message_name` = '"+welcome_message_name + "'"
    			+ " WHERE groups_id="+groups_id+";";
    	System.out.println(updateSettingQuery);
    	try {
			DataService.runQuery(updateSettingQuery);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }
}
