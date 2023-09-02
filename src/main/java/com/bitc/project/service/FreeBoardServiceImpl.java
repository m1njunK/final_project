package com.bitc.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.project.dao.FreeBoardDAO;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.util.SearchPageMaker;
import com.bitc.project.vo.FreeBoardVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FreeBoardServiceImpl implements FreeBoardService {

    private final FreeBoardDAO dao;
	
    @Override
    public void updateCnt(int bno) throws Exception {
        dao.updateCnt(bno);
    }
    
	@Override
	public String remove(int bno) throws Exception {
		return dao.remove(bno) == 1 ? "게시글 삭제 완료" : "게시글 삭제 실패";
	}

    @Override
    public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
        int totalCount = dao.totalCount();
        return new PageMaker(cri, totalCount);
    }

    @Override
    public String regist(FreeBoardVO board) throws Exception {
        int result = dao.createFreeBoard(board);
        return (result != 0) ? "게시글 작성 완료" : "게시글 작성 실패";
    }

    @Override
    public FreeBoardVO read(int bno) throws Exception {
        return dao.read(bno);
    }

	@Override
	public String modify(FreeBoardVO board) throws Exception {
		return dao.modify(board) != 0 ? "게시글 수정 완료" : "게시글 수정 실패";
	}
    
	@Override
	public List<FreeBoardVO> freeBoardList(SearchCriteria cri) throws Exception {
		return dao.listCriteria(cri);
	}
	
	@Override
	public List<FreeBoardVO> searchList(SearchCriteria cri){
		return dao.searchList(cri);
	}

	@Override
	public SearchPageMaker getSearchPM(SearchCriteria cri) {
		SearchPageMaker spm = new SearchPageMaker();
		spm.setCri(cri);
		if(cri.getSearchType() == null) {
			spm.setTotalCount(dao.totalCount());
		}else {
			spm.setTotalCount(dao.searchCount(cri));
		}
		return spm;
	}
	
}
