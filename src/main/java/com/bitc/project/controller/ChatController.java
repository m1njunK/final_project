package com.bitc.project.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.project.handler.ChattingHandler;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
    @Autowired
    private ChattingHandler chattingHandler;
	
	@GetMapping("/chat")
	public void chat(Model model) {}

	// 방생성
	@GetMapping("create")
	public String create(RedirectAttributes rttr,HttpSession session) {
		Map<String, Object> chatRoom =  chattingHandler.creatRoom();
		rttr.addFlashAttribute("chatRoom",chatRoom);
		rttr.addFlashAttribute("roomNum",chatRoom.get("roomNum"));
		return "redirect:/chat/chat";
	}
	
	// 방 리스트
	@GetMapping("chatRoom")
	public void chatRoomList(Model model) {
		model.addAttribute("chatRoom",chattingHandler.getRoomList());
	}
	
	@GetMapping("joinChat")
	public String join(int roomNum,RedirectAttributes rttr) {
		rttr.addFlashAttribute("roomNum",roomNum);
		return "redirect:/chat/chat";
	}
}
