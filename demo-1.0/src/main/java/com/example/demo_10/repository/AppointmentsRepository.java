package com.example.demo_10.repository;

import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo_10.model.Appointments;

public interface AppointmentsRepository extends JpaRepository<Appointments,Long>{

}
