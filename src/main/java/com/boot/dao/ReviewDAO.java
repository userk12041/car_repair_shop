package com.boot.dao;

import java.util.List;

import com.boot.dto.ReviewDTO;

public interface ReviewDAO {
	List<ReviewDTO> getReviewsByShopId(int repairShopId);
	void insertReview(ReviewDTO review);
    void deleteReview(int reviewId);
}

