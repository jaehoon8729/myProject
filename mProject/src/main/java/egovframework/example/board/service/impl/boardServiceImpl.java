package egovframework.example.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.board.service.boardService;
import egovframework.example.board.vo.boardVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("boardService")
public class boardServiceImpl extends EgovAbstractServiceImpl implements boardService {
//    private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	private boardDAO boardDao;
	
	public List<boardVo> selectBoardList() throws Exception {
    	return boardDao.selectBoardList();
    }

	public boardVo selectBoardContent(boardVo vo) throws Exception {
		
		return boardDao.selectContent(vo);
	}
}