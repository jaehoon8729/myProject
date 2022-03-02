package egovframework.example.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.board.service.boardService;
import egovframework.example.board.vo.boardVo;
import egovframework.example.board.vo.comVo;
import egovframework.example.ivory.vo.Search;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("boardService")
public class boardServiceImpl extends EgovAbstractServiceImpl implements boardService {
//    private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	private boardDAO boardDao;
	
	public List<boardVo> selectBoardList(Search search) throws Exception {
    	return boardDao.selectBoardList(search);
    }

	public boardVo selectBoardContent(boardVo vo) throws Exception {
		
		return boardDao.selectContent(vo);
	}
	
	public void insertBoardContent(boardVo vo) throws Exception {
		boardDao.insertContent(vo);
	}

	public int getBoardListCnt(Search search) throws Exception {
		return boardDao.getBoardListCnt(search);
	}
	
	public int updateBoard(boardVo vo) throws Exception {
		// TODO Auto-generated method stub
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
}