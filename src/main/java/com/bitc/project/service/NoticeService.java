package com.bitc.project.service;

import java.util.List;


import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.util.SearchPageMaker;
import com.bitc.project.vo.NoticeVO;


public interface NoticeService {

	
	// 전체 목록 불러오기
	List<NoticeVO> readNoticeList(SearchCriteria cri)throws Exception;
	// 게시글 하나 불러오기
	NoticeVO readNotice(int bno)throws Exception;
	// 게시글 등록하기
	String newNotice(NoticeVO vo) throws Exception;
	// 게시글 수정하기
	String editNotice(NoticeVO vo) throws Exception;
	// 게시글 삭제하기
	String deleteNotice(int bno) throws Exception;
	// 조회수 증가하기
	void updateVcnt(int bno)  throws Exception;
	// 좋아요 증가하기
	String upadateLcnt(int bno) throws Exception;
	// 페이징 정보 처리
	SearchPageMaker getPageMaker(SearchCriteria cri)throws Exception;
	// 고정 공지 리스트 가져오기
	List<NoticeVO> fixedNoticeList()throws Exception;
	// 검색으로 공지 리스트불러오기
	List<NoticeVO> searchList(SearchCriteria cri) throws Exception;
}
