package com.iitb.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateHelper {
	
	private static final String _DATE_FORMAT = "yyyy-MM-dd";
	
	public static Date getDate(String aDateString){
		Date date = null;
		if(isDateStringValid(aDateString)){
			SimpleDateFormat format = new SimpleDateFormat(_DATE_FORMAT);
			try{
				date = format.parse(aDateString);
			}
			catch(Exception e){
				System.err.println("[Error:] Could not parse date!");
				e.printStackTrace();
			}			
		}
		return date; 
	}
	
	private static boolean isDateStringValid(String aDateString){
		if(aDateString == null || aDateString.trim().equals(""))
			return false;
		String date[]=aDateString.split("-");
		if(date.length!=3){
			date=aDateString.split("/");
		}
		if(date.length!=3){
			return false;
		}
	int yy=Integer.parseInt(date[0]);
		String mm=date[1];
		String dd=date[2];
		
		
	      if (dd.equals("31") &&  (mm.equals("4") || mm .equals("6") || mm.equals("9") ||mm.equals("11") || mm.equals("04") || mm .equals("06") || mm.equals("09"))) {
	    		  	            return false;
	    		  	         }
	      else if (mm.equals("2") || mm.equals("02")) {
	    		  	 
	    		  	          if(yy % 4==0){
	    		 	              if(dd.equals("30") || dd.equals("31")){
	    		 	                  return false;
	    		 	              }
	    		 	              else{
	    		 	                  return true;
	    		 	              }
	    		 	          }
	    		  	          else{
	    		 	                 if(dd.equals("29")||dd.equals("30")||dd.equals("31")){
	    		 	                  return false;
	    		 	                 }else{
	    		 	                  return true;
	    		 	              }
	    		 	          }
	      }
	      else{                
	    		 	        return true;                
	    		 	 }
	}
}
