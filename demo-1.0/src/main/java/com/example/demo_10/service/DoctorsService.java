package com.example.demo_10.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.UserInfo;

import com.example.demo_10.repository.DoctorsRepository;
import com.example.demo_10.repository.UserInfoRepository;


@Service
public class DoctorsService {
	@Autowired
	private UserInfoRepository userInfoRepository;
	@Autowired
	private DoctorsRepository doctorsRepository;
	public boolean removeFavoriteDoctor(String username, Long doctorId) {
	    UserInfo useInfo = userInfoRepository.findUserInfoByUsername(username);
	    Doctors doctor = doctorsRepository.findById(doctorId).orElse(null);

	    if (useInfo != null && doctor != null) {
	 
	        boolean removed = useInfo.getFavoriteDoctors().remove(doctor);
	        if (removed) {
	        	userInfoRepository.save(useInfo); 
	            return true;
	        } else {
	            return false;
	        }
	    }
	    return false; 
	}
}