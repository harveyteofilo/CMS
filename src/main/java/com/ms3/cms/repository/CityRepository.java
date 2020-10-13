package com.ms3.cms.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ms3.cms.model.City;

@Repository
public interface CityRepository extends CrudRepository<City, Integer> {

	public List<City> findByStateStateId(Integer stateId);
}
