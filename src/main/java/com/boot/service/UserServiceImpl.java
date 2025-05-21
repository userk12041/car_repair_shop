package com.boot.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.UserDAO;
import com.boot.dto.UserDTO;
import com.boot.util.GeoUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("UserService")
public class UserServiceImpl implements UserService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public void register(UserDTO userDTO) {
        // 주소 -> 위도, 경도 변환
        double[] latlng = GeoUtil.getLatLngFromAddress(userDTO.getRegion());

        if (latlng != null) {
            userDTO.setLatitude(latlng[0]); // 위도
            userDTO.setLongitude(latlng[1]); // 경도
        } else {
            // 실패했을 경우 기본값 처리 (예: 0.0 또는 null)
            userDTO.setLatitude(0.0);
            userDTO.setLongitude(0.0);
        }
        UserDAO userDao = sqlSession.getMapper(UserDAO.class);
        log.info("UserService register userDTO=>"+userDTO);
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

    @Override
    public boolean isUserIdAvailable(String userId) {
        UserDAO userDao = sqlSession.getMapper(UserDAO.class);
        return userDao.countByUserId(userId) == 0;
    }

    @Override
    public boolean isNicknameAvailable(String nickname) {
        UserDAO userDao = sqlSession.getMapper(UserDAO.class);
        return userDao.countByNickname(nickname) == 0;
    }

    // ✅ 이메일 + 전화번호로 아이디 찾기
    public String findUserIdByEmailAndPhone(String email, String phone) {
        UserDAO userDao = sqlSession.getMapper(UserDAO.class);
        return userDao.findUserIdByEmailAndPhone(email, phone);
    }

    // ✅ 아이디 + 이메일로 존재 확인 (비밀번호 재설정 조건 확인용)
    public boolean verifyUserIdAndEmail(String userId, String email) {
        UserDAO userDao = sqlSession.getMapper(UserDAO.class);
        return userDao.countByUserIdAndEmail(userId, email) > 0;
    }

    // ✅ 비밀번호 재설정
    public void updatePassword(String userId, String newPassword) {
        UserDAO userDao = sqlSession.getMapper(UserDAO.class);
        userDao.updatePassword(userId, newPassword);
    }
}
