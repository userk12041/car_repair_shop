package com.boot.service;

import java.util.List;

import com.boot.dto.ReviewDTO;

public interface ReviewService {
//    List<ReviewDTO> getReviewsByShopId(int repairShopId, int page, int size);
    List<ReviewDTO> getReviewsByShopId(int repairShopId);
//    int countReviewsByShopId(int repairShopId);
}

