package egovframework.example.board.controller;


import java.io.File;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.board.service.boardService;
import egovframework.example.board.vo.boardVo;
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
		
		model.addAttribute("search", search);
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
	
	@RequestMapping(value="/board/boardPost.do")
	public String boardPost(@ModelAttribute boardVo vo) throws Exception {
		System.out.println(vo.getContent());
		String fileName = null;
        MultipartFile uploadFile = vo.getUploadFile();

        if (!uploadFile.isEmpty()) {
            String originalFileName = uploadFile.getOriginalFilename();
            String ext = FilenameUtils.getExtension(originalFileName); // 확장자 구하기
            UUID uuid = UUID.randomUUID(); // UUID 구하기
            fileName = uuid + "." + ext;
            uploadFile.transferTo(new File(UPLOAD_PATH + fileName));
        }
        vo.setFile_name(fileName);
 
        boardservice.insertBoardContent(vo);

		return "redirect:board.do";
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
