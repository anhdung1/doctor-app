package com.example.demo_10.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo_10.model.UserInfo;
import com.example.demo_10.service.UsersService;

@RestController
@RequestMapping("/user_information")
public class UsersController {
	@Autowired
	public UsersService userService;
	@GetMapping
	public UserInfo getUserInfor() {
	
		return userService.getUserInfo(userService.getUsername());
	}
	@PutMapping
	public UserInfo updateUserInfo(@RequestBody UserInfo userInfo) {
		return userService.updateUserInfo(userService.getUsername(), userInfo);
	}
}
