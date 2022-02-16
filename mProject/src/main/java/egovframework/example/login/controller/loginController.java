package egovframework.example.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class loginController {
	
	@RequestMapping(value="/login/login.do")
	public String login() {
		return "login/login";
	}
	
	@RequestMapping(value="/login/joinForm.do")
	public String joinForm() {
		return "login/joinForm";
	}
}
