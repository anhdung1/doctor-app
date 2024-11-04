package com.example.demo_10.service;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.demo_10.model.ChatMessage;
import com.example.demo_10.model.Users;
import com.example.demo_10.model.dto.ChatDTO;
import com.example.demo_10.model.dto.ChatRequest;
import com.example.demo_10.repository.ChatMessageRepository;

@Service
public class ChatMessageService {
	@Autowired
	private UsersService userService;
	@Autowired
	private ChatMessageRepository  chatMessageRepository;
	public ChatDTO saveMessage(ChatRequest chatRequest) {
		ChatMessage newChatMessage=new ChatMessage();
		newChatMessage.setTimestamp(LocalDateTime.now());
		Users sender=userService.findById(chatRequest.getSenderId());
		Users receiver=userService.findById(chatRequest.getReceiverId());
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
			ChatDTO chat=transChatDTO(chatMessage);
			listChat.add(chat);
		}
		
		return listChat;
	}
	public List<Object> getListUserMessage(String username){
		Users user=userService.findByUsername(username);
		  if (user != null && user.getChatReceiver() != null) {
		        List<Object> arrayList = new ArrayList<>();
		        for (Users newUser : user.getChatReceiver()) {
		            if(newUser.getUserInfo()==null) {
		            	arrayList.add(newUser.getDoctor());
		            }else {
		            	arrayList.add(newUser.getUserInfo());
		            }
		            
		        }
		        return arrayList;
		    }
		    return Collections.emptyList();
	}
	public void createMessagePparticipants(Long doctorId,String username) {
		Users doctor=userService.findReceiverById(doctorId);
		
		if(doctor==null) {
			Users user=userService.findByUsername(username);
			user.getChatReceiver().add(doctor);
		}
	}
	public List<ChatMessage>findTop10Messages(Long senderId,Long receiverId,Pageable pageable){
		return chatMessageRepository.findTop10Messages(senderId, receiverId, pageable);
	}
}
