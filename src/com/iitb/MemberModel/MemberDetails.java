package com.iitb.MemberModel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.KookooFunctionsTextToSpeechModel.*;
import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;

public class MemberDetails
{
	Connection connObj ;


	/*
	 * This method returns the members according to the group_id given in manage.jsp 
	 * should not be confused with method getMemberDetails which returns all the members of all the groups in GlobalGroupChange.jsp
	 * should not be confused with method getGroupDetails which returns groups of any member in GlobalGroupChange.jsp
	 * @author:Teena Soni
	 */
	public Object[][] getGroupMemberDetails(String groupId) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] members=null;
		try {
			//String query="SELECT member_id,member_name, member_number FROM `member` where groups_id='"+groupId+"';";
			String query="SELECT member.member_id ,member.MEMBER_NAME, member.MEMBER_NUMBER , member_details.MEMBER_ADDRESS FROM member LEFT JOIN member_details "+" ON member.MEMBER_DETAIL_ID=member_details.MEMBERS_DETAIL_ID where groups_id="+groupId+";";
			
			ResultSet rs=DataService.getResultSet(query);
			int membersCount = DataService.getRowCount(query);
			if(membersCount>0){
				members = (Object[][]) DataService.getDataFromResultSet(rs);
			}
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}

		return members;
	}

	/*
	 * This method checks if the new added number already exist . If exists it does not allow to add.
	 * Manage.jsp
	 * @author:Teena Soni
	 */
	public boolean checkMemberDetails(String memberNumber){
		try {
			String membernumber="SELECT * FROM member_details WHERE member_number='"+memberNumber+"' ";
			System.out.println(membernumber);
			ResultSet rs=DataService.getResultSet(membernumber);

			if(rs.next()){
				System.out.println("member is here "+true);
				return true;
			}
			else{

				System.out.println("member is here "+false);
				return false;
			} 
		}
		catch (SQLException e) {

			e.printStackTrace();
		}
		return false;
	}

	/*
	 * This method checks if the new added member name already exist . If exists it does not allow to add.
	 * Manage.jsp
	 * @author:Teena Soni
	 */
	public boolean checkMemberGroup(String groupId,String memberNumber){
		try{
			String details ="SELECT * FROM member WHERE groups_id='"+groupId+"'&& member_number='"+memberNumber+"';";
			System.out.println(details);
			ResultSet rs=DataService.getResultSet(details);
			if(rs.next()){
				return true;
			}
			else
				return false;
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}

	/*
	 * After checkMemberDetails and checkMemberGroup functions above it adds the member to the group
	 * Manage.jsp
	 * @author:Teena Soni
	 */
	public void addMember(String memberName,String memberNumber,String memberAddress,String memberEmailId,String orgId){
		try {
			String insertMemberDetails="INSERT INTO `member_details`(`member_name`,`member_number`,`member_address`,`member_email_id`,org_id) VALUES('"+memberName+"','"+memberNumber+"','"+memberAddress+"','"+memberEmailId+"','"+orgId+"')";
			System.out.println(insertMemberDetails);		
			DataService.runQuery(insertMemberDetails);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/*
	 * This method adds a new member in the group selected 
	 * Manage.jsp -> members tab
	 * @author:Teena Soni
	 */
	public boolean insertMemberintoGroup(String memberName,String memberNumber,String groupId){
		try{
			String memberDetails="SELECT members_detail_id FROM member_details WHERE member_number ='"+memberNumber+"'";
			System.out.println(memberDetails);
			ResultSet result=DataService.getResultSet(memberDetails);
			if(result.next()){
				String membersDetailsId=result.getString("members_detail_id");
				System.out.println("member_detail_id=="+membersDetailsId);
				String getGroupName="SELECT groups_name FROM groups WHERE groups_id='"+groupId+"'";
				ResultSet rs1=DataService.getResultSet(getGroupName);
				if(rs1.next()){
					String groupName=rs1.getString("groups_name");
					String insertMember="INSERT INTO `member`(`member_name`,`member_number`,`groups_id`,`member_detail_id`,`groups_name`) VALUES('"+memberName+"','"+memberNumber+"','"+groupId+"' ,'"+membersDetailsId+"','"+groupName+"')";
					System.out.println(insertMember);
					try{
						DataService.runQuery(insertMember);
						return true;

					}catch(com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException e){

						return false;
					}
				}
			}
		}
		catch(SQLException e){
			return false;
		}
		return false;
	}	

	/*
	 * This method checks the member details and whether login has been assigned !!
	 * GlobalGroupChange.jsp
	 * @author:Teena Soni
	 */
	public boolean updateMemberDetails(String memberName,String memberNumber,String memberId,String parentOrg,String username,String password,String userLogin){

		try{

			String createLoginQuery="INSERT INTO `organization`(`org_username`,`org_password`,`org_number`,`member_name`,`member_id`,`parent_org`) "
					+ "VALUES('"+username+"','"+password+"','"+memberNumber+"','"+memberName+"','"+memberId+"','"+parentOrg+"');";
			System.out.println(createLoginQuery);

			DataService.runQuery(createLoginQuery);
			String message="Your login credentials are \nusername: "+username+" \npassword: "+password;
			KooKooFunctions.sendSMS(memberNumber, message);
			return true;
		}

		catch(Exception e){
			e.printStackTrace();
			return false;
		}

	}
	/*
	 * This method after updates the member details and assigns login after check
	 * GlobalGroupChange.jsp
	 * @author:Teena Soni
	 */
	public void updateMember(String memberId,String memberName,String memberNumber,String memberAddress){
		try {
			String updateMemberDetailsQuery="UPDATE `member_details` SET `member_name` = '"+ memberName +"', `member_address` = '"+memberAddress+"' WHERE members_detail_id="+memberId+" and  `member_number` = '"+ memberNumber +"' ";
			//String helloquery="select * from member;";
			System.out.println(updateMemberDetailsQuery);
			//DataService.runQuery(helloquery);
			DataService.runQuery(updateMemberDetailsQuery);
			//System.out.println("Query ran..................!!!!!!!!!!!!!!!!!!!!!!");
			String updateMemberQuery = "UPDATE `member` SET `member_name` = '"+ memberName +"', `member_number` = '"+ memberNumber +"' WHERE member_detail_id="+memberId+";";
			System.out.println(updateMemberQuery);
			DataService.runQuery(updateMemberQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	/*
	 * This method gets the details of all the members in all the groups.
	 * GlobalGroupChange.jsp
	 * @author:Teena Soni
	 */
	public Object[][] getMemberDetails(String orgId,String groupId,String parentOrg) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		//savepoint1 = connObj.setSavepoint("Savepoint1");

		Object[][] result = null;


		try {

			String query="SELECT * from member_details where org_id="+orgId;
			System.out.println("query  "+query);
			ResultSet rs=(ResultSet) DataService.getResultSet(query);
			result = (Object[][]) DataService.getDataFromResultSet(rs);
			System.out.println(result[0][0]);

		} 

		catch (Exception e) {
			e.printStackTrace();
			//connObj.rollback(savepoint1);
		}
		return result;
	}

	/*
	 * This method is used to find the info of members in a group.
	 * deleting groups in GlobalGroupChange.jsp 
	 * @author:Teena Soni
	 */
	public void findMemberInfo(String memberNumber) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		try {
			String findMemberInfo="select members_detail_id,member_name from member_details where member_number="+memberNumber;
			ResultSet ResSet=DataService.getResultSet(findMemberInfo);
			ResSet.next();
			String foundmemberid=ResSet.getString("members_detail_id");
			String memberName=ResSet.getString("member_name");
			String insertToParentGroupsQuery="INSERT INTO `member` (`member_name`,`member_detail_id`,`member_number`,`groups_id`,`groups_name`) VALUES('"+memberName+"','"+foundmemberid+"','"+memberNumber+"','0','Parent')";
			DataService.runQuery(insertToParentGroupsQuery);
			System.out.print(insertToParentGroupsQuery+"   findmemberinfo completed");
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
	}

	/*
	 * Function to get all details of a member
	 * 
	 * @author:Rasika Mohod
	 */
	public Object[][] getMembersData(String groupsId) throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] MembersData = null;
		try 
		{
			String query="SELECT * FROM `member` where groups_id='"+groupsId+"';";
			ResultSet rs=DataService.getResultSet(query);
			MembersData=DataService.getDataFromResultSet(rs);

			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return MembersData;
	}
	/*
	 * returns member details of a particular group
	 * Upload.jsp
	 * @author: Nachiketh
	 */
	public Object[][] getMembers(String group_id)throws SQLException
	{
		Connection connObj ;
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		Object members[][] = null;
		try
		{
			String query="SELECT * FROM `member` where groups_id='"+group_id+"';";
            ResultSet rs1=DataService.getResultSet(query);
            members = DataService.getDataFromResultSet(rs1);
            connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		
				
		return members;
	}
}
