<%@page import="com.ozonetel.kookoo.Response,java.util.*,com.ozonetel.kookoo.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.ozonetel.kookoo.CollectDtmf"%>
 <%@page import= "java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>

<%
Response kResponse1 = new Response();
kResponse1.setFiller("yes");
String afterDtmf[]={ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
%>
    <c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state == "start" }'> 
        <%            
                    
            CollectDtmf cd = new CollectDtmf();
            cd.setMaxDigits(1);
            cd.setTermChar("#");
            String register_number = request.getParameter("register_number");
            System.out.println("language page="+register_number);
            String groups_id=request.getParameter("groups_id");
            System.out.println("groups_id==="+groups_id);
            kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/strt_language_menu.wav");
            kResponse1.addCollectDtmf(cd);
            session.setAttribute("state", "collectdNumber");
            kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language_UnRegisteredUser.jsp?register_number="+register_number+"&groups_id="+groups_id);
            out.print(kResponse1.getXML());
        %>
    </c:when>
    
     <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
        <%   
        
        try{
            String language = request.getParameter("data");
            System.out.println("value="+language);
            String register_number=request.getParameter("register_number");
            System.out.println("register_numbergotdtmf="+register_number);
            String Groups_id=request.getParameter("groups_id");
            System.out.println("groups_id==="+Groups_id);
            
            //interpreting the selected option
           if(language.equals(null)||language.equals("")||language==""||language==null){
        	
        	   kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav");
        	   kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language_UnRegisteredUser.jsp?event=NewCall&language="+language+"&register_number="+register_number+"&groups_id="+Groups_id);
        	   
           }
           else if(language.equals("1") || language.equals("2") || language.equals("3")){
        	   
        	     System.out.println(ConfigParams.getIvrslink()+"LanguageCheck_UnResgisteredUser.jsp?event=NewCall&language="+language+"&register_number="+register_number);
            	 kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"LanguageCheck_UnResgisteredUser.jsp?event=NewCall&language="+language+"&register_number="+register_number+"&groups_id="+Groups_id);
               }
           else {
            
            	   kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav");
            	   kResponse1.addGotoNEXTURL(ConfigParams.getIvrslink()+"Language_UnRegisteredUser.jsp?event=NewCall&language="+language+"&register_number="+register_number+"&groups_id="+Groups_id);
            	   
               }
     
        	   out.print(kResponse1.getXML());
               
            }    
            
         
        catch(Exception e){
        	
        }
            %>
    </c:when>
    </c:choose>
