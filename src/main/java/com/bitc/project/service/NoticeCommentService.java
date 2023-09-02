package com.bitc.project.service;

import java.util.List;

import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.vo.NoticeCommentVO;

public interface NoticeCommentService {
	// 전체 댓글목록 가져오기
		List<NoticeCommentVO> getCommentList(Criteria cri,int bno);
			
		// 댓글 작성
		String create(NoticeCommentVO vo);
		
		// 댓글 수정
		String modify(NoticeCommentVO vo);
		
		// 댓글 삭제
		String delete(int cno);
		
		// 댓글 페이징 정보 처리
		PageMaker getPageMaker(Criteria cri, int bno)throws Exception;
}











