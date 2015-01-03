<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>

<%@page import="com.ozonetel.kookoo.Response,java.util.Date,com.ozonetel.kookoo.Record"%>
<%@page import= "java.sql.*"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>
<%@ page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions" %>

<c:choose> 
    <c:when test='${param.event == "NewCall" }'> 
        <%--When we get a new call,we have to prompt for voice--%>
        <%
                Response kResponse=new Response();
        		CollectDtmf cd = new CollectDtmf();
                cd.setMaxDigits(2);
                String group_id="";
            
                String groups_id = request.getParameter("groups_id");
                System.out.println(groups_id);
       
                kResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/strt_language_menu.wav");
               
                kResponse.addCollectDtmf(cd);
                kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Menu.jsp?groups_id="+groups_id);
                session.setAttribute("state", "collectdNumber");
                out.print(kResponse.getXML());
           	
        %>
    </c:when>
    
    <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
    <% 
       try{
        	 
        	Response kResponse = new Response(); 
        	String Groups_id=request.getParameter("groups_id");
        	System.out.println("welcome="+Groups_id);
            String language = request.getParameter("data");
            System.out.println("value="+language);
            String callerID= request.getParameter("caller_id");
            
            //interpreting the selected option
           if(language.equals(null)||language.equals("")||language==""||language==null){
        	   
        	   kResponse.addPlayText("please enter any digit");
        	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Menu.jsp?event=NewCall&language="+language);
        	   
           }
          
           else if(language.equals("1") || language.equals("2") || language.equals("3"))
           {
        	 
        	   System.out.println(ConfigParams.getIvrslink()+"Language.jsp?event=NewCall&language="+language+"&groups_id="+Groups_id);
                kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language.jsp?event=NewCall&language="+language+"&groups_id="+Groups_id);
           }
          
          else {
            	   kResponse.addPlayText("this is not valid number");
            	   kResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"Menu.jsp?event=NewCall&language="+language);
            	   
               }
     
        	   out.print(kResponse.getXML());
               
            }    
          
       
        catch(Exception e){
      
        	e.printStackTrace();
        }
            %>
    </c:when>
    </c:choose>
