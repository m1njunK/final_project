package com.bitc.project.controller;

import java.util.List;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.project.service.QnaService;
import com.bitc.project.vo.QnaVO;

import lombok.RequiredArgsConstructor;


@Controller
@RequestMapping("/qna/*")
@RequiredArgsConstructor
public class QnaController {
	
	private final QnaService qs;
	
	@GetMapping("qnaPage")
	public void qna(Model model) throws Exception {
		List<QnaVO> qnaList= qs.qnaList();
		model.addAttribute("qnaList", qnaList);
	}
	
	
	@GetMapping("newQna")
	public void newQna(Model model) throws Exception {	
	}
	@PostMapping("newQna")
	public String makeNewQna(QnaVO vo, RedirectAttributes rttr) throws Exception {
		vo.setQuestionContent(vo.getQuestionContent().replace("\r\n", "<br/>"));
		String result = qs.newQna(vo);
		rttr.addFlashAttribute("result",result);
		return "redirect:/qna/qnaPage"; 
	}
	
	
	@GetMapping("editQna")
	public void editQna(int qnaId, Model model) throws Exception {
		QnaVO vo = qs.qnaLoad(qnaId);
		vo.setQuestionContent(vo.getQuestionContent().replace("<br/>", "\r\n"));
		model.addAttribute("QnaVO", vo);
	}
	
	@PostMapping("editQna")
	public String editQna(QnaVO vo, RedirectAttributes rttr) throws Exception{
		vo.setQuestionContent(vo.getQuestionContent().replace("\r\n", "<br/>"));
		String result = qs.editQna(vo);
		rttr.addFlashAttribute("result",result);
		return "redirect:/qna/qnaPage"; 
	}
	
	@GetMapping("delete")
	public String deleteQna(int qnaId,RedirectAttributes rttr) throws Exception{
		String result = qs.remove(qnaId);
		rttr.addFlashAttribute("result",result);
		return "redirect:/qna/qnaPage"; 
	}
	
	
}
