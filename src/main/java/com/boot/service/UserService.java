package com.boot.service;

import com.boot.dto.UserDTO;

public interface UserService {
	void register(UserDTO userDTO);
	UserDTO login(String userId, String password);
	boolean isUserIdAvailable(String userId);
	boolean isNicknameAvailable(String nickname);
}
