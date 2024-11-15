package com.example.demo_10.controller;

import java.util.List;

import com.example.demo_10.model.dto.AppointmentRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import com.example.demo_10.model.Appointments;
import com.example.demo_10.service.AppointmentsService;
import com.example.demo_10.service.DoctorsService;

@RestController
@RequestMapping("/appointment")
public class AppointmentsController {
	@Autowired
	private DoctorsService doctorsService;
	@Autowired
	private AppointmentsService appointmentService;
	@GetMapping
	public ResponseEntity<List<Appointments>> getAppointment(@RequestParam Long doctorId){
		return ResponseEntity.ok(doctorsService.getAppointment(doctorId));
	}

	@PatchMapping("/{id}")
	public ResponseEntity<String> setBookingAppointment(@PathVariable Long id){
		Authentication authentication= SecurityContextHolder.getContext().getAuthentication();

		try{String result=appointmentService.setPatient(id,authentication.getName());
			if(result.equals("Success")) {
				return ResponseEntity.ok(result);
			}
			return ResponseEntity.ofNullable(result);}
		catch(Exception e){
			return ResponseEntity.ok(e.getMessage());
		}
	}
}
