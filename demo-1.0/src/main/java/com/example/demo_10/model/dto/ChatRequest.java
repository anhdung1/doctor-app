package com.example.demo_10.model.dto;

import com.example.demo_10.model.ChatMessage.MessageType;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;

public class ChatRequest {
	private Long receiverId;
	private String content;
	private Long senderId;
	@Enumerated(EnumType.STRING)
    private MessageType type;
	public MessageType getType() {
		return type;
	}
	public void setType(MessageType type) {
		this.type=type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Long getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(Long receiverId) {
		this.receiverId = receiverId;
	}
	public Long getSenderId() {
		return senderId;
	}
	public void setSenderId(Long senderId) {
		this.senderId = senderId;
	}

}
