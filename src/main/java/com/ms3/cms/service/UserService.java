package com.ms3.cms.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.BooleanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.ms3.cms.dto.AddressDto;
import com.ms3.cms.dto.CityDto;
import com.ms3.cms.dto.ContactDto;
import com.ms3.cms.dto.UserDetailDto;
import com.ms3.cms.dto.UserDto;
import com.ms3.cms.model.Address;
import com.ms3.cms.model.City;
import com.ms3.cms.model.Contact;
import com.ms3.cms.model.User;
import com.ms3.cms.repository.AddressRepository;
import com.ms3.cms.repository.ContactRepository;
import com.ms3.cms.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private AddressRepository addressRepository;
	
	@Autowired
	private ContactRepository contactRepository;
	
	public List<UserDto> getUsers() {
		List<UserDto> userDtoList = new ArrayList<UserDto>(0);
		List<User> userList = userRepository.findAll();
		userList.forEach(user -> userDtoList.add(mapUserToDto(user)));
		return userDtoList;
	}
	
	public UserDetailDto getUserDetails(Integer userId) {
		UserDetailDto userDetailDto = new UserDetailDto();
		User user = userRepository.findOne(userId);
		if (null != user) {
			userDetailDto = mapUserToDetailDto(user);
			List<Address> addressList = addressRepository.findByUserUserId(userId);
			List<AddressDto> addressDtoList = new ArrayList<AddressDto>(0);
			addressList.forEach(address -> addressDtoList.add(mapAddressToDto(address)));
			userDetailDto.setAddressList(addressDtoList);
			List<Contact> contactList = contactRepository.findByUserUserId(userId);
			List<ContactDto> contactDtoList = new ArrayList<ContactDto>(0);
			contactList.forEach(contact -> contactDtoList.add(mapContactToDto(contact)));
			userDetailDto.setContactList(contactDtoList);
		}
		return userDetailDto;
	}
	
	@Transactional
	public UserDetailDto addUserDetail(UserDetailDto userDetailDto) {
		UserDetailDto savedUserDetailDto = null;
		if (null != userDetailDto) {
			User user = mapDtoToUser(userDetailDto);
			User savedUser = userRepository.save(user);
			List<Address> savedAddressList = new ArrayList<Address>(0);
			List<Contact> savedContactList = new ArrayList<Contact>(0);
			if (!CollectionUtils.isEmpty(userDetailDto.getAddressList())) {
				List<Address> addressList = new ArrayList<Address>(0);
				for (AddressDto addressDto : userDetailDto.getAddressList()) {
					Address address = mapDtoToAddress(addressDto);
					address.setUser(savedUser);
					addressList.add(address);
				}
				savedAddressList = (List<Address>) addressRepository.save(addressList);
			}
			if (!CollectionUtils.isEmpty(userDetailDto.getContactList())) {
				List<Contact> contactList = new ArrayList<Contact>(0);
				for (ContactDto contactDto : userDetailDto.getContactList()) {
					Contact contact = mapDtoToContact(contactDto);
					contact.setUser(savedUser);
					contactList.add(contact);
				}
				savedContactList = (List<Contact>) contactRepository.save(contactList);
			}
			if (null != savedUser) {
				savedUserDetailDto = mapUserToDetailDto(user);
				List<AddressDto> savedAddressDtoList = new ArrayList<AddressDto>(0);
				savedAddressList.forEach(savedAddress -> savedAddressDtoList.add(mapAddressToDto(savedAddress)));
				savedUserDetailDto.setAddressList(savedAddressDtoList);
				List<ContactDto> savedContactDtoList = new ArrayList<ContactDto>(0);
				savedContactList.forEach(savedContact -> savedContactDtoList.add(mapContactToDto(savedContact)));
				savedUserDetailDto.setContactList(savedContactDtoList);
			}
		}
		return savedUserDetailDto;
	}
	
	@Transactional
	public UserDetailDto editUserDetail(Integer userId, UserDetailDto userDetailDto) throws Exception {
		UserDetailDto savedUserDetailDto = null;
		if (null != userDetailDto && null != userId) {
			if (!userRepository.exists(userId)) {
				throw new Exception("User does not exist");
			}
			User user = mapDtoToUser(userDetailDto);
			User savedUser = userRepository.save(user);
			List<Address> savedAddressList = new ArrayList<Address>(0);
			List<Contact> savedContactList = new ArrayList<Contact>(0);
			// REMOVE ALL PREVIOUS ADDRESSES
			addressRepository.deleteByUserUserId(userId);
			if (!CollectionUtils.isEmpty(userDetailDto.getAddressList())) {
				// UPDATE ADDRESS LIST
				List<Address> addressList = new ArrayList<Address>(0);
				for (AddressDto addressDto : userDetailDto.getAddressList()) {
					Address address = mapDtoToAddress(addressDto);
					address.setUser(savedUser);
					addressList.add(address);
				}
				savedAddressList = (List<Address>) addressRepository.save(addressList);
			}
			// REMOVE ALL PREVIOUS CONTACTS
			contactRepository.deleteByUserUserId(userId);
			if (!CollectionUtils.isEmpty(userDetailDto.getContactList())) {
				List<Contact> contactList = new ArrayList<Contact>(0);
				for (ContactDto contactDto : userDetailDto.getContactList()) {
					Contact contact = mapDtoToContact(contactDto);
					contact.setUser(savedUser);
					contactList.add(contact);
				}
				savedContactList = (List<Contact>) contactRepository.save(contactList);
			}
			if (null != savedUser) {
				savedUserDetailDto = mapUserToDetailDto(user);
				List<AddressDto> savedAddressDtoList = new ArrayList<AddressDto>(0);
				savedAddressList.forEach(savedAddress -> savedAddressDtoList.add(mapAddressToDto(savedAddress)));
				savedUserDetailDto.setAddressList(savedAddressDtoList);
				List<ContactDto> savedContactDtoList = new ArrayList<ContactDto>(0);
				savedContactList.forEach(savedContact -> savedContactDtoList.add(mapContactToDto(savedContact)));
				savedUserDetailDto.setContactList(savedContactDtoList);
			}
		} else {
			throw new Exception("User ID should not be null");
		}
		return savedUserDetailDto;
	}
	
	@Transactional
	public UserDetailDto deleteUserDetail(Integer userId) throws Exception {
		UserDetailDto deletedUser = null;
		if (null != userId) {
			if (!userRepository.exists(userId)) {
				throw new Exception("User does not exist");
			}
			deletedUser = getUserDetails(userId);
			addressRepository.deleteByUserUserId(userId);
			contactRepository.deleteByUserUserId(userId);
			userRepository.delete(userId);
		} else {
			throw new Exception("User ID should not be null");
		}
		return deletedUser;
	}
	
	private UserDto mapUserToDto(User user) {
		UserDto userDto = new UserDto();
		userDto.setUserId(user.getUserId());
		userDto.setFirstName(user.getFirstName());
		userDto.setLastName(user.getLastName());
		userDto.setDateOfBirth(user.getDateOfBirth());
		userDto.setGender(user.getGender());
		userDto.setTitle(user.getTitle());
		return userDto;
	}
	
	private UserDetailDto mapUserToDetailDto(User user) {
		UserDetailDto userDetailDto = new UserDetailDto();
		userDetailDto.setUserId(user.getUserId());
		userDetailDto.setFirstName(user.getFirstName());
		userDetailDto.setLastName(user.getLastName());
		userDetailDto.setDateOfBirth(user.getDateOfBirth());
		userDetailDto.setGender(user.getGender());
		userDetailDto.setTitle(user.getTitle());
		return userDetailDto;
	}
	
	private AddressDto mapAddressToDto(Address address) {
		AddressDto addressDto = new AddressDto();
		addressDto.setAddressId(address.getAddressId());
		addressDto.setUserId(address.getUser().getUserId());
		if (null != address.getCity()) {
			addressDto.setCity(mapCityToDto(address.getCity()));
		}
		addressDto.setType(address.getType());
		addressDto.setNumber(address.getNumber());
		addressDto.setStreet(address.getStreet());
		addressDto.setUnit(address.getUnit());
		addressDto.setZipCode(address.getZipcode());
		return addressDto;
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
	
	private ContactDto mapContactToDto(Contact contact) {
		ContactDto contactDto = new ContactDto();
		contactDto.setContactId(contact.getContactId());
		contactDto.setUserId(contact.getUser().getUserId());
		contactDto.setType(contact.getType());
		contactDto.setValue(contact.getValue());
		contactDto.setIsPreferred(contact.getIsPreferred() ? "Yes" : "No");
		return contactDto;
	}
	
	private User mapDtoToUser(UserDetailDto userDetailDto) {
		User user = new User();
		user.setUserId(userDetailDto.getUserId());
		user.setFirstName(userDetailDto.getFirstName());
		user.setLastName(userDetailDto.getLastName());
		user.setGender(userDetailDto.getGender());
		user.setDateOfBirth(userDetailDto.getDateOfBirth());
		user.setTitle(userDetailDto.getTitle());
		return user;
	}
	
	private Contact mapDtoToContact(ContactDto contactDto) {
		Contact contact = new Contact();
		contact.setContactId(contactDto.getContactId());
		contact.setUser(new User(contactDto.getUserId()));
		contact.setIsPreferred(BooleanUtils.toBoolean(contactDto.getIsPreferred()));
		contact.setType(contactDto.getType());
		contact.setValue(contactDto.getValue());
		return contact;
	}
	
	private Address mapDtoToAddress(AddressDto addressDto) {
		Address address = new Address();
		address.setAddressId(addressDto.getAddressId());
		address.setUser(new User(addressDto.getUserId()));
		address.setCity(new City(addressDto.getCityId()));
		address.setNumber(addressDto.getNumber());
		address.setStreet(addressDto.getStreet());
		address.setType(addressDto.getType());
		address.setUnit(addressDto.getUnit());
		address.setZipcode(addressDto.getZipCode());
		return address;
	}
}
