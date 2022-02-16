package egovframework.example.board.service;

import java.util.List;

import egovframework.example.board.vo.boardVo;

public interface boardService {

	public List<boardVo> selectBoardList() throws Exception;
	
	public boardVo selectBoardContent(boardVo vo) throws Exception;

}
