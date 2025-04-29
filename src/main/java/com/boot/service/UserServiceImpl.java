package com.boot.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.UserDAO;
import com.boot.dto.UserDTO;

@Service("UserService")
public class UserServiceImpl implements UserService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void register(UserDTO userDTO) {
        UserDAO userDao = sqlSession.getMapper(UserDAO.class);
        // 비밀번호 암호화 **제외**
        userDao.register(userDTO);		
	}
}
