package com.iitb.GroupBean;

import java.util.ArrayList;

public class GroupBean {
	Object [][] group_details;
	Object [][] change_group;
	Object [][] manipulate_add;
	Object [][] manipulate_delete;
	Object [][] manage_settings;
	String groups_id;
	String group_name;
	ArrayList<Object[][]> array_list;
	public Object[][] getGroup_details() {
		return group_details;
	}
	public void setGroup_details(Object[][] group_details) {
		this.group_details = group_details;
	}
	public Object[][] getChange_group() {
		return change_group;
	}
	public void setChange_group(Object[][] change_group) {
		this.change_group = change_group;
	}
	public Object[][] getManipulate_add() {
		return manipulate_add;
	}
	public void setManipulate_add(Object[][] manipulate_add) {
		this.manipulate_add = manipulate_add;
	}
	public Object[][] getManipulate_delete() {
		return manipulate_delete;
	}
	public void setManipulate_delete(Object[][] manipulate_delete) {
		this.manipulate_delete = manipulate_delete;
	}
	public Object[][] getManage_settings() {
		return manage_settings;
	}
	public void setManage_settings(Object[][] manage_settings) {
		this.manage_settings = manage_settings;
	}
	public String getGroups_id() {
		return groups_id;
	}
	public void setGroups_id(String groups_id) {
		this.groups_id = groups_id;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public ArrayList<Object[][]> getArray_list() {
		return array_list;
	}
	public void setArray_list(ArrayList<Object[][]> array_list) {
		this.array_list = array_list;
	}
	
	
}
