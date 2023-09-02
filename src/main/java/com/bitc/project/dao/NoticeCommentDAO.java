package com.bitc.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.project.util.Criteria;
import com.bitc.project.vo.NoticeCommentVO;

public interface NoticeCommentDAO {

	
	// 댓글목록 가져오기
		@Select("SELECT * FROM notice_comment WHERE NoticeBNO = #{bno} ORDER BY commentNO ASC limit #{cri.startRow},#{cri.perPageNum}")
		List<NoticeCommentVO> getCommentList(@Param("cri")Criteria cri,@Param("bno")int bno);
			
		// 댓글 작성
		@Insert("INSERT INTO notice_comment VALUES(0,#{noticeBNO},#{commentContent},#{commenterID},now())")
		int create(NoticeCommentVO vo);

		// 댓글 수정
		@Update("UPDATE notice_comment SET commentContent = #{commentContent} WHERE commentNO = #{commentNO}")
		int modify(NoticeCommentVO vo);
		
		// 댓글 삭제
		@Delete("DELETE FROM notice_comment WHERE commentNO = #{cno}")
		int delete(int cno);
		
		@Select("SELECT count(*) FROM notice_comment WHERE NoticeBNO = #{bno}")
		int totalCount(int bno);
	

}
