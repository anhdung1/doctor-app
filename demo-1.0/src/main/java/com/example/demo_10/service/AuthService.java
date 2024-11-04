package com.example.demo_10.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo_10.model.UserInfo;
import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.Users;
import com.example.demo_10.model.response.LoginResponse;
@Service
public class AuthService {

	 @Autowired 
	   private RolesService rolesService;
	    @Autowired
	    private UsersService usersService; 
	    @Autowired
	    private  UserInfoService userInfoService;
	 public void register(Users user) {
	    Users newUser=	usersService.saveUsers(rolesService.findByName(), usersService.encodePassword(user.getPassword()), user.getUsername());
	    	userInfoService.saveUserInfo(newUser);
	    	
	 }
	 public LoginResponse responseUser(String token,String username) {
		 Users user= usersService.findByUsername(username);
		 UserInfo userInfo=user.getUserInfo();
		 if(userInfo==null) {
			 Doctors doctor=user.getDoctor();
			 return new LoginResponse(token, doctor); 
		 }
		 return new LoginResponse(token,userInfo);
		 
	 }
	 
}
