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
//    public List<ReviewDTO> getReviewsByShopId(int repairShopId, int page, int size) {
    public List<ReviewDTO> getReviewsByShopId(int ShopId) {
        ReviewDAO reviewDAO = sqlSession.getMapper(ReviewDAO.class);
//        int offset = (page - 1) * size;
//        return reviewDAO.getReviewsByShopIdPaging(ShopId, offset, size);
        return reviewDAO.getReviewsByShopId(ShopId);
    }

//    @Override
//    public int countReviewsByShopId(int repairShopId) {
//        ReviewDAO reviewDAO = sqlSession.getMapper(ReviewDAO.class);
//        return reviewDAO.countReviewsByShopId(repairShopId);
//    }
}


