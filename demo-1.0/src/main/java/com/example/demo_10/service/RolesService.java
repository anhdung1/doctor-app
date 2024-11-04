package com.example.demo_10.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.Roles;
import com.example.demo_10.repository.RolesRepository;

@Service
public class RolesService {
	@Autowired
	private RolesRepository rolesRepository;
	public Roles findByName() {
		Roles roles = rolesRepository.findByName("ROLE_USER");
	    if (roles == null) {
	      
	        roles = new Roles();
	        roles.setName("ROLE_USER");
	        roles = rolesRepository.save(roles); 
	    }
	    return roles;
	}
	public Roles save(Roles role) {
	return rolesRepository.save(role);
	}
}
