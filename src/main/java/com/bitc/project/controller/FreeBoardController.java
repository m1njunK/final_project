package com.bitc.project.controller;

import java.nio.charset.Charset;
import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.project.service.FreeBoardCommentSerivce;
import com.bitc.project.service.FreeBoardService;
import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.vo.FreeBoardCommentVO;
import com.bitc.project.vo.FreeBoardVO;
import com.bitc.project.vo.ImageBoardVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/freeBoard")
@RequiredArgsConstructor
public class FreeBoardController {
	
	private final FreeBoardService fs;
	private final FreeBoardCommentSerivce fcs;
	
	// 게시글 목록 페이지 이동
	@GetMapping("freeBoard_list")
	public String imgBoardList(SearchCriteria cri, Model model) throws Exception {
		cri.setPerPageNum(10);
		List<FreeBoardVO> list = null;
		String searchType = cri.getSearchType();
		if(cri.getSearchValue() == null) {
			list = fs.freeBoardList(cri);
		}else {
			if(searchType.equals("title") || searchType.equals("content") || searchType.equals("auth")) {
				list = fs.searchList(cri);
			}else {
				return "redirect:/freeBoard/freeBoard_list";
			}
		}
		model.addAttribute("freeBoardList",list);
		model.addAttribute("pm",fs.getSearchPM(cri));
		return "/freeBoard/freeBoard_list";
	}
	
	// 게시글 작성 페이지 이동
	@GetMapping("create")
	public String create() throws Exception {
		return "/freeBoard/freeBoard_form";
	}
	
	// 게시글 작성 처리 요청
	@PostMapping("create")
	public String create(FreeBoardVO vo) throws Exception {
		fs.regist(vo);
		return "redirect:freeBoard_list";
	}
	
	// 게시글 상세보기 페이지 요청
	@GetMapping("freeBoard_detail")
	public String imgBoard_detail(int bno, RedirectAttributes rttr) throws Exception {
		// 조회수 증가
		fs.updateCnt(bno);
		rttr.addAttribute("bno",bno);
		return "redirect:read";
	}
	
	// 게시글 상세보기 페이지 이동
	@GetMapping("read")
	public String read(int bno,Model model,Criteria cri) throws Exception 
	{
		cri.setPerPageNum(10);
		model.addAttribute("pm",fcs.getPageMaker(cri, bno));
		FreeBoardVO vo = fs.read(bno);
		model.addAttribute("comments",fcs.getCommentList(cri,bno));
		model.addAttribute("post",vo);
		return "/freeBoard/freeBoard_detail";
	}

	// 게시글 삭제 요청
	@PostMapping("remove")
	public String delete(int bno, RedirectAttributes rttr) throws Exception
	{
		rttr.addFlashAttribute("msg",fs.remove(bno));
		return "redirect:freeBoard_list";
	}
	
	// 게시글 수정 페이지 이동
	@PostMapping("modify")
	public String modify(int bno,Model model) throws Exception
	{
		model.addAttribute("post",fs.read(bno));
		return "/freeBoard/freeBoard_modify";
	}
	
	// 게시글 수정 요청
	@PostMapping("modify_submit")
	public String update(FreeBoardVO vo, RedirectAttributes rttr) throws Exception{
		rttr.addFlashAttribute("vo",fs.read(vo.getBno()));
		rttr.addFlashAttribute("msg",fs.modify(vo));
		rttr.addAttribute("bno",vo.getBno());
		return "redirect:read";
	}
	
	/**
	 *  댓글요청 처리 (ajax) 
	 *  ics가 처리해줌 
	 */
	// 댓글작성 요청 처리 
	@PostMapping("commentWrite")
	public ResponseEntity<String> commentWrite(FreeBoardCommentVO vo) {
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setContentType(new MediaType("application","json",Charset.forName("UTF-8")));
		try {
			String message = fcs.create(vo);
			entity = new ResponseEntity<>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),headers,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 댓글 삭제 요청 처리
	@DeleteMapping(value="commentDel/{cno}", produces="application/json; charset=utf8")
	@ResponseBody
	public String commentDelete(@PathVariable(name="cno") int cno) throws Exception{
		return fcs.delete(cno);
	}
	
	// 댓글 수정 요청 처리
	@PatchMapping(value = "commentMod" , produces="application/json; charset=utf8")
	@ResponseBody
	public String commentModify(@RequestBody FreeBoardCommentVO vo) throws Exception{
		return fcs.modify(vo);
	}
	
}
