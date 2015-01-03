<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page
	import="com.ozonetel.kookoo.Response,java.util.Date,com.ozonetel.kookoo.Record"%>
<%@page import="java.sql.*"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page import="com.iitb.SettingsModel.IvrsMenuSettings" %>
<%
Response feedback_response = new Response();
// for music 
feedback_response.setFiller("yes");
IvrsMenuSettings im = new IvrsMenuSettings();
String language = request.getParameter("language");
String groups_id=request.getParameter("groups_id");
System.out.println("feedback=="+groups_id);
char Language = language.charAt(0);
char base = '1';

String record_feedback = "Please record your feedback after beep";
String confirm_feedback = "Press 1 to confirm           press 2 to re record";
String bye_bye = im.getStandard(1, "thankyou_msg");

String feedbackQn[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_unstructured_feedback_record.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_unstructured_feedback_record.wav"};
String recordedOrder[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_unstructured_recorded.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_unstructured_recorded.wav"};
String confrmFeedback[]={ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_unstructured_confirm.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_unstructured_confirm.wav"};
String reRecord[]={ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_unstructured_rerecord.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_unstructured_rerecord.wav"};
String thanksClip[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_thanks_msg.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_thanks_msg.wav"};
String noneClip[] = {ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav" ,ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav"};
String afterDtmf[]={ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String noneUrl[] ={"Feedback.jsp?event=NewCall&language="+language+"&groups_id="+groups_id};

%>
<c:choose>
	<c:when test='${param.event == "NewCall" }'>
		<%--When we get a new call,we have to prompt for voice--%>
		<%
            Record record = new Record();
        	record.setMaxDuration(9000000000000000000l);
            CollectDtmf cd = new CollectDtmf();
            
            //give unique file name for each recording
            record.setFileName("kookoo_audio" + new Date().getTime());
            record.setFormat("wav");
            request.getSession().setAttribute("state", "recorded");
            if(Language - base != 2) feedback_response.addPlayAudio(feedbackQn[Language - base]);
            else 
            feedback_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_unstructured_feedback_record.wav");
            feedback_response.addRecord(record); 
            feedback_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"Feedback.jsp?language=" + language+"&groups_id="+groups_id);
            out.print(feedback_response.getXML());
            
        %>
	</c:when>

	<c:when
		test='${param.event == "Record" && sessionScope.state == "recorded"}'>
		<%
        
        String languages = request.getParameter("language");
        String Groups_id=request.getParameter("groups_id");
        CollectDtmf cd = new CollectDtmf();
        if(Language - base != 2)feedback_response.addPlayAudio(recordedOrder[Language - base]);
        else 
        feedback_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_unstructured_recorded.wav");

        feedback_response.addPlayAudio(request.getParameter("data"));
        String feedbackURL=request.getParameter("data");
              
        if(Language - base !=2) {
        	//feedback_response.addPlayAudio(frwdOrder[Language - base]);
            feedback_response.addPlayAudio(confrmFeedback[Language - base]);
            feedback_response.addPlayAudio(reRecord[Language-base]);
 
        }
        else {
        
              feedback_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_unstructured_confirm.wav");
              feedback_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_unstructured_rerecord.wav");
        }
        feedback_response.addCollectDtmf(cd);
        session.setAttribute("state", "collectdNumber");

        feedback_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"Feedback.jsp?feedbackURL="+feedbackURL + "&language=" + languages+"&groups_id="+Groups_id);
        out.println(feedback_response.getXML());
        
        %>
	</c:when>

	<c:when
		test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}'>

		<%
                
                CollectDtmf cd = new CollectDtmf();
                String feedbackmenu_number = request.getParameter("data");
                String Groupss_id =request.getParameter("groups_id");
                System.out.println("feedback="+Groupss_id);

                //interpreting the selected option
                if(feedbackmenu_number.equals("")||feedbackmenu_number.equals(null)||feedbackmenu_number==""||feedbackmenu_number==null){
               	  feedback_response.addPlayAudio(afterDtmf[Language-base]);
            	   feedback_response.addGotoNEXTURL(ConfigParams.getIvrslink()+"Feedback.jsp?event=NewCall&language=" +language+"&groups_id="+Groupss_id);
                    }
                
                //  1 for confrom
                else if(feedbackmenu_number.equals("1") )
                {
  
                     session.removeAttribute("state");
                     String feedbackURL=request.getParameter("feedbackURL");
                     // Database connectivity goes here
                     String caller_id=request.getParameter("cid");
                     
                     try{
                        	 // recorded feedback is download
                         DownloadFile.downloadFeedback(feedbackURL);
                        }
                     catch(Exception e){
                         System.out.println(e);
                         e.printStackTrace();
                     }
                     System.out.println("feedback="+caller_id);
            
                     // for storing the url , groups_id , caller_id in database
                     ProcessOrder.storeFeedback(feedbackURL, Groupss_id, caller_id);
                     if(Language - base!=2) 
                    	 feedback_response.addPlayAudio(thanksClip[Language - base]);
                    else 
                         feedback_response.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_thanks_msg.wav");
                  
                } 
                
                // 2 for re record
                else if(feedbackmenu_number.equals("2"))
                {
                    session.removeAttribute("state");
                    feedback_response.addGotoNEXTURL(ConfigParams.getIvrslink()+ noneUrl[0]);
                }
                else
                {
                	if(Language-base!=2)feedback_response.addPlayAudio(noneClip[Language - base]);
                    else 
                	feedback_response.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav");
                    feedback_response.addGotoNEXTURL(ConfigParams.getIvrslink()+ noneUrl[0]);
                }
                
                out.print(feedback_response.getXML());
                feedback_response.addHangup();
                %>
	</c:when>


</c:choose>
