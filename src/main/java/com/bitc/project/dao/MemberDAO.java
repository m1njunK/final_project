package com.bitc.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.project.util.Criteria;
import com.bitc.project.vo.LoginDTO;
import com.bitc.project.vo.MemberVO;
import com.bitc.project.vo.NoteVO;

@Mapper
public interface MemberDAO {
	
	/**
	 * 회원가입
	 * @return 
	 * */
	@Insert("INSERT INTO member (id, nname, pass, email, name, birthdate,gender) VALUES (#{id}, #{nname}, #{pass}, #{email}, #{name}, #{birthdate}, #{gender})")
	void insertMember(MemberVO member) throws Exception;
	
	/**
	 * 아이디 검색
	 * */
	@Select("SELECT * FROM member WHERE id = #{id}")
	MemberVO selectMemberById(String id);
	
	/**
	 * 리스트 정보 전부 검색
	 * */
	@Select("SELECT * FROM member")
	List<MemberVO> selectAllMember();

	/**
	 * 정보 업데이트
	 * */
	@Update("UPDATE member SET nname = #{nname}, name = #{name}, email = #{email}, gender=#{gender} WHERE id = #{id}")
	void updateMember(MemberVO member);

	/**
	 * 정보 삭제
	 * */
	@Update("UPDATE member SET withdraw = true WHERE id = #{id}")
	void withdraw(MemberVO vo);
	
	/**
	 * 아이디 비밀번호 검색
	 * @return MemberVO
	 */
	
	@Select("SELECT * FROM member WHERE id = #{id} AND pass = #{pass}")
	MemberVO selectIdAndPass(LoginDTO dto);

	 /**
	  * LoginDTO 로그인 요청 처리
	  * */
	@Select("SELECT * FROM member WHERE id = #{id} AND pw = #{pw}")
	MemberVO login(LoginDTO dto) throws Exception;

	@Select("SELECT nname FROM member WHERE nname = #{nname}")
	String checkNick(@Param("nname")String nname);
	
	
	/* security */
	
	/**
	 * u_id로 권한 정보 확인
	 */
	@Select("SELECT u_auth FROM member_auth " + " WHERE u_id = #{u_id}")
	List<String> getAuthList(String u_id) throws Exception;
	
	/**
	 * 회원가입한 회원 기본 권한 추가 ROLE_USER
	 */
	@Insert("INSERT INTO member_auth " + " VALUES(#{u_id},'ROLE_USER')")
	void insertAuth(String u_id) throws Exception;
	
}
