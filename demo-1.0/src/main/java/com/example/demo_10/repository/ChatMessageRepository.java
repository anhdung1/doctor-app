package com.example.demo_10.repository;
import org.springframework.data.domain.Pageable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo_10.model.ChatMessage;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
	  List<ChatMessage> findByReceiverId(Long receiverId);
	    List<ChatMessage> findBySenderId(Long senderId);
	    @Query("SELECT c FROM ChatMessage c WHERE (c.sender.id = :senderId AND c.receiver.id = :receiverId) OR (c.sender.id = :receiverId AND c.receiver.id = :senderId) ORDER BY c.timestamp DESC")
	    List<ChatMessage> findTop10Messages(@Param("senderId") Long senderId, @Param("receiverId") Long receiverId, Pageable pageable);	    List<ChatMessage> findTop10ByOrderByTimestampDesc();
}
