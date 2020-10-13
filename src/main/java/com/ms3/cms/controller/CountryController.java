package com.ms3.cms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.ms3.cms.dto.CountryDto;
import com.ms3.cms.dto.StateDto;
import com.ms3.cms.service.CountryService;
import com.ms3.cms.service.StateService;

@RestController
public class CountryController {
	
	@Autowired
	private CountryService countryService;
	
	@Autowired
	private StateService stateService;
	
	@GetMapping(path = "/countries", produces = "application/json")
	public List<CountryDto> getCountries() {
		return countryService.getCountries();
	}

	@GetMapping(path = "/country/{countryId}/states", produces = "application/json")
	public List<StateDto> getCountryStates(@PathVariable("countryId") Integer countryId) {
		return stateService.getStatesByCountryId(countryId);
	}
}
