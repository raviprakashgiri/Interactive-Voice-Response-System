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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String language = request.getParameter("language");
String groups_id = request.getParameter("groups_id");
System.out.println("placeorder="+groups_id);
CollectDtmf cd = new CollectDtmf();
cd.setMaxDigits(1);
// wait 8 sec for collect DTMF
cd.setTimeOut(8000);
Response audioResponse = new Response();
// for music
audioResponse.setFiller("yes");
char Language = language.charAt(0);

char base = '1';

String placeOrder_menu = "Press 1 to confirm           press 2 to re record";

String record_voice ="Please record your message after beep";



String placeOrderQn[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_semi_structured_recording.wav", ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_semi_structured_recordinggg.wav"};
String recordedOrder[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_semi_strucutred_recorded.wav", ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_semi_strucutred_recordedd.wav"};
String conformOrder[]={ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_semi_structured_confirm.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_semi_structured_confirm.wav"};
String rerecordOrder[]={ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_semi_structured_rerecord.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_semi_structured_rerecord.wav"};
String thanksClip[] = {ConfigParams.PUBLICLINKFORAUDIO+"/language/hindi/hi_thanks_msg.wav",ConfigParams.PUBLICLINKFORAUDIO+"/language/marathi/mr_thanks_msg.wav"};
String noneClip[] = {ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav", ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String afterDtmf[]={ConfigParams.DEFAULTWAV+"/default_wav/hi_provide_valid_input.wav",ConfigParams.DEFAULTWAV+"/default_wav/mr_provide_valid_input.wav" , ConfigParams.DEFAULTWAV+"/default_wav/en_provide_valid_input.wav"};
String noneUrl[] = {"PlaceOrder.jsp?event=NewCall&language=" + language+"&groups_id="+groups_id};

%>
<c:choose> 
    <c:when test='${param.event == "NewCall"}'> 
        <%--When we get a new call,we have to prompt for voice--%>
        <%
            Record record = new Record();
           	record.setMaxDuration(9000000000000000000l);
            String responsetype = request.getParameter("Responsetype");	
            System.out.println("rstypeh=="+responsetype);
            //give unique file name for each recording
            record.setFileName("kookoo_audio" + new Date().getTime());
            record.setFormat("wav");
           
            request.getSession().setAttribute("state", "recorded");
            Response kookooResponse = new Response();
            
            if(Language-base!=2)
            kookooResponse.addPlayAudio(placeOrderQn[Language - base]);
            else 
            kookooResponse.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_structured_recording.wav");
            kookooResponse.addRecord(record);    
            kookooResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PlaceOrder.jsp?language="+language+"&groups_id="+groups_id); 
            out.print(kookooResponse.getXML());
            
        %>
    </c:when>
    
        <c:when test='${param.event == "Record" && sessionScope.state == "recorded"}' >
        <%
            String messageURL = request.getParameter("data");
            System.out.print(messageURL);
            String Groupss_id = request.getParameter("groups_id"); 
            System.out.println(Groupss_id);
            // Database connectivity goes here
            String caller_id=request.getParameter("cid");
            
            //for testing
            try{
           	 // download the order 
            DownloadFile.downloadAudio(messageURL);
            }catch(Exception e){
                System.out.println(e);
                e.printStackTrace();
            }
          
            ProcessOrder.storeOrder(messageURL, Groupss_id, caller_id);
         /*   String languages=request.getParameter("language");
            String Groups_id = request.getParameter("groups_id");          
            System.out.println("Groups_id="+Groups_id);
            if(Language-base!=2){
            	audioResponse.addPlayAudio(recordedOrder[Language - base]);
            	
            }
            else {
            	
            	audioResponse.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_strucutred_recorded.wav");
            }
            
            audioResponse.addPlayAudio(request.getParameter("data"));
            String messageURL=request.getParameter("data");
            
           
            if(Language-base!=2){
            	
            	audioResponse.addPlayAudio(conformOrder[Language - base]);
             	audioResponse.addPlayAudio(rerecordOrder[Language - base]);
            	
            }
            else{
          
            	audioResponse.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_structured_confirm.wav");
            	audioResponse.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_semi_structured_rerecord.wav");
            }

            audioResponse.addCollectDtmf(cd);
            session.setAttribute("state", "collectdNumber");

           audioResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PlaceOrder.jsp?messageURL="+messageURL+"&language="+languages+"&groups_id="+Groups_id); */

            out.println(audioResponse.getXML());
           audioResponse.addHangup();
        %>
    </c:when>
    
    <c:when test='${param.event == "GotDTMF" || requestScope.state == "collectdNumber"}' >
                
                <%
            /*     System.out.println("inside the dtmf");
                String number2 = request.getParameter("data");
                String Groupss_id=request.getParameter("groups_id");
                System.out.println("placeorder id="+Groupss_id);
                Response kResponse2 = new Response();
              //interpreting the selected option
               if(number2.equals(null)||number2.equals("")||number2==""||number2==null){
            	  
            	    kResponse2.addPlayAudio(afterDtmf[Language-base]); 
            	  kResponse2.addGotoNEXTURL(ConfigParams.getIvrslink()+"PlaceOrder.jsp?event=NewCall&language="+language+"&groups_id="+Groupss_id); 
               }
                // for confrom
                else  if(number2.equals("1"))
                {
  
                     session.removeAttribute("state");
                     String messageURL=request.getParameter("messageURL");
                                                           
                     // Database connectivity goes here
                     String caller_id=request.getParameter("cid");
                     
                     //for testing
                     try{
                    	 // download the order 
                     DownloadFile.downloadAudio(messageURL);
                     }catch(Exception e){
                         System.out.println(e);
                         e.printStackTrace();
                     }
                   
                     ProcessOrder.storeOrder(messageURL, Groupss_id, caller_id);
  
                     if(Language-base!=2){ kResponse2.addPlayAudio(thanksClip[Language - base]);}
                     else{
                    	
                         kResponse2.addPlayAudio(ConfigParams.PUBLICLINKFORAUDIO+"/language/english/en_thanks_msg.wav");
                     }
                } 
                
                // for  re record
                else  if(number2.equals("2"))
                {
                    session.removeAttribute("state");
                    kResponse2.addGotoNEXTURL(ConfigParams.getIvrslink()+noneUrl[0]);
                    System.out.println("uRl="+noneUrl[0]);
                }
                else{
                kResponse2.addPlayAudio(noneClip[Language - base]);
                    kResponse2.addGotoNEXTURL(ConfigParams.getIvrslink()+noneUrl[0]);
                }
                
                out.print(kResponse2.getXML());
                kResponse2.addHangup(); */
                
                %>
             </c:when>
    
    
    
</c:choose>