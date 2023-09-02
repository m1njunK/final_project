package com.bitc.project.service;

import java.util.List;

import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.vo.NoteVO;

public interface NoteService {
	
	// 쪽지 리스트 출력
	List<NoteVO> noteVOList(Criteria cri,String id) throws Exception;
	
	// 쪽지 작성
	void createNote(NoteVO vo) throws Exception;
	
	// 쪽지 보기
	NoteVO read(int nno) throws Exception;
	
	int delete(int nno) throws Exception;
	
	// PM > pagemaker
    PageMaker getPageMaker(Criteria cri,String to_Id) throws Exception;
    
    void replyNote(NoteVO vo) throws Exception;

}
