package com.boot.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.ReviewDAO;
import com.boot.dao.ReviewInspDAO;
import com.boot.dto.ReviewDTO;
import com.boot.dto.ReviewInspDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
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
    	log.info("insertReview");
    	log.info("review"+ review);
    	
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

	@Override
	public boolean hasReview(int shopId, String userId) {
		ReviewDAO dao = sqlSession.getMapper(ReviewDAO.class);
		return dao.checkReviewByUserAndShop(shopId, userId);
	}
	
	// insp
    @Override
    public List<ReviewInspDTO> getReviewsByInspId(int ShopId) {
        ReviewInspDAO dao = sqlSession.getMapper(ReviewInspDAO.class);
        return dao.getReviewsByInspId(ShopId);
    }
    
    @Override
    public void insertReviewInsp(ReviewInspDTO review) {
    	log.info("insertReviewInsp");
    	log.info("review "+ review);
    	
    	ReviewInspDAO dao = sqlSession.getMapper(ReviewInspDAO.class);
    	dao.insertReviewInsp(review);
    }

    @Override
    public void deleteReviewInsp(int reviewId) {
    	ReviewInspDAO dao = sqlSession.getMapper(ReviewInspDAO.class);
        dao.deleteReviewInsp(reviewId);
    }
    @Override
    public void updateReviewInsp(ReviewInspDTO review) {
    	ReviewInspDAO dao = sqlSession.getMapper(ReviewInspDAO.class);
        dao.updateReviewInsp(review);
    }

	@Override
	public boolean hasReviewInsp(int shopId, String userId) {
		ReviewInspDAO dao = sqlSession.getMapper(ReviewInspDAO.class);
		return dao.checkReviewByUserAndInsp(shopId, userId);
	}
}


