package com.iitb.globals;

import com.iitb.globals.ReadPropertyFile;
 /**
  * @author ravi prakash giri
  * This class is used to read the property file attributes and store them in static variables which are  used throughout the project.
  * The configuration variables are used to deploy the same system for different organizations.
  * Thus increasing mobility.
  */
public class ConfigParams {
	
	static ReadPropertyFile rd=new ReadPropertyFile();
	
	public static final String LDAPUSER=rd.getCaption("ldapUser");
	public static final String LDAPPASS=rd.getCaption("ldapPass");
	public static final String DOWNLOADDIR=rd.getCaption("downloadDir"); // where the audio files from kookoo will be downloaded
	public static final String UPLOADDIR=rd.getCaption("uploadDir"); // where the broadcast files from dashboard will be uploaded
	public static final String PUBLICLINKFORAUDIO=rd.getCaption("publicLink"); // publicly accessible link to play audio files in kookoo
	public static final String KOOKOONUMBER=rd.getCaption("kookooNumber"); // kookoo number on which the application runs
	public static final String IVRSLINK=rd.getCaption("ivrsLink");
	public static final String BROADCASTCALLBACKURL=rd.getCaption("broadcastCallbackURL"); // Link of the call back URL. Refer to kookoo callback
	
	public static final String ORGABB=rd.getCaption("orgAbbreviation"); // abbreviation of the Organization used for SMS registration
	public static final String LANGUAGEDIR=rd.getCaption("languageDir"); // directory where wav files of different languages are stored
	public static final String KOOKOONUMBERTODISPLAY = rd.getCaption("kookooNumberToDisplay");
	public static final String ORGID = rd.getCaption("org_id");
	public static final String ORGNAME=rd.getCaption("orgname"); // name of organization
	public static final String PUBLICLINKFORDATABASE=rd.getCaption("publicLinkForDatabase");
	public static final String PUBLISHERDIR =rd.getCaption("publisherDir");
	public static final String FEEDBACKDIR =rd.getCaption("feedbackDir");
	public static final String DEFAULTWAV =rd.getCaption("defaultWav");
	public static final String DEFAULTDIR =rd.getCaption("defaultDir");
	public static final String UPLOADPUBLISHERMESSAGE = rd.getCaption("uploadedPublisherMessage");
	public static final String UPLOADWAV = rd.getCaption("uploadWav");
	public static final String WELCOMEMESSAGELINK = rd.getCaption("welcomeMessageLink");
	public static final String CUSTOMISEDRECORDEDVOICEFILES = rd.getCaption("customised_recorded_voices");
	/**
	  * To get the KooKoo phone number of the organization
	  * @return String 
	  */
	public static String getKookoonumber() {
		return KOOKOONUMBER;
	}
	
	/**
	  * To get the organization abbreviation for adding user via SMS
	  * @return String 
	  */
	public static String getOrgabb() {
		return ORGABB;
	}
	
	
	public static String getIvrslink() {
		return IVRSLINK;
	}
	
	public static String getOrgId() {
		return ORGID;
	}
	
	 /**
	  * To get the KooKoo phone number to display on Dashboard
	  * @return String 
	  */
	public static String getKookoonumbertodisplay() {
		return KOOKOONUMBERTODISPLAY;
	}
	
	 /**
	  * To get the upload directory of welcome message which is common to all the groups
	  * @return String 
	  */
	public static String getuploadDir() {
		return UPLOADDIR;
	}
	
	
	
}
