package com.bitc.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.project.dao.MemberDAO;
import com.bitc.project.service.MemberService;
import com.bitc.project.vo.MemberVO;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
    private MemberDAO md;
	
    @Autowired
    private MemberService ms;
	
    @GetMapping("/modify")
    public String modify(Model model, String id) {
	    MemberVO vo = ms.findMemberById(id);
	    model.addAttribute("member", vo);
	    return "user/modify";
    	}
    
    @PostMapping("/modify")
    public String modify(Model model, String id, MemberVO vo) {
    	    ms.updateMember(vo);
    	    return "redirect:/user/user";
    	}

	@RequestMapping(value = "user", method = RequestMethod.GET)
    public String list(Model model,String id) {
		MemberVO member = md.selectMemberById(id);
        model.addAttribute("member", member);
        return "user/user";
    }
	
	@GetMapping("/withdraw")
	public String memberWithdraw(MemberVO member, RedirectAttributes redirectAttributes) {
	    ms.withdraw(member);
	    redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
	    return "redirect:/";
	}
	
}
