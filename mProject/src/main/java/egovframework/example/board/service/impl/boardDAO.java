package egovframework.example.board.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.board.vo.boardVo;
import egovframework.example.cmmn.service.impl.EgovComAbstractDAO;
import egovframework.example.ivory.vo.Search;

/**
 * @Class Name : WncAdmDAO.java
 * @Description : WncAdm DAO Class
 * @Modification Information
 *
 * @author wnc
 * @since 2021-05-01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All rights reserved.
 */

@Repository("boardDAO")
public class boardDAO extends EgovComAbstractDAO {
    
    public List<boardVo> selectBoardList(Search search) throws Exception{
    	return selectList("find_board_list",search);
    }
    
    public boardVo selectContent(boardVo vo) throws Exception{
    	return selectOne("find_content",vo);
    }
    
    public void insertContent(boardVo vo) throws Exception{
    	insert("insert_board",vo);
    }
    public int getBoardListCnt(Search search) throws Exception{
    	return selectOne("getBoardListCnt", search);
    }
    
    public void updateBoard(boardVo vo) throws Exception{
    	update("update_board", vo);
    }
}
