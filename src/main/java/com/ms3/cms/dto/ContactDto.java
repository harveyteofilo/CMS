package com.ms3.cms.dto;

import java.io.Serializable;

public class ContactDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer contactId;
	private Integer userId;
	private String type;
	private String value;
	private String isPreferred;
	/**
	 * @return the contactId
	 */
	public Integer getContactId() {
		return contactId;
	}
	/**
	 * @param contactId the contactId to set
	 */
	public void setContactId(Integer contactId) {
		this.contactId = contactId;
	}
	/**
	 * @return the userId
	 */
	public Integer getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}
	/**
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}
	/**
	 * @return the isPreferred
	 */
	public String getIsPreferred() {
		return isPreferred;
	}
	/**
	 * @param isPreferred the isPreferred to set
	 */
	public void setIsPreferred(String isPreferred) {
		this.isPreferred = isPreferred;
	}
	@Override
	public String toString() {
		return "ContactDto [contactId=" + contactId + ", userId=" + userId + ", type=" + type + ", value=" + value
				+ ", isPreferred=" + isPreferred + "]";
	}
}
