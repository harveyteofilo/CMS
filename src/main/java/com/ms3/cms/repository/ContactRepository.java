package com.ms3.cms.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ms3.cms.model.Contact;

@Repository
public interface ContactRepository extends CrudRepository<Contact, Integer> {

	public List<Contact> findByUserUserId(Integer userId);
	
	public void deleteByUserUserId(Integer userId);
}
