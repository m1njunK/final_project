package com.bitc.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.project.util.Criteria;
import com.bitc.project.vo.ImageBoardCommentVO;

public interface ImageBoardCommentDAO {
	// 댓글목록 가져오기
	@Select("SELECT * FROM imageBoardComments WHERE imageBoardBNO = #{bno} ORDER BY commentNO ASC limit #{cri.startRow},#{cri.perPageNum}")
	List<ImageBoardCommentVO> getCommentList(@Param("cri")Criteria cri,@Param("bno")int bno);
		
	// 댓글 작성
	@Insert("INSERT INTO imageBoardComments VALUES(0,#{imageBoardBNO},#{commentContent},#{commenterID},now())")
	int create(ImageBoardCommentVO vo);

	// 댓글 수정
	@Update("UPDATE imageBoardComments SET commentContent = #{commentContent} WHERE commentNO = #{commentNO}")
	int modify(ImageBoardCommentVO vo);
	
	// 댓글 삭제
	@Delete("DELETE FROM imageBoardComments WHERE commentNO = #{cno}")
	int delete(int cno);
	
	@Select("SELECT count(*) FROM imageBoardComments WHERE imageBoardBNO = #{bno}")
	int totalCount(int bno);
}
