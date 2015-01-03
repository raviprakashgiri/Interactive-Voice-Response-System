package com.iitb.Controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.iitb.GroupBean.GroupBean;
import com.iitb.dbUtilities.DataService;

/**
 * Servlet implementation class IVRSDataServlet
 * This servlet is used to provide data to the tables in the reports, view all group activities.
 * It sends data in JSON format. 
 * This enables implementation of DataTables.
 * To understand this class please refer docs at http://datatables.net/release-datatables/examples/data_sources/js_array.html
 */
public class IVRSDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IVRSDataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("hi");
		String req_type=request.getParameter("req_type");
		System.out.println("req_type :"+req_type);
		String dataTable=request.getParameter("dataTable");
		String responseData="";
		
		if(dataTable.equalsIgnoreCase("true")){
			String org_id=request.getParameter("org_id");
			
			String getMessagesQuery="";
			if(req_type.equalsIgnoreCase("inbox")){
			 getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,date_format(`timestamp`,'%d-%m-%y' '||%r'),message_id,groups.groups_name FROM `message`"
	        		+ " JOIN groups ON groups.groups_id=message.groups_id and groups.org_id='"+org_id+"' and ( message.status_id='0' OR message.status_id='3') "
	        				+ "ORDER BY message.`timestamp` DESC ;";
			System.out.println(getMessagesQuery);
			}
			else if(req_type.equalsIgnoreCase("accepted")){
				 getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,date_format(`timestamp`,'%d-%m-%y' '||%r'),message_id,groups.groups_name FROM `message`"
		        		+ " JOIN groups ON groups.groups_id=message.groups_id and groups.org_id='"+org_id+"' and message.status_id='1' "
		        				+ "ORDER BY message.`timestamp` DESC  ;";
				System.out.println(getMessagesQuery);		
			}
			
			else if(req_type.equalsIgnoreCase("rejected")){
				 getMessagesQuery="SELECT `message_location`,`member_number`,`status_id`,`comments`,date_format(`timestamp`,'%d-%m-%y' '||%r'),message_id,groups.groups_name FROM `message`"
		        		+ " JOIN groups ON groups.groups_id=message.groups_id and groups.org_id='"+org_id+"' and message.status_id='2' "
		        				+ "ORDER BY message.`timestamp` DESC  ;";
				System.out.println(getMessagesQuery);		
			}
			
			ResultSet rs;
			try {
				rs = DataService.getResultSet(getMessagesQuery);
				responseData=getJSONEncodedString(request, rs);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(req_type.equalsIgnoreCase("broadcast")){
				getMessagesQuery="SELECT `broadcast_location`,`publisher_number`,date_format(`timestamp`,'%d-%m-%y' '||%r'),groups.groups_name,groups.groups_id FROM `broadcast`"
		        		+ " JOIN groups ON groups.groups_id=broadcast.groups_id and groups.org_id='"+org_id+"' "
		        		+ "ORDER BY broadcast.`timestamp` DESC;";
				try {
					rs = DataService.getResultSet(getMessagesQuery);
					responseData=getJsonEncodedStringForBroadcastMsg(request, rs);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
			
		}
		
		else if(req_type.equalsIgnoreCase("report")){
			String report_type=request.getParameter("report_type");
			String grp_id = request.getParameter("group_id");
			GroupBean groupBean =new GroupBean();
			groupBean.setGroups_id(grp_id);
			System.out.println("group_id set in ivrsdataservlet "+groupBean.getGroups_id());
			responseData=getReports(request, report_type);
			request.setAttribute("groupBean",groupBean);
			RequestDispatcher rd=request.getRequestDispatcher("Manage.jsp");  
	        rd.forward(request, response);
		}
	    response.getWriter().write(responseData);
	    
		
	}
	
	

	
	
	
	private String getJSONEncodedString(HttpServletRequest request, ResultSet rs){
		String jsonEncodedString="";
		
		JSONArray FinalList = new JSONArray();
		
		try {
			while(rs.next()){
				String groupName=rs.getString(7);
		        String dateTime=rs.getString(5);
		        String msgURL=rs.getString(1);
		        String member_number=rs.getString(2);
		        String comments=rs.getString(4);
		        String message_id=rs.getString(6);
		        String status_id=rs.getString(3);
		        String getMemberNameQuery="SELECT  member_name FROM member where member_number="+member_number+";";
		        ResultSet memberNameQueryResult=DataService.getResultSet(getMemberNameQuery);
		        String member_name=member_number;
		        if(memberNameQueryResult.next()){
		        member_name=memberNameQueryResult.getString(1);
		        }
		        String status="";
		        if(status_id.equalsIgnoreCase("3")){
		        	status="Cancelled";
		        }
				
		        String playAudioString="<audio controls><source src=\""+msgURL+"\" type=\"audio/wav\"></source><p>Your browser does not support this audio format.</p></audio>";
		        JSONArray dataRow = new JSONArray(); // This records each row of the returned resultset
		        dataRow.add(dateTime);
		        dataRow.add(groupName);
		        dataRow.add(message_id);
		        dataRow.add(member_name);
		        dataRow.add(playAudioString);
		        dataRow.add(status);
		        dataRow.add(comments);
		        
		        FinalList.add(dataRow);
			}
			jsonEncodedString=FinalList.toJSONString();
			System.out.println("JSON STRING : "+jsonEncodedString);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error is here::::::::::::::::::::::");
			e.printStackTrace();
		}
		
		return jsonEncodedString;
				
	}

	private String getJsonEncodedStringForBroadcastMsg(HttpServletRequest request, ResultSet rs) throws SQLException {
		
		String jsonEncodedString="";
		
		JSONArray FinalList = new JSONArray();
		while(rs.next()){
	        String groupName=rs.getString(4);
	        String dateTime=rs.getString(3);
	        String msgURL=rs.getString(1);
	        String publisher_number=rs.getString(2);
	        String groupsId = rs.getString(5);
	        String getpublisherNameQuery="SELECT  member_name FROM member where member_number="+publisher_number+";";
	        ResultSet publisherNameQueryResult=DataService.getResultSet(getpublisherNameQuery);
	        String publisher_name=publisher_number;
	        if(publisherNameQueryResult.next()){
	        	publisher_name=publisherNameQueryResult.getString(1);
	        }
	       
	        String playAudioString="<audio controls><source src=\""+msgURL+"\" type=\"audio/wav\"></source><p>Your browser does not support this audio format.</p></audio>"
	        		+ "";
	           
	        String broadcast="<button onclick=\"broadcastCall('"+groupsId+"','"+msgURL+"','"+publisher_number+"');\">Broadcast</button>";
	        String url="<a href=\""+msgURL+"\" target=\"_blank\" title=\"Right Click Save Link as\">Download</a>";
	        JSONArray dataRow = new JSONArray(); // This records each row of the returned resultset
	        dataRow.add(dateTime);
	        dataRow.add(groupName);
	        dataRow.add(publisher_name);
	        dataRow.add(playAudioString);
	        dataRow.add(url);
	        dataRow.add(broadcast);
	       
	        FinalList.add(dataRow);
	     }
		jsonEncodedString=FinalList.toJSONString();
		return jsonEncodedString;
	}

	private String getReports(HttpServletRequest request,	String report_type){
		String JsonString="";
		String group_id=request.getParameter("group_id");
		
		try{
		
			JSONArray FinalList=new JSONArray();
			if(report_type.equalsIgnoreCase("incoming-calls")){
			String getIncomingCallLogQuery="SELECT `caller_id`,`member_id`,`time` FROM `incoming_call` where groups_id="+group_id+"  ORDER BY time DESC LIMIT 10;"; 
	    	
				ResultSet getIncomingCallLog=DataService.getResultSet(getIncomingCallLogQuery);
				
				while(getIncomingCallLog.next()){
					String caller_id=getIncomingCallLog.getString(1);
		    		String member_id=getIncomingCallLog.getString(2);
		    		String timestamp=getIncomingCallLog.getString(3);
		    		String memberName="";
		    		
		    		String getMemberNameQuery="SELECT `member_name` FROM `member` where member_id="+member_id+";";
		    		ResultSet getMemberName=DataService.getResultSet(getMemberNameQuery);
		    		if(getMemberName.next()){
		    			memberName=getMemberName.getString(1);
		    		}
		    		getMemberName.close();
		    		
		    		JSONArray data=new JSONArray();
		    		data.add(timestamp);
		    		data.add(memberName);
		    		data.add(caller_id);
				}
				JsonString=FinalList.toJSONString();				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return JsonString;
	}
}

