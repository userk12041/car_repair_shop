package com.boot.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.BookmarkDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("BookmarkService")
public class BookmarkServiceImpl implements BookmarkService {
	
	@Autowired
    private SqlSession sqlSession;

    @Override
    public boolean toggleBookmark(String userId, int shopId) {
    	log.info("service");
        BookmarkDAO dao = sqlSession.getMapper(BookmarkDAO.class);
        log.info("userId "+userId);
        log.info("shopId "+shopId);
        boolean exists = dao.isBookmarked(userId, shopId);
        log.info("exists : "+exists);
        if (exists) {
        	log.info("service if");
            dao.deleteBookmark(userId, shopId);
            return false; // 북마크 해제됨
        } else {
        	log.info("service else");
            dao.insertBookmark(userId, shopId);
            return true; // 북마크 추가됨
        }
    }

    @Override
    public boolean isBookmarked(String userId, int shopId) {
    	log.info("service isBookmarked");
        BookmarkDAO dao = sqlSession.getMapper(BookmarkDAO.class);
        return dao.isBookmarked(userId, shopId);
    }
}