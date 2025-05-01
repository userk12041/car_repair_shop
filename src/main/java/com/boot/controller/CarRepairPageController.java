package com.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dao.CarRepairDAO;
import com.boot.dto.CarRepairDTO;
import com.boot.dto.ReviewDTO;
import com.boot.service.ReviewService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/repairShop")
@RequiredArgsConstructor
public class CarRepairPageController {

    private final CarRepairDAO carRepairDAO;
    @Autowired
    private ReviewService reviewService;

    @GetMapping("/view")
    public String detailPage(@RequestParam("id") int id, Model model) {
        CarRepairDTO shop = carRepairDAO.getRepairById(id);
        List<ReviewDTO> reviews = reviewService.getReviewsByShopId(id);
        model.addAttribute("reviews", reviews);
        model.addAttribute("shop", shop);
        return "view";  // view.jsp 로 이동
    }
}
