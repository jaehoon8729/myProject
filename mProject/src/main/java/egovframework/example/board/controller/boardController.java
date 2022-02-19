package egovframework.example.board.controller;


import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.board.service.boardService;
import egovframework.example.board.vo.boardVo;
import egovframework.example.ivory.vo.Search;


@Controller
public class boardController {
	
	private static final String UPLOAD_PATH = "D:\\studyDownload";
	
	@Autowired
	private boardService boardservice;
	
	@RequestMapping(value="/board/board.do")
	public String board(Model model
			 ,@RequestParam(required=false,defaultValue="1")int page
	            ,@RequestParam(required=false,defaultValue="1")int range
	            ,@RequestParam(required=false,defaultValue="title")String searchType
	            ,@RequestParam(required=false)String keyword
	            ,@ModelAttribute("search")Search search) throws Exception {
		
		model.addAttribute("search", search);
        search.setSearchType(searchType);
        search.setKeyword(keyword);

      //전체 개시글 개수
        int listCnt = boardservice.getBoardListCnt(search);
        
        //검색 후 페이지
        search.pageInfo(page, range, listCnt);
        System.out.println(search.getKeyword());
        System.out.println(search.getSearchType());
        //페이징
        model.addAttribute("pagination", search);
        
        //게시글 화면 출력
        model.addAttribute("boardList", boardservice.selectBoardList(search));
		
		return "board/board";
	}
	
	@RequestMapping(value="/board/boardPost.do", method = RequestMethod.POST)
	public String boardPost(boardVo vo, @RequestParam("file") MultipartFile loadfile, Model model) throws Exception {
		System.out.println("test");
		
		String tf = vo.getFile_name();
		System.out.println(vo.getContent()+","+vo.getFile_name());
		
		if(loadfile != null) {
			vo.setFile_name(saveFile(loadfile));
			System.out.println(vo.getFile_name());
		}
		
		if(vo.getFile_name() != null){ // 파일 저장 성공
	        System.out.println("파일저장성공-----------------");
	    } else { // 파일 저장 실패
	    	System.out.println("파일저장실패-----------------");
	    }
		
	
		boardservice.insertBoardContent(vo);
		
		return "redirect:board.do";
	}
	
	private String saveFile(MultipartFile file) {
		//서버에서 이름안겹치게 uuid로 랜덤텍스트 생성
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid);
		String saveName = uuid.toString() + "_" + file.getOriginalFilename();
		System.out.println(saveName);
		//저장할 file 객체를 생성(저장할 폴더이름,저장할파일이름)
		File saveFile = new File(UPLOAD_PATH,saveName);
		
		try {
			//업로드파일에 savefile이라는 객체를 입힘
			file.transferTo(saveFile);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		return saveName;
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
