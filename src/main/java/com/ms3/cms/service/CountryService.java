package com.ms3.cms.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ms3.cms.dto.CountryDto;
import com.ms3.cms.model.Country;
import com.ms3.cms.repository.CountryRepository;

@Service
public class CountryService {

	@Autowired
	private CountryRepository countryRepository;
	
	public List<CountryDto> getCountries() {
		List<CountryDto> countryDtoList = new ArrayList<CountryDto>(0);
		List<Country> countryList = countryRepository.findAll();
		countryList.forEach(country -> countryDtoList.add(mapCountryToDto(country)));
		return countryDtoList;
	}
	
	private CountryDto mapCountryToDto(Country country) {
		CountryDto countryDto = new CountryDto();
		countryDto.setCountryId(country.getCountryId());
		countryDto.setName(country.getName());
		countryDto.setAbbrev(country.getAbbrev());
		return countryDto;
	}
}
