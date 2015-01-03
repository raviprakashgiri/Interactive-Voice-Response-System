package com.iitb.WellinfoBean;

public class WellDataBean 
{
	
	String[] district_name;
	String[] district_to_tehsil;
	String[] tehsil_to_village;
	Object[][] tehsil_names;
	Object[][] village_name;
	Object[][] well_data;
	
	public String[] getDistrict_name() {
		return district_name;
	}
	public void setDistrict_name(String[] district_name) {
		this.district_name = district_name;
	}
	public String[] getDistrict_to_tehsil() {
		return district_to_tehsil;
	}
	public void setDistrict_to_tehsil(String[] district_to_tehsil) {
		this.district_to_tehsil = district_to_tehsil;
	}
	public String[] getTehsil_to_village() {
		return tehsil_to_village;
	}
	public void setTehsil_to_village(String[] tehsil_to_village) {
		this.tehsil_to_village = tehsil_to_village;
	}
	public Object[][] getTehsil_names() {
		return tehsil_names;
	}
	public void setTehsil_names(Object[][] tehsil_names) {
		this.tehsil_names = tehsil_names;
	}
	public Object[][] getVillage_name() {
		return village_name;
	}
	public void setVillage_name(Object[][] village_name) {
		this.village_name = village_name;
	}
	public Object[][] getWell_data() {
		return well_data;
	}
	public void setWell_data(Object[][] well_data) {
		this.well_data = well_data;
	}
}
