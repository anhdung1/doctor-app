package com.example.demo_10.model.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public class AppointmentRequest {
    private Long doctorId;
    private LocalTime AppointmentTime;
    private LocalDate AppointmentDate;
    private boolean isBooked;

    public Long getDoctorId() {
        return doctorId;
    }

    public LocalTime getAppointmentTime() {
        return AppointmentTime;
    }

    public LocalDate getAppointmentDate() {
        return AppointmentDate;
    }

    public boolean isBooked() {
        return isBooked;
    }
}
