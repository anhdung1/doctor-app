package com.example.demo_10.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Roles;
import com.example.demo_10.model.UserInfo;
import com.example.demo_10.model.Users;
import com.example.demo_10.repository.RolesRepository;
import com.example.demo_10.repository.UserInfoRepository;
import com.example.demo_10.repository.UsersRepository;
@Service
public class UsersService {
	@Autowired
	private  RolesRepository rolesRepository;
	@Autowired
    private UsersRepository usersRepository;
	@Autowired
	private UserInfoRepository userInfoRepository;
	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public String saveUser(String rawPassword) {
        
        return passwordEncoder.encode(rawPassword);
    }
    public boolean checkUsernameExists(String username) {
        return usersRepository.existsByUsername(username);
    }
    public void register(Users user) {
		 
		 Roles roles = rolesRepository.findByName("USER");
		    if (roles == null) {
		      
		        roles = new Roles();
		        roles.setName("USER");
		        roles = rolesRepository.save(roles); 
		    }
	    	Users newUser=new Users();
	    	newUser.setRole(roles);
	    	newUser.setPassword(saveUser(user.getPassword()));
	    	newUser.setUsername(user.getUsername());
	    	usersRepository.save(newUser);
	 }
    public String getUsername() {
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        return  authentication.getName();
	        
    }
    public UserInfo getUserInfo(String username) {
    	Users user=usersRepository.findByUsername(username);
    	return user.getUserInfo();
    }
    public UserInfo updateUserInfo(String username,UserInfo userInfo) {
    	Users user=usersRepository.findByUsername(username);
    	UserInfo userInfoUpdate=userInfoRepository.findByUser(user);
    	if(userInfoUpdate==null) {
    		userInfoUpdate=userInfo;
        	userInfoUpdate.setUser(user);
        	 user.setUserInfo(userInfoUpdate);
        	 usersRepository.save(user);

    	}else {
    		userInfoUpdate.setAddress(userInfo.getAddress());
    		userInfoUpdate.setEmail(userInfo.getEmail());
    		userInfoUpdate.setFirstName(userInfo.getFirstName());
    		userInfoUpdate.setLastName(userInfo.getLastName());

    		userInfoUpdate.setPhoneNumber(userInfo.getPhoneNumber());
        	userInfoUpdate.setUser(user);
        	 usersRepository.save(user);
    	}
    	 return user.getUserInfo();
    }
    
}
