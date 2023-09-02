package com.bitc.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.project.dao.NoteDAO;
import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.vo.NoteVO;

@Service
public class NoteServiceImpl implements NoteService {

    private final NoteDAO nd;

    @Autowired
    public NoteServiceImpl(NoteDAO noteDAO) {
        this.nd = noteDAO;
    }

    @Override
    @Transactional
    public void createNote(NoteVO vo) throws Exception {
    	nd.createNote(vo);
    }

    @Override
    public NoteVO read(int nno) throws Exception {
        return nd.read(nno);
    }

    @Override
    public int delete(int nno) throws Exception {
        return nd.delete(nno);
    }

	@Override
	public List<NoteVO> noteVOList(Criteria cri,String id) throws Exception {
		return nd.noteVOList(cri,id);
	}

	@Override
    public PageMaker getPageMaker(Criteria cri,String to_Id) throws Exception {
		return new PageMaker(cri,nd.totalCount(to_Id));
    }

	@Override
	public void replyNote(NoteVO vo) throws Exception {
		nd.replyNote(vo);
	}


}
