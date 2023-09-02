package com.bitc.project.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bitc.project.vo.LoginDTO;
import com.bitc.project.vo.MemberVO;

public class LoginInterceptor implements HandlerInterceptor{
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo") != null) {
			session.removeAttribute("userInfo");
		} 
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler
			  , ModelAndView modelAndView
			 ) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("userInfo");
		ModelMap modelObj = modelAndView.getModelMap();
		LoginDTO dto = (LoginDTO)modelObj.get("loginDTO");

		if(vo != null) {
			// 자동 로그인 요청 처리
			if(dto.isAutoLogin()) {
				Cookie cookie = new Cookie("autoLogin",dto.getId());
				cookie.setPath("/");
				cookie.setMaxAge(60 * 60 * 24 * 15);
				response.addCookie(cookie);
			}
		}

		
		}
	}