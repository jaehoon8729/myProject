package egovframework.example.login.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.example.login.service.userService;
import egovframework.example.login.vo.userVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("userService")
public class userServiceImpl extends EgovAbstractServiceImpl implements userService {
//    private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	
	@Autowired
	private userDAO userDao;

	public userVo userLogin(userVo vo) throws Exception {
		 // DB 비밀번호와 로그인 비밀번호가 틀릴경우 loginFail 모델은 내려준다.
		if (!pwdEncoder.matches(vo.getUser_pswd(), userDao.userLogin(vo).getUser_pswd()) ) {
			System.out.println("정보가 다릅니다");
			vo.setUser_id(null);
			vo.setUser_name(null);
			vo.setUser_pswd(null);
			return vo;
		}else {
			return userDao.userLogin(vo);
		}
	}
	
	public void insertMember(userVo vo) throws Exception {
		userDao.insertMember(vo);
	}
	
	public String selectOverlap(userVo vo) throws Exception{
		return userDao.selectOverlap(vo);
	}

	public userVo selectUserInfo(userVo vo) throws Exception {
		if(!pwdEncoder.matches(vo.getUser_pswd(), userDao.userLogin(vo).getUser_pswd())) {
			
		}
		return userDao.userLogin(vo);
	}
	
}