package com.example.demo_10.model.dto;

import com.example.demo_10.model.Doctors;

public class DoctorsDTO {
	private boolean isFavorite;
	private Doctors doctors;
	public DoctorsDTO(Doctors doctors,boolean isFavorite) {
		this.doctors=doctors;
		this.isFavorite=isFavorite;
	}
	public boolean isFavorite() {
		return isFavorite;
	}
	public void setFavorite(boolean isFavorite) {
		this.isFavorite = isFavorite;
	}
	public Doctors getDoctors() {
		return doctors;
	}
	public void setDoctors(Doctors doctors) {
		this.doctors = doctors;
	}
}
