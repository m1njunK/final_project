package com.bitc.project.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.bitc.project.dao.MemberDAO;
import com.bitc.project.vo.MemberVO;

/**
 * 회원가입 요청 처리 전
 * id or password 검증
 * */
public class JoinInterceptor implements HandlerInterceptor{
	
	@Autowired
	MemberDAO DAO;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		
		String upw = request.getParameter("pass");
		String repw = request.getParameter("confirmPassword");
		
		RequestDispatcher rd = request.getRequestDispatcher(
			"/WEB-INF/views/join/join.jsp"
		);
		
		String message = "";
		
		if (upw == null || repw == null || !upw.equals(repw)) {
		    message = "비밀번호가 일치하지 않습니다.";
		    request.setAttribute("message", message);
		    rd.forward(request, response);
		    return false;
		}

		
		// 중복 아이디 체크
		String id = request.getParameter("id");
		System.out.println("id : " + id);
		
		// 동일한 uid값으로 등록된 사용자 정보가 존재
		MemberVO vo = DAO.selectMemberById(id);
		System.out.println(id);
		if(vo != null) {
			message = id+"는 이미 존재하는 아이디입니다.";
			request.setAttribute("message", message);
			rd.forward(request, response);
			return false;
		}
		
		
		return true;
	}
}