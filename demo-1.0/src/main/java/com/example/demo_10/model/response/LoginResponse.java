package com.example.demo_10.model.response;

public class LoginResponse {
    private String token;
    private String image;
    private String firstName;
    private String lastName;
    private Long id;
    private String username;

    public LoginResponse(String token, String username, String image,String lastName,String firstName,Long id) {
        this.token = token;
        this.firstName=firstName;
        this.image=image;
        this.username = username;
        this.lastName = lastName;
        this.id=id;
    }

    public String getUsername() {
        return username;
    }

	public String getToken() {
		return token;
	}

	public String getImage() {
		return image;
	}

	public String getLastName() {
		return lastName;
	}

	public String getFirstName() {
		return firstName;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
