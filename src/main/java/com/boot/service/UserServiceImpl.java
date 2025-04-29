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
        userDao.register(userDTO);		
	}
	
	@Override
	public UserDTO login(String userId, String password) {
	    UserDAO userDao = sqlSession.getMapper(UserDAO.class);
	    UserDTO user = userDao.findByUserId(userId);

	    if (user != null && user.getPassword().equals(password)) {
	        return user;
	    }
	    return null;
	}

}
