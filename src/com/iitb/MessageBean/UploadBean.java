package com.iitb.MessageBean;

public class UploadBean implements java.io.Serializable
{
	
	String broadcast_url;
	Object[][] data ;
	String id_message;
	Object[][] video_id;

	int count;
	int total;
	
	public String getBroadcast_url() {
		return broadcast_url;
	}
	public void setBroadcast_url(String broadcast_url) {
		this.broadcast_url = broadcast_url;
	}
	public String getId_message() {
		return id_message;
	}
	public void setId_message(String id_message) {
		this.id_message = id_message;
	}
	public Object[][] getVideo_id() {
		return video_id;
	}
	public void setVideo_id(Object[][] video_id) {
		this.video_id = video_id;
	}
	public Object[][] getData() {
		return data;
	}
	public void setData(Object[][] data) {
		this.data = data;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
}
