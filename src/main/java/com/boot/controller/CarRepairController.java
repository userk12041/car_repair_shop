package com.boot.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.boot.dto.InspectionCenterDTO;
import com.boot.dto.SyncResultDTO;
import com.boot.service.CarRapairInspectionService;
import com.boot.service.CarRepairService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CarRepairController {

	private final CarRepairService carRepairService;
	@Autowired
	private CarRapairInspectionService inspectionService;
	
	@GetMapping("/saveRepairShopData")	//API -> DB 정보 저장 메서드
	public String saveRepairShopData() {
		carRepairService.saveInitialRepairShopData();
		return "redirect:/admin/repairShop/list";
	}
	
	@PostMapping("/admin/repairShop/sync")	//API 동기화 -> DB 갱신 메서드
	public String syncRepairShop(HttpSession session) {
		SyncResultDTO result = carRepairService.syncFromAPI();
		session.setAttribute("syncResult", result); // 리다이렉트 후 alert 출력용
		return "redirect:/admin/repairShop/list";
	}	
	
	@GetMapping("/main")
	public String mainPage() {
		return "main";
	}
	
	// 테스트용 세션 초기화 메서드
	@GetMapping("/session/reset")
	public String resetSession(HttpSession session) {
		session.invalidate(); // 세션 초기화
		return "redirect:/main"; // 메인 페이지로 리다이렉트
	}
	
    // test
    @GetMapping("/inspection")
	public String getInspection(Model model) throws IOException {
    	inspectionService.getInspectionData();
    	List<InspectionCenterDTO> list = inspectionService.getAllInspectionCenters();
    	model.addAttribute("inspectionCenters",list);
    	return "inspectionTest";
    }
    
    @GetMapping("/inspection/show")
	public String showInspection(Model model) throws IOException {
    	List<InspectionCenterDTO> list = inspectionService.getAllInspectionCenters();
    	model.addAttribute("inspectionCenters",list);
    	return "inspectionTest";
    }
}
