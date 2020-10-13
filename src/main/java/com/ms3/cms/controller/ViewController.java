package com.ms3.cms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import com.ms3.cms.service.StateService;
import com.ms3.cms.service.UserService;

@Controller
public class ViewController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private StateService stateService;
	
	private final Integer USA_COUNTRY_ID = 1;

	@GetMapping(path = "/home")
	public ModelAndView home() {
		ModelAndView modelAndView = new ModelAndView("home");
		modelAndView.addObject("pageTitle", "Home");
		modelAndView.addObject("users", userService.getUsers());
		return modelAndView;
	}
	
	@GetMapping(path = "/user-detail/{userId}")
	public ModelAndView userDetail(@PathVariable("userId") Integer userId) {
		ModelAndView modelAndView = new ModelAndView("user-detail");
		modelAndView.addObject("user", userService.getUserDetails(userId));
		return modelAndView;
	}
	
	@GetMapping(path = "/add-user")
	public ModelAndView addUser() {
		ModelAndView modelAndView = new ModelAndView("user-form");
		modelAndView.addObject("pageTitle", "Add User");
		modelAndView.addObject("url", "/cms/user");
		modelAndView.addObject("method", "POST");
		modelAndView.addObject("states", stateService.getStatesByCountryId(USA_COUNTRY_ID));
		return modelAndView;
	}
	
	@GetMapping(path = "edit-user/{userId}")
	public ModelAndView editUser(@PathVariable("userId") Integer userId) {
		ModelAndView modelAndView = new ModelAndView("user-form");
		modelAndView.addObject("pageTitle", "Edit User");
		modelAndView.addObject("url", "/cms/user/" + userId);
		modelAndView.addObject("method", "PUT");
		modelAndView.addObject("user", userService.getUserDetails(userId));
		modelAndView.addObject("states", stateService.getStatesByCountryId(USA_COUNTRY_ID));
		return modelAndView;
	}
}
