package com.iitb.EmailModel;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadFile;

public class MailModel{
	private static final long serialVersionUID = 1L;
	
	//setting the credentials for connecting to the database
	private static String url = "jdbc:mysql://localhost/afc";
	private static String username = "ravi";
	private static String password = "ravi";

	private static Connection con = null;
	private static Statement stmt = null;
	
	byte[] buffer = new byte[4096];
	int bytesRead = -1;
	Hashtable uploads=null;

	//constructor
	public MailModel() {
		connect();
	}

	
	/*This function connects to the SQL Database
	 * MailModel.java
	 * @uthor: Mehul Smriti Raje
	 */
	static void connect(){
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, username, password);
			stmt = con.createStatement();
			System.out.println("connected");
		}
		catch(Exception e)
		{
			System.out.println("Not connected");
		}
	}

	
	/*This function creates the mail object, sets its contents and sends the mail
	 * IvrsServlet.java
	 * @uthor: Mehul Smriti Raje
	 */
	public void sendMail(String to, String subject,String description)
			throws ServletException, IOException {

		// setting host details
		System.out.println("Inside Email Servlet");

		System.out.println(to);
		String host = "10.105.1.1";
		String mail_smtp_port = "25";
		Properties properties=null;

		MultipartFormDataRequest request = null;
		String mail_user = "ruralivrs@cse.iitb.ac.in";
		String mail_password = "ruralivrs*";

		String from = mail_user;
		Address[] ad = null;
		String receivers[] = null;
		ResultSet rs = null;
		String result = null;

		try {

			/*This part executes the sql queries to fetch data from the database
			 *@uthor: Mehul Smriti Raje 
			 */

			String[] to_ids=to.split(",");
			ArrayList<String> rec=new ArrayList<String>();

			//obtaining email address of recipients from their ids
			/*try 
			{*/
				int i=0;
				do
				{
					System.out.println(to_ids[i]);
					rs = stmt.executeQuery("SELECT member_email_id FROM member_details WHERE members_detail_id="+ to_ids[i]);
					while (rs.next()) {
						System.out.println(rs.getString("member_email_id"));
						rec.add(rs.getString("member_email_id"));
					}
					i++;
				}while(i<to_ids.length);
				
				System.out.println("To success");
				
			/*} catch (Exception e) {
				e.printStackTrace();
				System.out.println("To error");
			}*/


			//setting email addresses of the receivers
			//try
			//{
				receivers=new String[rec.size()];
				ad=new InternetAddress[rec.size()];
				int k=0;
				do
				{
					receivers[k]=rec.get(k);
					ad[k]=new InternetAddress(rec.get(k));
					k++;
				}while(k<rec.size());
				System.out.println("Initialisation success");
			/*}
			catch(Exception e)
			{
				System.out.println("Initialisation error");
			}*/

			//setting session properties
			properties = System.getProperties();
			properties.put("mail.smtp.port", mail_smtp_port);
			properties.put("mail.smtp.starttls.enable", "true");
			properties.setProperty("mail.user", mail_user);
			properties.setProperty("mail.password", mail_password);
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.ssl.trust", host);
			properties.setProperty("mail.smtp.host", host);
			
			System.out.println("Properties done");

			// authenticate session user
			Session mailsession = Session.getInstance(properties,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							System.out.println("correct");
							return new PasswordAuthentication(
									"ruralivrs@cse.iitb.ac.in", "ruralivrs*");
						}
					});

			System.out.println("Session done");
			/*This part creates the multipart message that has to be sent via email
			 * @uthor: Mehul Smriti Raje
			 */
			//try {
				MimeMessage message = new MimeMessage(mailsession);
				//setting then senders and receivers
				message.setFrom(InternetAddress.getLocalAddress(mailsession));
				message.setSender(new InternetAddress(from));
				message.addRecipients(Message.RecipientType.TO, ad);
				message.setRecipients(Message.RecipientType.TO, ad);

				// Set Subject: header field
				message.setSubject(subject);
				
				/*Now set the content of the message
				 * Obtained from the description text area in Email.jsp
				 */
				message.setContent(description, "text/html"); 

				System.out.println(message.getFrom());
				System.out.println(message.getSender());
				System.out.println(message.getAllRecipients());
				Multipart multi = new MimeMultipart();

				BodyPart messagepart = new MimeBodyPart();
				messagepart.setContent(description, "text/html");
				multi.addBodyPart(messagepart);


				/*This part attaches the files to the email
				 * File names received from the file dialog boxes in Email.jsp
				 */
				UploadFile f = null;
				int t = 0;
				MimeBodyPart attach;
				//get information of all the attached files in a hashtable
				
				for(int j=0;j<uploads.size();j++)
				{
					f = (UploadFile) uploads.get("att" + t++);
					if (f.getFileName() == null||f.getFileName()=="")
						break;
					System.out.println(f.getFileName());
					File uploadtest=null;
					//uploading the files one by one and attaching them to the multipart message
					try
					{
						uploadtest=uploadFile(f);
					}
					catch(Exception e)
					{
						System.out.println("Attachment error");
					}
					attach = new MimeBodyPart();
					attach.attachFile(uploadtest);
					multi.addBodyPart(attach);

					System.out.println("hello");
				}

				message.setContent(multi);
				Transport.send(message);
				System.out.println("Attachments done!");

				//Email sent successfully
				result = "Sent message successfully....";

			/*} catch (AddressException e) {
				e.printStackTrace();
				result = "Error: unable to send message....";
			} catch (MessagingException mex) {
				mex.printStackTrace();
				result = "Error: unable to send message....";
			}*/
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	String location=null;
	public void setPath(String path)
	{
		location=path;
	}
	
	/*This function uploads the selected files to the specified directory on the server
	 * MailModel.java
	 * @uthor: Mehul Smriti Raje
	 */
	public File uploadFile(UploadFile f) throws FileNotFoundException, IOException
	{
		File uploadtest = new File(location+ f.getFileName()); //path of server storage


		System.out.println("saveFile: "
				+ uploadtest.getAbsolutePath());
		FileOutputStream outputStream = new FileOutputStream(
				uploadtest);

		// saves uploaded file
		InputStream inputStream = f.getInpuStream();
		while ((bytesRead = inputStream.read(buffer)) != -1) {
			outputStream.write(buffer, 0, bytesRead);
		}
		outputStream.close();
		inputStream.close();
		
		return uploadtest;
	}
	
	
	/*This function sets the list of files to those selected by the user
	 * IvrsServlet
	 * @uthor: Mehul Smriti Raje
	 */
	public void setFiles(Hashtable files)
	{
		uploads=files;
	}
	
}

