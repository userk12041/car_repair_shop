package com.boot.service;

import java.util.List;

import com.boot.dto.ReviewDTO;
import com.boot.dto.ReviewInspDTO;

public interface ReviewService {
    List<ReviewDTO> getReviewsByShopId(int repairShopId);
    void insertReview(ReviewDTO review);
    void deleteReview(int reviewId);
    void updateReview(ReviewDTO review);
    boolean hasReview(int shopId, String userId);
    
    List<ReviewInspDTO> getReviewsByInspId(int inspCenterId);
    void insertReviewInsp(ReviewInspDTO review);
    void deleteReviewInsp(int reviewId);
    void updateReviewInsp(ReviewInspDTO review);
    boolean hasReviewInsp(int shopId, String userId);
}

