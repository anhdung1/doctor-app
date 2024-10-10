//package com.example.demo_10.service;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.mail.SimpleMailMessage;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.stereotype.Service;
//
//@Service
//public class EmailService {
//
//    @Autowired
//    private JavaMailSender mailSender;
//
//    public void SendConfirmationEmail(String toEmail, String subject, String body) {
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setFrom("kacunglezaj0@hotmail.com"); // Thay đổi với email Outlook của bạn
//        message.setTo(toEmail);
//        message.setSubject(subject);
//        message.setText(body);
//        mailSender.send(message);
//    }
//}
