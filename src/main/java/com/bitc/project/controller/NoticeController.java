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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.project.dao.AttachmentDAO;
import com.bitc.project.service.NoticeCommentService;
import com.bitc.project.vo.ImageBoardVO;
import com.bitc.project.vo.NoticeCommentVO;
import com.bitc.project.service.NoticeService;
import com.bitc.project.util.Criteria;
import com.bitc.project.util.SearchCriteria;
import com.bitc.project.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notice/*")
public class NoticeController {
	
	private final NoticeService ns;
	private final NoticeCommentService ncs;
	
	@GetMapping("noticeList")
	public void noticeList(Model model, SearchCriteria cri) throws Exception {
		cri.setPerPageNum(10);
		List<NoticeVO> list = null;
		if(cri.getSearchValue() !=null) {
			list = ns.searchList(cri);	
		}else {
			list = ns.readNoticeList(cri);
		}
		List<NoticeVO> fixedNoticeList = ns.fixedNoticeList(); 
		model.addAttribute("noticeList", list);
		model.addAttribute("fixedNoticeList", fixedNoticeList);
		model.addAttribute("pm",ns.getPageMaker(cri));
		
	}
	
	@GetMapping("noticeDetail")
	public String noticeDetail(int bno, RedirectAttributes rttr)throws Exception{
		ns.updateVcnt(bno);
		rttr.addAttribute("bno",bno);
		return "redirect:detail";
	}
	
	@GetMapping("detail")
	public String detail(Model model, int bno, Criteria cri)throws Exception{
		model.addAttribute("pm",ncs.getPageMaker(cri, bno));
		// 댓글 리스트
		model.addAttribute("comments",ncs.getCommentList(cri,bno));
		NoticeVO vo = ns.readNotice(bno);
		model.addAttribute("vo", vo);
		return "/notice/noticeDetail";
	}
	/*
	 * @GetMapping("likeCount") public String likeCount (Model model, int bno,
	 * RedirectAttributes rttr)throws Exception{ String result =
	 * ns.upadateLcnt(bno); rttr.addFlashAttribute("result",result);
	 * model.addAttribute("result", result); return
	 * "redirect:noticeDetail?bno="+bno; }
	 */
	@GetMapping("newNotice")
	public void newNotice() {
	}
	
	@PostMapping("newNotice")
	public String newNoticePost(NoticeVO vo, RedirectAttributes rttr
			//, String editor
			) throws Exception {
		//vo.setContent(editor);
		String result = ns.newNotice(vo);
		rttr.addFlashAttribute("result", result);
		return "redirect:noticeList";
	}
	
	
	@GetMapping("editNotice")
	public void editNoitce(int bno, Model model) throws Exception {
		NoticeVO vo = ns.readNotice(bno);
		model.addAttribute("vo", vo);
	}
	
	@PostMapping("editNotice")
	public String editNoticePost(NoticeVO vo, RedirectAttributes rttr) throws Exception {
		String result = ns.editNotice(vo);
		rttr.addFlashAttribute("result", result);
		return "redirect:noticeList";
	}
	
	
	@GetMapping("deleteNotice")
	public String deleteNotice(int bno, RedirectAttributes rttr) throws Exception{
		String result = ns.deleteNotice(bno);
		rttr.addFlashAttribute("result",result);
		return "redirect:/notice/noticeList";
	}
	
	
	
	/* ===========댓 글 처 리=========== */

	/**
	 *  댓글요청 처리 (ajax) 
	 *  ncs가 처리해줌 
	 */
	// 댓글작성 요청 처리 
	@PostMapping("commentWrite")
	public ResponseEntity<String> commentWrite(NoticeCommentVO vo) {
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setContentType(new MediaType("application","json",Charset.forName("UTF-8")));
		try {
			String message = ncs.create(vo);
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
		return ncs.delete(cno);
	}
	
	// 댓글 수정 요청 처리
	@PatchMapping(value = "commentMod" , produces="application/json; charset=utf8")
	@ResponseBody
	public String commentModify(@RequestBody NoticeCommentVO vo) throws Exception{
		return ncs.modify(vo);
	}

	
}
