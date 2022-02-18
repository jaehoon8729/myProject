package egovframework.example.board.service;

import java.util.List;

import egovframework.example.board.vo.boardVo;
import egovframework.example.ivory.vo.Search;

public interface boardService {

	public List<boardVo> selectBoardList(Search search) throws Exception;
	
	public boardVo selectBoardContent(boardVo vo) throws Exception;

	public void insertBoardContent(boardVo vo) throws Exception;

	public int getBoardListCnt(Search search) throws Exception;
}
