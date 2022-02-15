package egovframework.example.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class boardController {
	@RequestMapping(value="/board/board.do")
	public String board() {
		return "board/board";
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
