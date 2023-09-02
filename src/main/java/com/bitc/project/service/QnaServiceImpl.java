package com.bitc.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.project.dao.QnaDAO;
import com.bitc.project.vo.QnaVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService {

	private final QnaDAO dao;
	
	@Override
	public List<QnaVO> qnaList() throws Exception {
		return dao.qnaList();
	}

	@Override
	public String newQna(QnaVO vo) throws Exception {
		int result = dao.createQna(vo);
		String message = (result != 0) ? "QnA 등록 성공" : "QnA 등록 FAILED";
		return message;
	}

	@Override
	public QnaVO qnaLoad(int qnaId) throws Exception {
		return dao.qnaload(qnaId);
	}
	@Override
	public String editQna(QnaVO vo) throws Exception {
		return dao.updateQna(vo) == 1 ? "QnA 수정 성공" : "QnA 수정 FAIELD";
	}
	
	@Override
	public String remove(int qnaId) throws Exception {
		return dao.qnaDelete(qnaId) == 1 ? "QnA 삭제 성공" : "QnA 삭제 FAIELD";
	}


}
