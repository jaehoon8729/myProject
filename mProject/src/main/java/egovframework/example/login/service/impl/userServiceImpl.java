package egovframework.example.login.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.login.service.userService;
import egovframework.example.login.vo.userVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("userService")
public class userServiceImpl extends EgovAbstractServiceImpl implements userService {
//    private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	private userDAO userDao;

	public userVo userLogin(userVo vo) throws Exception {
		return userDao.userLogin(vo);
	}
	
	public void insertMember(userVo vo) throws Exception {
		userDao.insertMember(vo);
	}
}