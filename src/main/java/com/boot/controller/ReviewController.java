package com.boot.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boot.dto.ReviewDTO;
import com.boot.dto.ReviewInspDTO;
import com.boot.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    // test용 삭제 가능
    @GetMapping("/review")
    public String list(@RequestParam int ShopId, Model model) {
        List<ReviewDTO> reviews = reviewService.getReviewsByShopId(ShopId);

        model.addAttribute("reviews", reviews);

        return "review_list";
    }
    
    @PostMapping("/review/insert")
    public String insertReview(@ModelAttribute ReviewDTO review,
                               HttpSession session,
                               @RequestParam("repairShopId") int repairShopId,
                               RedirectAttributes redirectAttributes) {
        // 로그인된 사용자 ID 가져오기
        String userId = (String) session.getAttribute("loginId");
        if (userId == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        review.setUserId(userId);
        review.setRepairShopId(repairShopId);
        reviewService.insertReview(review);

        return "redirect:/repairShop/view?id=" + repairShopId;
    }
    
    @PostMapping("/review/delete")
    public String deleteReview(@RequestParam("id") int reviewId, @RequestParam("repairShopId") int repairShopId) {
        reviewService.deleteReview(reviewId);
        return "redirect:/repairShop/view?id=" + repairShopId; // 삭제 후, 해당 업체의 상세 페이지로 리다이렉트
    }
    
    @PostMapping("/review/update")
    public String updateReview(@ModelAttribute ReviewDTO review,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null || !loginId.equals(review.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "수정 권한이 없습니다.");
            return "redirect:/login";
        }

        reviewService.updateReview(review);
        return "redirect:/repairShop/view?id=" + review.getRepairShopId();
    }
    
    // insp
    @PostMapping("/review/insert/insp")
    public String insertReview_insp(@ModelAttribute ReviewInspDTO review,
                               HttpSession session,
                               @RequestParam("insp_center_id") int insp_center_id,
                               RedirectAttributes redirectAttributes) {
        // 로그인된 사용자 ID 가져오기
        String userId = (String) session.getAttribute("loginId");
        if (userId == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/login";
        }
        log.info("/review/insert/insp");

        review.setUserId(userId);
        review.setInsp_center_id(insp_center_id);
        log.info(review.toString());
        reviewService.insertReviewInsp(review);
        log.info("insertReview_insp after");

        return "redirect:/inspectionCenter/inspview?id=" + insp_center_id;
    }
    
    @PostMapping("/review/delete/insp")
    public String deleteReview_insp(@RequestParam("id") int reviewId, @RequestParam("insp_center_id") int insp_center_id) {
        reviewService.deleteReviewInsp(reviewId);
        return "redirect:/inspectionCenter/inspview?id=" + insp_center_id; // 삭제 후, 해당 업체의 상세 페이지로 리다이렉트
    }
    
    @PostMapping("/review/update/insp")
    public String updateReview_insp(@ModelAttribute ReviewInspDTO review,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null || !loginId.equals(review.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "수정 권한이 없습니다.");
            return "redirect:/login";
        }

        reviewService.updateReviewInsp(review);
        return "redirect:/inspectionCenter/inspview?id=" + review.getInsp_center_id();
    }
    
}

