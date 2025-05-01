package com.boot.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.dto.UserDTO;

@Mapper
public interface UserDAO {
    void register(UserDTO userDTO);
    UserDTO findByUserId(String userId);
    int countByUserId(String userId);
    int countByNickname(String nickname);
    String findUserIdByEmailAndPhone(@Param("email") String email, @Param("phone") String phone);
    int countByUserIdAndEmail(@Param("userId") String userId, @Param("email") String email);
    void updatePassword(@Param("userId") String userId, @Param("newPassword") String newPassword);
}
