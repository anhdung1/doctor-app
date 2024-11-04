package com.example.demo_10.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Roles;
import com.example.demo_10.model.UserInfo;
import com.example.demo_10.model.Users;
import com.example.demo_10.repository.UsersRepository;
@Service
public class UsersService {
	@Autowired
	private  RolesService rolesService;
	@Autowired
    private UsersRepository usersRepository;
    public UsersService(UsersRepository usersRepository) {
        this.usersRepository = usersRepository;
    }
	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public String encodePassword(String rawPassword) {
        
        return passwordEncoder.encode(rawPassword);
    }
    public boolean checkUsernameExists(String username) {
        return usersRepository.existsByUsername(username);
    }
    public void register(Users user) {
		 
		 Roles roles = rolesService.findByName();
		    if (roles == null) {
		      
		        roles = new Roles();
		        roles.setName("ROLE_USER");
		        roles = rolesService.save(roles); 
		    }
	    	Users newUser=new Users();
	    	newUser.setRole(roles);
	    	newUser.setPassword(encodePassword(user.getPassword()));
	    	newUser.setUsername(user.getUsername());
	    	usersRepository.save(newUser);
	 }
    public String getUsername() {
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        return  authentication.getName();
	        
    }
    public Users findByUsername(String username) {
    	return usersRepository.findByUsername(username);
    }
    public Users findReceiverById(Long receiverId) {
    	return usersRepository.findReceiverById(receiverId);
    }
    public Users findById(Long id) {
    	return usersRepository.findById(id).orElseThrow();
    }
    public boolean existByUsername(String username) {
    	return usersRepository.existsByUsername(username);
    }
    public Users saveUsers(Roles role,String password,String username) {
    	Users user=new Users();
    	user.setPassword(password);
    	user.setRole(role);
    	user.setUsername(username);
    
    	usersRepository.save(user);
    	return user;
    }
    public Users saveUserWithUser(Users user) {
    	usersRepository.save(user);
    	return user;
    }
    public UserInfo updateUserInfo(String username,UserInfo userInfo) {
    	Users user=usersRepository.findByUsername(username);
    	UserInfo userInfoUpdate=user.getUserInfo();
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
