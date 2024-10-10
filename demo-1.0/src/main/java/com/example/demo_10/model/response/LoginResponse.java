package com.example.demo_10.model.response;

public class LoginResponse {
    private String token;
    private String image;
    private String firstName;
    private String lastName;
    
    private String username;

    public LoginResponse(String token, String username, String image,String lastName,String firstName) {
        this.token = token;
        this.firstName=firstName;
        this.image=image;
        this.username = username;
        this.lastName = lastName;
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

}
