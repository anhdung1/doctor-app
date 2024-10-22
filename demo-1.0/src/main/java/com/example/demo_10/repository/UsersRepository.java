package com.example.demo_10.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo_10.model.Users;

public interface UsersRepository extends JpaRepository<Users,Long> {
	Users findByUsername(String username);
	boolean existsByUsername(String username);
	@Query("SELECT u FROM Users u JOIN u.chatReceiver r WHERE r.id = :receiverId")
	Users findReceiverById(@Param("receiverId") Long receiverId);
}
