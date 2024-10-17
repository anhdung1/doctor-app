package com.example.demo_10.service;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.ChatMessage;

import com.example.demo_10.model.Users;
import com.example.demo_10.model.dto.ChatDTO;
import com.example.demo_10.model.dto.ChatRequest;
import com.example.demo_10.repository.ChatMessageRepository;

import com.example.demo_10.repository.UsersRepository;

@Service
public class ChatMessageService {
	@Autowired
	private UsersRepository userRepository;
	@Autowired
	private ChatMessageRepository  chatMessageRepository;
	public ChatDTO saveMessage(ChatRequest chatRequest) {
//		System.out.println("start");
//		System.out.println(chatRequest.getDoctorId());
//		System.out.println("end");
		ChatMessage newChatMessage=new ChatMessage();
		newChatMessage.setTimestamp(LocalDateTime.now());
		Users sender=userRepository.findById(chatRequest.getSenderId()).orElseThrow();
		Users receiver=userRepository.findById(chatRequest.getReceiverId()).orElseThrow();
		newChatMessage.setReceiver(receiver);
		newChatMessage.setSender(sender);
		newChatMessage.setContent(chatRequest.getContent());
		newChatMessage.setType(chatRequest.getType());
		chatMessageRepository.save(newChatMessage);
		return transChatDTO(newChatMessage);
	}
	public ChatDTO transChatDTO(ChatMessage chatMessage) {
		ChatDTO chat=new ChatDTO();
		chat.setContent(chatMessage.getContent());
		chat.setReceiverId(chatMessage.getReceiver().getId());
		chat.setSenderId(chatMessage.getSender().getId());
		chat.setTimestamp(chatMessage.getTimestamp());
		return chat;
	}
	public List<ChatDTO> transListChatDTO(List<ChatMessage> listChatMessage) {
		List<ChatDTO> listChat=new ArrayList<ChatDTO>();
		for(ChatMessage chatMessage:listChatMessage) {
			ChatDTO chat=new ChatDTO();
			chat.setContent(chatMessage.getContent());
			chat.setReceiverId(chatMessage.getReceiver().getId());
			chat.setSenderId(chatMessage.getSender().getId());
			chat.setTimestamp(chatMessage.getTimestamp());
			listChat.add(chat);
		}
		
		return listChat;
	}
}
