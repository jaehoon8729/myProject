package egovframework.example.board.controller;


import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	//View
	@RequestMapping(value="/board/view.do")
	public String view(@ModelAttribute boardVo vo, Model model) throws Exception {
		comVo cvo = new comVo();
		cvo.setBoard_id(vo.getBoard_id());
		System.out.println("boardid in cvo:"+cvo.getBoard_id());
		//게시글내용
		model.addAttribute("vo",boardservice.selectBoardContent(vo));
		//댓글내용
		model.addAttribute("cvo", boardservice.selectCommentList(cvo));
		
		return "board/view";
	}
	
	//수정
	@RequestMapping(value="/board/detail.do")
	public String detail(boardVo vo, Model model) throws Exception {
		
		
		model.addAttribute("vo", boardservice.selectBoardContent(vo));
		return "board/detail";
	}
	
	//detailPost
	@RequestMapping(value="/board/detailPost.do")
	@ResponseBody
	public Map detailPost(boardVo vo) throws Exception {
		
		Map result = new HashMap<String,Object>();

		System.out.println("uploadfile:"+vo.getUploadFile());
		System.out.println("board_id:"+vo.getBoard_id());
		System.out.println("content:"+vo.getContent());
		System.out.println("filename:"+vo.getFile_name());
		System.out.println("id:"+vo.getUser_id());
		System.out.println("같은가?"+boardservice.selectBoardContent(vo).getFile_name());
		
		String fileName = null;
        MultipartFile uploadFile = vo.getUploadFile();
        System.out.println("eeeeeeee");
        if(vo.getFile_name() != null) {
        	if(!vo.getFile_name().equals(boardservice.selectBoardContent(vo).getFile_name())) {
            	System.out.println("vvvvvvvvvv");
            	if (uploadFile != null) {
                	System.out.println("3번경우");
                    String originalFileName = uploadFile.getOriginalFilename();
                    String ext = FilenameUtils.getExtension(originalFileName); // 확장자 구하기
                    UUID uuid = UUID.randomUUID(); // UUID 구하기
                    fileName = uuid + "." + ext;
                    uploadFile.transferTo(new File(UPLOAD_PATH + fileName));
                }
                vo.setFile_name(fileName);
            }
        }
        
        System.out.println("ㅁㅁㅁㅁㅁㅁ");
		if(boardservice.updateBoard(vo) == 1) {
			result.put("success", true);
		}else {
			result.put("success", false);
		}
        
		return result;
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
}
