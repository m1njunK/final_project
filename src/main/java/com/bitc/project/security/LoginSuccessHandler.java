package com.bitc.project.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.bitc.project.security.user.CustomUser;
import com.bitc.project.vo.MemberVO;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	/*
	@Autowired
	private final MemberService ms;
	*/

	@Override
	public void onAuthenticationSuccess(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Authentication auth)
			throws IOException, ServletException {
		CustomUser user = (CustomUser) auth.getPrincipal();
		MemberVO vo = user.getVo();
		
		request.getSession().setAttribute("userInfo", vo);

		String context = request.getContextPath();
		response.sendRedirect(context);

	}

}
