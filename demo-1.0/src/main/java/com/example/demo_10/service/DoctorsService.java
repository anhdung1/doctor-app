package com.example.demo_10.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.Users;
import com.example.demo_10.repository.DoctorsRepository;
import com.example.demo_10.repository.UsersRepository;

@Service
public class DoctorsService {
	@Autowired
	private UsersRepository usersRepository;
	@Autowired
	private DoctorsRepository doctorsRepository;
	public boolean removeFavoriteDoctor(String username, Long doctorId) {
	    Users user = usersRepository.findByUsername(username);
	    Doctors doctor = doctorsRepository.findById(doctorId).orElse(null);

	    if (user != null && doctor != null) {
	 
	        boolean removed = user.getFavoriteDoctors().remove(doctor);
	        if (removed) {
	            usersRepository.save(user); 
	            return true;
	        } else {
	            return false;
	        }
	    }
	    return false; 
	}
}