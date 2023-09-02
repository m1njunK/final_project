package com.bitc.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.vo.NoticeCommentVO;
import com.bitc.project.dao.NoticeCommentDAO;

import lombok.RequiredArgsConstructor;

// Service Spring Bean  등록
@Service
@RequiredArgsConstructor
public class NoticeCommentServiceImpl implements NoticeCommentService{
	
	// CommentDAO 의존성 주입
	private final NoticeCommentDAO dao;

	@Override
	public List<NoticeCommentVO> getCommentList(Criteria cri,int bno) {
		return dao.getCommentList(cri,bno);
	}

	@Override
	public String create(NoticeCommentVO vo) {
		return dao.create(vo) > 0 ? "댓글 등록 완료" : "댓글 등록 실패";
	}

	@Override
	public String modify(NoticeCommentVO vo) {
		return dao.modify(vo) > 0 ? "댓글 수정 완료" : "댓글 수정 실패";
	}

	@Override
	public String delete(int cno) {
		return dao.delete(cno) > 0 ? "댓글 삭제 완료" : "댓글 삭제 실패";
	}

	@Override
	public PageMaker getPageMaker(Criteria cri,int bno) throws Exception {
		return new PageMaker(cri,dao.totalCount(bno));
	}
}










