package com.iitb.GroupModel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.ArrayList;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.MysqlConnect;

public class GroupDetails {
	Connection connObj ;

	/*
	 * this method returns the details of all the groups to be displayed on Dashboard.jsp
	 * Dashboard.jsp 
	 * @author :
	 */
	public Object[][] getGroupDetails(String orgId) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;	       
		connObj.setAutoCommit(false);
		try
		{
			String query="SELECT * FROM `groups` WHERE org_id="+orgId+" and groups_id not in (0) ORDER BY groups_name ASC;";
			System.out.println(query);
			ResultSet rs=DataService.getResultSet(query);

			Object [][] groupDetails=DataService.getDataFromResultSet(rs);
			return groupDetails;
		}
		catch(SQLException e){
			e.printStackTrace();
			connObj.rollback();
			System.out.println("Rollback !!");

		}
		return null;
	}


	/*
	 * Method to change the groups of members from manage of the current group
	 * Manage.jsp -> Members tab
	 * @author:Teena Soni
	 */
	public Object[][] changeGroup(String groupId,String orgId) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] changeGroup=null;

		try {
			String query="SELECT groups_id,groups_name FROM `groups`where groups_id not in ("+groupId+") and org_id=("+orgId+")";
			System.out.print("query"+query);
			ResultSet rs= DataService.getResultSet(query);
			changeGroup= (Object[][]) DataService.getDataFromResultSet(rs);
			for(int i=0;i<changeGroup.length;i++)
			{
				System.out.print("coming in for loop"+changeGroup[i][1]);
			}
			connObj.commit();
			System.out.println("changegroup function finished!!");
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();

		}
		return changeGroup;
	}


	/* 
	 * Method to delete the group and all the members contained in it.
	 * Manage.jsp -> Settings tab
	 * @author:Teena Soni
	 */
	public void deleteGroup(String groupId) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Savepoint savepoint = connObj.setSavepoint("savepoint");

		String deleteGroupQuery="DELETE FROM `groups` WHERE groups_id="+groupId+";";
		String changeToParentGroup = "update member set groups_id=0 where groups_id="+groupId+";";	
		String query = "SELECT member_name FROM `member` where groups_id ="+groupId+";";
		try 
		{
			ResultSet rs = DataService.getResultSet(query);	
			String val = "";
			int totalCount = 0;int i = 0;

			while(rs.next()) 
			{
				String member =rs.getString("member_name");
				String query1 = "SELECT SUM(Count)as count from `member` where member_name='"+member+"';";
				ResultSet rs1 = DataService.getResultSet(query1);
				System.out.println("member"+member);
				while(rs1.next())
				{
					totalCount = rs1.getInt("count");
					System.out.println("totalcount"+totalCount);
					
					// if totalCount = 0
					// do nothing because member belongs to parent group
					if(totalCount > 1)
					{
						String deleteMemberQuery = "DELETE FROM `member` WHERE member_name='"+member+"';";
						DataService.runQuery(deleteMemberQuery);

					}
					else if(totalCount == 1)
					{
						DataService.runQuery(changeToParentGroup);
						String updateCountValue = "update member set Count=0 where member_name='"+member+"';";
						DataService.runQuery(updateCountValue);
					}
				}
			}
			DataService.runQuery(deleteGroupQuery);

			connObj.commit();
		}
		catch (SQLException e)
		{	
			e.printStackTrace();
			connObj.rollback(savepoint);
		}
	}



	/*
	 * This method returns the details of all the groups a member belongs to in GlobalGroupChange.jsp
	   The ArrayList so obtained contains two objects 1. list of group names of corresponding member
	                                                  2. list of group Id's of corresponding member
	 * GlobalGroupChange.jsp
	 * @author:Teena Soni
	 */
	public ArrayList<Object[][]> getGroupDetails(String orgId,Object[][] result) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);

		Object[][] groupNameList=new  Object[result.length][20];
		Object[][] groupIdList=new  Object[result.length][20];
		ArrayList<Object[][]> groupDetails = new ArrayList<Object[][]>();
		System.out.println(result.length);
		Integer len=result.length;
		try{
			Integer i=0;
			while(i<len){
				System.out.println(result[i][2]);
				String getBelongingGroupsList="SELECT DISTINCT groups.GROUPS_NAME, groups.GROUPS_ID FROM groups LEFT JOIN member "+" ON member.GROUPS_ID=groups.GROUPS_ID WHERE groups.org_id="+orgId+" AND member.member_number ="+ result[i][1];
				System.out.println("getBelongingGroupsList  "+getBelongingGroupsList);
				//Thread.currentThread();
				//Thread.sleep(50000);
				ResultSet rscheck=(ResultSet) DataService.getResultSet(getBelongingGroupsList);
				Integer j=0;
				while(rscheck.next())
				{

					groupNameList[i][j]=rscheck.getString("groups.GROUPS_NAME");
					groupIdList[i][j]=rscheck.getString("groups.GROUPS_ID");
					j++;
				}

				i++;

			}
			groupDetails.add(groupNameList);
			groupDetails.add(groupIdList);
			connObj.commit();

		}
		catch(Exception e){
			e.printStackTrace();
			//connObj.rollback(savepoint1);
			System.out.println("Query 1 and 2 both rolled back!!");
		} 

		return groupDetails;

	}

	// ManipulateGroups.jsp
	// This function displays all the group names to which the member selected does not belong to but wants to add.
	// @author:Teena Soni
	public Object[][] manipulateAdd(String memberNumber, String manipulate, String orgId) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] manipulateAdd=null;
		try {
			String getNotBelongingGroupsList="Select groups_name from groups where org_id="+orgId+" and groups_name not in (SELECT groups_name FROM member where member_number="+memberNumber+" ) and groups_id <> 0";
			System.out.println("getNotBelongingGroupsList   "+getNotBelongingGroupsList);
			ResultSet rs=(ResultSet) DataService.getResultSet(getNotBelongingGroupsList); 
			manipulateAdd=(Object[][])DataService.getDataFromResultSet(rs);
			connObj.commit();
		} catch (Exception e) {

			e.printStackTrace();
			connObj.commit();
		}
		return manipulateAdd;
	}

	/*
	 * ManipulateGroups.jsp
	 * This function displays all the group names to which the member selected belongs to but wants to delete.
	 * @author:Teena Soni
	 */
	public Object[][] manipulateDelete(String memberNumber, String manipulate, String orgId) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] manipulateDelete=null;
		try {
			String getBelongingGroupsList="Select groups_name from groups where org_id="+orgId+" and groups_name in (SELECT groups_name FROM member where member_number="+memberNumber+" ) and groups_id <> 0";
			System.out.println("getBelongingGroupsList   "+getBelongingGroupsList);
			ResultSet rs=(ResultSet)DataService.getResultSet(getBelongingGroupsList); 
			manipulateDelete=(Object[][])DataService.getDataFromResultSet(rs);
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
		return manipulateDelete;
	}


	/*
	 * This function adds the groups selected to be added to the member.
	 * GlobalGroupChange.jsp
	 * @author:Teena Soni
	 */
	public void addMultiGroups(String memberNumber,String[] groupsName) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		try {
			String findMemberInfo="select members_detail_id,member_name from member_details where member_number="+memberNumber;
			ResultSet ResSet=(ResultSet) DataService.getResultSet(findMemberInfo);
			while(ResSet.next()){
				String foundMemberId=ResSet.getString("members_detail_id");
				String memberName=ResSet.getString("member_name");
				//String member_name=ResSet.getString("member_name");
				for(int i=0;i<groupsName.length;i++){
					String getGroupsId="Select groups_id from groups where groups_name='"+groupsName[i]+"'";
					ResultSet rs =(ResultSet) DataService.getResultSet(getGroupsId);
					rs.next();
					String found_groups_id=rs.getString("groups_id");
					String insertMultiGroupsQuery="INSERT INTO `member`(`member_name`,`member_detail_id`,`member_number`,`groups_id`,`groups_name`)VALUES('"+memberName+"','"+foundMemberId+"','"+memberNumber+"','"+found_groups_id+"','"+groupsName[i]+"')";
					DataService.runQuery(insertMultiGroupsQuery);
					System.out.print(insertMultiGroupsQuery);
				}
			}
			String ifParent="select groups_id from member where member_number='"+memberNumber+"'and groups_id=0" ;
			ResultSet rsIfParent=(ResultSet) DataService.getResultSet(ifParent);
			if(rsIfParent.next())
			{
				String deleteParent="delete from member where member_number='"+memberNumber+"' and groups_id=0";
				DataService.runQuery(deleteParent);
			}
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}

	}


	/*
	 * This function counts the groups selected to be deleted from the groups a member belongs to.
	 * GlobalGroupChange.jsp
	 * @author:Teena Soni
	 */
	public ResultSet countGroups(String memberNumber) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		ResultSet groupCount=null;
		try {
			String sendToParent="SELECT COUNT('member_number') FROM member WHERE member_number='"+memberNumber+"'";
			System.out.println("sendToParent  "+sendToParent);
			groupCount=(ResultSet) DataService.getResultSet(sendToParent);
			connObj.commit();
			System.out.println("countgroups executed!!");
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
		return groupCount;
	}

	/* 
	 * After counting groups the delete function deletes those groups from the list.
	 * GlobalGroupChange.jsp -> delete tab
	 * @author:Teena Soni
	 */
	public void deleteFromGroup(String memberNumber,String[] inGroupsName,int i) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		try {
			String deleteFromGroups="delete from member where member_number='"+memberNumber+"' and groups_name='"+inGroupsName[i]+"'";
			DataService.runQuery(deleteFromGroups);
			System.out.print(deleteFromGroups);				
			System.out.print(inGroupsName.length);
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
	}

	
	/* 
	 * This function returns the details of the member of the group selected 
	 * Manage.jsp
	 * Multipart form type request.
	 * @author:Teena Soni
	 */
	public Object[][] manageSettings(String groupId) throws SQLException {
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		Object[][] settings=null;		
		try {
			String query="SELECT groups_name,LANGUAGE,delivery_type,backup_calls,allow_forwarding,email_id FROM groups WHERE groups_id = "+groupId;
			ResultSet rs = DataService.getResultSet(query);
			settings= (Object[][]) DataService.getDataFromResultSet(rs);
			connObj.commit();
		} catch (Exception e) {
			e.printStackTrace();
			connObj.rollback();
		}
		return settings;
	}

	/*
	 * This function updates the name of the current group and saves it permanently.
	 * Manage.jsp -> Settings tab
	 * @author:Teena Soni
	 */
	public void saveSettings(String groupsName,String groupId)
	{
		String queryToUpdateGroupName = "Update groups set groups_name='"+groupsName+"' where groups_id='"+groupId+"'";
		String query ="update member set groups_name='"+groupsName+"' where groups_id='"+groupId+"'";

		try 
		{
			DataService.runQuery(queryToUpdateGroupName);
			DataService.runQuery(query);
			System.out.println("SaveSettings function");
		} 
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	/*
	 * Method to check if any group is present or not.
	 * Void method Used for req_type newGroup.
	 * @author:Richa Nigam.
	 */
	public boolean groupAlreadyPresent(String groupName,String orgId) throws SQLException{
		String query="SELECT groups_name FROM groups WHERE LOWER(groups_name)=LOWER('"+groupName+"') AND org_id="+orgId+"";
		ResultSet rs=DataService.getResultSet(query);
		if(rs.next())
			return true;
		else 
			return false;
	}

	/* 
	 * Function to get Group name
	 * ViewPrintBill.jsp
	 * @author:Rasika Mohod
	 */
	public String getGroupName(String groupId) throws SQLException
	{
		connObj = MysqlConnect.getDbCon().conn;			        
		connObj.setAutoCommit(false);
		String GroupName=null;
		try
		{
			String getGroupNameQuery="Select groups_name from groups where groups_id="+groupId;
			ResultSet rs=DataService.getResultSet(getGroupNameQuery);
			rs.next();

			GroupName=rs.getString("groups_name");
			connObj.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			connObj.rollback();
		}
		return GroupName;
	}
	
		
		/*
		 * This method is used to change the group of a member from the current group selected.
		 * Manage.jsp
		 * 
		 * @author:Teena Soni
		 */
		 
		public void changeGroupLocal(String groupId,String[] selectedMembers,int i) throws SQLException
		{
			connObj = MysqlConnect.getDbCon().conn;			        
			connObj.setAutoCommit(false);
			try {
				//String query="update member set groups_id ='"+groupId+"' where member_id ='"+selectedMembers[i]+"' AND groups_name not in(select groups_name from member where groups_id ='"+groupId+"' ";
				String query="update member set groups_id ='"+groupId+"' where member_id="+selectedMembers[i];

				DataService.runQuery(query);
				System.out.println(query);
				connObj.commit();
			} catch (Exception e) {
				e.printStackTrace();
				connObj.rollback();
			}
		}
		
		// the below written method is unidentified currently on hold !!		
		
			// @author:Teena Soni
			public void changeGroupGlobal(String groupId,String[] selectedMembers,int i) throws SQLException
			{
				connObj = MysqlConnect.getDbCon().conn;			        
				connObj.setAutoCommit(false);
				try {
					String query="update member set groups_id ='"+groupId+"' where member_id="+selectedMembers[i];
					DataService.runQuery(query);
					System.out.println(query);
					connObj.commit();
				} catch (Exception e) {
					e.printStackTrace();
					connObj.rollback();
				}


			}
}
