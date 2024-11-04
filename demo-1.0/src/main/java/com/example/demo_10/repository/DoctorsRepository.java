package com.example.demo_10.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


import com.example.demo_10.model.Doctors;

public interface DoctorsRepository extends JpaRepository<Doctors,Long>{
	@Query(value = "SELECT * FROM doctors ORDER BY RAND() LIMIT 7", nativeQuery = true)
    List<Doctors> findRandomDoctors();
	List<Doctors> findByCategoryContaining(String category);
	

}