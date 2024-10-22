package com.example.demo_10.model;

import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;

@Entity

public class UserInfo {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	private String address;
	private String phoneNumber;
	private String email;
	private String firstName;
	private String lastName;
	private String image;
	@JoinTable(
	        name = "favorite", 
	        joinColumns = @JoinColumn(name = "user_id"), 
	        inverseJoinColumns = @JoinColumn(name = "doctor_id") 
	    )
	@ManyToMany(fetch = FetchType.EAGER  ) 
	private Set<Doctors> favoriteDoctors = new HashSet<>();

    public Set<Doctors> getFavoriteDoctors() {
        return favoriteDoctors;
    }
    public void setFavoriteDoctors(Set<Doctors> favoriteDoctors) {
        this.favoriteDoctors = favoriteDoctors;
    }
	public UserInfo() {

	}
	@OneToOne
	@JoinColumn(name="id",referencedColumnName="id")
	@JsonIgnore
	private Users user;

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
}
