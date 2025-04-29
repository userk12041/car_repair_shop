package com.boot.dao;

import org.apache.ibatis.annotations.Mapper;

import com.boot.dto.UserDTO;

@Mapper
public interface UserDAO {
	void register(UserDTO userDTO);
	UserDTO findByUserId(String userId);
}
