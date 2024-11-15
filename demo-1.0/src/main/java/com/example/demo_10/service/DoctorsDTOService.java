package com.example.demo_10.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.UserInfo;

import com.example.demo_10.model.dto.DoctorsDTO;

@Service
public class DoctorsDTOService {
	@Autowired
	private UserInfoService userInfoService;
	public List<DoctorsDTO> transToDoctorsDTO(List<Doctors> listDoctors, String username) {
	    if (listDoctors.isEmpty()) {
	        return Collections.emptyList();
	    }
	   
	    UserInfo userInfo=userInfoService.getUserInfoRepository().findUserInfoByUsername(username);
	    List<Doctors> favoriteDoctors = new ArrayList<>(userInfo.getFavoriteDoctors());
	    
	    List<DoctorsDTO> arrayListDTO = new ArrayList<>();
	    for (Doctors doctor : listDoctors) {
	        boolean isFavorite = favoriteDoctors.stream()
	                                            .anyMatch(favDoctor -> favDoctor.getId().equals(doctor.getId()));
	        DoctorsDTO doctorsDTO = new DoctorsDTO(doctor, isFavorite);
	        arrayListDTO.add(doctorsDTO);
	    }

	    return arrayListDTO;
	}

}
