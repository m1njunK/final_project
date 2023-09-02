package com.bitc.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.project.dao.AttachmentDAO;
import com.bitc.project.dao.NoticeDAO;
import com.bitc.project.dao.QnaDAO;
import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.util.SearchPageMaker;
import com.bitc.project.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

	private final NoticeDAO dao;
	private final AttachmentDAO attachDAO;
	
	@Override
	public List<NoticeVO> readNoticeList(SearchCriteria cri) throws Exception {
		return dao.noticeList(cri);
	}

	@Override
	public NoticeVO readNotice(int bno) throws Exception {
		NoticeVO vo = dao.readNotice(bno);
		// 첨부파일 목록 추가
		List<String> fileList = attachDAO.getAttach(bno);
		vo.setFiles(fileList);
		return vo;
	}

	@Transactional
	@Override
	public String newNotice(NoticeVO vo) throws Exception {
		int result = dao.newNotice(vo);
		// 첨부된 파일 이름 리스트
		List<String> files = vo.getFiles();
		if(files != null) {
			for(String fullName : files) {
				attachDAO.addAttach(fullName);
			}
		}
		return result == 1 ? "공지사항 등록 성공" : "공지사항 등록 실패";
	}

	@Override
	public String editNotice(NoticeVO vo) throws Exception {
		int result = dao.updateNotice(vo);
		// 기존에 등록 되어 있던 첨부파일 정보 삭제
		attachDAO.deleteAttach(vo.getBno());
		
		List<String> fileList = vo.getFiles();
		if(fileList!= null && !fileList.isEmpty()) {
			// 수정 시 등록된 첨부파일 존재
			for(String fullName : fileList) {
				attachDAO.replaceAttach(vo.getBno(),fullName);
			}
		}

		return result == 1 ? "공지사항 수정 성공" : "공지사항 수정 실패";
	}

	@Override
	public String deleteNotice(int bno) throws Exception {
		// 첨부파일 db 삭제
		attachDAO.deleteAttach(bno);
		return dao.deleteNotice(bno) == 1 ? "공지사항 삭제 성공" : "공지사항 삭제 실패";
	}

	@Override
	public void updateVcnt(int bno) throws Exception {
		dao.updateVcnt(bno);
	}

	@Override
	public String upadateLcnt(int bno) throws Exception {
		return dao.updateLikeCnt(bno) ==1 ? "좋아요를 눌렀습니다. " : "좋아요 누르기 실패" ;
	}
	
	@Override
	public SearchPageMaker getPageMaker(SearchCriteria cri) throws Exception {
		SearchPageMaker spm = new SearchPageMaker();
		int totalCount = dao.searchListCount(cri);
		spm.setCri(cri);
		spm.setTotalCount(totalCount);
		return spm;
	}

	@Override
	public List<NoticeVO> fixedNoticeList() throws Exception {
		return dao.fixedNoticeList();
	}

	@Override
	public List<NoticeVO> searchList(SearchCriteria cri) throws Exception {
		return dao.searchList(cri);
	}

}
