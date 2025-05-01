package com.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dto.CarRepairDTO;
import com.boot.service.CarRepairService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CarRepairAdminController {

	@Autowired
	private CarRepairService carRepairService;

	// 전체 조회 (페이지 + 페이징 블럭 처리)
	@GetMapping("/admin/repairShop/list")
	public String listRepairShops(@RequestParam(value = "page", defaultValue = "1") int page,
									@RequestParam(value = "sortField", defaultValue = "id") String sortField,
									@RequestParam(value = "order", defaultValue = "asc") String order,
									Model model) {
		log.info("@# listRepairShops");

		int pageSize = 20; // 한 페이지에 보여줄 데이터 수
		int totalCount = carRepairService.getTotalCount(); // 전체 게시물 수
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);

		// 현재 페이지 기준 데이터 조회
//		List<CarRepairDTO> list = carRepairService.getPagedShops(page, pageSize);
		List<CarRepairDTO> list = carRepairService.getPagedShopsSorted(sortField, order, page, pageSize);

		// 페이지 블럭 계산
		int pageBlock = 10; // 한 번에 보여줄 페이지 수
		int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
		int endPage = Math.min(startPage + pageBlock - 1, totalPage);
		boolean hasPrev = startPage > 1;
		boolean hasNext = endPage < totalPage;

		// Model 전달
		model.addAttribute("list", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("hasPrev", hasPrev);
		model.addAttribute("hasNext", hasNext);
		model.addAttribute("sortField", sortField);
		model.addAttribute("order", order);

		return "admin"; // => admin.jsp
	}
	
	// 이름으로 검색
	@GetMapping("/admin/repairShop/search")
	public String searchRepairShops(@RequestParam("name") String name, Model model) {
		log.info("@# searchRepairShops");
		
		List<CarRepairDTO> list = carRepairService.searchByName(name);
		model.addAttribute("list", list);
		return "admin";
	}

	// 수정 적용
	@PostMapping("/admin/repairShop/update")
	public String updateRepairShop(CarRepairDTO dto, @RequestParam(value = "page", defaultValue = "1") int page) {
		log.info("@# updateRepairShops");
		
		carRepairService.updateShop(dto);
		return "redirect:/admin/repairShop/list?page=" + page + "&updateSuccess=true"; // 수정 후 목록으로 리다이렉트
	}
	
	// 수정 페이지로 이동
	@GetMapping("/admin/repairShop/edit")
	public String editRepairShop(@RequestParam("id") int id, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		log.info("@# editRepairShop, id = " + id);

		CarRepairDTO repairShop = carRepairService.getRepairShopById(id);
		model.addAttribute("repairShop", repairShop);
		model.addAttribute("currentPage", page);

		return "admin_edit"; // => /WEB-INF/views/admin_edit.jsp
	}

	// 삭제
	@GetMapping("/admin/repairShop/delete")
	public String deleteRepairShop(@RequestParam("id") int id, @RequestParam(value = "page", defaultValue = "1") int page) {
		log.info("@# deleteRepairShop, id = " + id);
		
		carRepairService.deleteShop(id);
		return "redirect:/admin/repairShop/list?page=" + page + "&deleteSuccess=true"; // 삭제 후 목록으로 리다이렉트
	}
	
	// 정렬
	@GetMapping("/admin/repairShop/sort")
	public String sortRepairShops(@RequestParam(value = "sortField", defaultValue = "id") String sortField,
	                              @RequestParam(value = "order", defaultValue = "asc") String order,
	                              @RequestParam(value = "page", defaultValue = "1") int page,
	                              Model model) {

		int pageSize = 20;
		List<CarRepairDTO> list = carRepairService.getPagedShopsSorted(sortField, order, page, pageSize);

		model.addAttribute("list", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("sortField", sortField);
		model.addAttribute("order", order);
		return "admin";
	}
	
	@GetMapping("/admin/auth")
	public String adminAuth() {
		return "admin_auth"; // → /WEB-INF/views/admin_auth.jsp 로 포워딩됨
	}	
	
}
