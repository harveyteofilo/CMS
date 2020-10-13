package com.ms3.cms.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ms3.cms.model.Address;

@Repository
public interface AddressRepository extends CrudRepository<Address, Integer> {

	public List<Address> findByUserUserId(Integer userId);
	
	public void deleteByUserUserId(Integer userId);
}
