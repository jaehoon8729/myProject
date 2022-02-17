package egovframework.example.login.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import egovframework.example.cmmn.service.impl.EgovComAbstractDAO;
import egovframework.example.login.vo.userVo;


@Repository("userDAO")
public class userDAO extends EgovComAbstractDAO {
	
	
    public userVo userLogin(userVo vo) throws Exception{
    	return selectOne("userLogin",vo);
    }
    
    public void insertMember(userVo vo) throws Exception{
    	insert("insertMember",vo);
    }
  
}
