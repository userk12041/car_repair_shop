package com.boot.service;

import java.util.List;

import com.boot.dto.ReviewDTO;

public interface ReviewService {
    List<ReviewDTO> getReviewsByShopId(int repairShopId);
    void insertReview(ReviewDTO review);
    void deleteReview(int reviewId);
    void updateReview(ReviewDTO review);
    boolean hasReview(int shopId, String userId);
}

