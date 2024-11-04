package com.example.demo_10.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.UserInfo;
import com.example.demo_10.model.Users;
import com.example.demo_10.repository.UserInfoRepository;

@Service
public class UserInfoService {

	@Autowired
	private UserInfoRepository userInfoRepsository;
	
	public void saveUserInfo(Users user) {
		UserInfo newUserInfo=new UserInfo();
		newUserInfo.setUserInfoId(user.getId());
		newUserInfo.setUser(user);
		userInfoRepsository.save(newUserInfo);
	}
	public UserInfo findUserInfoByUsername(String username) {
    	return userInfoRepsository.findUserInfoByUsername(username);
    }
	public void saveUserInfo(UserInfo userInfo) {
		userInfoRepsository.save(userInfo);
	}
	
}
