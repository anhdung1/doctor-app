package com.example.demo_10.model;

import java.util.HashSet;
import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;

@Entity
public class Users {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	private String username;
	private String password;
	@OneToOne(mappedBy="user",cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	private UserInfo userInfo;
	@ManyToOne
	@JoinColumn(name="role_id")
	private Roles role;
	@ManyToMany(fetch = FetchType.EAGER) 
	@JoinTable(
	        name = "favorite", 
	        joinColumns = @JoinColumn(name = "user_id"), 
	        inverseJoinColumns = @JoinColumn(name = "doctor_id") 
	    )
	private Set<Doctors> favoriteDoctors = new HashSet<>();

    public Set<Doctors> getFavoriteDoctors() {
        return favoriteDoctors;
    }
    public void setFavoriteDoctors(Set<Doctors> favoriteDoctors) {
        this.favoriteDoctors = favoriteDoctors;
    }
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public UserInfo getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}
	public Roles getRole() {
		return role;
	}
	public void setRole(Roles role) {
		this.role = role;
	}
	
}
