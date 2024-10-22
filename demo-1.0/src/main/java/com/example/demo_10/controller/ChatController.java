package com.example.demo_10.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.example.demo_10.model.ChatMessage;
import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.dto.ChatDTO;
import com.example.demo_10.model.dto.ChatRequest;
import com.example.demo_10.repository.ChatMessageRepository;
import com.example.demo_10.service.ChatMessageService;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import java.util.Collections;
import java.util.List;

@Controller
public class ChatController {

    @Autowired
    private ChatMessageRepository chatMessageRepository;
    @Autowired
    private ChatMessageService chatMessageService;
    @MessageMapping("/chat.sendMessage/{roomId}")
    @SendTo("/topic/chat-room/{roomId}")
    public ChatDTO sendMessage(@DestinationVariable String roomId, @Payload ChatRequest chatRequest) {
//    	System.out.println(chatRequest.getReceiverId());
//    	System.out.println(chatRequest.getSenderId());
//    	System.out.println(chatRequest.getContent());
//    	System.out.println(chatRequest.getType());
//    	System.out.println(roomId);
        return chatMessageService.saveMessage(chatRequest);
    }
    @GetMapping("/chat/history")
    public ResponseEntity<List<ChatDTO>> getChatHistory(
        @RequestParam(required = false) Long receiverId, 
        @RequestParam(required = false) Long senderId,
        @RequestParam(defaultValue = "0") int page, 
        @RequestParam(defaultValue = "30") int size) {
        
        if (senderId != null || receiverId != null) {
            Pageable pageable = PageRequest.of(page, size);

            List<ChatMessage> messages = chatMessageRepository.findTop10Messages(senderId, receiverId, pageable);

            
                Collections.reverse(messages);  
                return ResponseEntity.ok(chatMessageService.transListChatDTO(messages));
            
        }

        return ResponseEntity.notFound().build();
    }

    @PostMapping("/add-message-participants")
    public void createMessageParticipants(@RequestParam Long doctorId){
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        String username = authentication.getName();
    	chatMessageService.createMessagePparticipants(doctorId, username);
    }
    @GetMapping("/chat/list-doctors")
    public ResponseEntity<List<Doctors>> getListDoctorsMessage(){
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        String username = authentication.getName();
    	List<Doctors> listDoctors=chatMessageService.getListDoctorMessage(username);
    	if(listDoctors.isEmpty()) {
    		return ResponseEntity.notFound().build();
    	}
    	return ResponseEntity.ok(listDoctors);
    }
}

