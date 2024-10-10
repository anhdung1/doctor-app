package com.example.demo_10.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo_10.model.Roles;

public interface RolesRepository extends JpaRepository<Roles,Long>{
	Roles findByName(String roles);
}
