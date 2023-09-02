package com.bitc.project.service;

import java.util.List;

import com.bitc.project.vo.QnaVO;

public interface QnaService {
	
	/**
	 * 질의응답 불러오기
	 */
	List<QnaVO> qnaList() throws Exception;
	
	/**
	 * 질의응답 등록하기
	 */
	String newQna(QnaVO vo) throws Exception;
	
	/**
	 * 특정 질의응답 불러오기
	 */
	QnaVO qnaLoad(int qnaId) throws Exception;
	/**
	 * 질의응답 수정하기
	 */
	String editQna(QnaVO vo) throws Exception;
	/**
	 * 질의응답 삭제하기
	 */
	String remove(int qnaId) throws Exception;
}
