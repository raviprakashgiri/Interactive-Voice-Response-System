package com.iitb.KookooFunctionsTextToSpeechModel;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * This class provides an interface to the TTS script on the server.
 * @author $ujen
 *
 */
public class TextToSpeech {
	
	String timeStamp = new SimpleDateFormat("[dd-MM-yyyy | HH:mm:ss]").format(Calendar.getInstance().getTime());
	
	/**
	 * This method provides the inputs to TTS script
	 * @param language
	 * @param textToConvert
	 * @param filePath
	 * @param fileName
	 * @return "Done"
	 * @throws UnsupportedEncodingException
	 */
	public String convertText(String language, byte[] textToConvert, String filePath, String fileName) throws UnsupportedEncodingException{
		
		System.out.println(timeStamp + " TTS called with inputs: "+ language + " "+textToConvert + " "+filePath + " "+fileName);
		
		FestivalTTS(language, new String(textToConvert,"UTF-8"), filePath, fileName);
		
		System.out.println(timeStamp + " TTS exit");
		return "Done";
	}
	
	private String max( String l, String m, String n ,String o) {
		
		System.out.println(timeStamp + " language chosen :" + l);
	    System.out.println(timeStamp + " string to be converted in wave file:" +m);
	    
	    BufferedReader is = null;
	    BufferedReader es = null;
		  try{
	  	 ProcessBuilder pb = new ProcessBuilder("bash","/home/davis/newfest.sh",l,m,n,o);
	  	Process p = pb.start();
	  	
	  	String line;
	    is = new BufferedReader(new InputStreamReader(p.getInputStream()));
	    while((line = is.readLine()) != null)
	        System.out.println(line);
	    es = new BufferedReader(new InputStreamReader(p.getErrorStream()));
	    while((line = es.readLine()) != null)
	        System.err.println(line);

	    int exitCode = p.waitFor();
	    if (exitCode == 0)
	    	 System.out.println (timeStamp + " Done.");
	    else
	        System.out.println(timeStamp + " Something bad happend. Exit code: " + exitCode);
	    
	   
	  }
	     catch(Exception e){

	  	   System.out.println (timeStamp + " Err: " + e.getMessage());
	  	      
	     }
		  return "Done";
	}
	
	
	private void FestivalTTS(String l, String m, String n, String o){
		 try{
		      System.out.println(m + " , text in " + l + " is producing a wave file " + o + " at " + n + ".");
		    //  ProcessBuilder pb = new ProcessBuilder("bash","/home/hduser/ruralivrs/TTS/dhvaniProcess.sh",l,m,n,o,0);
		      ProcessBuilder pb = new ProcessBuilder("bash","/home/hduser/ruralivrs/TTS/dhvaniTest.sh",l,m,n,o);
		      Process p = pb.start();
		      p.waitFor ();
		      
		      System.out.println ("Done.");
		    }
		    catch(Exception e){
		      System.out.println ("Err: " + e.getMessage());
		    }
	}
}
