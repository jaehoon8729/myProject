package egovframework.example.board.controller;


import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.board.service.boardService;
import egovframework.example.board.vo.boardVo;
import egovframework.example.board.vo.comVo;
import egovframework.example.ivory.vo.Search;


@Controller
public class boardController {
	private static final String UPLOAD_PATH = "D:\\studyDownload\\";
	@Autowired
	private boardService boardservice;
	
	@RequestMapping(value="/board/board.do")
	public String board(Model model
			 ,@RequestParam(required=false,defaultValue="1")int page
	            ,@RequestParam(required=false,defaultValue="1")int range
	            ,@RequestParam(required=false,defaultValue="title")String searchType
	            ,@RequestParam(required=false)String keyword
	            ,@ModelAttribute("search")Search search) throws Exception {
		
        search.setSearchType(searchType);
        search.setKeyword(keyword);

      //전체 개시글 개수
        int listCnt = boardservice.getBoardListCnt(search);
        
        //검색 후 페이지
        search.pageInfo(page, range, listCnt);
        
        //페이징
        model.addAttribute("pagination", search);
        
        //게시글 화면 출력
        model.addAttribute("boardList", boardservice.selectBoardList(search));
		
		return "board/board";
	}
	
	//글작성
	@RequestMapping(value="/board/boardPost.do")
	public String boardPost(@ModelAttribute boardVo vo) throws Exception {
		try {
			int a = boardservice.insertBoardContent(vo);
			System.out.println("boardPostResult:"+a);
		}catch(Exception ex) {
			System.out.println(ex);
		}
		return "redirect:board.do";
	}
	
	//View
	@RequestMapping(value="/board/view.do")
	public String view(@ModelAttribute boardVo vo, Model model) throws Exception {
		try {
			//게시글+댓글 내용
			model.addAttribute("vo",boardservice.selectBoardContent(vo));
		}catch(Exception ex){
			System.out.println(ex);
		}
		return "board/view";
	}
	
	//수정페이지
	@RequestMapping(value="/board/detail.do")
	public String detail(boardVo vo, Model model) throws Exception {
		

		model.addAttribute("vo", boardservice.selectBoardContent(vo));
		return "board/detail";
	}
	
	//detailPost
	@RequestMapping(value="/board/detailPost.do",method = RequestMethod.POST)
	@ResponseBody
	public String detailPost(@ModelAttribute boardVo vo) throws Exception {
		
		boardservice.updateBoard(vo);
		return "1";
	}
	
	//글작성페이지이동
	@RequestMapping(value="/board/register.do")
	public String write() {
		
		return "board/register";
	}
	
	//댓글작성
	@PostMapping("/board/commentPost.do")
	public String comWrite(comVo vo, Model model) throws Exception {
		System.out.println("cid:"+vo.getBoard_id());
		System.out.println("ccontent:"+vo.getCom_content());
		System.out.println("cuser:"+vo.getUser_id());

		boardservice.insertCommend(vo);
		return "redirect:view.do?board_id="+vo.getBoard_id();
	}
	//댓글삭제
	@PostMapping("/board/deleteComment.do")
	public String deleteComment(comVo vo, Model model) throws Exception {
		System.out.println("bid:"+vo.getBoard_id());
		System.out.println("ccontent:"+vo.getCom_content());
		System.out.println("cuser:"+vo.getUser_id());
		System.out.println("cid"+vo.getComment_id());
		boardservice.deleteComment(vo);
		return "redirect:view.do?board_id="+vo.getBoard_id();
	}
	
	//댓글수정
		@PostMapping("/board/updateComment.do")
		public String updateComment(comVo vo) throws Exception {
			System.out.println("userid:"+vo.getUser_id());
			System.out.println("boardid:"+vo.getBoard_id());
			System.out.println("content:"+vo.getCom_content());
			System.out.println("comid:"+vo.getComment_id());
			
			boardservice.updateComment(vo);
			return "redirect:view.do?board_id="+vo.getBoard_id();
		}
		
	//게시글삭제
	@PostMapping("/board/delete.do")
	public String deleteBoard(boardVo vo) throws Exception{
		System.out.println("삭제중:"+vo.getBoard_id());
		int a = boardservice.deleteBoard(vo);
		System.out.println("result:"+a);
		return "redirect:board.do";
	}
}
