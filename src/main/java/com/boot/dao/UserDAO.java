package com.boot.dao;

import org.apache.ibatis.annotations.Mapper;

import com.boot.dto.UserDTO;

@Mapper
public interface UserDAO {
	void register(UserDTO userDTO);
	UserDTO findByUserId(String userId);
	int countByUserId(String userId);
    int countByNickname(String nickname);
	String findUserIdByEmailAndPhone(String email, String phone);
	int countByUserIdAndEmail(String userId, String email);
	void updatePassword(String userId, String newPassword);
}
