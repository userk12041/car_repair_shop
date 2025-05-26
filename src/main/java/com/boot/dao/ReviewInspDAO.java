package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.boot.dto.ReviewInspDTO;

public interface ReviewInspDAO {
	List<ReviewInspDTO> getReviewsByInspId(int ShopId);
	void insertReviewInsp(ReviewInspDTO review);
    void deleteReviewInsp(int reviewId);
    void updateReviewInsp(ReviewInspDTO review);
    boolean checkReviewByUserAndInsp(@Param("shopId") int shopId, @Param("userId") String userId);
}

