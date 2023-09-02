package com.bitc.project.service;

import java.util.List;

import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.vo.FreeBoardCommentVO;

public interface FreeBoardCommentSerivce {
	
	// 전체 댓글목록 가져오기
	List<FreeBoardCommentVO> getCommentList(Criteria cri,int bno);
		
	// 댓글 작성
	String create(FreeBoardCommentVO vo);
	
	// 댓글 수정
	String modify(FreeBoardCommentVO vo);
	
	// 댓글 삭제
	String delete(int cno);

	PageMaker getPageMaker(Criteria cri, int bno) throws Exception;

}
