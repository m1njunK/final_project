package com.bitc.project.service;

import java.util.List;

import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.vo.LoginDTO;
import com.bitc.project.vo.MemberVO;

public interface MemberService {
	
	// 가입
    MemberVO registerNewMember(MemberVO membervo) throws Exception;  
    
    // 찾기
    MemberVO findMemberById(String ID);
    
    // 전부찾기
    List<MemberVO> findAllMembers();
    
    // 정보 업데이트
    void updateMember(MemberVO membervo);
    
    // 정보 삭제
    void withdraw(MemberVO member);

    // 여기서 부터는 User
	
	// 로그인 정보 찾기
	MemberVO selectIdAndPass(LoginDTO dto);

	// LoginDTO 로그인처리 
	MemberVO login(LoginDTO dto) throws Exception;

	String checkNick(String nname) throws Exception;

	void memberJoin(MemberVO vo) throws Exception;

	/*
	 * PageMaker getPageMaker(Criteria cri, List<MemberVO> members) throws
	 * Exception;
	 */

}
