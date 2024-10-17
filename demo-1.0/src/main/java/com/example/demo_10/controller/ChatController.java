package com.example.demo_10.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.example.demo_10.model.ChatMessage;
import com.example.demo_10.model.dto.ChatDTO;
import com.example.demo_10.model.dto.ChatRequest;
import com.example.demo_10.repository.ChatMessageRepository;
import com.example.demo_10.service.ChatMessageService;
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
    public ResponseEntity<List<ChatDTO>>  getChatHistory(@RequestParam(required = false) Long receiverId, @RequestParam(required = false) Long senderId) {
    	if(senderId!=null||receiverId!=null) {
    		List<ChatMessage> massage=chatMessageRepository.findChatHistoryBySenderAndDoctor(senderId, receiverId);
    		if(massage!=null) {
    			return ResponseEntity.ok(chatMessageService.transListChatDTO(massage));
    		}
    	
    	}
    	return ResponseEntity.notFound().build();
    }
}

