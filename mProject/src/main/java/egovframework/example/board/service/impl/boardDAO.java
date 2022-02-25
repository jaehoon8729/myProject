package egovframework.example.board.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.board.vo.boardVo;
import egovframework.example.board.vo.comVo;
import egovframework.example.cmmn.service.impl.EgovComAbstractDAO;
import egovframework.example.ivory.vo.Search;


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
    
    public int updateBoard(boardVo vo) throws Exception{
    	return update("update_board", vo);
    }
    
    public int insertCommnet(comVo vo) throws Exception{
    	return insert("insert_comment", vo);
    }
    
    public List<comVo> selectCommentList(comVo vo) throws Exception{
    	return selectList("find_comment_list",vo);
    }
}