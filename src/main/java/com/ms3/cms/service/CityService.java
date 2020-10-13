package com.ms3.cms.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ms3.cms.dto.CityDto;
import com.ms3.cms.model.City;
import com.ms3.cms.repository.CityRepository;

@Service
public class CityService {

	@Autowired
	private CityRepository cityRepository;
	
	public List<CityDto> getCitiesByState(Integer stateId) {
		List<CityDto> cityDtoList = new ArrayList<CityDto>(0);
		List<City> cityList = cityRepository.findByStateStateId(stateId);
		cityList.forEach(city -> cityDtoList.add(mapCityToDto(city)));
		return cityDtoList;
	}
	
	private CityDto mapCityToDto(City city) {
		CityDto cityDto = new CityDto();
		cityDto.setCityId(city.getCityId());
		cityDto.setName(city.getName());
		if (null != city.getState()) {
			cityDto.setStateId(city.getState().getStateId());
			cityDto.setStateName(city.getState().getName());
		}
		return cityDto;
	}
}
