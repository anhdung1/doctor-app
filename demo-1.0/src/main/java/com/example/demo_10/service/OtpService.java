package com.example.demo_10.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class OtpService {

    @Autowired
    private JavaMailSender mailSender;
    private final Map<String, String> otpStorage = new HashMap<>();
    public void sendOtp(String email) {
    	 String otp = generateOtp();
         otpStorage.put(email, otp); 
         SimpleMailMessage message = new SimpleMailMessage();
         message.setFrom("kacunglezaj0@hotmail.com");
         message.setTo(email);
         message.setSubject("Your OTP Code");
         message.setText("Your OTP code is: " + otp);
         mailSender.send(message);
    }

    public String generateOtp() {
        return String.valueOf(new Random().nextInt(9999 - 1000) + 1000);
    }
    public boolean verifyOtp(String email, String otp) {
        return otp.equals(otpStorage.get(email));
    }
}
