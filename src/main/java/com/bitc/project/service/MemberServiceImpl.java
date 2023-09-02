package com.bitc.project.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.project.dao.MemberDAO;
import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.vo.LoginDTO;
import com.bitc.project.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final MemberDAO memberDAO;

	/*
	 * public MemberServiceImpl(MemberDAO memberDAO) { this.memberDAO = memberDAO; }
	 */
    
	private final PasswordEncoder encoder;

	@Transactional
	@Override
	public void memberJoin(MemberVO vo) throws Exception {
		String u_pw = vo.getPass();
		System.out.println("암호화 전 : " + u_pw);
		vo.setPass(encoder.encode(u_pw));
		System.out.println("암호화 후 : " + vo.getPass());
		memberDAO.insertMember(vo);
		// 일반회원 권한 부여
		memberDAO.insertAuth(vo.getId());
	}

    @Override
    public MemberVO registerNewMember(MemberVO membervo) throws Exception {
        memberDAO.insertMember(membervo); // 회원 등록
        return membervo; 				  // 등록된 회원 정보 반환
    }

    @Override
    public MemberVO findMemberById(String id) {
        return memberDAO.selectMemberById(id);
    }

    @Override
    public List<MemberVO> findAllMembers() {
        return memberDAO.selectAllMember();
    }

    @Override
    public void updateMember(MemberVO membervo) {
        memberDAO.updateMember(membervo);
    }

	/*
	 * @Override public void deleteMember(String ID) {
	 * 
	 * if (ID == "ADMIN" && ID == "admin") { throw new
	 * RuntimeException("관리자 계정은 삭제할 수 없습니다."); }
	 * 
	 * memberDAO.deleteMember(ID); }
	 */

    @Override
    public MemberVO selectIdAndPass(LoginDTO dto) {
        return memberDAO.selectIdAndPass(dto);
    }

	@Override
	public MemberVO login(LoginDTO dto) throws Exception {
		return memberDAO.login(dto);
	}

	@Override
	public String checkNick(String nname) {
		return memberDAO.checkNick(nname) == null ? "OK" : "X";
	}

	@Override
	public void withdraw(MemberVO member) {
		memberDAO.withdraw(member);
	}

	/*
	 * @Override public PageMaker getPageMaker(Criteria cri, List<MemberVO> members)
	 * { return new PageMaker(cri,memberDAO.totalCount(members)); }
	 */



}
