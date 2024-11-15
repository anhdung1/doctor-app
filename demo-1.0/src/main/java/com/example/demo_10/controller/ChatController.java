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
import com.example.demo_10.model.dto.ChatDTO;
import com.example.demo_10.model.dto.ChatRequest;
import com.example.demo_10.service.ChatMessageService;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import java.util.Collections;
import java.util.List;

@Controller
public class ChatController {

	
    @Autowired
    private ChatMessageService chatMessageService;
    @MessageMapping("/chat.sendMessage/{roomId}")
    @SendTo("/topic/chat-room/{roomId}")
    public ChatDTO sendMessage(@DestinationVariable String roomId, @Payload ChatRequest chatRequest) {
//    	System.out.println(chatRequest.getReceiverId());
//    	System.out.println(chatRequest.getSenderId());
//    	System.out.println(chatRequest.getContent());
//    	System.out.println(chatRequest.getType());
    	System.out.println(roomId);
        return chatMessageService.saveMessage(chatRequest);
    }
    @GetMapping("/chat/history")
    public ResponseEntity<List<ChatDTO>> getChatHistory(
        @RequestParam Long receiverId, 
        @RequestParam Long senderId,
        @RequestParam(defaultValue = "0") int page, 
        @RequestParam(defaultValue = "30") int size) {
        
        
            Pageable pageable = PageRequest.of(page, size);

            List<ChatMessage> messages = chatMessageService.getChatMessageRepository().findTop10Messages(senderId, receiverId, pageable);
           
            
                
                Collections.reverse(messages);  
                return ResponseEntity.ok(chatMessageService.transListChatDTO(messages));
            
        

    }

    @PostMapping("/add-message-participants")
    public void createMessageParticipants(@RequestParam Long doctorId){
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        String username = authentication.getName();
    	chatMessageService.createMessageParticipants(doctorId, username);
    }
    @GetMapping("/chat/list-chatted")
    public ResponseEntity<List<Object>> getListDoctorsMessage(){
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        String username = authentication.getName();
    	List<Object> listDoctors=chatMessageService.getListUserMessage(username);
    	if(listDoctors.isEmpty()) {
    		return ResponseEntity.notFound().build();
    	}
    	return ResponseEntity.ok(listDoctors);
    }
}

