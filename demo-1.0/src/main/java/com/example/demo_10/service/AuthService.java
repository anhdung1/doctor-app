package com.example.demo_10.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Roles;
import com.example.demo_10.model.UserInfo;
import com.example.demo_10.model.Users;
import com.example.demo_10.model.response.LoginResponse;
import com.example.demo_10.repository.RolesRepository;
import com.example.demo_10.repository.UserInfoRepository;
import com.example.demo_10.repository.UsersRepository;

@Service
public class AuthService {

	 @Autowired 
	   private RolesRepository rolesRepository;
	    @Autowired
	    private UsersService usersService; 
	    @Autowired
	    private  UserInfoRepository userInfoRepository;
	 @Autowired 
	   private UsersRepository usersRepository;
	 public void register(Users user) {
		 
		 Roles roles = rolesRepository.findByName("USER");
		    if (roles == null) {
		      
		        roles = new Roles();
		        roles.setName("USER");
		        roles = rolesRepository.save(roles); 
		    }
		    
		    
	    	Users newUser=new Users();
	    	newUser.setRole(roles);
	    	newUser.setPassword(usersService.saveUser(user.getPassword()));
	    	newUser.setUsername(user.getUsername());
	    	
	    	usersRepository.save(newUser);
	    	UserInfo userInfo=new UserInfo();
	    	userInfo.setUser(newUser);
	    	userInfoRepository.save(userInfo);
	 }
	 public LoginResponse responseUser(String token,String username) {
		 Users user= usersRepository.findByUsername(username);
		 UserInfo userInfo=userInfoRepository.findByUser(user);
		 return new LoginResponse(token,userInfo);
	 }
	 
}
