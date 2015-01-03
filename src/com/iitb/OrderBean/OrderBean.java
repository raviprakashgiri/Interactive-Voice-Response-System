package com.iitb.OrderBean;

import java.util.ArrayList;

public class OrderBean {
	Object[][] total_unit_sold;
	Float[] total_quantity_sold;
	Object[][] saved_order;
	ArrayList<Object[][]> save_order;
	public ArrayList<Object[][]> getSave_order() {
		return save_order;
	}
	public void setSave_order(ArrayList<Object[][]> save_order) {
		this.save_order = save_order;
	}
	public Object[][] getTotal_unit_sold() {
		return total_unit_sold;
	}
	public void setTotal_unit_sold(Object[][] total_unit_sold) {
		this.total_unit_sold = total_unit_sold;
	}
	public Float[] getTotal_quantity_sold() {
		return total_quantity_sold;
	}
	public void setTotal_quantity_sold(Float[] total_quantity_sold) {
		this.total_quantity_sold = total_quantity_sold;
	}
	public Object[][] getSaved_order() {
		return saved_order;
	}
	public void setSaved_order(Object[][] saved_order) {
		this.saved_order = saved_order;
	}
	
	
}
