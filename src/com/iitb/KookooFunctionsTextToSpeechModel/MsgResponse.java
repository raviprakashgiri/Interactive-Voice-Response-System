package com.iitb.KookooFunctionsTextToSpeechModel;

import java.sql.ResultSet;

import com.iitb.dbUtilities.DataService;

public class MsgResponse {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	public static void storeResponse(String number , String msg ,String Groups_id){
		
		try {
			
			ResultSet rs = DataService.getResultSet("SELECT member_name from member_details where member_number="
					+ number + ";");
			if (rs.next()){
				
				//String groups_id = rs.getString(1);
				String member_name=rs.getString(1);
				System.out.println(member_name);
				ResultSet rs1 =DataService.getResultSet("SELECT member_response from response WHERE member_number="+number+" && group_id="+Groups_id);
				if(rs1.next()){
					String mem_response=rs1.getString(1);
					String updateQuery =("update response set member_response='"+msg +"' where member_number="+number+"&& group_id="+Groups_id);
					System.out.println(updateQuery);
					DataService.runQuery(updateQuery);
							
				}
				else{
					String insertOrderQuery = "INSERT INTO response(member_name, member_number,member_response,group_id) VALUES('"
							+ member_name
							+ "','"
							+ number
							+ "','"
							+ msg
							+ "','"
							+Groups_id
							+"');";
					System.out.println(insertOrderQuery);
					DataService.runQuery(insertOrderQuery);
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
			
		}
	}

}
