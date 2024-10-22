package com.example.demo_10.repository;



import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


import com.example.demo_10.model.UserInfo;
import com.example.demo_10.model.Users;

public interface UserInfoRepository extends JpaRepository<UserInfo,Long> {
	UserInfo findByUser(Users user);
	 @Query("SELECT c FROM UserInfo c WHERE c.user.username = :username")
	 UserInfo findUserInfoByUsername(String username);
}
