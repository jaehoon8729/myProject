package egovframework.example.board.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.board.service.boardService;
import egovframework.example.board.vo.boardVo;
import egovframework.example.board.vo.comVo;
import egovframework.example.ivory.vo.Search;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("boardService")
public class boardServiceImpl extends EgovAbstractServiceImpl implements boardService {
//    private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
	
	private static final String UPLOAD_PATH = "D:\\studyDownload\\";
	
	@Autowired
	private boardDAO boardDao;
	
	public List<boardVo> selectBoardList(Search search) throws Exception {
		
		
    	return boardDao.selectBoardList(search);
    }

	public Map<String, Object> selectBoardContent(boardVo vo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("servicedfn:"+boardDao.selectContent(vo).getDefault_file_name());
		map.put("vo", boardDao.selectContent(vo));
		map.put("cvo", boardDao.selectCommentList(vo));
		return map;
	}
	
	public int insertBoardContent(boardVo vo) throws Exception {
		//파일이 있으면 이름을 저장(파일이름이 겹치는 현상을 방지)
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
 
		return boardDao.insertContent(vo);
	}

	public int getBoardListCnt(Search search) throws Exception {
		return boardDao.getBoardListCnt(search);
	}
	
	public int updateBoard(boardVo vo) throws Exception {
		try {			
			String fileName = null;
	        MultipartFile uploadFile = vo.getUploadFile();

	        //파일이 변한경우 (삭제or수정)
	        if(vo.getBoardFileCheck().equals("new")) {
	        	//파일이 수정된경우
            	if (!uploadFile.isEmpty()) {
                    String originalFileName = uploadFile.getOriginalFilename();
                    String ext = FilenameUtils.getExtension(originalFileName); // 확장자 구하기
                    UUID uuid = UUID.randomUUID(); // UUID 구하기
                    fileName = uuid + "." + ext;
                    uploadFile.transferTo(new File(UPLOAD_PATH + fileName));
                }
            	vo.setDefault_file_name(uploadFile.getOriginalFilename());
                vo.setFile_name(fileName);
	        } else if(vo.getBoardFileCheck().equals("old")) {
	        	//파일이 변하지않은경우 DB에 있는 파일이름을 그대로 다시 넣어줌
	        	boardVo vo1 = (boardVo) selectBoardContent(vo).get("vo");
	        	vo.setFile_name(vo1.getFile_name());	
	        }
			System.out.println("filename:"+vo.getFile_name());
			System.out.println("dfilenameinservice"+vo.getDefault_file_name());
		}
		catch(Exception ex) {
			System.out.println(ex);
		}
		return boardDao.updateBoard(vo);
	}
	
	public int insertCommend(comVo vo) throws Exception {
		return boardDao.insertCommnet(vo);
	}
	
	public List<comVo> selectCommentList(comVo vo) throws Exception{
		return boardDao.selectCommentList(vo);
	}
	
	public int deleteBoard(boardVo vo) throws Exception{
		return boardDao.deleteBoard(vo);
	}
	
	public int deleteComment(comVo vo) {
		return boardDao.deleteComment(vo);
	}
	
	public int updateComment(comVo vo) {
		return boardDao.updateComment(vo);
	}
}