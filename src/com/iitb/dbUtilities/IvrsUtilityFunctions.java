package com.iitb.dbUtilities;

import java.util.Collections;

import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


import com.iitb.dbUtilities.DataService;

/**
 * @author T Sravan Kumar 
 * To get the values from ivrs database based on given
 *         input.
 */
public class IvrsUtilityFunctions {
	/**
	 * @author T Sravan Kumar 
	 *
	 */
	private String[] getGroupIdsFromCallerId(String callerId) {
		ResultSet rs;
		String[] data = null;
		String query = "SELECT groups_id FROM member WHERE member_number ="
				+ callerId;

		try {
			System.out.println(query);
			rs = DataService.getResultSet(query);
			int rows = getRows(rs);
			data = new String[rows];
			int i = 0;
			while (rs.next()) {
				data[i] = rs.getString("groups_id");
				i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return data;
	}

	private ArrayList<Date> getLatestBroadcast(String[] groupIds) throws SQLException {
		ResultSet rs;
		ArrayList<Date> al = new ArrayList<Date>();
		Timestamp timestamp = null;
		String query = "";
		for (int i = 0; i < groupIds.length; i++) {
			query = "Select timestamp,groups_id from latest_broadcast where groups_id = "
					+ groupIds[i];
			rs = DataService.getResultSet(query);
			System.out.println(query);
			while (rs.next()) {
				System.out.println("working");
				timestamp = rs.getTimestamp("timestamp");
				al.add(new Date(timestamp.getTime()));
			}
		}
		if(!al.equals(null)){
		Collections.sort(al);
		}
		return al;
	}
	/**
	 * @author T Sravan Kumar 
	 * 
	 */
	private String[] getLatestBroadcastGroupId(ArrayList<Date> broadcastList)
			throws SQLException {
		String[] a = new String[2];
		Date d = null;
		String LatestBroadcastTime;
		ResultSet rs = null;
		String query = "select groups_id,broadcast_location from latest_broadcast where timestamp = '";
		if (!broadcastList.isEmpty()) {
			d = broadcastList.get(broadcastList.size() - 1);
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			LatestBroadcastTime = sdf.format(d);
			rs = DataService.getResultSet(query + LatestBroadcastTime+ "'");
		}
		if (rs.next()) {
			a[0] = rs.getString("groups_id");
			a[1] = rs.getString("broadcast_location");
		}else {
			a=null;
		}
		return a;

	}
	/**
	 * @author T Sravan Kumar 
	 * To get LatestBroadcast message and that particular groupId 
	 * Input callerId of the member.
	 * output String 1d array.
	 */
	private String[] getLatestBroadcastMessageGroupIdFromCallerId(String callerId)
			throws SQLException {

		String[] groupsIds = getGroupIdsFromCallerId(callerId);
		ArrayList<Date> al = null;
		String[] result = null;
		if(!groupsIds.equals(null)){
		 al = getLatestBroadcast(groupsIds);
		}
		if(!al.equals(null)){
		result = getLatestBroadcastGroupId(al);
		}
		if(result.equals(null)){
			result[0] = "No Latest Broadcast message";
		}
		
		return result;
	}
	/**
	 * @author T Sravan Kumar 
	 * No. of rows present in the resultset will be populated.
	 * input ResultSet Object.
	 * output int.
	 */
	public int getRows(ResultSet res) {
		int totalRows = 0;
		try {
			res.last();
			totalRows = res.getRow();
			res.beforeFirst();
		} catch (Exception ex) {
			return 0;
		}
		return totalRows;
	}
	/**
	 * @author T Sravan Kumar 
	 * Group id of the member and latest broadcast message will be output.
	 * input Caller Id as String(member's phone number).
	 * output String type.
	 */
	public String getGroupsIdBroadcastMessageFromCallerId(String callerId){
		ArrayList<Date> al = new ArrayList<Date>();
		Date d = null;
		String groupId = "";
		String broadcast_location = "";
		String result ="";
		String queryToGetGroupIds = "SELECT groups_id FROM member WHERE member_number ='"+callerId+"'";
		
		ResultSet rs = null;
		try {
			rs = DataService.getResultSet(queryToGetGroupIds);
			System.out.println("queryToGetGroupIds  "+queryToGetGroupIds);
		} catch (SQLException e) {
			System.out.println("The member does not exists in Member Table.");
			e.printStackTrace();
		}
		int sizeOfArray  = getRows(rs);
		String[] groupsIds = new String[sizeOfArray];
		int i=0;
		try {
			while(rs.next()){
				groupsIds[i]=rs.getString("groups_id");
				i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		if(!groupsIds.equals(null)){
			String queryToGetLatestBroadCast;
			for(i=0;i<groupsIds.length;i++){
				queryToGetLatestBroadCast= "Select timestamp,groups_id from latest_broadcast where groups_id = "+groupsIds[i];
				try {
					rs = DataService.getResultSet(queryToGetLatestBroadCast);
					System.out.println("queryToGetLatestBroadCast  "+queryToGetLatestBroadCast);
					if(rs.next()){
						al.add(new Date(rs.getTimestamp("timestamp").getTime()));
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
		}
		if(!al.equals(null) && !al.isEmpty()){
			Collections.sort(al);
			d = al.get(al.size() - 1);
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String LatestBroadcastTime = sdf.format(d);
			String getGroupId = "select groups_id,broadcast_location from latest_broadcast where timestamp = '"+LatestBroadcastTime+"'";
			try {
				System.out.println("getGroupId  "+getGroupId);
				rs = DataService.getResultSet(getGroupId);
				if(rs.next()){
					groupId = rs.getString("groups_id");
					broadcast_location = rs.getString("broadcast_location");
				}
				result = groupId+","+broadcast_location;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(groupId.equals("") && broadcast_location.equals("")){
			result = "0,No broadcast message";
		}
		
		return result;
		
	}
	/**
	 * @author T Sravan Kumar 
	 * Group ids of the member and latest broadcast messages will be output..
	 * input Caller Id as String(member's phone number).
	 * output String 2d array.(acolumn for groupids and another for latest broadcast message of that particular group)
	 */
	public String[][] getLatestBroadcastList(String callerId){
		String[][]  result = null;// = new String[][];
		ArrayList<Date> al = new ArrayList<Date>();
		String queryToGetGroupIds = "SELECT groups_id FROM member WHERE member_number ='"+callerId+"'";
		
		ResultSet rs = null;
		try {
			rs = DataService.getResultSet(queryToGetGroupIds);
			System.out.println("queryToGetGroupIds  "+queryToGetGroupIds);
		} catch (SQLException e) {
		
			System.out.println("The member does not exists in Member Table.");
			e.printStackTrace();
		}
		int sizeOfArray  = getRows(rs);
		String[] groupsIds = new String[sizeOfArray];
		int i=0;
		try {
			while(rs.next()){
				groupsIds[i]=rs.getString("groups_id");
				i++;
			}
		} catch (SQLException e) {
				e.printStackTrace();
		}
		
		
		if(!groupsIds.equals(null)){
			String queryToGetLatestBroadCast;
			for(i=0;i<groupsIds.length;i++){
				queryToGetLatestBroadCast= "Select timestamp ,groups_id from latest_broadcast where groups_id = "+groupsIds[i];
				try {
					rs = DataService.getResultSet(queryToGetLatestBroadCast);
					System.out.println("queryToGetLatestBroadCast  "+queryToGetLatestBroadCast);
					if(rs.next()){
						al.add(new Date(rs.getTimestamp("timestamp").getTime()));
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		
		
	}
		if(!al.equals(null) && !al.isEmpty()){
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String LatestBroadcastTime;
			String query = "";
			Collections.sort(al);
			Collections.reverse(al);
			Date[] timesArray = al.toArray(new Date[al.size()]);
			System.out.println("bar.length = " + timesArray.length);
			result = new String[timesArray.length][2];
			
			for(i=0;i<timesArray.length;i++){
				LatestBroadcastTime = sdf.format(timesArray[i]);
				System.out.println("LatestBroadcastTime  "+LatestBroadcastTime);
				
				query = "Select groups_id,broadcast_location from latest_broadcast where timestamp='"+LatestBroadcastTime+"'";
				try {
					rs = DataService.getResultSet(query);
					
					
					System.out.println("query "+query);
					int r;
					while(rs.next()){
						r=0;
						System.out.println("result["+i+"]["+r+"] :"+rs.getString(1));
						result[i][r] = rs.getString(1);
						r++;
						System.out.println("result["+i+"]["+r+"] :"+rs.getString(2));
						result[i][r] = rs.getString(2);
						}
					
				} catch (SQLException e) {
					e.printStackTrace();
				
				System.out.println(query);
				System.out.println(timesArray[i]);
			}
		}
		}
		return result;
	
	}

}
