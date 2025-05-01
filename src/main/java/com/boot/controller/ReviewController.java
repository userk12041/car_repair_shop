package com.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dto.ReviewDTO;
import com.boot.service.ReviewService;

@Controller
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping("/review")
//    public String list(@RequestParam int repairShopId, @RequestParam(defaultValue = "1") int page, Model model) {
    public String list(@RequestParam int ShopId, Model model) {

//        int pageSize = 5;
//        int total = reviewService.countReviewsByShopId(repairShopId);
//        int totalPages = (int) Math.ceil((double) total / pageSize);

        List<ReviewDTO> reviews = reviewService.getReviewsByShopId(ShopId);

        model.addAttribute("reviews", reviews);
//        model.addAttribute("currentPage", page);
//        model.addAttribute("totalPages", totalPages);
//        model.addAttribute("repairShopId", repairShopId);

        return "review_list";  // review/list.jsp
    }
}

