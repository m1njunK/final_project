package com.bitc.project.security.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.bitc.project.dao.MemberDAO;
import com.bitc.project.vo.MemberVO;

public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	MemberDAO dao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO vo = null;
		try {
			vo = dao.selectMemberById(username);
			if (vo != null) {
				vo.setAuthList(dao.getAuthList(username));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// return 한 사용자 정보를 이용하여 비밀번호를 비교
		return vo == null ? null : new CustomUser(vo);
	}

}
