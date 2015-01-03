package com.iitb.SettingsBean;

public class BillingBean {
	Object[][] bill_settings;
	Object[][] bill;
	String bill_total_list[];
	public String[] getBill_total_list() {
		return bill_total_list;
	}

	public void setBill_total_list(String[] bill_total_list) {
		this.bill_total_list = bill_total_list;
	}

	String bill_id;
	String bill_id_list[];
	String bill_total;
	String update;
	public String[] getBill_id_list() {
		return bill_id_list;
	}

	public void setBill_id_list(String[] bill_id_list) {
		this.bill_id_list = bill_id_list;
	}

	public Object[][] getBill() {
		return bill;
	}

	public void setBill(Object[][] bill) {
		this.bill = bill;
	}

	
	

	public String getUpdate() {
		return update;
	}

	public void setUpdate(String update) {
		this.update = update;
	}

	public String getBill_total() {
		return bill_total;
	}

	public void setBill_total(String bill_total) {
		this.bill_total = bill_total;
	}

	public String getBill_id() {
		return bill_id;
	}

	public void setBill_id(String bill_id) {
		this.bill_id = bill_id;
	}
	
	public Object[][] getBill_settings() {
		return bill_settings;
	}

	public void setBill_settings(Object[][] bill_settings) {
		this.bill_settings = bill_settings;
	}
}
