package com.bitc.project.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.bitc.project.dao.MemberDAO;
import com.bitc.project.vo.MemberVO;

public class CheckCookieInterceptor implements HandlerInterceptor {

	@Autowired
	MemberDAO dao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedInUser") != null) {
			System.out.println("이미 로그인한 사용자");
			return true;
		}
		
		
		Cookie cookie = WebUtils.getCookie(request, "autoLogin");
		if(cookie != null) {
			// cookie.getValue() == uid
			String id = cookie.getValue();
			MemberVO vo = dao.selectMemberById(id);
			if(vo != null) {
				session.setAttribute("userInfo", vo);
			}
		}
		return true;
	}

	
	
}
