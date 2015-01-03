/*
 * NAMING CONVENTIONS :
 * 
 * Variables in Beans		: The variable name is separated with underscore "_". eg. Object [][] group_details;
 * All other variables		: The variable name is in camelCase .eg. String memberName;
 * Methods in Models		: The method name is in camelCase .eg. public void deleteGroups();
 * Object of a java class	: The object declaration is in camelCase .eg. GroupBean groupBean=new GroupBean();
 * All req_type values		: The req_type variable has value in camelCase eq: req_type.equals("globalGroupChange");
 * 
 * COMMENT CONVENTION :
 * 
 * For each req_type in IvrsServlet the comments correspond to the following order:
 * 		PURPOSE : 
 * 		VIEW	: 
 * 		MODEL	: 
 * 		BEAN	: 
 * 
 * For each method in all Models the comments correspond to the following order:
 * 		PURPOSE : 
 * 		VIEW	:	
 */
package com.iitb.Controller;


//import VoiceMessages;

import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javazoom.upload.MultipartFormDataRequest;

import com.iitb.dbUtilities.DataService;
import com.iitb.dbUtilities.DataServiceConnect;
import com.iitb.globals.*;
import com.iitb.EmailModel.MailModel;
import com.iitb.GroupModel.*;
import com.iitb.GroupBean.*;
import com.iitb.AuthenticatorModel.*;
import com.iitb.AuthenticatorBean.*;
import com.iitb.MemberModel.*;
import com.iitb.MemberBean.*;
import com.iitb.ProductModel.*;
import com.iitb.ProductBean.*;
import com.iitb.PublisherModel.*;
import com.iitb.PublisherBean.*;
import com.iitb.SettingsModel.*;
import com.iitb.SettingsBean.*;
import com.iitb.MessageModel.*;
import com.iitb.MessageBean.*;
import com.iitb.OrderModel.*;
import com.iitb.OrderBean.*;
import com.iitb.WellinfoModel.*;
import com.iitb.WellinfoBean.*;

public class IvrsServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;
	public IvrsServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String redirect=request.getParameter("redirect");
		HttpSession session = request.getSession();
		/*
		 * For redirection to Dashboard using PRG pattern
		 * Dashboard.jsp
		 * GroupModel/GroupDetails.java
		 * AuthenticatorBean/LoginBean.java , GroupBean/GroupBean.java
		 * @author ravi
		 */
		if(redirect!=null){
			System.out.println("in doget");
			LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
						
			GroupBean groupBean=new GroupBean();
			GroupDetails groupDetails=new GroupDetails();
			try {
				groupBean.setGroup_details(groupDetails.getGroupDetails(loginUser.getOrg_id()));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("groupBean",groupBean);
			
	        RequestDispatcher requestDispatcher=request.getRequestDispatcher("Dashboard.jsp");  
			requestDispatcher.forward(request, response); 
			
		}
		else{
			doPost(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String req_type="";
		HttpSession session = request.getSession();


		req_type = request.getParameter("req_type");
		System.out.println("req_type::::"+req_type);
		String ln = request.getParameter("ln");
		session.setAttribute("ln",ln);

		try
		{
			if(req_type==null){
				MultipartFormDataRequest mrequest;
				mrequest = new MultipartFormDataRequest(request);


				
				
				/* This req_type is used to  insert video name and video link into videos
				 * Upload.jsp
				 * SettingsModel/IvrsServletMulti.java
				 * 
				 */
				 
				if (mrequest.getParameter("req_type").equals("videoyoutube"))
				{
					String videoname = mrequest.getParameter("videoname");
					String videolink = mrequest.getParameter("videolink");
					String videonamelink = videoname+"#"+videolink;

					IvrsServletMulti ism = new IvrsServletMulti();
					ism.videoYoutube(videoname, videolink, videonamelink);
				}

				
				/* This req_type is used to save the updates done to the groupnames 
				 * Manage.jsp
				 * GroupModel/GroupDetails.java
				 * 
				 */
				else if(mrequest.getParameter("req_type").equals("saveSettings"))
				{
					GroupDetails groupDetails = new GroupDetails();
					String groupsName = mrequest.getParameter("groups_name");
					String groupId = mrequest.getParameter("groups_id");

					groupDetails.saveSettings(groupsName,groupId);
				}




				
				/* This req_type is used for new file uploading
				 * Upload.jsp
				 * SettingsModel/IvrsServletMulti.java, MessageModel/Upload.java
				 * @author:Ravi Prakash Giri
				 */
				else if(mrequest.getParameter("req_type").equals("new_file_upload")) {
					Upload upload = new Upload();

					System.out.println("-------Inside new File Uploading---");
					String newFile = mrequest.getParameter("file_upload");
					System.out.println(newFile);
					String dir = ConfigParams.UPLOADPUBLISHERMESSAGE;
					System.out.print(dir);

					String filePath = upload.UploadingFile(mrequest, dir, "file_upload", "file_upload");
					System.out.println("filepath="+filePath);
					File file = new File(filePath);
					String fileName = file.getName();
					System.out.println("fileName :- " + fileName);

					/*String dir1 = ConfigParams.UPLOADPUBLISHERMESSAGE+"/"+filename;
					System.out.print(dir1);
					String filePath1 = upload.UploadingFile(mrequest, dir, "file_upload", "file_upload");
					 */
					String inputFileName = fileName;
					String out = "C://file_upload.wav";


					/*
					 * filename  -  input audiofile name
					 * out - output file name with location
					 */
					//WavConverter.convert( inputFileName, out);

					/*try {
						WavConverter.convert( inputFileName, out);
						Thread.sleep(1000);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}*/
					System.out.println("---------------****----------------------");
					
					filePath = dir + fileName;
					//	String message_location = "/home/hduser/ruralivrs/ProjectFiles/apache-tomcat-6.0.37/webapps/Downloads/RuralIvrs/publisher/"+ filename;
					String messageLocation = ConfigParams.UPLOADWAV+ fileName;
					System.out.println(messageLocation);
					String orgName = ConfigParams.ORGNAME;
					
					NewMessage newMessage = new NewMessage();
					newMessage.newMess(messageLocation,orgName);
					System.out.println("Message working properly");
					
				}
				
				
				else if(mrequest.getParameter("req_type").equals("dummy_msg_upload")) {
					Upload upload = new Upload();

					System.out.println("-------Inside new File Uploading---");
					String newFile = mrequest.getParameter("file_upload");
					System.out.println(newFile);
					String dir = ConfigParams.UPLOADPUBLISHERMESSAGE;
					System.out.print(dir);
					

					String filePath = upload.UploadingFile(mrequest, dir, "file_upload", "file_upload");
					System.out.println("filepath="+filePath);
					File file = new File(filePath);
					String fileName = file.getName();
					System.out.println("fileName :- " + fileName);

					/*String dir1 = ConfigParams.UPLOADPUBLISHERMESSAGE+"/"+filename;
					System.out.print(dir1);
					String filePath1 = upload.UploadingFile(mrequest, dir, "file_upload", "file_upload");
					 */
					String inputFileName = fileName;
					String out = "C://file_upload.wav";
					


					/*
					 * filename  -  input audiofile name
					 * out - output file name with location
					 */
					//WavConverter.convert( inputFileName, out);

					/*try {
						WavConverter.convert( inputFileName, out);
						Thread.sleep(1000);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}*/
					System.out.println("---------------****----------------------");
					
					filePath = dir + fileName;
					//	String message_location = "/home/hduser/ruralivrs/ProjectFiles/apache-tomcat-6.0.37/webapps/Downloads/RuralIvrs/publisher/"+ filename;
					String messageLocation = ConfigParams.UPLOADWAV+ fileName;
					System.out.println(messageLocation);
					String orgName = ConfigParams.ORGNAME;
					//String memberNames=request.getParameter("memberNames");
					String memberNumber=mrequest.getParameter("memberNumber");
					String groupId=mrequest.getParameter("groupId");
					String query = "INSERT INTO message (member_number, message_location, groups_id) VALUES ('"+memberNumber+"','"+messageLocation+"','"+groupId+"');";
					try {
						DataService.runQuery(query);
						System.out.println(query);
						
					} catch(SQLException e)  {
						e.printStackTrace();
					}
					
				}
				
				else if(mrequest.getParameter("req_type").equals("dummyFileUpload"))
				{
					System.out.println("into dummy.........");
					Upload upload = new Upload();

					System.out.println("-------Inside new File Uploading---");
					String newFile = mrequest.getParameter("file_upload");
					System.out.println(newFile);
					String dir = ConfigParams.UPLOADPUBLISHERMESSAGE;
					System.out.print(dir);

					String filePath = upload.UploadingFile(mrequest, dir, "file_upload", "file_upload");
					System.out.println("filepath="+filePath);
					File file = new File(filePath);
					String fileName = file.getName();
					System.out.println("fileName :- " + fileName);

					/*String dir1 = ConfigParams.UPLOADPUBLISHERMESSAGE+"/"+filename;
					System.out.print(dir1);
					String filePath1 = upload.UploadingFile(mrequest, dir, "file_upload", "file_upload");
					 */
					String inputFileName = fileName;
					String out = "C://file_upload.wav";


					/*
					 * filename  -  input audiofile name
					 * out - output file name with location
					 */
					//WavConverter.convert( inputFileName, out);

					/*try {
						WavConverter.convert( inputFileName, out);
						Thread.sleep(1000);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}*/
					System.out.println("---------------****----------------------");
					
					filePath = dir + fileName;
					//	String message_location = "/home/hduser/ruralivrs/ProjectFiles/apache-tomcat-6.0.37/webapps/Downloads/RuralIvrs/publisher/"+ filename;
					String messageLocation = ConfigParams.UPLOADWAV+ fileName;
					System.out.println("This is the location of dummy file!!"+messageLocation);
					String orgName = ConfigParams.ORGNAME;
					//String memberNames=request.getParameter("memberNames");
					String memberNumber=mrequest.getParameter("selectedGroup");
					String groupId=mrequest.getParameter("groupId");
					String query = "INSERT INTO message (member_number, message_location, groups_id) VALUES ('"+memberNumber+"','http://qassist.cse.iitb.ac.in/Downloads/AFC/audio-upload/dummy.wav','"+groupId+"');";
					try {
						DataService.runQuery(query);
						System.out.println(query);
						
					} catch(SQLException e)  {
						e.printStackTrace();
					}
					
				}
				
				
				
				/* This req_type is used for Saving settings
				 * SystemSettings.jsp
				 * MessageModel/Upload.java
				 * 
				 */
				
				
				else if (mrequest.getParameter("req_type").equals("globalGroupSettings")) 
				{
					System.out.println(mrequest.getParameter("req_type"));
					String selectedResponse = "";
					String responsetype = "";
					String language = "";
					String enableFeedback="";
					String enableResponse="";
					String[] responsevalue = mrequest.getParameterValues("response1");
					String[] languagevalue = mrequest.getParameterValues("language");
					String[] responsevalueincoming = mrequest.getParameterValues("responsein");
					String[] languagevalueincoming = mrequest.getParameterValues("languagein");
					
					String languagein ="";
					String responsein ="";
					String responsetypein="";
					String selectedResponsein="";
					String welcome_message = mrequest.getParameter("welcome_message");
					System.out.println("////////////////////");
					
					System.out.println(welcome_message);
					// String delivery_type=
					// mrequest.getParameter("welcome_message");
					String broadcast = mrequest.getParameter("broadcast");
					String emailId = mrequest.getParameter("email_id");
					
					String previousBroadcast = mrequest.getParameter("Previous_broadcast");
					String repeatBroadcast = mrequest.getParameter("repeat_broadcast");
					String latestBroadcast = mrequest.getParameter("Latest_broadcast");
					String orderCancel = mrequest.getParameter("ordercancel");
					enableFeedback = mrequest.getParameter("feedback");
					enableResponse = mrequest.getParameter("response");
					String enableBill = mrequest.getParameter("bill");
					System.out.println("enableBill: "+enableBill);
					String enableSave = mrequest.getParameter("save");
					System.out.println("enableSave: "+enableSave);
					String enableReject = mrequest.getParameter("reject");
					System.out.println("welcome_message   " + welcome_message);
					System.out.println("okcklclskdl="+orderCancel );
					String filePresent = mrequest.getParameter("filePresent");
										System.out.println("filePresent"+filePresent+"sadasdad");
					System.out.println("emailId  " + emailId);
					if (responsevalue != null) {

						for (int i = 0; i < responsevalue.length; i++) {
							selectedResponse = responsevalue[i];
							responsetype = responsetype.concat(selectedResponse);
							// System.out.print(rs);

						}
						// System.out.println("response=="+responsevalue.length);

					}System.out.println("responseoutgoing==" + responsetype);
					

					if (languagevalue != null) {
						for (int j = 0; j < languagevalue.length; j++) {
							String selectedLanguage = languagevalue[j];
							language = language.concat(selectedLanguage);
							// System.out.print(languages);
						}
					}
					System.out.println("Languageoutgoing=" + language);
					
					if (responsevalueincoming != null) {

						for (int i = 0; i < responsevalueincoming.length; i++) {
						    selectedResponsein = responsevalueincoming[i];
							responsetypein = responsetypein.concat(selectedResponsein);
							// System.out.print(rs);
						}
							// System.out.println("response=="+responsevalue.length);

					}System.out.println("responseincoming==" + responsetypein);
					

					if (languagevalueincoming != null) {
						for (int j = 0; j < languagevalueincoming.length; j++) {
							String selectedLanguagein = languagevalueincoming[j];
							languagein = languagein.concat(selectedLanguagein);
							// System.out.print(languages);
						}
					}
					System.out.println("Languageincoming=" + languagein);
					
					
					Upload upload = new Upload();
					
					System.out.println(filePresent!="");
					if(!filePresent.equals("")){
						System.out.println("Hi file is there...");
					String dir = ConfigParams.UPLOADDIR;
					System.out.println(dir);
					String filePath = upload.UploadingFile(mrequest, dir,"welcome_message", "Welcome_message");
					File file = new File(filePath);
					String filename = file.getName();
					System.out.println("filenamefilenamefilenamefilenamefilename    "
									+ filename);

					filePath = dir + filename;
				//	String welcome_message_location = "http://qassist.cse.iitb.ac.in/Downloads/RuralIvrs/audio-upload/"+ filename;
					String welcome_message_location = ConfigParams.WELCOMEMESSAGELINK + filename;
					System.out.println(welcome_message_location);
					String global_setting_id = "Select global_setting_id from globalsettings;"; // ResultSet
																								// publisher=DataService.getResultSet(publisher_query);
					try {
						ResultSet gl = DataService.getResultSet(global_setting_id);
						if (gl.next()) {
							String query = "Update globalsettings set " 
								    +  "email_id='"+ emailId 
									+ "',language='" + language
									+ "',response='" + responsetype
									+"',responsein='"+ responsetypein
									+"',languagein='"+languagein
									+ "',welcome_msg_location='" + welcome_message_location
									+ "',broadcast_call='" + broadcast + "',Previous_broadcast='"+previousBroadcast+"',repeat_broadcast='"+repeatBroadcast+"',order_cancel='"+orderCancel+"',Latest_broadcast='"+latestBroadcast+"',enable_feedback='"+enableFeedback+"',enable_response='"+enableResponse+"',enable_bill='"+enableBill+"',enable_save='"+enableSave+"',enable_reject='"+enableReject+"'";
							System.out.println(query);
							try {
								DataService.runQuery(query);
							} catch (SQLException e) {
								System.out.println("Error During query:" + query);
								e.printStackTrace();
							}

						} else {
						
							String query = "INSERT INTO globalsettings(email_id,language,response,welcome_msg_location,broadcast_call,Previous_broadcast,languagein,responsein,repeat_broadcast,order_cancel,Latest_broadcast ) VALUES('"
									+ emailId
									+ "','"
									+ language
									+ "','"
									+ responsetype
									+ "','"
									+ filePath
									+ "','"
									+ broadcast 
									+"','"
									+previousBroadcast
									+"','"
									+languagein
									+"','"
									+responsetypein
									+"','"
									+repeatBroadcast
									+"','"
									+orderCancel
									+"','"
									+latestBroadcast
											+"');";
							System.out.println(query);

							try {
								DataService.runQuery(query);
								// DataService.runQuery(emailUpdate);
							} catch (SQLException e) {
								System.out.println("Error During query:" + query);
								e.printStackTrace();
							}

						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
					else if(filePresent.equals("")){
						
						System.out.println("File not Present File  not Present File  not Present*********************");
						String global_setting_id = "Select global_setting_id from globalsettings;"; // ResultSet
																									// publisher=DataService.getResultSet(publisher_query);
						try {
							ResultSet gl = DataService.getResultSet(global_setting_id);
							if (gl.next()) {
								String query = "Update globalsettings set email_id='"
										+ emailId + "',language=" + language
										+ ",response='" + responsetype
										//+ "',welcome_msg_location='" 
										+ "'" + ",broadcast_call='" + broadcast 
										+ "'" + ",Previous_broadcast='" + previousBroadcast + "'"
										+",languagein='"+ languagein+
										"'" + ",responsein='"+responsetypein+ "',repeat_broadcast='"+repeatBroadcast+"',order_cancel='"+orderCancel+"',Latest_broadcast='"+latestBroadcast+"',enable_feedback='"+enableFeedback+"',enable_response='"+enableResponse+"',enable_bill= 0,enable_save= 0,enable_reject='"+enableReject+"'";
								System.out.println(query);
								try {
									DataService.runQuery(query);
								} catch (SQLException e) {
									System.out.println("Error During query:" + query);
									e.printStackTrace();
								}

							} else {
								// String
								// query="SELECT groups_id,member_id FROM member WHERE member_number LIKE '%"+caller_id+"';";
								// //To get the group to which member belongs
								// ResultSet rs=DataService.getResultSet(query);
								//
								String query = "INSERT INTO globalsettings(email_id,language,response,welcome_msg_location,broadcast_call,Previous_broadcast,languagein,responsein,repeat_broadcast,Latest_broadcast) VALUES('"
										+ emailId
										+ "','"
										+ language
										+ "','"
										+ responsetype
										+ "','"
										
										+ "','"
										+ broadcast + "','"+previousBroadcast+"','"+languagein+"','"+responsein+"','"+repeatBroadcast+"','"+latestBroadcast+"');";
								System.out.println(query);

								try {
									DataService.runQuery(query);
									// DataService.runQuery(emailUpdate);
								} catch (SQLException e) {
									System.out.println("Error During query:" + query);
									e.printStackTrace();
								}

							}
						} catch (SQLException e) {
							e.printStackTrace();
						}

					}
				}
				/* This req_type is used for broadcasting
				 * Upload.jsp
				 * SettingsModel/IvrsServletMulti.java
				 * 
				 */
				
				else if(mrequest.getParameter("req_type").equals("broadcast"))
				{
					String filePresent = mrequest.getParameter("filePresent");
					String desiredFileName = mrequest.getParameter("fileName");
					String uploadFileLocation = mrequest.getParameter("upload");
					String callNow[] = mrequest.getParameterValues("now");

					String selectedResponse= "";
					String responseType="";
					String language="";
					String broadcastId="";
					String groupId = request.getParameter("group_id");
					String[] responseValue = mrequest.getParameterValues("response");
					String[] languageValue=mrequest.getParameterValues("language");

					String backupcallNumber = mrequest.getParameter("backup_calls");
					String backupcallTimeHr1 = mrequest.getParameter("backup_call_time1");
					String backupcallTimeMin1 = mrequest.getParameter("backup_call_time_min1");
					String backupcallTime1 = backupcallTimeHr1+backupcallTimeMin1;

					String backupcallTimeHr2 = mrequest.getParameter("backup_call_time2");
					String backupcallTimeMin2 = mrequest.getParameter("backup_call_time_min2");
					String backupcallTime2 = backupcallTimeHr2+backupcallTimeMin2;

					String backupcallTimeHr3 = mrequest.getParameter("backup_call_time3");
					String backupcallTimeMin3 = mrequest.getParameter("backup_call_time_min3");
					String backupcallTime3 = backupcallTimeHr3+backupcallTimeMin3;

					String backupcallTimeHr4 = mrequest.getParameter("backup_call_time4");
					String backupcallTimeMin4 = mrequest.getParameter("backup_call_time_min4");
					String backupcallTime4 = backupcallTimeHr4+backupcallTimeMin4;

					String backupcallTimeHr5 = mrequest.getParameter("backup_call_time5");
					String backupcallTimeMin5 = mrequest.getParameter("backup_call_time_min5");
					String backupcallTime5 = backupcallTimeHr5+backupcallTimeMin5;

					String shceduledHr1 = mrequest.getParameter("shceduled_time1");
					String shceduledHr2 = mrequest.getParameter("shceduled_time1");
					String shceduledHr3 = mrequest.getParameter("shceduled_time1");

					String shceduledTimeMin1 = mrequest.getParameter("shceduled_time_min1");
					String shceduledTimeMin2 = mrequest.getParameter("shceduled_time_min2");
					String shceduledTimeMin3 = mrequest.getParameter("shceduled_time_min3");

					String scheduledTime1 = shceduledHr1+shceduledTimeMin1;
					String scheduledTime2 = shceduledHr2+shceduledTimeMin2;
					String scheduledTime3 = shceduledHr3+shceduledTimeMin3;

					if(responseValue!=null)
					{
						for(int i=0;i<responseValue.length;i++)
						{
							selectedResponse= responseValue[i];
							responseType=responseType.concat(selectedResponse);
						}
					}
					if(languageValue!=null)
					{
						for(int j=0 ; j<languageValue.length;j++)
						{
							String selectedLanguage = languageValue[j];
							language = language.concat(selectedLanguage);
						}
					}
					groupId = mrequest.getParameter("group_id");

				//	String  dir = "/home/davis/Rural-ivrs-TOMCAT/apache-tomcat-7.0.42/webapps/Downloads/audio-upload";

					try
					{
						String orgName=ConfigParams.ORGNAME;
				//		String name="Test";

						IvrsServletMulti ivrsServletMultiObj = new IvrsServletMulti();
						broadcastId = ivrsServletMultiObj.message(orgName, groupId, language, responseType, backupcallNumber, backupcallTime1, backupcallTime2, backupcallTime3, backupcallTime4, backupcallTime5, scheduledTime1, scheduledTime2, scheduledTime3);
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
					try
					{
						String[] selectedMembers = mrequest.getParameterValues("selectedMember");
						IvrsServletMulti ivrsServletMultiObj = new IvrsServletMulti();
						ivrsServletMultiObj.selected(selectedMembers, groupId, callNow, language, responseType, broadcastId, backupcallNumber, backupcallTime1, backupcallTime2, backupcallTime3, backupcallTime4, backupcallTime5, scheduledTime1, scheduledTime2, scheduledTime3);

					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
				}
			}	
			else	
			{

				/* Creates a new group
				 * Dashboard.jsp
				 * GroupModel/GroupDetails and DbUtilities/DataServiceConnect
				 * AuthenticatorBean/LoginBean 
				 * 
				 */
				if (req_type.equalsIgnoreCase("newGroup")) {
					String groupName = request.getParameter("groupName");
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");

					GroupDetails groupDetails=new GroupDetails();
					//validates if the group name is already present
					boolean groupAlreadyPresent=groupDetails.groupAlreadyPresent(groupName,loginUser.getOrg_id());
					//inserts the group if group name is unique
					if(!groupAlreadyPresent&& !groupName.equalsIgnoreCase("")){
						DataServiceConnect dataServiceConnect=new DataServiceConnect();

						dataServiceConnect.insertIntoGroups(groupName, loginUser.getOrg_id(), null);
					}
					//redirects to Dashboard.jsp after inserting the group (GET response : PRG pattern)
					response.sendRedirect("IvrsServlet?redirect=1");

				}
				/* For Downloading All Messages 
				 * VoiceMessages.jsp and TextMessages.jsp
				 * MessageModel/VoiceMessages.java
				 * @author: Ravi Prakash Giri
				 */
				if(req_type.equals("downloadMessages"))
				{
					File file = new File("inbox.csv");
					BufferedWriter output = new BufferedWriter(new FileWriter(file));
					String text="Timestamp,message_id,member_name,member_number,comments";
					output.write(text);
					output.newLine();
					String groupId = request.getParameter("groupId");
					// getting values from database
					VoiceMessages voiceMessages=new VoiceMessages();
					Object[][] getMessages = voiceMessages.getInboxMessages(groupId);
					int i=0;
					while(i < getMessages.length)
					{
						text=""; 
						getMessages[i][4]=(getMessages[i][4].toString()).replace(" ", "|");
						text=getMessages[i][4]+","+getMessages[i][5]+","+getMessages[i][6]+","+getMessages[i][1]+","+getMessages[i][3];
						output.write(text);
						output.newLine();
						i++;
					}
					output.close();
					String filePath=file.getAbsolutePath();
					int length = 0;
					ServletOutputStream outStream = response.getOutputStream();
					ServletContext context  = getServletConfig().getServletContext();
					String mimeType = context.getMimeType(filePath);

					// sets response content type 
					if (mimeType == null) {
						mimeType = "application/octet-stream";
					}
					response.setContentType(mimeType);
					response.setContentLength((int)file.length());
					String fileName = (new File(filePath)).getName();

					// sets HTTP header 
					response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

					byte[] byteBuffer = new byte[1024*2];
					DataInputStream in = new DataInputStream(new FileInputStream(file));

					// reads the file's bytes and writes them to the response stream 
					while ((in != null) && ((length = in.read(byteBuffer)) != -1))
					{
						outStream.write(byteBuffer,0,length);
					}
					in.close();
					outStream.close();
				}
				else if(req_type.equals("downloadDetails"))
				{
					File file = new File("detailinbox.csv");
					BufferedWriter output = new BufferedWriter(new FileWriter(file));
				//	String text="Timestamp,message_id,member_name,member_number,comments";
					String textD="Name,number,address";
					
					output.write(textD);
					output.newLine();
					String groupId = request.getParameter("groupId");
					// getting values from database
					VoiceMessages voiceMessages=new VoiceMessages();
					Object[][] getMessages = voiceMessages.getDetails(groupId);
					int i=0;
					while(i < getMessages.length)
					{
						String text=""; 
						//getMessages[i][4]=(getMessages[i][4].toString()).replace(" ", "|");
						text=getMessages[i][0]+","+getMessages[i][1]+","+getMessages[i][2];
						output.write(text);
						output.newLine();
						i++;
					}
					output.close();
					String filePath=file.getAbsolutePath();
					int length = 0;
					ServletOutputStream outStream = response.getOutputStream();
					ServletContext context  = getServletConfig().getServletContext();
					String mimeType = context.getMimeType(filePath);

					// sets response content type 
					if (mimeType == null) {
						mimeType = "application/octet-stream";
					}
					response.setContentType(mimeType);
					response.setContentLength((int)file.length());
					String fileName = (new File(filePath)).getName();

					// sets HTTP header 
					response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

					byte[] byteBuffer = new byte[1024*2];
					DataInputStream in = new DataInputStream(new FileInputStream(file));

					// reads the file's bytes and writes them to the response stream 
					while ((in != null) && ((length = in.read(byteBuffer)) != -1))
					{
						outStream.write(byteBuffer,0,length);
					}
					in.close();
					outStream.close();
				}
				/* For "Voice Messages Response" Tab on Dashboard and Global Settings
				 * VoiceMessages.jsp
				 * MessageModel/VoiceMessages.java , MemberModel/MemberDetails.java
				 * GroupBean/GroupBean.java , MemberBean/MemberBean.java
				 * 
				 * 				 */
				else if(req_type.equals("voiceMessage"))
				{
					VoiceTextMessagesBean messageBean = new VoiceTextMessagesBean();
					GroupBean groupBean = new GroupBean();
					MemberBean memberBean = new MemberBean();
					VoiceMessages voiceMessages=new VoiceMessages();
					MemberDetails memberDetails=new MemberDetails();

					String groupId = request.getParameter("groupId");
					groupBean.setGroups_id(groupId);

					memberBean.setMember_details(memberDetails.getGroupMemberDetails(groupId));

					messageBean.setInbox_messages(voiceMessages.getInboxMessages(groupId));

					messageBean.setAccepted_messages(voiceMessages.getAcceptedMessages(groupId));

					messageBean.setRejected_messages(voiceMessages.getRejectedMessages(groupId));

					messageBean.setResponse_yes(voiceMessages.getResponseYes(groupId));

					messageBean.setResponse_no(voiceMessages.getResponseNo(groupId));

					messageBean.setFeedback_messages(voiceMessages.getFeedback(groupId));

					messageBean.setProcessed_messages(voiceMessages.getProcessedMessages(groupId));

					messageBean.setSaved_messages(voiceMessages.getSavedMessages(groupId));
					
					
					SystemSettings newSettings = new SystemSettings();
					Object systemData[][] = newSettings.getSystemData();
					SettingsBean settingsBean = new SettingsBean();
					settingsBean.setSystem_data(systemData);
					
					request.setAttribute("settings",settingsBean);

					request.setAttribute("messageBean",messageBean);
					request.setAttribute("memberBean",memberBean);
					request.setAttribute("groupBean",groupBean);
					if(memberDetails.getGroupMemberDetails(groupId)==null){
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("VoiceMessages.jsp?member=false");
						requestDispatcher.forward(request, response);
					}
					else{
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("VoiceMessages.jsp");
					requestDispatcher.forward(request, response);
					}
				}
				/* For Updating Message Comments
				 * VoiceMessages.jsp
				 * MessageModel/VoiceMessages.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("updateMsgComment"))
				{
					String messageComments=request.getParameter("messageComments");
					String messageId=request.getParameter("messageId");

					VoiceMessages voiceMessages=new VoiceMessages();
					voiceMessages.updateMsgComment(messageId,messageComments);
				}
				/* For Updating Message Status of Inbox Messages (Accepted/Rejected)
				 * VoiceMessages.jsp
				 * MessageModel/VoiceMessages.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("updateMsgStatus"))
				{
					String messageId=request.getParameter("messageId");
					String statusId=request.getParameter("statusId");

					VoiceMessages voiceMessages=new VoiceMessages();
					voiceMessages.updateMsgStatus(messageId,statusId);
				}
				/* For "Process Button" on GenerateBill page and Forwarding Accepted Order to Processed Order
				 * GenerateBill.jsp
				 * OrderModel/OrderModel.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("processOrder"))
				{
					String boughtProductName=request.getParameter("boughtProductName");
					String boughtProductIds=request.getParameter("boughtProductIds");
					String boughtProductQuantity=request.getParameter("boughtProductQuantity");
					String boughtProductPrice=request.getParameter("boughtProductPrice");
					String productPrice=request.getParameter("productPrice");
					String messageId=request.getParameter("messageId");

					OrderModel orderModel=new OrderModel();
					orderModel.processOrder(messageId,boughtProductName,boughtProductIds,boughtProductQuantity,boughtProductPrice,productPrice);
				}
				/* For "Save Button" on GenerateBill page and Forwarding Accepted Order to Saved Order
				 * GenerateBill.jsp
				 * OrderModel/OrderModel.java
				 * GroupBean/GroupBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("saveOrder"))
				{
					System.out.println("oye !");
					GroupBean groupBean= new GroupBean();
					OrderModel orderModel=new OrderModel();
					
					String boughtProductName=request.getParameter("boughtProductName");
					String productPrice=request.getParameter("productPrice");
					String boughtProductIds=request.getParameter("boughtProductIds");
					String boughtProductQuantity=request.getParameter("boughtProductQuantity");
					String boughtProductPrice=request.getParameter("boughtProductPrice");
					String messageId=request.getParameter("messageId");
					String groupId = request.getParameter("groupId");
					System.out.println("grp id ="+groupId+"msgiD="+messageId);
					groupBean.setGroups_id(groupId);
					orderModel.saveOrder(messageId,groupId,boughtProductName,boughtProductIds,boughtProductQuantity,boughtProductPrice,productPrice);

					request.setAttribute("groupBean",groupBean);

					//RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=voiceMessage");
					//requestDispatcher.forward(request, response);
				}
				/* For "Save Button" on ProcessOrEdit page and Forwarding Saved Order to Saved Order
				 * ProcessOrEdit.jsp
				 * OrderModel/OrderModel.java
				 * GroupBean/GroupBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("editAndSaveOrder"))
				{
					GroupBean groupBean= new GroupBean();
					OrderModel orderModel=new OrderModel();

					String boughtProductName=request.getParameter("boughtProductName");
					String productPrice=request.getParameter("productPrice");
					String boughtProductIds=request.getParameter("boughtProductIds");
					String boughtProductQuantity=request.getParameter("boughtProductQuantity");
					String boughtProductPrice=request.getParameter("boughtProductPrice");
					String messageId=request.getParameter("messageId");
					String groupId = request.getParameter("groupId");

					groupBean.setGroups_id(groupId);
					orderModel.editSaveOrder(messageId,groupId,boughtProductName,boughtProductIds,boughtProductQuantity,boughtProductPrice,productPrice);	

					request.setAttribute("groupBean",groupBean);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=voiceMessage");
					requestDispatcher.forward(request, response);
				}
				/* For "Process Button" on ProcessOrEdit page and Forwarding Saved Order to Processed Order
				 * ProcessOrEdit.jsp
				 * OrderModel/OrderModel.java
				 * GroupBean/GroupBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("process"))
				{
					GroupBean groupBean= new GroupBean();
					OrderModel orderModel=new OrderModel();

					String boughtProductName=request.getParameter("boughtProductName");
					String productPrice=request.getParameter("productPrice");
					String boughtProductIds=request.getParameter("boughtProductIds");
					String boughtProductQuantity=request.getParameter("boughtProductQuantity");
					String boughtProductPrice=request.getParameter("boughtProductPrice");
					String messageId=request.getParameter("messageId");
					String groupId = request.getParameter("groupId");

					groupBean.setGroups_id(groupId);
					orderModel.processFinalOrder(messageId,groupId,boughtProductName,boughtProductIds,boughtProductQuantity,boughtProductPrice,productPrice);

					request.setAttribute("groupBean",groupBean);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=voiceMessage");
					requestDispatcher.forward(request, response);
				}
				/* For "Text Messages Response" Tab on Dashboard and Global Settings
				 * TextMessages.jsp
				 * MessageModel/TextMessages.java, MemberModel/MemberDetails.java
				 * GroupBean/GroupBean.java , MemberBean/MemberBean.java , MessageBean/VoiceTextMessagesBean.java
				 * 
				 */
				else if(req_type.equals("textMessage"))
				{
					VoiceTextMessagesBean messageBean = new VoiceTextMessagesBean();
					GroupBean groupBean = new GroupBean();
					MemberBean memberBean = new MemberBean();
					TextMessages textMessages=new TextMessages();
					MemberDetails memberDetails=new MemberDetails();

					String groupId = request.getParameter("groupId");
					groupBean.setGroups_id(groupId);

					memberBean.setMember_details(memberDetails.getGroupMemberDetails(groupId));

					messageBean.setInbox_messages(textMessages.getInboxMessages(groupId));

					messageBean.setAccepted_messages(textMessages.getAcceptedMessages(groupId));

					messageBean.setRejected_messages(textMessages.getRejectedMessages(groupId));

					messageBean.setDefault_messages(textMessages.getDefaultMessages(groupId));

					messageBean.setResponse_yes(textMessages.getResponseYes(groupId));

					messageBean.setResponse_no(textMessages.getResponseNo(groupId));

					messageBean.setFeedback_messages(textMessages.getFeedback(groupId));

					request.setAttribute("messageBean",messageBean);
					request.setAttribute("memberBean",memberBean);
					request.setAttribute("groupBean",groupBean);
					if(memberDetails.getGroupMemberDetails(groupId)==null){
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("TextMessages.jsp?member=false");
						requestDispatcher.forward(request, response);
					}
					else{
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("TextMessages.jsp");
					requestDispatcher.forward(request, response);
					}
				}
				/* For Updating Text Message Comments
				 * TextMessages.jsp
				 * MessageModel/TextMessages.java
				 * 
				 * 		 */
				else if(req_type.equalsIgnoreCase("updateMessageComment"))
				{
					String messageComments=request.getParameter("messageComments");
					String messageId=request.getParameter("messageId");

					TextMessages textMessages=new TextMessages();
					textMessages.UpdateMessageComment(messageComments,messageId);
				}
				/* For Updating Default Message Comments in Text Message Response
				 * TextMessages.jsp
				 * MessageModel/TextMessages.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("updateDefaultMessageComment"))
				{
					String messageComments=request.getParameter("messageComments");
					String messageId=request.getParameter("messageId");

					TextMessages textMessages=new TextMessages();
					textMessages.UpdateDefaultMessageComment(messageComments,messageId);
				}
				/* For Updating Message Status of Inbox Messages (Accepted/Rejected)
				 * TextMessages.jsp
				 * MessageModel/TextMessages.java
				 *
				 */
				else if(req_type.equalsIgnoreCase("updateMessageStatus"))
				{
					String statusId=request.getParameter("statusId");
					String messageId=request.getParameter("messageId");

					TextMessages textMessages=new TextMessages();
					textMessages.UpdateMessageStatus(statusId,messageId);
				}
				/* For "OutgoingSMS" tab on Dashboard to list all outgoing messages
				 * OutgoingMessages.jsp
				 * MessageModel/IncomingOutgoing.java 
				 * MessageBean/IncomingOutgoingBean.java
				 * 
				 */
				else if(req_type.equals("outgoingMessage"))
				{
					IncomingOutgoing incomingOutgoing=new IncomingOutgoing();
					IncomingOutgoingBean inoutBean=new IncomingOutgoingBean();

					String groupId = request.getParameter("groupId");

					inoutBean.setOutgoing_messages(incomingOutgoing.getOutgoingMessages(groupId));

					request.setAttribute("inoutBean",inoutBean);			
					if(incomingOutgoing.getOutgoingMessages(groupId)==null){
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("OutgoingMessage.jsp?message=false");
						requestDispatcher.forward(request, response);
					}
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("OutgoingMessage.jsp");
					requestDispatcher.forward(request, response);
				}
				/* For "Generate Bill" tab on Accepted Messages page to generate bill for accepted orders
				 * GenerateBill.jsp 
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java , GroupBean/GroupBean.java
				 * 
				 */
				else if(req_type.equals("generateBill"))
				{			
					ProductDetails productDetails=new ProductDetails();
					ProductBean productBean=new ProductBean();
					GroupBean groupBean=new GroupBean();

					String groupId = request.getParameter("groupId");
					String memberName=request.getParameter("memberName");
					String memberNumber=request.getParameter("memberNumber");
					String dateTime=request.getParameter("dateTime");
					System.out.println(dateTime);
					String msgUrl=request.getParameter("msgUrl");
					String messageId=request.getParameter("messageId");
					String comments=request.getParameter("comments");

					groupBean.setGroups_id(groupId);

					productBean.setProduct_detail(productDetails.getProductDetail());

					productBean.setProduct_quantity_detail(productDetails.getProductQuantityDetails());

					productBean.setCount_products_price(productDetails.countProducts());

					productBean.setCount_price_is_null(productDetails.countPrice());

					request.setAttribute("productBean",productBean);

					request.setAttribute("groupBean", groupBean);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("GenerateBill.jsp?memberName="+memberName+"&msgUrl="+msgUrl+"&messageId="+messageId
							+"&dateTime="+dateTime+"&memberNumber="+memberNumber+"&comments="+comments+"");
					requestDispatcher.forward(request, response);
				}

				/* For "View/Print Bill" tab on Processed orders page to view & print bill for processed orders
				 * ViewPrintBill.jsp 
				 * GroupModel/GroupDetails.java, SettingsModel/BillSettings.java,OrderModel/OrderModel.java
				 * SettingsBean/BillingBean.java, OrderBean/OrderBean.java , GroupBean/GroupBean.java, AuthenticatorBean/LoginBean.java
				 * 
				 */
				else if(req_type.equals("viewBill"))
				{	
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
					GroupBean groupBean = new GroupBean();
					BillingBean billingBean = new BillingBean();
					OrderBean orderBean = new OrderBean();
					OrderModel orderModel=new OrderModel();
					GroupDetails groupDetails=new GroupDetails();
					BillSettings billSettings=new BillSettings();

					String groupId = request.getParameter("groupId");
					String messageId=request.getParameter("messageId");
					String memberName=request.getParameter("memberName");
					String memberAddress=request.getParameter("memberAddress");
					String orderTime=request.getParameter("orderTime");
					String orgId=loginUser.getOrg_id();

					groupBean.setGroups_id(groupId);

					groupBean.setGroup_name(groupDetails.getGroupName(groupId));

					billingBean.setBill_settings(billSettings.getBillSettings(orgId));

					billingBean.setBill_id(billSettings.getBillId(messageId));

					orderBean.setSaved_order(orderModel.getSavedOrder(messageId));

					billingBean.setBill_total(billSettings.getBillTotal(messageId));

					request.setAttribute("billingBean",billingBean);
					request.setAttribute("orderBean",orderBean);
					request.setAttribute("groupBean",groupBean);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("ViewPrintBill.jsp?messageId="+messageId+"&memberName="+memberName+"&memberAddress="+memberAddress+"&orderTime="+orderTime+"&groupId="+groupId);
					requestDispatcher.forward(request, response);
				}
				/* For "Process/Edit" tab on Saved orders page to process order for saved orders
				 * ProcessOrEdit.jsp 
				 * ProductModel/ProductDetails.java,orderModel/OrderModel.java
				 * GroupBean/GroupBean.java, OrderBean/OrderBean.java , ProductBean/ProductBean.java
				 *
				 */
				else if(req_type.equals("processOrEdit"))
				{
					ProductBean productBean = new ProductBean();
					GroupBean groupBean=new GroupBean();
					OrderBean orderBean = new OrderBean();
					ProductDetails productDetails=new ProductDetails();
					OrderModel orderModel=new OrderModel();

					String groupId = request.getParameter("groupId");
					String memberName=request.getParameter("memberName");
					String msgUrl=request.getParameter("msgUrl");
					
					String orderTime=request.getParameter("orderTime");
					if(orderTime==null){
						orderTime=request.getParameter("dateTime");
					}
					String comments=request.getParameter("comments");
					String messageId=request.getParameter("messageId");

					groupBean.setGroups_id(groupId);

					productBean.setProduct_detail(productDetails.getProductDetail());

					productBean.setProduct_quantity_detail(productDetails.getProductQuantityDetails());

					productBean.setCount_products_price(productDetails.countProducts());

					productBean.setCount_price_is_null(productDetails.countPrice());

					orderBean.setSaved_order(orderModel.getSavedOrder(messageId));

					request.setAttribute("orderBean",orderBean);
					request.setAttribute("groupBean",groupBean);
					request.setAttribute("productBean",productBean);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("ProcessOrEdit.jsp?messageId="+messageId+"&memberName="+memberName+"&orderTime="+orderTime+"&comments="+comments+"&msgUrl="+msgUrl+"");
					requestDispatcher.forward(request, response);
				}
				
				
				
				else if(req_type.equalsIgnoreCase("global_settings"))
				{
					response.sendRedirect("GlobalSettings.jsp");
				}
	
				
				/* This req_type is used for Retrieving  settings
				 * NewSettings.jsp
				 * SettingsModel/NewSettings.java
				 *
				 *				 */
				else if(req_type.equals("settings"))
				{
					
					SystemSettings newSettings = new SystemSettings();
					Object systemData[][] = newSettings.getSystemData();
							
					SettingsBean settingsBean = new SettingsBean();

					settingsBean.setSystem_data(systemData);

					request.setAttribute("settings",settingsBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("SystemSettings.jsp");  
					requestDispatcher.forward(request, response);
				}


				/* This req_type is used for broadcasting
				 * Upload.jsp
				 * MessageModel/Broadcast.java
				 *
				 */
				else if(req_type.equals("voice"))
				{
					GroupBean groupBean=new GroupBean();
					String groupId = request.getParameter("groupId");
					groupBean.setGroups_id(groupId);
					String language="";
					String emailId = "";
					String res="";
					String broadcastCall ="";
					String broadcastURL = ""; 
					String messageId = "";
					String videoName="";
					String videoLink="";

					Broadcast broadcast = new Broadcast();
					MemberDetails memberDetails=new MemberDetails();
					UploadBean uploadBean = new UploadBean();
					MemberBean memberBean = new MemberBean();
					broadcastURL = broadcast.getMsgLocation();
					uploadBean.setBroadcast_url(broadcastURL);			

					Object data[][] = broadcast.getDataFromGlobalSettings();
					uploadBean.setData(data);

					messageId = broadcast.getMsgId();
					int numbers = Integer.parseInt(messageId);
					numbers ++;
					String messageIds=Integer.toString(numbers);
					String Id = "Msgid=";
					String Idmessage= Id + messageIds;
					uploadBean.setId_message(Idmessage);


					uploadBean.setVideo_id(broadcast.getVideoDetails());

					//uploadBean.setMembers(memberDetails.getMembers(groupId));
					Object members[][] = memberDetails.getMembers(groupId);
					memberBean.setMember_details(members);
					System.out.println("Member Bean is set");

					uploadBean.setCount( broadcast.getCount(groupId));

					uploadBean.setTotal(broadcast.getTotal(groupId));

					request.setAttribute("upload",uploadBean);
					request.setAttribute("groupBean",groupBean);
					request.setAttribute("memberBean", memberBean);
					RequestDispatcher rd=request.getRequestDispatcher("Upload.jsp");  
					rd.forward(request, response);			
				}
				
				
				/* This req_type is used for Updating Publisher username
				 * UpdateUserLogin.jsp
				 * PublisherModel/NewUpdateLogin.java
				 *
				 */
				else if (req_type.equalsIgnoreCase("updateVerifyUserName"))
				{

					boolean var = false;
					String user1 = request.getParameter("user1");
					System.out.println(user1);
					String user2 = request.getParameter("user2");
					String pass1 = request.getParameter("pass1");



					NewUpdateLogin newUpdateLogin = new NewUpdateLogin();
					var = newUpdateLogin.verifyUsername(user1, user2, pass1);

					if(var==true)
					{	
						response.getWriter().write("Your Username is changed successfully.");
					}
					else
					{
						response.sendRedirect("Login.jsp?auth=failed");
					}

				}



				/* This req_type is used for Updating Publisher password
				 * UpdateUserLogin.jsp
				 * PublisherModel/NewUpdateLogin.java
				 * 
				 */
				else if (req_type.equalsIgnoreCase("updateVerifyPassword"))
				{
					boolean var = false;

					String user1 = request.getParameter("user1");
					String pass1 = request.getParameter("pass1");
					String pass2 = request.getParameter("pass2");
					String pass3 = request.getParameter("pass3");

					NewUpdateLogin newUpdateLogin = new NewUpdateLogin();
					var = newUpdateLogin.verifyPassword(user1, pass1, pass2);
					if(var==true)
					{	
						response.getWriter().write("Your Password is changed successfully.");
					}
					else
					{
						response.sendRedirect("Login.jsp?auth=failed");
					}
				}


				/* This req_type is used for retrieving Ivrs Menu Settings
				 * IvrsMenuSettings.jsp
				 * SettingsModel/IvrsMenuSettings.java
				 * 
				 */
				else if (req_type.equalsIgnoreCase("ivrsMenuSettings"))
				{
					String welcomeMessage = "";
					String farewell = "";
					String semiStructuredMain = "";
					String structuredMain = "";
					String unstructuredMain = "";
					String structuredOne = "";
					String structuredTwo = "";
					String semiStructuredOne = "";
					String semiStructuredTwo = "";

					String semiStructuredThree = "";
					String semiStructuredRecording = "";
					String semiStructuredCancelled = "";
					String semiStructuredConfirm = "";
					String semiStructuredRerecord = "";
					String unstructuredFeedbackRecord = "";
					String semiStructuredRecorded = "";

					String structuredAnswerYes = "";
					String structuredAnswerNo = "";
					String unstructuredRecorded = "";
					String unstructuredConfirm = "";
					String unstructuredRerecord = "";
					String semiStructured = "";
					String unstructured = "";
					String structured = "";
					String press = "";
					String one = "";
					String two = "";
					String three = "";
					String forText = "";
					String languageToDIsplay = "";

					ln = request.getParameter("ln");


					IvrsMenuSettingsBean ivrsMenuSettingsBean = new IvrsMenuSettingsBean();

					IvrsMenuSettings menuSettings = new IvrsMenuSettings();
					if(ln.equalsIgnoreCase("en"))
					{



						structured =menuSettings.getStandard(1, "structured");
						unstructured =menuSettings.getStandard(1, "unstructured");
						press= menuSettings.getStandard(1, "press");
						one =menuSettings.getStandard(1, "one");
						two =menuSettings.getStandard(1, "two");
						three =menuSettings.getStandard(1, "three");
						forText =menuSettings.getStandard(1, "for_text");
						semiStructuredMain =menuSettings.getSemiStructured(1, 0, 0, 0, "opt_1");
						structuredMain =menuSettings.getStructured(1, 0, 0, 0, "opt_1");
						unstructuredMain =menuSettings.getUnstructured(1, 0, 0, 0, "opt_1");
						structuredOne =menuSettings.getStructured(1, 1, 0, 0, "opt_1");
						structuredTwo =menuSettings.getStructured(1, 1, 0, 0, "opt_2");
						semiStructuredOne =menuSettings.getSemiStructured(1, 1, 0, 0, "opt_1");
						semiStructuredTwo =menuSettings.getSemiStructured(1, 1, 0, 0, "opt_2");
						semiStructuredThree =menuSettings.getSemiStructured(1, 1, 2, 0, "opt_2");
						semiStructuredRecording =menuSettings.getSemiStructured(1, 1, 2, 0, "opt_1");
						semiStructuredCancelled =menuSettings.getSemiStructured(1, 1, 3, 0, "opt_1");
						semiStructuredConfirm =menuSettings.getSemiStructured(1, 1, 4, 0, "opt_1");
						semiStructuredRerecord =menuSettings.getSemiStructured(1, 1, 4, 0,	"opt_2");
						semiStructuredRecorded =menuSettings.getSemiStructured(1, 1, 2, 0,	"opt_3");				
						unstructuredFeedbackRecord =menuSettings.getUnstructured(1, 1, 0, 0, "opt_1");
						structuredAnswerYes =menuSettings.getStructured(1, 1, 1, 0, "opt_1");
						structuredAnswerNo =menuSettings.getStructured(1, 1, 1, 0, "opt_2");
						unstructuredConfirm =menuSettings.getUnstructured(1, 2, 1, 0,"opt_1");
						unstructuredRerecord =menuSettings.getUnstructured(1, 2, 1, 0,"opt_2");
						unstructuredRecorded =menuSettings.getUnstructured(1, 1, 0, 0,"opt_2");


						ivrsMenuSettingsBean.setUnstructured(unstructured);
						ivrsMenuSettingsBean.setPress(press);
						ivrsMenuSettingsBean.setOne(one);
						ivrsMenuSettingsBean.setTwo(two);
						ivrsMenuSettingsBean.setThree(three);
						ivrsMenuSettingsBean.setUnstructured_main(unstructuredMain);
						ivrsMenuSettingsBean.setFor_text(forText);
						ivrsMenuSettingsBean.setUnstructured_feedback_record(unstructuredFeedbackRecord);
						ivrsMenuSettingsBean.setUnstructured_confirm(unstructuredConfirm);
						ivrsMenuSettingsBean.setUnstructured_recorded(unstructuredRecorded);
						ivrsMenuSettingsBean.setUnstructured_rerecord(unstructuredRerecord);
						ivrsMenuSettingsBean.setStructured(structured);
						ivrsMenuSettingsBean.setStructured_answer_no(structuredAnswerNo);
						ivrsMenuSettingsBean.setStructured_answer_yes(structuredAnswerYes);
						ivrsMenuSettingsBean.setStructured_main(structuredMain);
						ivrsMenuSettingsBean.setStructured_one(structuredOne);
						ivrsMenuSettingsBean.setStructured_two(structuredTwo);
						ivrsMenuSettingsBean.setSemi_structured_cancelled(semiStructuredCancelled);
						ivrsMenuSettingsBean.setSemi_structured_confirm(semiStructuredConfirm);
						ivrsMenuSettingsBean.setSemi_structured_main(semiStructuredMain);
						ivrsMenuSettingsBean.setSemi_structured_one(semiStructuredOne);
						ivrsMenuSettingsBean.setSemi_structured_recorded(semiStructuredRecorded);
						ivrsMenuSettingsBean.setSemi_structured_recording(semiStructuredRecording);
						ivrsMenuSettingsBean.setSemi_structured_rerecord(semiStructuredRerecord);
						ivrsMenuSettingsBean.setSemi_structured_three(semiStructuredThree);
						ivrsMenuSettingsBean.setSemi_structured_two(semiStructuredTwo);
						ivrsMenuSettingsBean.setLanguage_to_display("English");
						ivrsMenuSettingsBean.setWelcome_message(menuSettings.getStandard(1, "welcome_msg"));
						ivrsMenuSettingsBean.setFarewell(menuSettings.getStandard(1, "thankyou_msg"));
						ivrsMenuSettingsBean.setSemi_structured(menuSettings.getStandard(1, "semi_structured"));
						ivrsMenuSettingsBean.setLanguage("English");



					}
					else if(ln.equalsIgnoreCase("hi"))
					{
						languageToDIsplay = "Hindi";


						welcomeMessage =menuSettings.getStandardHindi(1, "welcome_msg");
						farewell =menuSettings.getStandardHindi(1, "thankyou_msg");

						semiStructured =menuSettings.getStandardHindi(1, "semi_structured");
						structured =menuSettings.getStandardHindi(1, "structured");
						unstructured =menuSettings.getStandardHindi(1, "unstructured");
						press =menuSettings.getStandardHindi(1, "press");
						one =menuSettings.getStandardHindi(1, "one");


						two =menuSettings.getStandardHindi(1, "two");

						three =menuSettings.getStandardHindi(1, "three");

						forText =menuSettings.getStandardHindi(1, "for_text");

						semiStructuredMain =menuSettings.getSemiStructuredHindi(1, 0, 0, 0,"opt_1");

						structuredMain =menuSettings.getStructuredHindi(1, 0, 0, 0, "opt_1");

						unstructuredMain =menuSettings.getUnstructuredHindi(1, 0, 0, 0, "opt_1");
						structuredOne =menuSettings.getStructuredHindi(1, 1, 0, 0, "opt_1");
						structuredTwo =menuSettings.getStructuredHindi(1, 1, 0, 0, "opt_2");
						semiStructuredOne =menuSettings.getSemiStructuredHindi(1, 1, 0, 0, "opt_1");
						semiStructuredTwo =menuSettings.getSemiStructuredHindi(1, 1, 0, 0, "opt_2");
						semiStructuredThree =menuSettings.getSemiStructuredHindi(1, 1, 2, 0,	"opt_2");
						semiStructuredRecording =menuSettings.getSemiStructuredHindi(1, 1, 2, 0, "opt_1");
						semiStructuredCancelled =menuSettings.getSemiStructuredHindi(1, 1, 3, 0, "opt_1");
						semiStructuredConfirm =menuSettings.getSemiStructuredHindi(1, 1, 4, 0, "opt_1");
						semiStructuredRerecord =menuSettings.getSemiStructuredHindi(1, 1, 4,	0, "opt_2");
						semiStructuredRecorded =menuSettings.getSemiStructuredHindi(1, 1, 2,	0, "opt_3");
						unstructuredFeedbackRecord =menuSettings.getUnstructuredHindi(1, 1,0, 0, "opt_1");
						structuredAnswerYes =menuSettings.getStructuredHindi(1, 1, 1, 0,	"opt_1");
						structuredAnswerNo =menuSettings.getStructuredHindi(1, 1, 1, 0,	"opt_2");
						unstructuredConfirm =menuSettings.getUnstructuredHindi(1, 2, 1, 0,"opt_1");
						unstructuredRerecord =menuSettings.getUnstructuredHindi(1, 2, 1, 0,"opt_2");
						unstructuredRecorded =menuSettings.getUnstructuredHindi(1, 1, 0, 0,"opt_2");

						ivrsMenuSettingsBean.setLanguage_to_display(languageToDIsplay);
						ivrsMenuSettingsBean.setWelcome_message(welcomeMessage);
						ivrsMenuSettingsBean.setFarewell(farewell);
						ivrsMenuSettingsBean.setSemi_structured(semiStructured);
						ivrsMenuSettingsBean.setStructured(structured);
						ivrsMenuSettingsBean.setUnstructured(unstructured);
						ivrsMenuSettingsBean.setPress(press);
						ivrsMenuSettingsBean.setOne(one);
						ivrsMenuSettingsBean.setTwo(two);
						ivrsMenuSettingsBean.setThree(three);
						ivrsMenuSettingsBean.setFor_text(forText);
						ivrsMenuSettingsBean.setStructured_main(structuredMain);
						ivrsMenuSettingsBean.setSemi_structured_main(semiStructuredMain);
						ivrsMenuSettingsBean.setUnstructured_main(unstructuredMain);
						ivrsMenuSettingsBean.setStructured_one(structuredOne);
						ivrsMenuSettingsBean.setStructured_two(structuredTwo);
						ivrsMenuSettingsBean.setSemi_structured_one(semiStructuredOne);
						ivrsMenuSettingsBean.setSemi_structured_two(semiStructuredTwo);
						ivrsMenuSettingsBean.setSemi_structured_three(semiStructuredThree);
						ivrsMenuSettingsBean.setSemi_structured_recording(semiStructuredRecording);
						ivrsMenuSettingsBean.setSemi_structured_cancelled(semiStructuredCancelled);
						ivrsMenuSettingsBean.setSemi_structured_confirm(semiStructuredConfirm);
						ivrsMenuSettingsBean.setSemi_structured_rerecord(semiStructuredRerecord);
						ivrsMenuSettingsBean.setSemi_structured_recorded(semiStructuredRecorded);
						ivrsMenuSettingsBean.setUnstructured_feedback_record(unstructuredFeedbackRecord);
						ivrsMenuSettingsBean.setStructured_answer_yes(structuredAnswerYes);
						ivrsMenuSettingsBean.setStructured_answer_no(structuredAnswerNo);
						ivrsMenuSettingsBean.setUnstructured_confirm(unstructuredConfirm);
						ivrsMenuSettingsBean.setUnstructured_rerecord(unstructuredRerecord);
						ivrsMenuSettingsBean.setUnstructured_recorded(unstructuredRecorded);
						ivrsMenuSettingsBean.setLanguage("Hindi");


					}

					else if(ln.equalsIgnoreCase("mr"))
					{
						languageToDIsplay = "Marathi";
						welcomeMessage =menuSettings.getStandardMarathi(1, "welcome_msg");
						farewell =menuSettings.getStandardMarathi(1, "thankyou_msg");

						semiStructured =menuSettings.getStandardMarathi(1, "semi_structured");
						structured =menuSettings.getStandardMarathi(1, "structured");
						unstructured =menuSettings.getStandardMarathi(1, "unstructured");

						press =menuSettings.getStandardMarathi(1, "press");
						one =menuSettings.getStandardMarathi(1, "one");
						two =menuSettings.getStandardMarathi(1, "two");
						three =menuSettings.getStandardMarathi(1, "three");
						forText =menuSettings.getStandardMarathi(1, "for_text");

						semiStructuredMain =menuSettings.getSemiStructuredMarathi(1, 0, 0, 0, "opt_1");
						structuredMain =menuSettings.getStructuredMarathi(1, 0, 0, 0, "opt_1");
						unstructuredMain =menuSettings.getUnstructuredMarathi(1, 0, 0, 0, "opt_1");
						structuredOne =menuSettings.getStructuredMarathi(1, 1, 0, 0, "opt_1");
						structuredTwo =menuSettings.getStructuredMarathi(1, 1, 0, 0, "opt_2");
						semiStructuredOne =menuSettings.getSemiStructuredMarathi(1, 1, 0, 0, "opt_1");
						semiStructuredTwo =menuSettings.getSemiStructuredMarathi(1, 1, 0, 0, "opt_2");
						semiStructuredThree =menuSettings.getSemiStructuredMarathi(1, 1, 2, 0,	"opt_2");

						semiStructuredRecording =menuSettings.getSemiStructuredMarathi(1, 1, 2, 0, "opt_1");
						semiStructuredCancelled =menuSettings.getSemiStructuredMarathi(1, 1, 3, 0, "opt_1");
						semiStructuredConfirm =menuSettings.getSemiStructuredMarathi(1, 1, 4, 0, "opt_1");
						semiStructuredRerecord =menuSettings.getSemiStructuredMarathi(1, 1, 4,	0, "opt_2");
						semiStructuredRecorded =menuSettings.getSemiStructuredMarathi(1, 1, 2,	0, "opt_3");
						unstructuredFeedbackRecord =menuSettings.getUnstructuredMarathi(1, 1, 0, 0, "opt_1");
						structuredAnswerYes =menuSettings.getStructuredMarathi(1, 1, 1, 0, "opt_1");
						structuredAnswerNo =menuSettings.getStructuredMarathi(1, 1, 1, 0, "opt_2");
						unstructuredConfirm =menuSettings.getUnstructuredMarathi(1, 2, 1, 0, "opt_1");
						unstructuredRerecord =menuSettings.getUnstructuredMarathi(1, 2, 1, 0, "opt_2");
						unstructuredRecorded =menuSettings.getUnstructuredMarathi(1, 1, 0, 0, "opt_2");

						ivrsMenuSettingsBean.setLanguage_to_display(languageToDIsplay);
						ivrsMenuSettingsBean.setWelcome_message(welcomeMessage);
						ivrsMenuSettingsBean.setFarewell(farewell);
						ivrsMenuSettingsBean.setSemi_structured(semiStructured);
						ivrsMenuSettingsBean.setStructured(structured);
						ivrsMenuSettingsBean.setUnstructured(unstructured);
						ivrsMenuSettingsBean.setPress(press);
						ivrsMenuSettingsBean.setOne(one);
						ivrsMenuSettingsBean.setTwo(two);
						ivrsMenuSettingsBean.setThree(three);
						ivrsMenuSettingsBean.setFor_text(forText);
						ivrsMenuSettingsBean.setStructured_main(structuredMain);
						ivrsMenuSettingsBean.setSemi_structured_main(semiStructuredMain);
						ivrsMenuSettingsBean.setUnstructured_main(unstructuredMain);
						ivrsMenuSettingsBean.setStructured_one(structuredOne);
						ivrsMenuSettingsBean.setStructured_two(structuredTwo);
						ivrsMenuSettingsBean.setSemi_structured_one(semiStructuredOne);
						ivrsMenuSettingsBean.setSemi_structured_two(semiStructuredTwo);
						ivrsMenuSettingsBean.setSemi_structured_three(semiStructuredThree);
						ivrsMenuSettingsBean.setSemi_structured_recording(semiStructuredRecording);
						ivrsMenuSettingsBean.setSemi_structured_cancelled(semiStructuredCancelled);
						ivrsMenuSettingsBean.setSemi_structured_confirm(semiStructuredConfirm);
						ivrsMenuSettingsBean.setSemi_structured_rerecord(semiStructuredRerecord);
						ivrsMenuSettingsBean.setSemi_structured_recorded(semiStructuredRecorded);
						ivrsMenuSettingsBean.setUnstructured_feedback_record(unstructuredFeedbackRecord);
						ivrsMenuSettingsBean.setStructured_answer_yes(structuredAnswerYes);
						ivrsMenuSettingsBean.setStructured_answer_no(structuredAnswerNo);
						ivrsMenuSettingsBean.setUnstructured_confirm(unstructuredConfirm);
						ivrsMenuSettingsBean.setUnstructured_rerecord(unstructuredRerecord);
						ivrsMenuSettingsBean.setUnstructured_recorded(unstructuredRecorded);
						ivrsMenuSettingsBean.setLanguage("Marathi");


					}	
					else 
					{
						response.sendError(512, "You have choosen a wrong Language");
					}

					request.setAttribute("IvrsMenuSettingsBean",ivrsMenuSettingsBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsMenuSettings.jsp");  
					requestDispatcher.forward(request, response);
				}


				/* This req_type is used for updating Ivrs Menu Settings
				 * IvrsMenuSettings.jsp
				 * SettingsModel/IvrsMenuSettings.java
				 * 
				 */
				if(req_type.equals("ivrsUpdate")){
					ln = (String)session.getAttribute("ln");

					System.out.println(ln);
					
					String welcomeMessage = request.getParameter("welcomeMessage");
					String thankingMessage = request.getParameter("thankingMessage");
					String mainMenuOne = request.getParameter("mainMenuOne");

					String semiStructuredOne = request.getParameter("semi_structured_one");
					String semiStructuredTwo = request.getParameter("semi_structured_two");
					String semiStructuredThree = request.getParameter("semi_structured_three");
					String semiStructuredRecording = request.getParameter("semi_structured_recording");
					String semiStructuredCancelled = request.getParameter("semi_structured_cancelled");
					String semiStructuredConfirm = request.getParameter("semi_structured_confirm");
					String semiStructuredRerecord = request.getParameter("semi_structured_rerecord");
					String semiStrucutredRecorded = request.getParameter("semi_strucutred_recorded");
					String semiStructured = request.getParameter("semi_structured");
					
					String structuredAnswerYes = request.getParameter("structured_answer_yes");
					String structuredAnswerNo = request.getParameter("structured_answer_no");
					String structured = request.getParameter("structured");

					String unstructuredFeedbackRecord = request.getParameter("unstructured_feedback_record");
					String unstructuredRecorded = request.getParameter("unstructured_recorded");
					String unstructuredConfirm = request.getParameter("unstructured_confirm");
					String unstructuredRerecord = request.getParameter("unstructured_rerecord");
					String unstructured = request.getParameter("unstructured");


					String mainMenuTwo = request.getParameter("mainMenuTwo");
					String mainMenuThree = request.getParameter("mainMenuThree");
					String responsePositive = request.getParameter("responsePositive");
					String responseNegative = request.getParameter("responseNegative");

					String language = "";
					String filePath=ConfigParams.LANGUAGEDIR;


					IvrsMenuSettings ivrsMenu = new IvrsMenuSettings();

					if(ln.equals("en")){
						language = "english";
						ivrsMenu.setStandard(1, "thankyou_msg", thankingMessage,"voice_thankyou","en_thanks_msg.wav");
						ivrsMenu.setStandard(1, "semi_structured", semiStructured, "voice_semi_structured", "en_semi_structured.wav");
						ivrsMenu.setStandard(1, "unstructured", unstructured, "voice_unstructured", "en_unstructured.wav");
						ivrsMenu.setStandard(1, "structured", structured, "voice_structured", "en_structured.wav");

						ivrsMenu.setSemiStructured(1, 0, 0, 0, "opt_1",mainMenuOne,"voice_1","en_mainMenuOne.wav");
						ivrsMenu.setSemiStructured(1, 1, 0, 0, "opt_1", semiStructuredOne,"voice_1","en_semi_structured_one.wav");
						ivrsMenu.setSemiStructured(1, 1, 0, 0, "opt_2", semiStructuredTwo,"voice_2","en_semi_structured_two.wav");
						ivrsMenu.setSemiStructured(1, 1, 2, 0, "opt_2", semiStructuredThree,"voice_2","en_semi_structured_three.wav");
						ivrsMenu.setSemiStructured(1, 1, 2, 0, "opt_1", semiStructuredRecording,"voice_1","en_semi_structured_recording.wav");
						ivrsMenu.setSemiStructured(1, 1, 3, 0, "opt_1", semiStructuredCancelled,"voice_1","en_semi_structured_cancelled.wav");
						ivrsMenu.setSemiStructured(1, 1, 4, 0, "opt_1", semiStructuredConfirm,"voice_1","en_semi_structured_confirm.wav");
						ivrsMenu.setSemiStructured(1, 1, 4, 0, "opt_2", semiStructuredRerecord,"voice_2","en_semi_structured_rerecord.wav");
						ivrsMenu.setSemiStructured(1, 1, 2, 0, "opt_3", semiStrucutredRecorded,"voice_3","en_semi_strucutred_recorded.wav");



						ivrsMenu.setStructured(1, 0, 0, 0, "opt_1", mainMenuThree,"voice_1","en_mainMenuThree.wav");
						ivrsMenu.setStructured(1, 1, 0, 0, "opt_1", responsePositive,"voice_1","en_responsePositive.wav");
						ivrsMenu.setStructured(1, 1, 0, 0, "opt_2", responseNegative,"voice_2","en_responseNegative.wav");
						ivrsMenu.setStructured(1, 1, 1, 0, "opt_1", structuredAnswerYes,"voice_1","en_structured_answer_yes.wav");
						ivrsMenu.setStructured(1, 1, 1, 0, "opt_2", structuredAnswerNo,"voice_2","en_structured_answer_no.wav");


						ivrsMenu.setUnstructured(1, 0, 0, 0, "opt_1",mainMenuTwo,"voice_1","en_mainMenuTwo.wav");
						ivrsMenu.setUnstructured(1, 1, 0, 0, "opt_1",unstructuredFeedbackRecord,"voice_1","en_unstructured_feedback_record.wav");
						ivrsMenu.setUnstructured(1, 1, 0, 0, "opt_2",unstructuredRecorded,"voice_2","en_unstructured_recorded.wav");
						ivrsMenu.setUnstructured(1, 2, 1, 0, "opt_1",unstructuredConfirm,"voice_1","en_unstructured_confirm.wav");
						ivrsMenu.setUnstructured(1, 2, 1, 0, "opt_2",unstructuredRerecord,"voice_2","en_unstructured_rerecord.wav");

						response.sendRedirect("Success.jsp");			
					}	

					if(ln.equals("hi")){
						language = "hindi";
						ivrsMenu.setStandardHindi(1, "thankyou_msg", thankingMessage,"voice_thankyou","hi_thanks_msg.wav");
						ivrsMenu.setStandardHindi(1, "semi_structured", semiStructured, "voice_semi_structured", "hi_semi_structured.wav");
						ivrsMenu.setStandardHindi(1, "structured", structured, "voice_structured", "hi_structured.wav");
						ivrsMenu.setStandardHindi(1, "unstructured", unstructured, "voice_unstructured", "hi_unstructured.wav");
						
						ivrsMenu.setStructuredHindi(1, 1, 0, 0, "opt_1", responsePositive,"voice_1","hi_responsePositive.wav");
						ivrsMenu.setStructuredHindi(1, 1, 0, 0, "opt_2", responseNegative,"voice_2","hi_responseNegative.wav");
						ivrsMenu.setStructuredHindi(1, 0, 0, 0, "opt_1", mainMenuThree,"voice_1","hi_mainMenuThree.wav");
						ivrsMenu.setStructuredHindi(1, 1, 1, 0, "opt_1", structuredAnswerYes,"voice_1","hi_structured_answer_yes.wav");
						ivrsMenu.setStructuredHindi(1, 1, 1, 0, "opt_2", structuredAnswerNo,"voice_2","hi_structured_answer_no.wav");

						
						ivrsMenu.setSemiStructuredHindi(1, 0, 0, 0, "opt_1",mainMenuOne,"voice_1","hi_mainMenuOne.wav");
						ivrsMenu.setSemiStructuredHindi(1, 1, 0, 0, "opt_1", semiStructuredOne,"voice_1","hi_semi_structured_one.wav");
						ivrsMenu.setSemiStructuredHindi(1, 1, 0, 0, "opt_2", semiStructuredTwo,"voice_2","hi_semi_structured_two.wav");
						ivrsMenu.setSemiStructuredHindi(1, 1, 2, 0, "opt_2", semiStructuredThree,"voice_2","hi_semi_structured_three.wav");
						ivrsMenu.setSemiStructuredHindi(1, 1, 2, 0, "opt_1", semiStructuredRecording,"voice_1","hi_semi_structured_recording.wav");
						ivrsMenu.setSemiStructuredHindi(1, 1, 3, 0, "opt_1", semiStructuredCancelled,"voice_1","hi_semi_structured_cancelled.wav");
						ivrsMenu.setSemiStructuredHindi(1, 1, 4, 0, "opt_1", semiStructuredConfirm,"voice_1","hi_semi_structured_confirm.wav");
						ivrsMenu.setSemiStructuredHindi(1, 1, 4, 0, "opt_2", semiStructuredRerecord,"voice_2","hi_semi_structured_rerecord.wav");
						ivrsMenu.setSemiStructuredHindi(1, 1, 2, 0, "opt_3", semiStrucutredRecorded,"voice_3","hi_semi_strucutred_recorded.wav");
						
						
						ivrsMenu.setUnstructuredHindi(1, 0, 0, 0, "opt_1",mainMenuTwo,"voice_1","hi_mainMenuTwo.wav");
						ivrsMenu.setUnstructuredHindi(1, 1, 0, 0, "opt_1",unstructuredFeedbackRecord,"voice_1","hi_unstructured_feedback_record.wav");
						ivrsMenu.setUnstructuredHindi(1, 1, 0, 0, "opt_2",unstructuredRecorded,"voice_2","hi_unstructured_recorded.wav");
						ivrsMenu.setUnstructuredHindi(1, 2, 1, 0, "opt_1",unstructuredConfirm,"voice_1","hi_unstructured_confirm.wav");
						ivrsMenu.setUnstructuredHindi(1, 2, 1, 0, "opt_2",unstructuredRerecord,"voice_1","hi_unstructured_rerecord.wav");
						
						response.sendRedirect("Success.jsp");
					}


					if(ln.equals("mr")){
						ivrsMenu.setStandardMarathi(1, "thankyou_msg", thankingMessage,"voice_thankyou","mr_thanks_msg.wav");
						ivrsMenu.setStandardMarathi(1, "semi_structured", semiStructured, "voice_semi_structured", "mr_semi_structured.wav");
						ivrsMenu.setStandardMarathi(1, "structured", structured, "voice_structured", "mr_structured.wav");
						ivrsMenu.setStandardMarathi(1, "unstructured", unstructured, "voice_unstructured", "mr_unstructured.wav");
						
						
						ivrsMenu.setStructuredMarathi(1, 0, 0, 0, "opt_1", mainMenuThree,"voice_1","mr_mainMenuThree.wav");
						ivrsMenu.setStructuredMarathi(1, 1, 0, 0, "opt_1", responsePositive,"voice_1","mr_responsePositive.wav");
						ivrsMenu.setStructuredMarathi(1, 1, 0, 0, "opt_2", responseNegative,"voice_2","mr_responseNegative.wav");
						ivrsMenu.setStructuredMarathi(1, 1, 1, 0, "opt_1", structuredAnswerYes,"voice_1","mr_structured_answer_yes.wav");
						ivrsMenu.setStructuredMarathi(1, 1, 1, 0, "opt_2", structuredAnswerNo,"voice_2","mr_structured_answer_no.wav");

						
						ivrsMenu.setSemiStructuredMarathi(1, 0, 0, 0, "opt_1",mainMenuOne,"voice_1","mr_mainMenuOne.wav");
						ivrsMenu.setSemiStructuredMarathi(1, 1, 0, 0, "opt_1", semiStructuredOne,"voice_1","mr_semi_structured_one.wav");
						ivrsMenu.setSemiStructuredMarathi(1, 1, 0, 0, "opt_2", semiStructuredTwo,"voice_2","mr_semi_structured_two.wav");
						ivrsMenu.setSemiStructuredMarathi(1, 1, 2, 0, "opt_2", semiStructuredThree,"voice_2","mr_semi_structured_three.wav");
						ivrsMenu.setSemiStructuredMarathi(1, 1, 2, 0, "opt_1", semiStructuredRecording,"voice_1","mr_semi_structured_recording.wav");
						ivrsMenu.setSemiStructuredMarathi(1, 1, 3, 0, "opt_1", semiStructuredCancelled,"voice_1","mr_semi_structured_cancelled.wav");
						ivrsMenu.setSemiStructuredMarathi(1, 1, 4, 0, "opt_1", semiStructuredConfirm,"voice_1","mr_semi_structured_confirm.wav");
						ivrsMenu.setSemiStructuredMarathi(1, 1, 4, 0, "opt_2", semiStructuredRerecord,"voice_2","mr_semi_structured_rerecord.wav");
						ivrsMenu.setSemiStructuredMarathi(1, 1, 2, 0, "opt_3", semiStrucutredRecorded,"voice_3","mr_semi_strucutred_recorded.wav");
						
						ivrsMenu.setUnstructuredMarathi(1, 1, 0, 0, "opt_1",unstructuredFeedbackRecord,"voice_1","mr_unstructured_feedback_record.wav");
						ivrsMenu.setUnstructuredMarathi(1, 1, 0, 0, "opt_2",unstructuredRecorded,"voice_2","mr_unstructured_recorded.wav");
						ivrsMenu.setUnstructuredMarathi(1, 2, 1, 0, "opt_1",unstructuredConfirm,"voice_1","mr_unstructured_confirm.wav");
						ivrsMenu.setUnstructuredMarathi(1, 2, 1, 0, "opt_2",unstructuredRerecord,"voice_1","mr_unstructured_rerecord.wav");
						ivrsMenu.setUnstructuredMarathi(1, 0, 0, 0, "opt_1",mainMenuTwo,"voice_1","mr_mainMenuTwo.wav");
						
						response.sendRedirect("Success.jsp");				
					}			
				}
				
				
				
				
				/* This req_type is used for Displaying well information
				 * WellInformation.jsp
				 * SettingsModel/WellInformation.java
				 * 
				 */
				else if(req_type.equals("wellsummary"))
				{
					WellInformation wellInfoNew = new WellInformation();
					WellDataBean wellDataBean = new WellDataBean();

					wellDataBean.setDistrict_name(wellInfoNew.districtName());

					wellDataBean.setDistrict_to_tehsil(wellInfoNew.districtToTehsil());

					wellDataBean.setTehsil_to_village(wellInfoNew.tehsilToVillage());

					request.setAttribute("wellinfo",wellDataBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("WellInformation.jsp");  
					requestDispatcher.forward(request, response);
				}
				/*
				 * for selecting date for OrderSummary
				 * DatePick.jsp
				 * 
				 */
				else if(req_type.equals("datePick"))
				{
					response.sendRedirect("DatePick.jsp");
				}
				/*
				 * Loads Order Summary with product lists and sold quantity units according to date entered
				 * DatePick.jsp , OrderSummary.jsp 
				 * OrderModel/OrderModel and ProductModel/ProductDetails 
				 * ProductBean/ProductBean.java and OrderBean/OrderBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("orderSummary"))
				{
					//recieves dates from DatePick.jsp
					String fromDate=request.getParameter("FromDate");
					String toDate=request.getParameter("ToDate");
					System.out.println(fromDate+" "+toDate);
					fromDate = fromDate == null ? "" : fromDate;
					toDate = toDate == null ? "" : toDate;

					//Date is validated using DateHelper
					boolean isValidFromDate = DateHelper.getDate(fromDate) != null
							? true
									: false;
					boolean isValidToDate = DateHelper.getDate(toDate) != null
							? true
									: false;
					//If both dates entered are valid then the order summary is loaded 
					if(isValidFromDate && isValidToDate){
						ProductDetails productDetails=new ProductDetails();
						OrderModel orderModel=new OrderModel();

						ProductBean productBean=new ProductBean();
						OrderBean orderBean=new OrderBean();

						//list of products that have been processed
						productBean.setProcessed_product_list(productDetails.getProcessedProductList());
						//list of quantity units
						productBean.setProduct_quantity(productDetails.getProductQuantity());
						//total  units sold of each quantity		
						Object totalUnitSold[][]=orderModel.getTotalUnitSold(fromDate, toDate,productDetails.getProcessedProductList() , productDetails.getProductQuantity()); 
						orderBean.setTotal_unit_sold(totalUnitSold);
						//overall total amount of product sold
						Float totalQuantitySold[]=orderModel.getTotalQuanitySold(fromDate, toDate, totalUnitSold,productDetails.getProductQuantity() );
						orderBean.setTotal_quantity_sold(totalQuantitySold);

						request.setAttribute("productBean",productBean);
						request.setAttribute("orderBean",orderBean);

						RequestDispatcher requestDispatcher=request.getRequestDispatcher("OrderSummary.jsp");  
						requestDispatcher.forward(request, response);  
					}
					//if either of the dates entered are invalid
					else{
						response.sendRedirect("DatePick.jsp?invalidDate=true");
					}

				} 
				/*
				 * for selecting date for GroupOrderSummary
				 * GroupDatePick.jsp
				 * 
				 */
				else if(req_type.equals("groupDatePick"))
				{
					response.sendRedirect("GroupDatePick.jsp");
				}
				/*
				 * Loads Group Order Summary with product lists and sold quantity units according to date entered
				 * GroupDatePick.jsp , GroupOrderSummary.jsp 
				 * OrderModel/OrderModel and ProductModel/ProductDetails and GroupModel/GroupDetails
				 * ProductBean/ProductBean.java and OrderBean/OrderBean.java and GroupBean/GroupBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("groupOrderSummary"))
				{
					//recieves dates from GroupDatePick.jsp
					String fromDate=request.getParameter("FromDate");
					String toDate=request.getParameter("ToDate");
					System.out.println(fromDate+" "+toDate);
					fromDate = fromDate == null ? "" : fromDate;
					toDate = toDate == null ? "" : toDate;

					//Date is validated using DateHelper
					boolean isValidFromDate = DateHelper.getDate(fromDate) != null
							? true
									: false;
					boolean isValidToDate = DateHelper.getDate(toDate) != null
							? true
									: false;
					//If both dates entered are valid then the order summary is loaded 
					if(isValidFromDate && isValidToDate){
						LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");						
						GroupDetails groupDetails=new GroupDetails();
						GroupBean groupBean=new GroupBean();
						
						//sets groups list 
						groupBean.setGroup_details(groupDetails.getGroupDetails(loginUser.getOrg_id()));
						
						request.setAttribute("groupBean",groupBean);
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("GroupOrderSummary.jsp?fromDate="+fromDate+"&toDate="+toDate);  
						requestDispatcher.forward(request, response);  
					}
					//if either of the dates entered are invalid
					else{
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("GroupDatePick.jsp");  
						requestDispatcher.forward(request, response);  
					}
					}
				else if(req_type.equalsIgnoreCase("groupWiseBills")){
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");		
					BillSettings billSettings=new BillSettings();
					VoiceMessages voiceMessages=new VoiceMessages();
					OrderModel orderModel=new OrderModel();
					BillingBean billingBean=new BillingBean();
					GroupBean groupBean=new GroupBean();
					VoiceTextMessagesBean voiceTextMessagesBean=new VoiceTextMessagesBean();
					OrderBean orderBean=new OrderBean();
					
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					String groupId=request.getParameter("groupId");
					String groupName=request.getParameter("groupName");
					
					System.out.println(fromDate);
					System.out.println(toDate);
					System.out.println(groupId);
					System.out.println(groupName);
					//setting the bill settings of the organization in the bean
					billingBean.setBill_settings(billSettings.getBillSettings(loginUser.getOrg_id()));
					
					Object[][] processedMessages=voiceMessages.getProcessedMessages(groupId, fromDate, toDate);
					
					voiceTextMessagesBean.setProcessed_messages(processedMessages);
					String billId[]=new String[processedMessages.length];
					
					ArrayList<Object[][]> savedOrder = new ArrayList<Object[][]>();
					String billTotal[]=new String[processedMessages.length];
					for(int i=0;i<processedMessages.length;i++){
						String messageId=(String)processedMessages[i][0];
						billId[i]=billSettings.getBillId(messageId);
						savedOrder.add(orderModel.getSavedOrder(messageId));
						billTotal[i]=billSettings.getBillTotal(messageId);
					}
				
						orderBean.setSave_order(savedOrder);
						billingBean.setBill_id_list(billId);
						voiceTextMessagesBean.setProcessed_messages(processedMessages);
					
						billingBean.setBill_total_list(billTotal);
						
						groupBean.setGroups_id(groupId);
						groupBean.setGroup_name(groupName);
						request.setAttribute("voiceTextMessagesBean", voiceTextMessagesBean);
						request.setAttribute("billingBean",billingBean);
						request.setAttribute("orderBean", orderBean);
						request.setAttribute("groupBean", groupBean);
						RequestDispatcher rd=request.getRequestDispatcher("GroupWiseBills.jsp");  
						rd.forward(request, response); 
					 
				}
				/*
				 * for selecting date for FullOrderSummary
				 * FullReportDate.jsp
				 * 				 */
				else if(req_type.equals("fullReportDate"))
				{
					response.sendRedirect("FullReportDate.jsp");
				}
				/*
				 * Loads Order Summary with product lists and sold quantity units according to date entered
				 * DatePick.jsp , OrderSummary.jsp 
				 * OrderModel/OrderModel and ProductModel/ProductDetails 
				 * ProductBean/ProductBean.java and OrderBean/OrderBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("fullReport"))
				{
					// receives dates from DatePick.jsp
					String fromDate=request.getParameter("FromDate");
					String toDate=request.getParameter("ToDate");
					System.out.println(fromDate+" "+toDate);
					fromDate = fromDate == null ? "" : fromDate;
					toDate = toDate == null ? "" : toDate;

					//Date is validated using DateHelper
					boolean isValidFromDate = DateHelper.getDate(fromDate) != null
							? true
									: false;
					boolean isValidToDate = DateHelper.getDate(toDate) != null
							? true
									: false;
					//If both dates entered are valid then the order summary is loaded 
					if(isValidFromDate && isValidToDate){
						OrderModel order=new OrderModel();
						ProductDetails productDetails=new ProductDetails();
						OrderBean orderBean=new OrderBean();
						ProductBean productBean= new ProductBean();
						//list of products processed 
						productBean.setProcessed_product_list(productDetails.getProcessedProductList());
						//list of quantities
						productBean.setProduct_quantity(productDetails.getProductQuantity());

						//total units sold of each quantity
						Object totalUnitSold[][]=order.getTotalUnitSold(fromDate, toDate,productDetails.getProcessedProductList() ,productDetails.getProductQuantity());
						orderBean.setTotal_unit_sold(totalUnitSold);

						Float totalQuantitySold[]=order.getTotalQuanitySold(fromDate, toDate, totalUnitSold,productDetails.getProductQuantity());//overall total amount of product sold
						orderBean.setTotal_quantity_sold(totalQuantitySold);
						request.setAttribute("productBean", productBean);
						request.setAttribute("orderBean",orderBean);

						RequestDispatcher rd=request.getRequestDispatcher("FullOrderSummary.jsp?fromDate="+fromDate+"&toDate="+toDate);  
						rd.forward(request, response); 
					}
					else{
						response.sendRedirect("FullReportDate.jsp?invalidDate=true");
					}

				}
				
				/*
				 * For authenticating the username and password & Redirects to Dashboard.jsp if user is valid
				 * Login.jsp and Dashboard.jsp 
				 * AuthenticatorModel/Authenticate 
				 * AuthenticatorBean/LoginBean
				 * 
				 * 				 */
				else if (req_type.equalsIgnoreCase("verifyUser"))
				{
					String username = request.getParameter("user");
					System.out.println("Username:"+username);
					String password = request.getParameter("password");

					System.out.println("Pass:"+password);
					Authenticate authenticate=new Authenticate();
					LoginBean loginUser=new LoginBean();
					loginUser=(LoginBean)authenticate.authenticate(username,password);

					// the username is not null if the user is valid
					if(loginUser.getUsername()!=null)	
					{
						session.setAttribute("loginUser", loginUser);
						response.sendRedirect("IvrsServlet?redirect=1");

					}
					//user is invalid 
					else{
						System.out.println("invalid ");
						RequestDispatcher rd=request.getRequestDispatcher("Login.jsp?auth=failed"); 
						rd.forward(request, response);  

					}
				}
				/*
				 * Invalidates the session when user clicks on Sign out on any page
				 * Dashboard.jsp, GlobalSettings.jsp ,Login.jsp
				 * 
				 */
				else if(req_type.equals("signout"))
				{
					request.getSession().invalidate();
					System.out.println("Session is in validated. User is signed out.");
					response.sendRedirect("Login.jsp");
				}
				/*
				 * Used for directing to Document.jsp from Login.jsp page
				 * Login.jsp , Document.jsp
				 * 
				 */
				else if(req_type.equalsIgnoreCase("document")) 
				{
					response.sendRedirect("Document.jsp");
				}
				/*
				 * Loads the existing bill settings if any 
				 * BillSettings.jsp
				 * SettingsModel/BillSettings
				 * AuthenticatorBean/LoginBean and SettingsBean/BillingBean 
				 * 
				 */
				else if(req_type.equalsIgnoreCase("billSettings"))
				{
					BillSettings billSettings=new BillSettings();
					// loginUser required for org_id
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");

					BillingBean billingBean=new BillingBean();
					//update signifies if the page is being displayed after updating the settings
					String update=request.getParameter("update");


					if(update!=null)
						billingBean.setUpdate(update);
					if(billSettings.getBillSettings(loginUser.getOrg_id())!=null)
					{
						//existing bill_settings
						billingBean.setBill_settings(billSettings.getBillSettings(loginUser.getOrg_id()));
						request.setAttribute("billingBean", billingBean);
					}
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("BillSettings.jsp");  
					requestDispatcher.forward(request, response);  
				}

				/*
				 * Updates the bill settings entered (submit button on BillSettings.jsp)
				 * BillSettings.jsp
				 * SettingsModel/BillSettings
				 * AuthenticatorBean/LoginBean and SettingsBean/BillingBean 
				 * 
				 */
				else if(req_type.equalsIgnoreCase("updateBill"))
				{
					String orgName=request.getParameter("organizationName");
					String orgAddLine1=request.getParameter("organizationAddress1");
					String orgAddLine2=request.getParameter("organizationAddress2");
					String orgAddCity=request.getParameter("organizationAddressCity");
					String orgContact=request.getParameter("organizationContact");
					String orgExtra=request.getParameter("extra");
					String orgFooter1=request.getParameter("footer1");
					String orgFooter2=request.getParameter("footer2");
					BillSettings billSettings=new BillSettings();
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
					boolean update=billSettings.updateBillSettings(loginUser.getOrg_id(),orgName,orgAddLine1, orgAddLine2, orgAddCity, orgContact, orgExtra, orgFooter1, 

							orgFooter2);
					System.out.println("update "+update);


					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=billSettings&update="+update);  
					requestDispatcher.forward(request, response);  
				}
				/*
				 * Loads product details to on clicking on Product Form on GlobalSettings
				 * ProductForm.jsp , GloablSettings.jsp
				 * ProductModel/ProductDetail.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if(req_type.equals("productForm"))
				{
					ProductDetails productDetails=new ProductDetails();
					ProductBean productBean=new ProductBean();
					//list of quantities					
					productBean.setProduct_quantity_detail(productDetails.getProductQuantityDetails());
					//list of product names ,price ,id
					productBean.setProduct_detail(productDetails.getProductDetail());

					request.setAttribute("productBean", productBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("ProductForm.jsp");  
					requestDispatcher.forward(request, response); 
				}
				/*
				 * Adds new product quantity units (Add new quantity button : Quantity tab)
				 * ProductForm.jsp
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if (req_type.equalsIgnoreCase("addProductQuantity"))
				{
					//list of quantities entered on the form
					String productQuantity[] = request.getParameterValues("quantity");
					int count=0;
					for(int i=0;productQuantity!=null && i<productQuantity.length;i++){
						//checks if any value is actually entered or not
						if(productQuantity[i].equals("0")){	
							RequestDispatcher rd=request.getRequestDispatcher("IvrsServlet?req_type=productForm");  
							rd.forward(request, response);
							count++;
							
						}
					}
					//values are entered on the form
					if(count==0)						
					{
						ProductDetails product=new ProductDetails();
						//inserts the quantity in th database
						product.insertQuantity(productQuantity);	
					}
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=productForm");  
					requestDispatcher.forward(request, response);  
				}
				/*
				 * Updates product quantity units (Update button :quantity tab)
				 * ProductForm.jsp
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("updateMultiQuans"))
				{
					//gets the updated list from the jsp
					String[] updateQuans= request.getParameterValues("updateQuansList");
					ProductDetails productDetails=new ProductDetails();
					//updates the quantity in the database
					productDetails.updateQuantity(updateQuans);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=productForm");  
					requestDispatcher.forward(request, response);  

				}
				/*
				 * Deletes selected product quantity units ( Delete button :Quantity tab)
				 * ProductForm.jsp
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("deleteMultiQuans"))
				{
					//gets quantities selected to be deleted
					String[] deletedQuans= request.getParameterValues("existingQuans");
					ProductDetails productDetails=new ProductDetails();
					// deletes the quantity from the database
					productDetails.deleteQuantity(deletedQuans);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=productForm");  
					requestDispatcher.forward(request, response);  

				}
				/*
				 * Updates product price (Update button : Product Price tab)
				 * ProductForm.jsp
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("updateProductDetail"))
				{
					//list of updated prices of products
					String[] updatePrice= request.getParameterValues("price");
					String[] updatePriceId= request.getParameterValues("priceid");
					
					ProductDetails productDetails=new ProductDetails();
					//updates the prices in the database
					productDetails.updatePrice(updatePrice,updatePriceId);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=productForm");  
					requestDispatcher.forward(request, response);  		
				}
				/*
				 * Updates product name (Update button : Product List tab)
				 * ProductForm.jsp
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("updateMultiProducts"))
				{
					//list of updated names
					String[] updatePros= request.getParameterValues("updateProductsList");
					ProductDetails productDetails=new ProductDetails();
					//updates the product names in the database
					productDetails.updateProduct(updatePros);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=productForm");  
					requestDispatcher.forward(request, response);  

				}
				/*
				 * Deletes products (Delete button : Product List tab)
				 * ProductForm.jsp
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("deleteMultiProducts"))
				{
					//list of selected products for deletion
					String[] deleteProducts= request.getParameterValues("existingProducts");
					ProductDetails product=new ProductDetails();
					//deletes the product from database
					product.deleteProduct(deleteProducts);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=productForm");  
					requestDispatcher.forward(request, response);  
				}
				/*
				 * Adds product name and price(Add new product button : Product list tab)
				 * ProductForm.jsp
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if (req_type.equalsIgnoreCase("addProductNameAndPrice"))
				{
					//list of product names entered
					String productsName[] = request.getParameterValues("products");
					//list of product prices entered
					String[] price= request.getParameterValues("price");	
					ProductDetails productDetails=new ProductDetails();
					//product name and price are added to the database
					productDetails.insertProduct(productsName, price);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=productForm");  
					requestDispatcher.forward(request, response);  
				}
				/*
				 * Displays product form with product name and price (Print list button : Product Price tab)
				 * ProductForm.jsp
				 * ProductModel/ProductDetails.java
				 * ProductBean/ProductBean.java
				 * 
				 */
				else if(req_type.equals("printlist")){

					ProductDetails productDetails=new ProductDetails();
					ProductBean productBean=new ProductBean();
					//List of product with names and price
					productBean.setProduct_detail(productDetails.getProductDetail());
					request.setAttribute("productBean", productBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("PrintList.jsp");  
					requestDispatcher.forward(request, response);  
				}

				/*
				 * Display Details of all the members, their numbers and the lists of the groups to which each member belongs.
				 * GlobalGroupChange.jsp
				 * MemberModel/MemberDetails.java and GroupModel/GroupDetails.java
				 * MemberBean/MemberBean.java and GroupBean/GroupBea.java
				 * 
				 */
				else if(req_type.equals("globalGroupChange"))
				{
					System.out.println("hii");
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
					MemberDetails memberDetails = new MemberDetails();
					GroupDetails groupDetails = new GroupDetails();
					GroupBean groupBean=new GroupBean();
					MemberBean memberBean = new MemberBean();
					String groupId = request.getParameter("groupId");
					System.out.print(groupId);

					memberBean.setMember_details(memberDetails.getMemberDetails(loginUser.getOrg_id(),groupId,loginUser.getParent_org()));
					groupBean.setArray_list(groupDetails.getGroupDetails(loginUser.getOrg_id(), memberBean.getMember_details()));				

					request.setAttribute("groupBean",groupBean);
					request.setAttribute("memberBean", memberBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("GlobalGroupChange.jsp"); 
					System.out.println("hiiiiiiiiiiiiiiiii");
					requestDispatcher.forward(request, response); 
				}

				/*
				 * Lists all the publishers and adds new publishers as well
				 * Publisher.jsp
				 * PublisherModel/PublisherDetails.java
				 * PublisherBean/PublisherBean.java
				 * 
				 */
				else if(req_type.equals("publish"))
				{
					PublisherDetails publisherDetails = new PublisherDetails();
					PublisherBean publisherBean = new PublisherBean();

					publisherBean.setPublisher_details(publisherDetails.getPublisherDetails());
					System.out.println("=========================================");
					request.setAttribute("publisherBean",publisherBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("Publisher.jsp");  
					requestDispatcher.forward(request, response); 
				}


				/* 
				 * Manages members (add , change groups of the members) , Reports (incoming . outgoing calls ) , delete groups
				 * Manage.jsp
				 * MessageModel/IncomingOutgoing.java , GroupModel/GroupDetails.java , MemberModel/MemberDetails.java
				 * MessageBean/IncomingOutgoingBean.java , GroupBean/GroupBean.java , MemberBean/MemberBean.java
				 * 
				 */
				else if(req_type.equals("manage"))
				{
					String setIncomingReport= "false";

					if(request.getParameter("setincomingreport")!=null){
						setIncomingReport=request.getParameter("setincomingreport");
					}

					System.out.println(setIncomingReport+" setincoming");
					String setOutgoingReport= "false";

					if(request.getParameter("setoutgoingreport")!=null){
						setOutgoingReport=request.getParameter("setoutgoingreport");
					}

					System.out.println(setOutgoingReport+" setoutgoing");
					String groupId=request.getParameter("groupId");
					System.out.println(groupId);
					String iFromDate= request.getParameter("ifromdate");
					System.out.println("from date in servlet"+iFromDate);
					String iToDate= request.getParameter("itodate");
					System.out.println("to date in servlet"+iToDate);
					String oFromDate= request.getParameter("ofromdate");
					System.out.println("from date in servlet"+oFromDate);
					String oToDate= request.getParameter("otodate");
					System.out.println("to date in servlet"+oToDate);

					MemberDetails memberDetails = new MemberDetails();
					MemberBean memberBean = new MemberBean();
					memberBean.setGroup_member_details(memberDetails.getGroupMemberDetails(groupId));

					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
					GroupDetails groupDetails = new GroupDetails();
					GroupBean groupBean=new GroupBean();
					groupBean.setChange_group(groupDetails.changeGroup(groupId,loginUser.getOrg_id()));
					System.out.println("hiiiiiii");
					groupBean.setGroups_id(groupId);
					groupBean.setManage_settings(groupDetails.manageSettings(groupId));
					System.out.println("hi-1");
					IncomingOutgoing incomingOutgoing = new IncomingOutgoing();
					IncomingOutgoingBean incomingOutgoingBean = new IncomingOutgoingBean();
					incomingOutgoingBean.setIncoming_calls(incomingOutgoing.getIncomingCalls(groupId,iFromDate,iToDate));
					incomingOutgoingBean.setOutgoing_calls(incomingOutgoing.getOutgoingCalls(groupId,oFromDate,oToDate));
					incomingOutgoingBean.setPending_calls(incomingOutgoing.getPendingCalls(groupId));
					System.out.println("hi-2");
					request.setAttribute("groupbean",groupBean);
					request.setAttribute("memberBean", memberBean);
					request.setAttribute("incomingOutgoingBean",incomingOutgoingBean);
					System.out.println("hi-3");
					if(setIncomingReport.equals("true") && setIncomingReport!=null){
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("Manage.jsp?#settings"); 
						//response.sendRedirect("Manage.jsp?groupBean="+groupBean+"&incomingOutgoingBean="+incomingOutgoingBean+"&#reports");
						requestDispatcher.forward(request, response);
					}
					else if(setOutgoingReport.equals("true") && setOutgoingReport!=null)
					{
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("Manage.jsp?#reports"); 
						System.out.println("going to manage.jsp");
						requestDispatcher.forward(request, response);
					}
					else{
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("Manage.jsp"); 
						System.out.println("going to manage.jsp");
						requestDispatcher.forward(request, response);
					}
				}

				/*
				 * This req_type gets all the incoming calls according to the date specified.
				 * Manage.jsp
				 * MessageModel/IncomingOutgoing.java , GroupModel/GroupDetails.java , MemberModel/MemberDetails.java
				 * MessageBean/IncomingOutgoingBean.java , GroupBean/GroupBean.java , MemberBean/MemberBean.java
				 * 
				 */
				else if (req_type.equals("manageIncomingCalls"))
				{
					String groupId=request.getParameter("groupId");
					String iFromDate= request.getParameter("ifromdate");
					String iToDate= request.getParameter("itodate");

					IncomingOutgoing incomingOutgoing = new IncomingOutgoing();
					IncomingOutgoingBean incomingOutgoingBean = new IncomingOutgoingBean();
					GroupBean groupBean=new GroupBean();

					incomingOutgoingBean.setIncoming_calls(incomingOutgoing.getIncomingCalls(groupId,iFromDate,iToDate));

					request.setAttribute("groupbean",groupBean);
					request.setAttribute("incomingOutgoingBean",incomingOutgoingBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=manage&groupId="+groupId+"&setincomingreport=true&setoutgoingreport=false"); 
					requestDispatcher.forward(request, response); 				

				}

				/*
				 * This req_type gets all the outgoing calls according to the date specified.
				 * Manage.jsp
				 * MessageModel/IncomingOutgoing.java , GroupModel/GroupDetails.java , MemberModel/MemberDetails.java
				 * MessageBean/IncomingOutgoingBean.java , GroupBean/GroupBean.java , MemberBean/MemberBean.java
				 * 
				 */
				else if (req_type.equals("manageOutgoingCalls"))
				{
					String groupId=request.getParameter("groupId");
					String oFromDate= request.getParameter("ofromdate");
					String oToDate= request.getParameter("otodate");

					IncomingOutgoing incomingOutgoing = new IncomingOutgoing();
					GroupBean groupBean=new GroupBean();
					IncomingOutgoingBean incomingOutgoingBean = new IncomingOutgoingBean();

					incomingOutgoingBean.setOutgoing_calls(incomingOutgoing.getOutgoingCalls(groupId,oFromDate,oToDate));

					request.setAttribute("groupbean",groupBean);					
					request.setAttribute("incomingOutgoingBean",incomingOutgoingBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=manage&groupId="+groupId+"&setoutgoingreport=true&setincomingreport=false"); 
					requestDispatcher.forward(request, response); 
				}
				
				/* 
				 * Updates the login details or assigns login to the existing members
				 * GlobalGroupChange.jsp -> Edit member Dialog box.
				 * MemberModel/MemberDetails.java 
				 * MemberBean/MemberBean.java , AuthenticatorBean/LoginBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("updateMemberDetails"))
				{
					String memberId=request.getParameter("memberId");
					String memberName=request.getParameter("memberName");
					System.out.println("memberName"+memberName);
					String memberNumber=request.getParameter("memberNumber");
					System.out.println("memberNumber"+memberNumber);
					String memberAddress=request.getParameter("memberAddress");
					//String memberEmailId=request.getParameter("memberEmailId");
					
					String username=request.getParameter("username");
					System.out.println(username);
					String password=request.getParameter("password");
					String userLogin=request.getParameter("userLogin");
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
					String parentOrg= loginUser.getOrg_id();

					System.out.println("PArent Org id : "+parentOrg);
					System.out.println("assign login  : "+userLogin);

					MemberDetails memberDetails = new MemberDetails();
					memberDetails.updateMember(memberId,memberName, memberNumber,memberAddress);
					if(userLogin.equalsIgnoreCase("true")){
						boolean assign=memberDetails.updateMemberDetails(memberName, memberNumber, memberId, loginUser.getParent_org(), username, password, userLogin);
						if(assign)
							response.getWriter().write("Assigned Login");
						else
							response.getWriter().write("This member is already assigned with login credentials.");

					}
					else{
						response.getWriter().write("Updated successfully");
					}
				}
				/*
				 * Adds new members in a group. If one is not a member of any group it adds to the publisher. 
				 * Manage.jsp -> Members tab (Add new members)
				 * MemeberModel/Memberdetails.java , PublisherModel/PublisherDetails.java
				 * AuthenticatorBean/LoginBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("addNewMember")){
					System.out.println("Inside Add member");
					String memberName=request.getParameter("memberName");
					String memberNumber=request.getParameter("memberNumber");
					String memberAddress=request.getParameter("memberAddress");
					String memberEmailId=request.getParameter("memberEmailId");
					String memberRole=request.getParameter("memberRole");
					System.out.println("All five set");
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
					String orgId=loginUser.getOrg_id();
					System.out.println("Login bean");
					String groupId=request.getParameter("groupId");
					System.out.println("Group Id");
					String memberNames[]=memberName.split("\n");
					String memberNumbers[]=memberNumber.split("\n");
					String memberAddresses[]=memberAddress.split("\n");
					String memberEmailIds[]=memberEmailId.split("\n");
					if(memberNames.length!=memberNumbers.length){
						response.getWriter().write("Names and numbers do not match");
					}
					else{
						System.out.println("In else");
						boolean flag=true;
						for (int i = 0; i < memberNumbers.length; i++) {
							try{
								System.out.println("Inside try");
								if(memberNumbers[i].length()!=10){
									throw new Exception("Number invalid");
								}

							}catch(Exception e){
								System.out.println("Exception occur");
								flag=false;
								response.getWriter().write("Number incorrect");
							}
						}
						if(flag)
						{
							System.out.println("Inside flag");
							PrintWriter out=response.getWriter();
							MemberDetails memberDetails = new MemberDetails();
							for (int i = 0; i < memberNumbers.length; i++)
							{
								if(memberRole.equalsIgnoreCase("member"))
								{
									boolean memberPresent=memberDetails.checkMemberDetails(memberNumbers[i]);
									if(memberPresent)
									{
										out.println(memberNumbers[i]+" already registered");	
									}
									else
									{
										memberDetails.addMember(memberNames[i], memberNumbers[i],memberAddresses[i],memberEmailIds[i],orgId);
									}
									memberPresent=memberDetails.checkMemberGroup(groupId, memberNumbers[i]);
									if(memberPresent){
										out.println(memberNumbers[i]+" already registered");
									}
									else 
									{
										boolean memberRegistered=memberDetails.insertMemberintoGroup(memberNames[i],memberNumbers[i], groupId);
										if(memberRegistered)
										{
											out.println(memberNumbers[i]+" registered successfully");
										}
										else
											out.println(memberNumbers[i]+" already registered");
									}
								}
							}
						}
					}
				}
				else if(req_type.equalsIgnoreCase("addNewPublisher"))
				{
					String memberName=request.getParameter("memberName");
					String memberNumber=request.getParameter("memberNumber");
					String memberRole=request.getParameter("memberRole");
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
					String orgId=loginUser.getOrg_id();

					String groupId=request.getParameter("groupId");

					String memberNames[]=memberName.split("\n");
					String memberNumbers[]=memberNumber.split("\n");

					if(memberNames.length!=memberNumbers.length){
						response.getWriter().write("Names and numbers do not match");
					}
					else{
						boolean flag=true;
						for (int i = 0; i < memberNumbers.length; i++) {
							try{
								if(memberNumbers[i].length()!=10){
									throw new Exception("Number invalid");
								}

							}catch(Exception e){
								flag=false;
								response.getWriter().write("Number incorrect");
							}
						}
						if(flag)
						{
							//PrintWriter out=response.getWriter();
							//MemberDetails memberDetails = new MemberDetails();
							for (int i = 0; i < memberNumbers.length; i++)
							{
								PublisherDetails publisherDetails = new PublisherDetails();
								publisherDetails.insertPublisher(memberName, memberNumber);
								System.out.println("hello");
								response.getWriter().write("Success");
							}
						}
					}
				}
				
				/* 
				 * Deletes the selected publishers from the list which is displayed on publisher.jsp
				 * Publisher.jsp -> Delete publishers
				 * PublisherModel/PublisherDetails.java
				 *                             
				 */
				else if(req_type.equals("deletePublisher"))
				{
					String[] selectedPublishers = request.getParameterValues("checkbox");
					PublisherDetails publisherDetails = new PublisherDetails();

					for(int i=0;i<selectedPublishers.length;i++)
					{
						publisherDetails.deletePublisher(selectedPublishers,i);
					}
				}

				/*
				 * This method list all the groups which a member does not belongs to for addition
				 * ManipulateGroupNames.jsp
				 * GroupModel/GroupDetails.java
				 * GroupBean/GroupBean.java , AuthenticatorBean/LoginBean.java
				 * 
				 */
				else if(req_type.equals("manipulateAdd"))
				{
					LoginBean loginUser = (LoginBean)session.getAttribute("loginUser");
					String memberNumber=request.getParameter("memberNumber");
					String manipulate=request.getParameter("manipulate");
					GroupDetails groupDetails = new GroupDetails();
					GroupBean groupBean = new GroupBean();

					groupBean.setManipulate_add(groupDetails.manipulateAdd(memberNumber,manipulate,loginUser.getOrg_id()));

					request.setAttribute("groupBean",groupBean);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("ManipulateGroupNames.jsp");  
					requestDispatcher.forward(request, response); 
				}
				/*
				 * This method list all the groups which a member belongs to for deletion
				 * ManipulateGroupNames.jsp
				 * GroupModel/GroupDetails.java
				 * GroupBean/GroupBean.java , AuthenticatorBean/LoginBean.java
				 * 
				 */				
				else if(req_type.equals("manipulateDelete"))
				{
					LoginBean loginUser = (LoginBean)session.getAttribute("loginUser");
					String memberNumber=request.getParameter("memberNumber");
					String manipulate=request.getParameter("manipulate");
					System.out.println(manipulate);
					GroupDetails groupDetails = new GroupDetails();
					GroupBean groupBean = new GroupBean();

					groupBean.setManipulate_delete(groupDetails.manipulateDelete(memberNumber,manipulate,loginUser.getOrg_id()));

					request.setAttribute("groupBean", groupBean);
					request.setAttribute("loginUser", loginUser);
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("ManipulateGroupNames.jsp");  
					requestDispatcher.forward(request, response); 
				}

				/*
				 * This req_type adds the groups to a member of which it does not belong to till now
				 * GlobalGroupChange.jsp -> Add option
				 * GroupModel/GroupDetails.java
				 * 
				 * 				 */	
				else if(req_type.equalsIgnoreCase("addMultiGroups"))
				{
					String memberNumber= request.getParameter("memberNumber");
					String[] groupsName;
					groupsName=request.getParameterValues("notInGroups");
					GroupDetails groupDetails = new GroupDetails();

					if(groupsName!=null)
					{
						groupDetails.addMultiGroups(memberNumber,groupsName);
					}
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=globalGroupChange");  
					requestDispatcher.forward(request, response); 
				}

				/*
				 * This req_type deletes the groups to which a member belongs
				 * GlobalGroupChange.jsp -> Delete option
				 * GroupModel/GroupDetails.java
				 * 
				 */	
				else if(req_type.equalsIgnoreCase("deleteMultiGroups"))
				{
					String memberNumber= request.getParameter("memberNumber");
					String[] inGroupsName;
					inGroupsName=request.getParameterValues("inGroups");
					GroupDetails groupDetails = new GroupDetails();
					ResultSet groupCount=groupDetails.countGroups(memberNumber);
					if(groupCount.first())
					{
						String foundGroupCount=groupCount.getString(1);
						Integer GroupCount=Integer.parseInt(foundGroupCount);
						Integer foundLength=inGroupsName.length;
						System.out.println(foundLength==GroupCount);
						if(inGroupsName!=null)
						{
							if(foundLength==GroupCount)
							{	
								MemberDetails memberDetails = new MemberDetails();
								memberDetails.findMemberInfo(memberNumber);
								Integer i=0;
								while(inGroupsName.length!=i)
								{
									groupDetails.deleteFromGroup(memberNumber, inGroupsName, i);
									i++;
								}
							}
							else{
								Integer i=0;
								while(inGroupsName.length!=i){
									groupDetails.deleteFromGroup(memberNumber, inGroupsName, i);
									i++;
								}
							}

						}
					}

					else
					{
						RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=globalGroupChange");  
						requestDispatcher.forward(request, response); 
					}


					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?req_type=globalGroupChange");  
					requestDispatcher.forward(request, response); 					
				}   

				/*
				 * Method to delete the existing groups in a group.
				 * Manage.jsp--> Settings tab  Delete group
				 * GroupModel/GroupDetails.java
				 * AuthenticatorBean/LoginBean.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("deleteGroup"))
				{
					GroupDetails groupDetails = new GroupDetails();
					LoginBean loginUser=(LoginBean)session.getAttribute("loginUser");
					groupDetails.deleteGroup(request.getParameter("groupId"));
					RequestDispatcher requestDispatcher=request.getRequestDispatcher("IvrsServlet?redirect=1");  
					requestDispatcher.forward(request, response); 				
					//response.sendRedirect("IvrsServlet?redirect=1"+loginUser.getOrg_id());//prg pattern @author: Richa Nigam
				}

				/*
				 * Code to change the group of the member.LOCAL(inside Group)
				 * Manage.jsp
				 * GroupModel/GroupDetails.java
				 * 
				 */
				else if(req_type.equals("changeGroup"))
				{
					String[] selectedMembers = request.getParameterValues("checkbox");
					String groupId = request.getParameter("selectedGroup");
					GroupDetails groupDetails = new GroupDetails();

					for(int i=0;i<selectedMembers.length;i++)
					{
						groupDetails.changeGroupLocal(groupId,selectedMembers,i);
					}
				}

				/*
				 * Code to change the group of number.GLOBAL(Organisation)
				 * GroupModel/GroupDetails.java
				 * 
				 */
				else if(req_type.equals("globalChangeGroup"))
				{
					String[] selectedMembers = request.getParameterValues("checkbox");
					String groupId = request.getParameter("selectedGroup");
					GroupDetails groupDetails = new GroupDetails();

					for(int i=0;i<selectedMembers.length;i++)
					{
						groupDetails.changeGroupGlobal(groupId,selectedMembers,i);

					}
				}
				/*
				 * This method is not used currently -------!!!
				 * Manage.jsp Report tab-> IncomingCall sub-tab find according to dates.
				 * 
				 */
				else if(req_type.equalsIgnoreCase("incomingcall"))
				{
					System.out.println("incomingcall");
					System.out.println(request.getParameter("group_id"));
					String fromDate=request.getParameter("fromdate");
					String toDate=request.getParameter("todate");
				}

				
				/* This req_type is used for Upload.jsp function callSMSURL(message,number,responses)
				 * Upload.jsp
				 * MessageModel/ActivityLog.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("sendSMS"))
				{
					request.setCharacterEncoding("UTF-8");
					String groupId=request.getParameter("groupsId");
					String smsContent=request.getParameter("smsContent");

					String receiverNumber=request.getParameter("receiverNumber");
					String responses = request.getParameter("response");
					int numbers =  receiverNumber.length();
					if(numbers <=9 ){

					}
					else
					{
						request.setCharacterEncoding("UTF-8");
						ActivityLog.logOutgoingtextSMS(groupId, smsContent, receiverNumber , responses);
						ActivityLog.logOutgoingtextSMS(groupId, smsContent, receiverNumber , responses);
					}
				}

				
				/* This req_type is used for retrieve names of well
				 * NamesOfWell.jsp
				 * WellinfoModel/NamesOfWell.java
				 * 
				 */
				
				if(req_type.equals("namesForWell"))
				{

					String districtName=request.getParameter("districtName");
					String tehsilName=request.getParameter("tehsilName");
					String villageName=request.getParameter("villageName");
					String findTehsil=request.getParameter("findTehsil");
					String findVillage=request.getParameter("findVillage");
					String fromDate=request.getParameter("fromDate");
					String toDate=request.getParameter("toDate");
					String getWellData=request.getParameter("getWellData");

					NamesOfWell namesOfWell = new NamesOfWell();
					WellDataBean wellDataBean = new WellDataBean();
					session.setAttribute("findTehsil",findTehsil);
					session.setAttribute("findVillage",findVillage);
					session.setAttribute("getWellData",getWellData);

					wellDataBean.setTehsil_names(namesOfWell.getTehsil(districtName));

					wellDataBean.setVillage_name(namesOfWell.getVillage(districtName, tehsilName));

					wellDataBean.setWell_data(namesOfWell.getWellData(districtName, tehsilName, villageName, fromDate, toDate));

					request.setAttribute("wellDataBean",wellDataBean);

					RequestDispatcher requestDispatcher=request.getRequestDispatcher("NamesOfWell.jsp");  
					requestDispatcher.forward(request, response);  
				}
				
				/* 
				 * This req_type is used to send emails
				 * Email.jsp
				 * MailModel/MailModel.java
				 * 
				 */
				else if(req_type.equalsIgnoreCase("sendMail"))
				{
					System.out.println("Inside IVRS Servlet");
					response.setContentType("multipart/mixed");
					String relativeWebPath = "/WEB-INF/Uploads/";
					String absoluteFilePath = getServletContext().getRealPath(relativeWebPath);
					
						MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);
						MailModel mailModel=new MailModel();
						String to=request.getParameter("indi_send");
						System.out.println(to);
						String subject=mreq.getParameter("subject");
						String description=mreq.getParameter("desc");
						Hashtable files=mreq.getFiles();
						System.out.println(files);
						if(files.size()!=0)
						{
							mailModel.setPath(absoluteFilePath);
							System.out.println("hello!");
							mailModel.setFiles(files);
						}
					try
					{
						mailModel.sendMail(to,subject,description);
						
						System.out.println("Email sent successfully!");
						response.sendRedirect("EmailSuccess.jsp");
					}
					catch(Exception e)
					{
						e.printStackTrace();
						System.out.println("Error in sending email!");
						response.sendRedirect("EmailFailure.jsp");
					}
				}
				
				
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			RequestDispatcher requestDispatcher=request.getRequestDispatcher("Error.html");  
			requestDispatcher.forward(request, response); 
		}
	}
}
