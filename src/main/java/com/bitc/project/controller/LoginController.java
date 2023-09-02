package com.bitc.project.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bitc.project.service.MemberService;
import com.bitc.project.vo.LoginDTO;
import com.bitc.project.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/login")
@RequiredArgsConstructor
public class LoginController {
	
    private final MemberService ms;
    
    @RequestMapping("login")
    public String login() {
    	return "/login/login";
    }
    
    @PostMapping("login") 
    public ModelAndView login(LoginDTO dto, HttpSession session, HttpServletResponse response) throws Exception{ 
        ModelAndView mav = new ModelAndView(); 
        MemberVO loggedInMember = ms.selectIdAndPass(dto); 	// 로그인 처리 및 사용자 정보 반환
        if (loggedInMember != null) {
        	session.setAttribute("userInfo", loggedInMember); // 세션에 사용자 정보 저장
            mav.setViewName("redirect:/");
        } 
        
        else {
            // 로그인 실패 처리
            mav.addObject("message", "로그인 실패");
            mav.setViewName("/login/login");
        }
        
        
        return mav; 
    }
    
	@GetMapping("/logout")
	public String logout(
			HttpSession session,
			HttpServletResponse response,
			@CookieValue(name="autoLogin", required=false) Cookie cookie
			) {
		
		if(session.getAttribute("userInfo") != null) {
			session.removeAttribute("userInfo");
			session.removeAttribute("invalidate");
			
			if(cookie != null) {
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			
		}
		return "redirect:/";
	}

}