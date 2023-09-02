package com.bitc.project.controller;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.project.dao.MemberDAO;
import com.bitc.project.service.NoteService;
import com.bitc.project.util.Criteria;
import com.bitc.project.util.PageMaker;
import com.bitc.project.vo.MemberVO;
import com.bitc.project.vo.NoteVO;

@Controller
@RequestMapping("note")
public class NoteController {
	
	@Autowired
	private NoteService ns;
	
	@Autowired
	private MemberDAO md;
	
	@GetMapping("note")
    public void note(Model model, Criteria cri,HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		cri.setPerPageNum(5);
        List<NoteVO> notes = ns.noteVOList(cri,id);
        model.addAttribute("notes", notes);
        PageMaker pm = ns.getPageMaker(cri,id);
        model.addAttribute("pm",pm);
    }
	
	@GetMapping("noteWrite")
    public String createNoteForm() {
        return "note/noteWrite";
    }

    @PostMapping("noteWrite")
    public String createNote(
    		NoteVO vo,
    		RedirectAttributes rttr
    		) throws Exception{
    	
    	boolean userCheck = us(vo.getTo_Id());
    	
    	if (!userCheck) {
            rttr.addFlashAttribute("errorMessage", "존재하지 않는 회원에게는 쪽지를 보낼 수 없습니다.");
            return "redirect:/note/noteWrite";
        }
    	
       ns.createNote(vo);
       rttr.addAttribute("id", vo.getFrom_Id());
        
  	 return "redirect:/note/note";
    }

	private boolean us(String to_Id) {
		MemberVO vo = md.selectMemberById(to_Id);
		return vo != null;
	}

	@GetMapping("noteDetail")
    public String noteDetail(
    		@RequestParam("nno")
    		int nno, Model model
    		) throws Exception {
        NoteVO note = ns.read(nno);
        model.addAttribute("note", note);
        return "note/noteDetail";
    }
    
    @GetMapping("noteReply")
    public String noteReply(Model model,@RequestParam("from") String from) throws Exception {
    	
    	NoteVO noteVo = new NoteVO();
    	noteVo.setTo_Id("주는사람");
    	noteVo.setFrom_Id(from);
    	
    	model.addAttribute("noteVO", noteVo);
    	model.addAttribute("to_Id", noteVo.getTo_Id());
    	model.addAttribute("from_Id", noteVo.getFrom_Id());
		return "note/noteReply";
    }
    
    @PostMapping("delete")
    public String delete(int[] nno, RedirectAttributes rttr, NoteVO vo) throws Exception {
    	for(int i = 0; i < nno.length; i++) {
    		ns.delete(nno[i]);
    	}
    	
    	rttr.addAttribute("id", vo.getFrom_Id());
    	
    	return "redirect:/note/note?id="+vo.getFrom_Id();
    	
    }
  }

	
