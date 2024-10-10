package com.example.demo_10.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.Users;
import com.example.demo_10.model.dto.DoctorsDTO;
import com.example.demo_10.repository.UsersRepository;
@Service
public class DoctorsDTOService {
	@Autowired
	private UsersRepository usersRepository;
	public List<DoctorsDTO> transToDoctorsDTO(List<Doctors> listDoctors, String username) {
	    if (listDoctors.isEmpty()) {
	        return Collections.emptyList();
	    }
	    Users user = usersRepository.findByUsername(username);
	    List<Doctors> favoriteDoctors = new ArrayList<>(user.getFavoriteDoctors());
	    
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
