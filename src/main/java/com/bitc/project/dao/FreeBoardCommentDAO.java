package com.bitc.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.project.util.Criteria;
import com.bitc.project.vo.FreeBoardCommentVO;
import com.bitc.project.vo.ImageBoardCommentVO;

public interface FreeBoardCommentDAO {

	// 전체 댓글목록 가져오기
	@Select("SELECT * FROM freeBoardComments WHERE FreeBoardbno = #{bno} ORDER BY commentID ASC limit #{cri.startRow},#{cri.perPageNum}")
	List<FreeBoardCommentVO> getCommentList(@Param("cri")Criteria cri,@Param("bno")int bno);
		
	// 댓글 작성
	@Insert("INSERT INTO freeBoardComments VALUES(0,#{freeBoardBNO},#{commentContent},#{commenterID},now())")
	int create(FreeBoardCommentVO vo);

	// 댓글 수정
	@Update("UPDATE freeBoardComments SET commentContent = #{commentContent} WHERE commentID = #{commentID}")
	int modify(FreeBoardCommentVO vo);
	
	// 댓글 삭제
	@Delete("DELETE FROM freeBoardComments WHERE commentID = #{cno}")
	int delete(int cno);
	
	@Select("SELECT count(*) FROM freeBoardComments WHERE freeBoardBNO = #{bno}")
	int totalCount(int bno);
}
