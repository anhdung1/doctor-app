package com.example.demo_10.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.UserInfo;
import com.example.demo_10.model.Users;
import com.example.demo_10.model.dto.DoctorsDTO;
import com.example.demo_10.repository.DoctorsRepository;
import com.example.demo_10.repository.UserInfoRepository;
import com.example.demo_10.repository.UsersRepository;
import java.util.Collections;


@Service
public class FavoriteService {
	@Autowired
	private UsersRepository usersRepository;
	@Autowired
	private UserInfoRepository userInfoRepository;
	@Autowired 
	private DoctorsRepository doctorsRepository;
	public Object favorite(String username, Long doctorId,boolean isFavorite) {
		Users user=usersRepository.findByUsername(username);
		 UserInfo userInfo = userInfoRepository.findByUser(user);
		    Doctors doctor = doctorsRepository.findById(doctorId).orElse(null);

		    if (userInfo != null && doctor != null) {
		        if(!isFavorite) {
		        	userInfo.getFavoriteDoctors().add(doctor);		 
		        }else {
		        	userInfo.getFavoriteDoctors().remove(doctor); 		       
		        }
		        usersRepository.save(user); 
		        DoctorsDTO doctorDTO=new DoctorsDTO(doctor, !isFavorite);
		        return doctorDTO;
		    }
		    return false;
	}
	public List<DoctorsDTO> getFavoriteDoctors(String username) {
	    UserInfo userInfo = userInfoRepository.findUserInfoByUsername(username);
	    if (userInfo != null && userInfo.getFavoriteDoctors() != null) {
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
