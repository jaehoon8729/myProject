package egovframework.example.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.login.service.userService;
import egovframework.example.login.vo.userVo;

@Controller
public class loginController {
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	
	@Autowired
	private userService userservice;
	
	//로그인페이지
	@RequestMapping(value="/login/login.do")
	public String login(HttpServletRequest request)throws Exception {	
		HttpSession session = request.getSession();
		    // requestUrl 가 null 이 아니거나 referer 가 null이 아닐경우
		if (request.getRequestURI() != null && request.getHeader("referer") != null) {
			// 이전페이지가 loginGet이거나 직접 로그인URL에 접속하지 않았을때만 referrer 저장
			if (!(request.getRequestURI().equals("/login/loginGet") && request.getHeader("referer").equals("http://localhost:8080/login/login.do"))) {
				// dest 세션에 이전 페이지 정보 저장
				session.setAttribute("dest", request.getHeader("referer"));
			}
		}
		return "login/login";
	}
	
	//로그인submit
	@RequestMapping(value="/login/loginPost.do", method = RequestMethod.POST)
	public String loginPost(userVo vo, Model model, HttpSession session, HttpServletRequest request) throws Exception {
		System.out.println("correctAnswer:"+ request.getSession().getAttribute("correctAnswer"));
		
		// 캡차가 있는경우
		if(request.getSession().getAttribute("correctAnswer") != null) {
			//캡차랑 input탭에 입력값이 틀리면 진행
			if(!request.getSession().getAttribute("correctAnswer").equals(vo.getCaptcha())) {
				System.out.println("캡차실패");
				return "redirect:login.do";
			}	
		}
		
	    // DB 비밀번호와 로그인 비밀번호가 틀릴경우 loginFail 모델은 내려준다.
		if (!pwdEncoder.matches(vo.getUser_pswd(), userservice.userLogin(vo).getUser_pswd())) {
			System.out.println("정보가 다릅니다");
			return "redirect:login.do";
		}else {
			vo = userservice.userLogin(vo);
			session.setAttribute("sessionUserVo", vo);
			return "redirect:/main.do";
		}
	}
	
	//로그아웃
	@RequestMapping(value = "/login/logout.do", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		session.invalidate();

		return "main";
	}
	
	//회원가입페이지
	@RequestMapping(value="/login/joinForm.do")
	public String joinForm(userVo vo, Model model) {
		
		
		
		return "login/joinForm";
	}
	
	//회원가입Post
	@PostMapping(value="/login/joinFormPost.do")
	public String joinPost(userVo vo) throws Exception {
		String pwd = vo.getUser_pswd();
		vo.setUser_pswd(pwdEncoder.encode(pwd));
		
		userservice.insertMember(vo);
		return "login/login";
	}
	
	//중복확인
	@PostMapping(value="/login/joinFormOverlap.do")
	@ResponseBody
	public String overlap(userVo vo) throws Exception {
		System.out.println("voID"+vo.getUser_id());

		if(vo.getUser_id().equals(userservice.selectOverlap(vo))) {
			System.out.println("true");
			return "1";
		}else {
			System.out.println("false");
			return "0";
		}

	}
}
