package com.example.demo_10.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.dto.DoctorsDTO;
import com.example.demo_10.repository.DoctorsRepository;
import com.example.demo_10.service.DoctorsDTOService;
import com.example.demo_10.service.FavoriteService;
import com.example.demo_10.service.UsersService;

@RestController
@RequestMapping("/doctors")
public class DoctorsController {
	@Autowired
	private FavoriteService favoriteService;
	@Autowired 
	private DoctorsDTOService doctorsDTOService;
	@Autowired
	private DoctorsRepository doctorsRepository;
	@Autowired
	private UsersService usersService;
	@GetMapping
	public ResponseEntity<List<DoctorsDTO>> getDoctors(){
		List<Doctors> doctors=doctorsRepository.findRandomDoctors();
		if(doctors.isEmpty()) {
			return ResponseEntity.notFound().build();
		}
		
		return ResponseEntity.ok(doctorsDTOService.transToDoctorsDTO(doctors,usersService.getUsername()));
	}
	@GetMapping("/all-doctors")
	public ResponseEntity<List<DoctorsDTO>> getAllDoctors(){
		List<Doctors> doctors=doctorsRepository.findAll();
		if(doctors.isEmpty()) {
			return ResponseEntity.notFound().build();
		}
		
		return ResponseEntity.ok(doctorsDTOService.transToDoctorsDTO(doctors,usersService.getUsername()));
	}
	@GetMapping("/search")
	public ResponseEntity<List<DoctorsDTO>> searchDoctors(@RequestParam String category){

		List<Doctors> doctors=doctorsRepository.findByCategoryContaining(category);
		if(doctors.isEmpty()) {
			return ResponseEntity.notFound().build();
		}
		return ResponseEntity.ok(doctorsDTOService.transToDoctorsDTO(doctors,usersService.getUsername()));
	}
	@PostMapping("/updatefavorite")
	 public ResponseEntity<?> addFavorite(@RequestParam Long doctorId ,@RequestParam boolean isFavorite){
		Object  isSuccess=    favoriteService.favorite(usersService.getUsername(), doctorId,isFavorite);
	     if(isSuccess instanceof Boolean)return ResponseEntity.notFound().build();
	     else return ResponseEntity.ok(isSuccess);
	}
	@GetMapping("/getfavorite")
	 public ResponseEntity<?> getFavorite(){
		 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        String username = authentication.getName();
	        
	     return ResponseEntity.ok(favoriteService.getFavoriteDoctors(username));
	}

}
