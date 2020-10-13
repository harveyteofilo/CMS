package com.ms3.cms.dto;

import java.io.Serializable;

public class CountryDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer countryId;
	private String name;
	private String abbrev;
	/**
	 * @return the countryId
	 */
	public Integer getCountryId() {
		return countryId;
	}
	/**
	 * @param countryId the countryId to set
	 */
	public void setCountryId(Integer countryId) {
		this.countryId = countryId;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the abbrev
	 */
	public String getAbbrev() {
		return abbrev;
	}
	/**
	 * @param abbrev the abbrev to set
	 */
	public void setAbbrev(String abbrev) {
		this.abbrev = abbrev;
	}
	@Override
	public String toString() {
		return "CountryDto [countryId=" + countryId + ", name=" + name + ", abbrev=" + abbrev + "]";
	}
}
