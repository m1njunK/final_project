package com.bitc.project.service;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;

import com.bitc.project.dao.ImageBoardDAO;
import com.bitc.project.util.Criteria;
import com.bitc.project.util.FileUtils;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.util.SearchPageMaker;
import com.bitc.project.vo.ImageBoardVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ImageBoardServiceImpl implements ImageBoardService {

	private final ImageBoardDAO dao;
	private final String uploadDir;
	private final ServletContext context;
	private String realPath;
	 
	@PostConstruct
	public void initPath() {
		realPath = context.getRealPath(File.separator+uploadDir);
		File file = new File(realPath);
		if(!file.exists()) {
			file.mkdirs();
		}
	}
	
	@Override
	public List<ImageBoardVO> imageBoardList(SearchCriteria cri) throws Exception {
		return dao.imageBoardList(cri);
	}

	@Override
	public String createImageBoard(ImageBoardVO vo) throws Exception {
		return dao.createImageBoard(vo) > 0 ? "게시글 등록 완료!" : "게시글 등록 실패..";
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		dao.updateCnt(bno);
		
	}

	@Override
	public ImageBoardVO read(int bno) throws Exception {
		ImageBoardVO vo = dao.read(bno);
		return vo;
	}

	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		return new PageMaker(cri,dao.totalCount());
	}

	
	@Override
	public int delete(int bno) throws Exception {
		return dao.delete(bno);
	}

	@Override
	public int update(ImageBoardVO vo) throws Exception {
		return dao.update(vo);
	}
	
	public ImageBoardVO saveFile(ImageBoardVO vo) throws Exception {
		String imageURL = FileUtils.thumbnailFile(realPath, vo.getFile());
		vo.setImageURL(uploadDir+imageURL);
		return vo;
	}

	@Override
	public SearchPageMaker getSearchPM(SearchCriteria cri) throws Exception {
		SearchPageMaker spm = new SearchPageMaker();
		spm.setCri(cri);
		if(cri.getSearchType() == null) {
			spm.setTotalCount(dao.totalCount());
		}else {
			spm.setTotalCount(dao.searchCount(cri));
		}
		return spm;
	}

	@Override
	public List<ImageBoardVO> searchList(SearchCriteria cri) throws Exception {
		List<ImageBoardVO> list = null;
		list = dao.searchList(cri);
		return list;
	}
}
