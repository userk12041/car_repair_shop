package com.boot.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.ReviewDAO;
import com.boot.dto.ReviewDTO;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<ReviewDTO> getReviewsByShopId(int ShopId) {
        ReviewDAO reviewDAO = sqlSession.getMapper(ReviewDAO.class);
        return reviewDAO.getReviewsByShopId(ShopId);
    }
    
    @Override
    public void insertReview(ReviewDTO review) {
        ReviewDAO reviewDAO = sqlSession.getMapper(ReviewDAO.class);
        reviewDAO.insertReview(review);
    }

    @Override
    public void deleteReview(int reviewId) {
        ReviewDAO dao = sqlSession.getMapper(ReviewDAO.class);
        dao.deleteReview(reviewId);
    }
    @Override
    public void updateReview(ReviewDTO review) {
        ReviewDAO dao = sqlSession.getMapper(ReviewDAO.class);
        dao.updateReview(review);
    }

}


