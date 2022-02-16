package egovframework.example.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String write() {
		return "board/register";
	}
}
