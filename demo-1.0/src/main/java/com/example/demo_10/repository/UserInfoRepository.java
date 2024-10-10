package com.example.demo_10.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo_10.model.UserInfo;

public interface UserInfoRepository extends JpaRepository<UserInfo,Long> {
	
}
