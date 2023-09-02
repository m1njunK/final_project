package com.bitc.project.vo;

import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private int idn;		// 식별값
	private String id;		// 로그인용 아이디
	
	public String nname;	// 닉네임 (2023-08-16 접근자 변경)
	
	private String pass;   	// 비밀번호
	private String email;	// 이메일
	private String name;	// 이름
	private boolean stopu;	// 정지 유저
    private String birthdate; // 생년월일
    private String gender;  // 성별
    private int point;		// 포인트
    private boolean withdraw;
    
    
    private boolean autoLogin;
    
    // 권한 목록
 	private List<String> authList;

    
	
}
