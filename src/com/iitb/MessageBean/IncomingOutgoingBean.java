package com.iitb.MessageBean;

public class IncomingOutgoingBean
{
	Object[][] outgoing_messages;
	Object[][] outgoing_calls;
	Object[][] incoming_calls;
	Object[][] pending_calls;
	
	public Object[][] getOutgoing_calls() {
		return outgoing_calls;
	}
	public void setOutgoing_calls(Object[][] outgoing_calls) {
		this.outgoing_calls = outgoing_calls;
	}
	public Object[][] getIncoming_calls() {
		return incoming_calls;
	}
	public void setIncoming_calls(Object[][] incoming_calls) {
		this.incoming_calls = incoming_calls;
	}
	public Object[][] getPending_calls() {
		return pending_calls;
	}
	public void setPending_calls(Object[][] pending_calls) {
		this.pending_calls = pending_calls;
	}
	public Object[][] getOutgoing_messages() {
		return outgoing_messages;
	}
	public void setOutgoing_messages(Object[][] outgoing_messages) {
		this.outgoing_messages = outgoing_messages;
	}
}