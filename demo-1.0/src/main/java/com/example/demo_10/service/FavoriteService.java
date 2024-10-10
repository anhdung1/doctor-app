package com.example.demo_10.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.Users;
import com.example.demo_10.model.dto.DoctorsDTO;
import com.example.demo_10.repository.DoctorsRepository;
import com.example.demo_10.repository.UsersRepository;
import java.util.Collections;


@Service
public class FavoriteService {
	@Autowired
	private UsersRepository usersRepository;
	@Autowired 
	private DoctorsRepository doctorsRepository;
	public Object favorite(String username, Long doctorId,boolean isFavorite) {
		 Users user = usersRepository.findByUsername(username);
		    Doctors doctor = doctorsRepository.findById(doctorId).orElse(null);

		    if (user != null && doctor != null) {
		        if(!isFavorite) {
		        	user.getFavoriteDoctors().add(doctor);		 
		        }else {
		        	user.getFavoriteDoctors().remove(doctor); 		       
		        }
		        usersRepository.save(user); 
		        DoctorsDTO doctorDTO=new DoctorsDTO(doctor, !isFavorite);
		        return doctorDTO;
		    }
		    return false;
	}
	public List<DoctorsDTO> getFavoriteDoctors(String username) {
	    Users user = usersRepository.findByUsername(username);
	    if (user != null && user.getFavoriteDoctors() != null) {
	        List<DoctorsDTO> arrayListDTO = new ArrayList<>();
	        for (Doctors doctor : user.getFavoriteDoctors()) {
	            DoctorsDTO doctorsDTO = new DoctorsDTO(doctor, true);
	            arrayListDTO.add(doctorsDTO);
	        }
	        return arrayListDTO;
	    }
	    return Collections.emptyList();
	}

}
