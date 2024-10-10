package com.example.demo_10.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo_10.model.Users;

public interface UsersRepository extends JpaRepository<Users,Long> {
	Users findByUsername(String username);
	boolean existsByUsername(String username);
}
