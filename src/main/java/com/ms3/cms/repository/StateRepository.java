package com.ms3.cms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ms3.cms.model.State;

@Repository
public interface StateRepository extends JpaRepository<State, Integer> {

	public List<State> findByCountryCountryId(Integer countryId);
}
