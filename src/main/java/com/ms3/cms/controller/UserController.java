package com.ms3.cms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.ms3.cms.dto.UserDetailDto;
import com.ms3.cms.dto.UserDto;
import com.ms3.cms.service.UserService;

@RestController
public class UserController {
	
	@Autowired
	private UserService userService;

	@GetMapping(path = "/users", produces = "application/json")
	public List<UserDto> getUsers() {
		return userService.getUsers();
	}
	
	@GetMapping(path = "/user/{userId}", produces = "application/json")
	public UserDetailDto getUserDetails(@PathVariable("userId") Integer userId) {
		return userService.getUserDetails(userId);
	}
	
	@PostMapping(path = "/user", produces = "application/json", consumes = "application/json")
	public Map<String, Object> addUserDetail(@RequestBody UserDetailDto userDetail) {
		Map<String, Object> responseObject = new HashMap<String, Object>(0);
		try {
			UserDetailDto addedUser = userService.addUserDetail(userDetail);
			responseObject.put("user", addedUser);
			responseObject.put("msg", "User added successfully");
			responseObject.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			responseObject.put("msg", ExceptionUtils.getMessage(e));
			responseObject.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			e.printStackTrace();
		}
		return responseObject;
	}
	
	@PutMapping(path = "/user/{userId}", produces = "application/json", consumes = "application/json")
	public Map<String, Object> updateUserDetail(@PathVariable Integer userId, @RequestBody UserDetailDto userDetail) {
		Map<String, Object> responseObject = new HashMap<String, Object>(0);
		try {
			UserDetailDto editedUser = userService.editUserDetail(userId, userDetail);
			responseObject.put("user", editedUser);
			responseObject.put("msg", "User updated successfully");
			responseObject.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			responseObject.put("msg", ExceptionUtils.getMessage(e));
			responseObject.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			e.printStackTrace();
		}
		return responseObject;
	}
	
	@DeleteMapping(path = "/user/{userId}", produces = "application/json")
	public Map<String, Object> deleteUser(@PathVariable Integer userId) {
		Map<String, Object> responseObject = new HashMap<String, Object>(0);
		try {
			UserDetailDto deletedUser = userService.deleteUserDetail(userId);
			responseObject.put("user", deletedUser);
			responseObject.put("msg", "User deleted successfully");
			responseObject.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			responseObject.put("msg", ExceptionUtils.getMessage(e));
			responseObject.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			e.printStackTrace();
		}
		return responseObject;
	}
}
