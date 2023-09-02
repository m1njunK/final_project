package com.bitc.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/game/*")
public class GameController {
	
	@PostMapping("start")
	public String startPage() {
		return "/game/start";
	}
	
	@PostMapping("game")
	public String game() {
		return "/game/game";
	}
	
}
