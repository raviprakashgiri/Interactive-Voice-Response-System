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
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
<%@page import="com.iitb.MessageModel.ActivityLog" %>

    <c:choose>
    <c:when test='${param.event == "NewCall" || sessionScope.state == "start" }'> 
        <%            
        
            Response UserResponse = new Response();
            CollectDtmf cd = new CollectDtmf();
            cd.setMaxDigits(4);
            cd.setTermChar("#");
            UserResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_unregisterUser.wav");
            UserResponse.addCollectDtmf(cd);
            session.setAttribute("state", "collectdNumber");
            UserResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"UnRegistered.jsp");
            out.print(UserResponse.getXML());
        %>
    </c:when>


<c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
        <%            
            String number = request.getParameter("data");
            Response InputResponse = new Response();
            
            //interpreting the selected option
            
            if(number==""||number.equals(null)||number==null||number.equals("")){
               	InputResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav");
            	InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"UnRegistered.jsp?event=NewCall");
               
               }
            
            else if (number.equals("1")) {
            	
            	session.removeAttribute("state");
              //  InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"RegisteredUser.jsp?event=NewCall");
            	InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"NewRegisteredUser.jsp?event=NewCall");
              
                } 
            
            else if(number.equals("2")){
            	
            	session.removeAttribute("state");
               	InputResponse.addPlayText("please contact your organization");
                }
            
            else{
            	
            	InputResponse.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav");
            	InputResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"UnRegistered.jsp?event=NewCall");
                }
                                            
                out.print(InputResponse.getXML());
                
            %>
    </c:when>
    
        
    
    
 
  
</c:choose>
