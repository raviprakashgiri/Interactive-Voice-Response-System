package com.iitb.MessageBean;
/*
 * Bean for VoiceMessages.jsp, TextMessages.jsp
 * 
 */
public class VoiceTextMessagesBean 
{	
	Object[][] inbox_messages;
	Object[][] accepted_messages;
	Object[][] rejected_messages;
	Object[][] response_yes;
	Object[][] response_no;
	Object[][] feedback_messages;
	Object[][] processed_messages;
	Object[][] saved_messages;
	Object[][] default_messages;
	
	
	/*---------- Methods for VoiceMessages.java and TextMessages.java ----------------*/
	public Object[][] getInbox_messages()
	{
		return inbox_messages;
	}
	public void setInbox_messages(Object[][] inbox_messages)
	{
		this.inbox_messages=inbox_messages;
	}
	public Object[][] getAccepted_messages()
	{
		return accepted_messages;
	}
	public void setAccepted_messages(Object[][] accepted_messages)
	{
		this.accepted_messages=accepted_messages;
	}
	public Object[][] getRejected_messages()
	{
		return rejected_messages;
	}
	public void setRejected_messages(Object[][] rejected_messages)
	{
		this.rejected_messages=rejected_messages;
	}
	public Object[][] getResponse_yes()
	{
		return response_yes;
	}
	public void setResponse_yes(Object[][] response_yes)
	{
		this.response_yes=response_yes;
	}
	public Object[][] getResponse_no()
	{
		return response_no;
	}
	public void setResponse_no(Object[][] response_no)
	{
		this.response_no=response_no;
	}
	public Object[][] getFeedback_messages()
	{
		return feedback_messages;
	}
	public void setFeedback_messages(Object[][] feedback_messages)
	{
		this.feedback_messages=feedback_messages;
	}
	/*----------------- Methods for VoiceMessages.java only ----------------*/
	public Object[][] getProcessed_messages()
	{
		return processed_messages;
	}
	public void setProcessed_messages(Object[][] processed_messages)
	{
		this.processed_messages=processed_messages;
	}
	public Object[][] getSaved_messages()
	{
		return saved_messages;
	}
	public void setSaved_messages(Object[][] saved_messages)
	{
		this.saved_messages=saved_messages;
	}
	/*------------------ Methods for TextMessages.java only ---------------*/
	public Object[][] getDefault_messages()
	{
		return default_messages;
	}
	public void setDefault_messages(Object[][] default_messages)
	{
		this.default_messages=default_messages;
	}
}
