package com.example.demo_10.model.response;

import com.example.demo_10.model.UserInfo;

public class LoginResponse {
    private String token;
    private UserInfo userInfo;

    public LoginResponse(String token,UserInfo userInfo) {
        this.token = token;
        this.setUserInfo(userInfo);
    }

    
	public String getToken() {
		return token;
	}


	public UserInfo getUserInfo() {
		return userInfo;
	}


	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	
}
