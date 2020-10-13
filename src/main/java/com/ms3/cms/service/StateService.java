package com.ms3.cms.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ms3.cms.dto.StateDto;
import com.ms3.cms.model.State;
import com.ms3.cms.repository.StateRepository;

@Service
public class StateService {

	@Autowired
	private StateRepository stateRepository;
	
	public List<StateDto> getStatesByCountryId(Integer countryId) {
		List<StateDto> stateDtoList = new ArrayList<StateDto>(0);
		List<State> stateList = stateRepository.findByCountryCountryId(countryId);
		stateList.forEach(state -> stateDtoList.add(mapStateToDto(state)));
		return stateDtoList;
	}
	
	private StateDto mapStateToDto(State state) {
		StateDto stateDto = new StateDto();
		stateDto.setStateId(state.getStateId());
		if (null != state.getCountry()) {
			stateDto.setCountryId(state.getCountry().getCountryId());
			stateDto.setCountryName(state.getCountry().getName());
		}
		stateDto.setName(state.getName());
		stateDto.setAbbrev(state.getAbbrev());
		return stateDto;
	}
}
