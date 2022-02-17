package egovframework.example.login.service;

import egovframework.example.login.vo.userVo;

public interface userService {
	public userVo userLogin(userVo vo) throws Exception;
	
	public void insertMember(userVo vo) throws Exception;
}
