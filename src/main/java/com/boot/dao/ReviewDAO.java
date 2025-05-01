package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.boot.dto.ReviewDTO;

public interface ReviewDAO {
    // 특정 정비소 리뷰 목록
//    List<ReviewDTO> getReviewsByShopId(@Param("repairShopId") int repairShopId);
	List<ReviewDTO> getReviewsByShopId(int repairShopId);

//    // 페이징 처리
//    List<ReviewDTO> getReviewsByShopIdPaging(
//    		@Param("repairShopId") int repairShopId,
//    		@Param("offset") int offset,
//    		@Param("limit") int limit);
//
//    // 리뷰 개수
//    int countReviewsByShopId(int repairShopId);
    
}

