<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.ProcessOrder"%>
<%@page import="com.iitb.MessageModel.DownloadFile"%>
<%@page import="com.iitb.dbUtilities.DataService"%>
<%@page import="com.iitb.globals.ConfigParams"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.KooKooFunctions"%>
<%@page import="com.iitb.KookooFunctionsTextToSpeechModel.IvrsUtilityFunctions"%>
<%@page
	import="com.ozonetel.kookoo.Response,java.util.Date,com.ozonetel.kookoo.Record"%>
<%@page import="java.sql.*"%>
<%@page import="com.ozonetel.kookoo.CollectDtmf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%
KooKooFunctions kookoofunction = new KooKooFunctions();
%>

<c:choose>
	<c:when test='${param.event == "NewCall" }'>
		<%
          Response audioResponse = new Response();
          String broadcastMSG=request.getParameter("broadcastMSG");
          System.out.println(broadcastMSG);
          CollectDtmf cd = new CollectDtmf();
          cd.setMaxDigits(3);
                  
    	  String result[] = kookoofunction.GetData();
  		  for(int i =0 ; i<result.length ; i++){
   			System.out.println("group_id="+result[i]);
  			audioResponse.addPlayText(result[i]);
    		}
          audioResponse.addCollectDtmf(cd);
          session.setAttribute("state", "collectdNumber");
          audioResponse.addGotoNEXTURL(ConfigParams.getIvrslink()+"PublisherByPhone.jsp?broadcastMSG="+broadcastMSG); 
          out.println(audioResponse.getXML());
       %>

	</c:when>

	<c:when
		test='${param.event == "GotDTMF" || requestScope.state == "collectNumber"}'>

		<%
                
                     Response kResponse1 = new Response();
                     String group_id=request.getParameter("data");
                     System.out.println("group_id=" + group_id);
                     try{
                     String result=kookoofunction.CheckGroup_id(group_id);
                     if(result.equals("true")){
                     String broadcastMSG=request.getParameter("broadcastMSG");
                     System.out.println(broadcastMSG);
                     String caller_id=request.getParameter("cid");
                     try{
                    	 ProcessOrder.PublisherPhoneMessage(broadcastMSG, caller_id, group_id);
                      //   DownloadFile.downloadPublisherFeedback(broadcastMSG);
                         }catch(Exception e){
                             System.out.println(e);
                             e.printStackTrace();
                         }
                     ProcessOrder.PublisherPhoneMessage(broadcastMSG, caller_id, group_id);
                     kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/Thanku.wav");
                     out.print(kResponse1.getXML());
                     kResponse1.addHangup();
                     }
                
                // otherwise it will excute
                   else{
                    	 kResponse1.addPlayAudio(ConfigParams.DEFAULTWAV+"/default_wav/HiNotValidGrpId.wav");
                    	 out.print(kResponse1.getXML());
                         kResponse1.addHangup();
                     }
                     }
                     catch(Exception e){
                     System.out.println(e);
                     }
                %>
	</c:when>




</c:choose>