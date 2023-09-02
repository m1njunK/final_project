package com.bitc.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.project.service.MemberService;
import com.bitc.project.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/join")
@RequiredArgsConstructor
public class JoinController {

	private final MemberService ms;
	
	@GetMapping("join") 
	public String join() {
		return "join/join";
	}

	@PostMapping("join")
	public String join(
			MemberVO vo,
			RedirectAttributes rttr
			) throws Exception {
		ms.memberJoin(vo);
		rttr.addFlashAttribute("message","회원가입 성공");
		return "redirect:/login/login";
		
	}
	
	@PostMapping("checkNickName")
	@ResponseBody
	public String checkNickName(@RequestParam String nname) throws Exception {
		return ms.checkNick(nname);
	}
}