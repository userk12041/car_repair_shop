package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.boot.dto.ReviewDTO;

public interface ReviewDAO {
	List<ReviewDTO> getReviewsByShopId(int ShopId);
	void insertReview(ReviewDTO review);
    void deleteReview(int reviewId);
    void updateReview(ReviewDTO review);
    boolean checkReviewByUserAndShop(@Param("shopId") int shopId, @Param("userId") String userId);
}

