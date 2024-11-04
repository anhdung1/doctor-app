package com.example.demo_10.model.response;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.UserInfo;

public class LoginResponse {
    private String token;
    private UserInfo userInfo;
    private Doctors doctor;
    public LoginResponse(String token,UserInfo userInfo) {
        this.token = token;
        this.userInfo=userInfo;

    }

    public LoginResponse(String token,Doctors doctor ) {
    	this.token=token;
    	this.doctor=doctor;

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

	public Doctors getDoctor() {
		return doctor;
	}

	public void setDoctor(Doctors doctor) {
		this.doctor = doctor;
	}

	


	
}
