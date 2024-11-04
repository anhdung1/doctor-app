package com.example.demo_10.service;

import com.example.demo_10.model.Users;
import com.example.demo_10.model.dto.AppointmentRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo_10.model.Appointments;
import com.example.demo_10.repository.AppointmentsRepository;

@Service
public class AppointmentsService {
	@Autowired
	private UsersService usersService;
	@Autowired
	private AppointmentsRepository appointmentRepository;
	
	public String setPatient(Long id,String username ) {
		Users user = usersService.findByUsername(username);
		Appointments appointment=appointmentRepository.findById(id).orElseThrow();

			if(appointment.getUsers()!=null) {
				appointment.setUsers(user);
				return "Success";
			}
			return "Appointment has been booked";

	}
}
