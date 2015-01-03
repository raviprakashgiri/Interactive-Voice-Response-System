<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<?xml version='1.0'?>
<vxml version="2.1">
<form>
<%
DateFormat dateFormat = new SimpleDateFormat("yyyy_MM-dd_HH:mm:ss");
Date date = new Date();

//boolean isMultipart = ServletFileUpload.isMultipartContent(request);

//FileItemFactory factory = new DiskFileItemFactory();
//ServletFileUpload upload = new ServletFileUpload(factory);
List fileItems = null;
try {
//fileItems = upload.parseRequest(request);
} catch (Exception e) {
e.printStackTrace();
} try {
Iterator iter = fileItems.iterator();
while (iter.hasNext()) {
FileItem item = (FileItem) iter.next();
String newFileName = "Recording-" + dateFormat.format(date);
String inputFilePath = "C://Audio"
+ newFileName + ".wav";

File file = new File(inputFilePath);
try {//Writing the wav file
item.write(file);
} catch (Exception e) {
e.printStackTrace();
}
}
} catch (Exception e) {
e.printStackTrace();
}
%>
<block>
<prompt> Audio upload complete! </prompt>
</block>
</form>
</vxml>