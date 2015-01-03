package com.iitb.AuthenticatorModel;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.DataService;

/**
 * This class handles the user registration via SMS.
 * @author $ujen
 *
 */
public class UserRegistration {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	/**
	 * Accept and interpret the input message from the user
	 * @param user_number
	 * @param message
	 * @param time
	 * @throws Exception
	 */
	
public static void regUser(String userNumber, String message, String time) throws Exception {
		
	userNumber=userNumber.substring(2);
		
		String insertInboundSms="INSERT INTO user_registration(`user_number`,`user_message`,`sms_time`) values('"+userNumber+"','"+message+"','"+time+"')";
		DataService.runQuery(insertInboundSms);
		System.out.println("Insert query : "+insertInboundSms);
		
		/** Splitting the message based on the pre specified format and then interpreting  it **/
		String msgDetails[]=message.split(" ");
        String username=msgDetails[2];
        String groupsId=msgDetails[1];
        String orgAbb=msgDetails[0];
        orgAbb=orgAbb.toUpperCase();
        
        
        if(isInteger(groupsId)){
        if(msgDetails.length>3){
        	username+=" "+msgDetails[3];// to store surname
        }
        
        System.out.println("group_id"+ groupsId);
        System.out.println("org_abb"+ orgAbb);
        System.out.println("name"+ username);
        
		/**
		 * Getting the database of the Organization to which the member is to be added
		 */
		String getOrgQuery="SELECT org_database FROM organization WHERE org_abbreviation ='"+orgAbb+"';";
		ResultSet orgResult=DataService.getResultSet(getOrgQuery);
		if(orgResult.next()){
			String orgDB=orgResult.getString(1);
			System.out.print(orgDB);
			String membernumber="SELECT * FROM member_details WHERE member_number='"+userNumber+"' ";
    		System.out.println(membernumber);
    		ResultSet rs11=DataService.getResultSet(membernumber);
    		if(rs11.next()){
    			System.out.println(userNumber+" already registered");	
    		}
    		else{
			String insertMemberDetail="INSERT INTO `"+orgDB+"`.`member_details`(`member_name` , `member_number`)VALUES('"+username+"','"+userNumber+"')";
			DataService.runQuery(insertMemberDetail);
    		}
			String details ="SELECT * FROM `"+orgDB+"`.member WHERE groups_id='"+groupsId+"'&& member_number='"+userNumber+"';";
    		System.out.println(details);
    		ResultSet rs=DataService.getResultSet(details);
    		if(rs.next()){
    		
    		}
    		else{
    			String memberDetails="SELECT members_detail_id FROM `"+orgDB+"`.member_details WHERE member_number ='"+userNumber+"'";
        		System.out.println(memberDetails);
        		ResultSet result=DataService.getResultSet(memberDetails);
        		if(result.next()){
        			String members_detail_id=result.getString("members_detail_id");
        			System.out.println("member_detail_id=="+members_detail_id);
        			String getGroupName="SELECT groups_name FROM `"+orgDB+"`.groups WHERE groups_id='"+groupsId+"'";
        			ResultSet rs1=DataService.getResultSet(getGroupName);
        			if(rs1.next()){
        				String group_name=rs1.getString("groups_name");
			String insertMember="INSERT INTO `"+orgDB+"`.`member`(`member_name`,`member_number`,`groups_id`) VALUES('"+username+"','"+userNumber+"','"+groupsId+"')";
			
			try{
				DataService.runQuery(insertMember);
			}catch(com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException e){
				e.printStackTrace();
				System.out.println("User already registered"); // To check if the user is already registered
			}
			System.out.print("MEmber added to "+ orgDB +" group "+ groupsId);		
		}
		}}
        }else{
        	
        	msgDetails = message.split(" ");
        	username=msgDetails[1];
            //String groups_id=msgDetails[1];
        	orgAbb=msgDetails[0];
            orgAbb=orgAbb.toUpperCase();
        	
        	if(msgDetails.length>2){
        		username+=" "+msgDetails[2];// to store surname
             }
             
             //System.out.println("group_id"+ groups_id);
             System.out.println("orgAbb"+ orgAbb);
             System.out.println("name"+ username);
             
     		
     		String getOrgQuery1="SELECT org_database,org_id FROM organization WHERE org_abbreviation ='"+orgAbb+"';";
     		ResultSet orgResult1=DataService.getResultSet(getOrgQuery1);
     		if(orgResult1.next()){
     			String orgDB=orgResult1.getString(1);
     			String orgId=orgResult1.getString("org_database");
     			String insertMember="INSERT INTO `"+orgDB+"`.`member`(`member_name`,`member_number`,groups_id) VALUES('"+username+"','"+userNumber+"',0)";
     			System.out.println("insertMember  "+insertMember);
     			try{
    				DataService.runQuery(insertMember);
    			}catch(com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException e){
    				e.printStackTrace();
    				System.out.println("User already registered"); // To check if the user is already registered
    			}
    			System.out.print("MEmber added to "+ orgDB +" group "+ groupsId);		
     		}
        	
        	
        	
        }
	}
	}
	public static boolean isInteger(String str) {
	    try {
	        Integer.parseInt(str);
	        return true;
	    } catch (NumberFormatException nfe) {
	        return false;
	    }
	}

}
