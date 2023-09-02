package com.bitc.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * noticeAttach table 작업 수행
 */
public interface AttachmentDAO {
	
	/**
	 * 첨부파일 등록
	 */
	@Insert("INSERT INTO noticeAttach(fullName, bno) "
			+ " VALUES(#{fullName}, LAST_INSERT_ID())")
	void addAttach(String fullName)throws Exception;
	
	/**
	 * 첨부파일 목록 검색
	 */
	@Select("SELECT fullName FROM noticeAttach WHERE bno = #{bno}")
	List<String> getAttach(int bno) throws Exception;

	/**
	 * 테이블에 등록된 첨부파일 목록 삭제
	 */
	@Delete("DELETE FROM noticeAttach WHERE bno = #{bno}")
	void deleteAttach(int bno) throws Exception;

	/**
	 * 첨부파일 목록 갱신
	 */
	@Insert("INSERT INTO noticeAttach(fullName, bno) "
			+ " VALUES(#{fullName} , #{bno}) ")
	void replaceAttach(@Param("bno") int bno, @Param("fullName") String fullName) throws Exception;
}




















