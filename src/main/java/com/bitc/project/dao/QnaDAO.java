package com.bitc.project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.project.vo.QnaVO;


public interface QnaDAO {

		/**
		 * @return 전체 QnA 목록
		 */
		@Select("SELECT * FROM QnA ORDER BY QnAID")
		List<QnaVO> qnaList()throws Exception;
		
		/**
		 * 새 QnA 작성
		 */
		@Insert("INSERT INTO QnA (QuestionTitle,QuestionContent) VALUES(#{questionTitle},#{questionContent})")
		int createQna(QnaVO vo);
		
		/**
		 * 특정 qna 로드
		 */
		@Select("SELECT * FROM QnA WHERE QnAID = #{qnaId}")
		QnaVO qnaload(int qnaId)throws Exception;
		
		/**
		 * 질의 응답 수정(edit)
		 */
		@Update("UPDATE qna SET QuestionTitle =#{questionTitle}, QuestionContent =#{questionContent} WHERE qnaId= #{qnaId}")
		int updateQna(QnaVO vo)throws Exception;
		
		/**
		 * qnaId로 질의응답 삭제
		 */
		@Delete("DELETE FROM qna WHERE QnAID = #{qndId}")
		int qnaDelete(int qnaId) throws Exception;

}
