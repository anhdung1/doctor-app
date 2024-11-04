package com.example.demo_10.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.UserInfo;
import com.example.demo_10.model.Users;
import com.example.demo_10.model.dto.DoctorsDTO;

import java.util.Collections;


@Service
public class FavoriteService {
	@Autowired
	private UsersService userService;
	
	@Autowired 
	private DoctorsService doctorsService;
	public Object favorite(String username, Long doctorId,boolean isFavorite) {
		Users user=userService.findByUsername(username);
		 UserInfo userInfo = user.getUserInfo();
		    Doctors doctor = doctorsService.findById(doctorId);

		    if (userInfo != null && doctor != null) {
		        if(!isFavorite) {
		        	userInfo.getFavoriteDoctors().add(doctor);		 
		        }else {
		        	userInfo.getFavoriteDoctors().remove(doctor); 		       
		        }
		        userService.saveUserWithUser(user); 
		        DoctorsDTO doctorDTO=new DoctorsDTO(doctor, !isFavorite);
		        return doctorDTO;
		    }
		    return false;
	}
	public List<DoctorsDTO> getFavoriteDoctors(String username) {
		Users user=userService.findByUsername(username);
		UserInfo userInfo=user.getUserInfo();
	    System.out.println(userInfo != null && userInfo.getFavoriteDoctors() != null);
	    if (userInfo != null && userInfo.getFavoriteDoctors() != null) {
	    	System.out.println("");
	    	System.out.println("");
	    	System.out.println(userInfo.getFavoriteDoctors());
	    	System.out.println("");
	    	System.out.println("");
	        List<DoctorsDTO> arrayListDTO = new ArrayList<>();
	        for (Doctors doctor : userInfo.getFavoriteDoctors()) {
	            DoctorsDTO doctorsDTO = new DoctorsDTO(doctor, true);
	            arrayListDTO.add(doctorsDTO);
	        }
	        
	        return arrayListDTO;
	    }
	    return Collections.emptyList();
	}

}
