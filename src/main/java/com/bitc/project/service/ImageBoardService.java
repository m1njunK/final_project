package com.bitc.project.service;

import java.util.List;

import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.util.SearchPageMaker;
import com.bitc.project.vo.ImageBoardVO;

public interface ImageBoardService {
	// 전체 이미지 게시글 가져오기
	List<ImageBoardVO> imageBoardList(SearchCriteria cri) throws Exception;
	
	// 페이징 정보 처리
	PageMaker getPageMaker(SearchCriteria cri)throws Exception;
	
	// 검색결과 페이징 정보 처리
	SearchPageMaker getSearchPM(SearchCriteria cri)throws Exception;
	 
	// 검색 리스트
	List<ImageBoardVO> searchList(SearchCriteria cri)throws Exception; 
	
	// 게시글 작성
	String createImageBoard(ImageBoardVO vo) throws Exception;
	
	// 조회수 증가
	void updateCnt(int bno)  throws Exception;
	
	// 게시글 상세보기 
	ImageBoardVO read(int bno) throws Exception;
	
	int delete(int bno) throws Exception;
	
	int update(ImageBoardVO vo) throws Exception;
}
