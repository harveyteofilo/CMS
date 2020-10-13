package com.ms3.cms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.ms3.cms.dto.CityDto;
import com.ms3.cms.service.CityService;

@RestController
public class StateController {

	@Autowired
	private CityService cityService;
	
	@GetMapping(path = "/state/{stateId}/cities", produces = "application/json")
	public List<CityDto> getStateCities(@PathVariable("stateId") Integer stateId) {
		return cityService.getCitiesByState(stateId);
	}
}
