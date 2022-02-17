package egovframework.example.board.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.board.vo.boardVo;
import egovframework.example.cmmn.service.impl.EgovComAbstractDAO;

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
    
    public List<boardVo> selectBoardList() throws Exception{
    	return selectList("find_board_list");
    }
    
    public boardVo selectContent(boardVo vo) throws Exception{
    	return selectOne("find_content",vo);
    }
    
    public void insertContent(boardVo vo) throws Exception{
    	insert("insert_board",vo);
    }
}
