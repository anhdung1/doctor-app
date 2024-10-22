package com.example.demo_10.model;



import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;

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
	@JsonIgnore
	@OneToOne(mappedBy="user",cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	private UserInfo userInfo;
	@OneToOne(mappedBy="user",cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	private Doctors doctor;
	@ManyToOne
	@JoinColumn(name="role_id")
	private Roles role;
	@JoinTable(
			name="message_participants",
			joinColumns=@JoinColumn(name="sender_id"),
			inverseJoinColumns=@JoinColumn(name="receiver_id")
	)
	@ManyToMany(fetch = FetchType.EAGER  ) 
	private Set<Users> chatReceiver=new HashSet<>();
	@JsonIgnore
	 @ManyToMany(mappedBy = "chatReceiver")
	    private Set<Users> chatSender = new HashSet<>();
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
	public Set<Users> getChatReceiver() {
		return chatReceiver;
	}
	public void setChatReceiver(Set<Users> chatReceiver) {
		this.chatReceiver = chatReceiver;
	}
	public Set<Users> getChatSender() {
		return chatSender;
	}
	public void setChatSender(Set<Users> chatSender) {
		this.chatSender = chatSender;
	}
	public Doctors getDoctor() {
		return doctor;
	}
	public void setDoctor(Doctors doctor) {
		this.doctor = doctor;
	}
	
}
