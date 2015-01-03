package com.iitb.MessageModel;

import java.io.File;
import java.io.InputStream;
import java.io.PrintStream;
import java.net.Authenticator;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.URL;
import java.net.URLConnection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iitb.dbUtilities.*;
import com.iitb.AuthenticatorBean.*;
import com.iitb.globals.*;
/**
 * This class is used to download the audio files from kookoo server
 * 
 * 
 * 
 */
public class DownloadFile {

	
	public static void main(String[] args) {
		downloadRemainingFiles();
//		try {
//			downloadAudio("http://recordings.kookoo.in/vishwajeet/kookoo_audio1382208897878.wav");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
	}
	
	/**
	 * To download audio file from a specified url
	 * 
	 * @param path The url of the file to be downloaded
	 * @return path of the stored file
	 */
	public static String downloadAudio(String path) throws Exception {
		String filepath = "";
		String fileName = null;

		URL url = new URL(path);
		// setting download directory
		String downloadDirectory = ConfigParams.DOWNLOADDIR;
		
		System.out.println("download file");
		// extracting file name from url
		fileName = path.substring(path.lastIndexOf("/") + 1);

		filepath = downloadDirectory + fileName;

		// Create a proxy object and set the authentication details.
		Proxy netmon = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(
				"172.17.166.10", 80));
		Authenticator.setDefault(new ProxyAuthenticator(ConfigParams.LDAPUSER, ConfigParams.LDAPPASS));

		// Open an URL Connection through the proxy.
		URLConnection urlc = url.openConnection(netmon);

		// Create a byte buffer to get the data.
		int numBytes = urlc.getContentLength();
		byte buffer[] = new byte[numBytes + 1024];

		// Get the input stream and create an output stream.
		InputStream is = urlc.getInputStream();
		PrintStream pout = new PrintStream(new File(filepath));

		// If the content MIME-type is audio/x-wav, then we succeeded.
		System.out.println(urlc.getContentType());

		byte data[] = new byte[2 * 1024];
		int count;
		while ((count = is.read(data, 0, 1024)) != -1) {
			pout.write(data, 0, count); // downloADING FILE
		}
		pout.close();
		is.close();
		System.out.println(filepath);
		return fileName;
	}
	
	/**
	 * To download the files from kookoo on routine basis
	 */
	public static void downloadRemainingFiles(){
		
		String getDownloadStatusQuery="SELECT message_id, download_status, message_location from message;";
		try {
			ResultSet downloadStatusResult=DataService.getResultSet(getDownloadStatusQuery);
			while(downloadStatusResult.next()){
				int status=Integer.parseInt(downloadStatusResult.getString(2));
				String message_id=downloadStatusResult.getString(1);
				
				if(status==0){
					String path=downloadStatusResult.getString(3);
					try {
						//for debugging
						System.out.println("Downloading file "+ path);
						String filename=downloadAudio(path);
						String filepath=ConfigParams.PUBLICLINKFORDATABASE+"/audio-download/"+filename;
						String updatePath="UPDATE message SET message_location='"+filepath+"', download_status=1 where message_id="+message_id+";";
						DataService.runQuery(updatePath);
						System.out.println("Updated path ");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	


public static String downloadPublisherFeedback(String path) throws Exception {
	
	String filepath = "";
	String fileName = null;

	URL url = new URL(path);
	// setting download directory
	
	//String downloadDirectory ="/home/hduser/ruralivrs/ProjectFiles/apache-tomcat-6.0.37/webapps/Downloads/RuralIvrs/publisher/";
	String downloadDirectory = ConfigParams.PUBLISHERDIR;
	System.out.println("download file");
	// extracting file name from url
	fileName = path.substring(path.lastIndexOf("/") + 1);

	filepath = downloadDirectory + fileName;

	// Create a proxy object and set the authentication details.
	Proxy netmon = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(
			"172.17.166.10", 80));
	Authenticator.setDefault(new ProxyAuthenticator(ConfigParams.LDAPUSER, ConfigParams.LDAPPASS));

	// Open an URL Connection through the proxy.
	URLConnection urlc = url.openConnection(netmon);

	// Create a byte buffer to get the data.
	int numBytes = urlc.getContentLength();
	byte buffer[] = new byte[numBytes + 1024];

	// Get the input stream and create an output stream.
	InputStream is = urlc.getInputStream();
	PrintStream pout = new PrintStream(new File(filepath));

	// If the content MIME-type is audio/x-wav, then we succeeded.
	System.out.println(urlc.getContentType());

	byte data[] = new byte[2 * 1024];
	int count;
	while ((count = is.read(data, 0, 1024)) != -1) {
		pout.write(data, 0, count); // downloADING FILE
	}
	pout.close();
	is.close();
	System.out.println(filepath);
	return fileName;
	
}
public static String downloadFeedback(String path) throws Exception {
	String filepath = "";
	String fileName = null;

	URL url = new URL(path);
	// setting download directory
	
//	String downloadDirectory ="/home/hduser/ruralivrs/ProjectFiles/apache-tomcat-6.0.37/webapps/Downloads/RuralIvrs/feedback-download/";
	String downloadDirectory = ConfigParams.FEEDBACKDIR;

	System.out.println("download file");
	// extracting file name from url
	fileName = path.substring(path.lastIndexOf("/") + 1);

	filepath = downloadDirectory + fileName;

	// Create a proxy object and set the authentication details.
	Proxy netmon = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(
			"172.17.166.10", 80));
	Authenticator.setDefault(new ProxyAuthenticator(ConfigParams.LDAPUSER, ConfigParams.LDAPPASS));

	// Open an URL Connection through the proxy.
	URLConnection urlc = url.openConnection(netmon);

	// Create a byte buffer to get the data.
	int numBytes = urlc.getContentLength();
	byte buffer[] = new byte[numBytes + 1024];

	// Get the input stream and create an output stream.
	InputStream is = urlc.getInputStream();
	PrintStream pout = new PrintStream(new File(filepath));

	// If the content MIME-type is audio/x-wav, then we succeeded.
	System.out.println(urlc.getContentType());

	byte data[] = new byte[2 * 1024];
	int count;
	while ((count = is.read(data, 0, 1024)) != -1) {
		pout.write(data, 0, count); // downloADING FILE
	}
	pout.close();
	is.close();
	System.out.println(filepath);
	return fileName;
}
}