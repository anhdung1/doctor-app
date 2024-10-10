package com.example.demo_10.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import org.springframework.web.bind.annotation.*;

import com.example.demo_10.service.AuthService;
import com.example.demo_10.service.CustomUserDetailsService;
import com.example.demo_10.service.JwtUtil;
import com.example.demo_10.service.OtpService;
import com.example.demo_10.service.UsersService;
import com.example.demo_10.model.Users;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
	@Autowired 
	private CustomUserDetailsService  customUserDetailsService;
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private OtpService otpService;
    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UsersService usersService;
    @Autowired	
    private AuthService authService; 
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Users user) {
        try {
        
            Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword())
            );

          
            String role = authentication.getAuthorities().iterator().next().getAuthority();
        
            String token = jwtUtil.generateToken(user.getUsername(), role);
            
           
            return ResponseEntity.ok(authService.responseUser(token, user.getUsername()));

        } catch (AuthenticationException e) {
            return ResponseEntity.status(401).body("Username or password is incorrect");
        }
    }
    @PostMapping("/send-otp")
    public ResponseEntity<?> sendOtp(@RequestParam String email) {
    	 otpService.sendOtp(email);
         return ResponseEntity.ok("OTP sent to email");
        
    }
    @PostMapping("/verify-otp")
    public ResponseEntity<?> verifyOtp(@RequestParam String otp, @RequestParam String email,@RequestParam Users user) {
        boolean isValidOtp = otpService.verifyOtp(email, otp);
        if (!isValidOtp) {
            return ResponseEntity.badRequest().body("Invalid OTP");
        }
     
        usersService.register(user);
        return ResponseEntity.ok("Account created successfully");
    }
    @PostMapping("/check-username")
    public ResponseEntity<?> register(@RequestBody Users user){
    	boolean isExistsUsername=customUserDetailsService.checkUsername(user.getUsername());
    	if(isExistsUsername) {
    		return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("Username already exists");
    	}
//    	authService.register(user);
    	return ResponseEntity.ok("Registered successfully");
    }
    @PostMapping("/signup")
    public ResponseEntity<?> registerRequest(@RequestBody Users user){
    	boolean isExistsUsername=customUserDetailsService.checkUsername(user.getUsername());
    	if(isExistsUsername) {
    		return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("Username already exists");
    	}
    	authService.register(user);
    	return ResponseEntity.ok("Registered successfully");
    }
}
