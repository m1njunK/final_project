package com.bitc.project.security.user;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.bitc.project.vo.MemberVO;

import lombok.Getter;

/**
 * 
 * 인가가 완료된 사용자 정보
 */
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;

	@Getter
	private MemberVO vo;

	public CustomUser(MemberVO vo) {
		super(vo.getId(), vo.getPass(), authorities(vo.getAuthList()));
		// , authorities(vo.getAuthList()));
		this.vo = vo;
	}

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public static Collection<? extends GrantedAuthority> authorities(List<String> authList) {
		List<GrantedAuthority> grantedAuthorityList = new ArrayList<>();
		for (String auth : authList) {
			grantedAuthorityList.add(new SimpleGrantedAuthority(auth));
		}
		return grantedAuthorityList;
	}

}
