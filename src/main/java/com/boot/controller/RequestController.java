package com.boot.controller;

import java.util.List;

import com.boot.dto.RequestDTO;
import com.boot.dto.CarRepairDTO;
import com.boot.service.CarRepairService;
import com.boot.service.RequestService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@Slf4j
public class RequestController {

	private final RequestService requestService;
	private final CarRepairService carRepairService;

	// 신청 폼 페이지
	@GetMapping("/repairShop/request")
	public String requestForm() {
		return "request_form";
	}

	// 신청 등록 처리
	@PostMapping("/repairShop/request")
	public String submitRequest(RequestDTO dto, Model model) {
		log.info("@# 신청 접수: " + dto.toString());
		requestService.submitRequest(dto);
		model.addAttribute("msg", "정비소 신청이 완료되었습니다.");
		return "request_result"; // 신청 완료 메시지 보여주는 JSP
	}
	
	// 신청 목록 조회 (관리자용)
	@GetMapping("/admin/repairShop/requests")
	public String viewRepairRequests(Model model) {
		log.info("@# viewRepairRequests");
		List<RequestDTO> list = requestService.getPendingRequests();
		model.addAttribute("requestList", list);
		return "admin_requests";  // /WEB-INF/views/admin_requests.jsp
	}

	// 신청 승인 처리
	@PostMapping("/admin/repairShop/approve")
	public String approveRequest(@RequestParam("id") int id) {
		log.info("@# approveRequest: {}", id);
		RequestDTO request = requestService.getRequestById(id);
		
		if (request != null) {
			CarRepairDTO newShop = new CarRepairDTO();
			newShop.setName(request.getName());
			newShop.setRoad_address(request.getRoad_address());
			newShop.setLot_address(request.getLot_address());
			newShop.setRegistration_date(request.getRegistration_date());
			newShop.setOpen_time(request.getOpen_time());
			newShop.setClose_time(request.getClose_time());
			newShop.setTel_number(request.getTel_number());

			carRepairService.insertShop(newShop); // 정식 테이블로 insert
			requestService.changeStatus(id, "APPROVED"); // 삭제 대신 상태 변경
		}
		
		return "redirect:/admin/repairShop/requests";
	}

	// 신청 거절 처리
	@PostMapping("/admin/repairShop/reject")
	public String rejectRequest(@RequestParam("id") int id) {
		log.info("@# rejectRequest: {}", id);
		requestService.changeStatus(id, "REJECTED"); // 삭제 대신 상태 변경
		return "redirect:/admin/repairShop/requests";
	}
}
