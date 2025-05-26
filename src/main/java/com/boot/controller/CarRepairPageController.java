package com.boot.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dao.CarRepairDAO;
import com.boot.dao.InspectionCenterDAO;
import com.boot.dto.CarRepairDTO;
import com.boot.dto.InspectionCenterDTO;
import com.boot.dto.ReviewDTO;
import com.boot.dto.ReviewInspDTO;
import com.boot.service.CarRapairInspectionService;
import com.boot.service.CarRepairService;
import com.boot.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class CarRepairPageController {

    private final CarRepairDAO carRepairDAO;
    private final InspectionCenterDAO inspectionCenterDAO;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private CarRepairService carRepairService;
    @Autowired
    private CarRapairInspectionService carRapairInspectionService;

    @GetMapping("/repairShop/view")
    public String detailPage(@RequestParam("id") int id, HttpSession session, Model model) {
        CarRepairDTO shop = carRepairDAO.getRepairById(id);
        carRepairService.incrementViewCount(id);
        List<ReviewDTO> reviews = reviewService.getReviewsByShopId(id);
        String userId = (String) session.getAttribute("loginId");
        log.info("Controller /view userId=>"+userId);
        boolean hasReview = reviewService.hasReview(id, userId);
        
        model.addAttribute("reviews", reviews);
        model.addAttribute("shop", shop);
        model.addAttribute("hasReview", hasReview);
        return "view";  // view.jsp 로 이동
    }
    
    @GetMapping("/inspectionCenter/view")
    public String inspdetailPage(@RequestParam("id") int id, HttpSession session, Model model) {
    	InspectionCenterDTO shop = inspectionCenterDAO.getInspectionById(id);
    	carRapairInspectionService.incrementViewCount(id);
    	
    	List<ReviewInspDTO> reviews = reviewService.getReviewsByInspId(id);
    	String userId = (String) session.getAttribute("loginId");
    	log.info("Controller /view userId=>"+userId);
    	boolean hasReview = reviewService.hasReviewInsp(id, userId);
    	
    	model.addAttribute("reviews", reviews);
    	model.addAttribute("shop", shop);
    	 model.addAttribute("hasReview", hasReview);
    	return "inspview";
    }
}
