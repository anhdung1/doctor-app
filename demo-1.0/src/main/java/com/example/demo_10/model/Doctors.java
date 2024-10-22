package com.example.demo_10.model;

import java.time.LocalTime;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;

@Entity
public class Doctors {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	private String nameDoctor;
	private String category;
	private Float rate;
	private int count;
	private String image;
	private Long views;
	private int experiences;
	private LocalTime available;
	private int price;
	@OneToOne
	@JoinColumn(name="id",referencedColumnName="id")
	@JsonIgnore
	private Users user;
	@JsonIgnore
	 @ManyToMany(mappedBy = "favoriteDoctors")
	    private Set<UserInfo> usersWhoFavorited = new HashSet<>();
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNameDoctor() {
		return nameDoctor;
	}
	public void setNameDoctor(String nameDoctor) {
		this.nameDoctor = nameDoctor;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Float getRate() {
		return rate;
	}
	public void setRate(Float rate) {
		this.rate = rate;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getExperiences() {
		return experiences;
	}
	public void setExperiences(int experiences) {
		this.experiences = experiences;
	}
	public Long getViews() {
		return views;
	}
	public void setViews(Long views) {
		this.views = views;
	}
	public LocalTime getAvailable() {
		return available;
	}
	public void setAvailable(LocalTime available) {
		this.available = available;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Set<UserInfo> getUsersWhoFavorited() {
		return usersWhoFavorited;
	}
	public void setUsersWhoFavorited(Set<UserInfo> usersWhoFavorited) {
		this.usersWhoFavorited = usersWhoFavorited;
	}


}
