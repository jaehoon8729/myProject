package egovframework.example.board.controller;

import java.security.Provider.Service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import egovframework.example.board.service.boardService;
import egovframework.example.board.vo.boardVo;


@Controller
public class boardController {
	
	@Autowired
	private boardService boardservice;
	
	@RequestMapping(value="/board/board.do")
	public String board(boardVo vo, Model model) throws Exception {
		
		model.addAttribute("boardList", boardservice.selectBoardList());
		
		return "board/board";
	}
	
	@RequestMapping(value="/board/boardPost.do")
	public String boardPost(boardVo vo, Model model) throws Exception {
		
		System.out.println(vo.getUser_id());
		System.out.println(vo.getTitle());
		System.out.println(vo.getContent());
		boardservice.insertBoardContent(vo);
		
		return "redirect:board/board";
	}
	
	
	@RequestMapping(value="/board/view.do")
	public String view(@ModelAttribute boardVo vo, Model model) throws Exception {

		model.addAttribute("vo",boardservice.selectBoardContent(vo));
		
		return "board/view";
	}
	
	@RequestMapping(value="/board/detail.do")
	public String detail() {
		return "board/detail";
	}
	
	@RequestMapping(value="/board/register.do")
	public String write(boardVo vo,Model model, HttpSession session) {
		
		return "board/register";
	}
}
