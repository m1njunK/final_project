package com.bitc.project.service;

import java.util.List;

import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.util.SearchPageMaker;
import com.bitc.project.vo.FreeBoardVO;

public interface FreeBoardService {
	
	// 게시글 조회수
    void updateCnt(int bno) throws Exception;
    
    // 게시글 삭제
    String remove(int bno) throws Exception;
    
    // PM > pagemaker
    PageMaker getPageMaker(SearchCriteria cri) throws Exception;
    
    // 게시글 작성
    String regist(FreeBoardVO board) throws Exception;
    
    // 게시글 상세보기
    FreeBoardVO read(int bno) throws Exception;
    
    // 게시글 목록
    // List<FreeBoardVO> listAll() throws Exception;
    
    // 게시글 수정
    String modify(FreeBoardVO board) throws Exception;
    
    // 페이징 처리된 게시글
    List<FreeBoardVO> freeBoardList(SearchCriteria cri) throws Exception;

	List<FreeBoardVO> searchList(SearchCriteria cri);

	SearchPageMaker getSearchPM(SearchCriteria cri);
}

