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
	public String listRepairShops(
		@RequestParam(value = "page", defaultValue = "1") int page,
		@RequestParam(value = "sortField", defaultValue = "id") String sortField,
		@RequestParam(value = "order", defaultValue = "asc") String order,
		@RequestParam(value = "name", required = false) String name,
		Model model
	) {
		log.info("@# listRepairShops");

		int pageSize = 20;

		int totalCount = (name != null && !name.isEmpty())
			? carRepairService.getSearchCount(name)
			: carRepairService.getTotalCount();

		int totalPage = (int) Math.ceil((double) totalCount / pageSize);

		List<CarRepairDTO> list = (name != null && !name.isEmpty())
			? carRepairService.getPagedSearchResults(name, sortField, order, page, pageSize)
			: carRepairService.getPagedShopsSorted(sortField, order, page, pageSize);

		// 페이지 블럭 계산 동일
		int pageBlock = 10;
		int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
		int endPage = Math.min(startPage + pageBlock - 1, totalPage);
		boolean hasPrev = startPage > 1;
		boolean hasNext = endPage < totalPage;

		model.addAttribute("list", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("hasPrev", hasPrev);
		model.addAttribute("hasNext", hasNext);
		model.addAttribute("sortField", sortField);
		model.addAttribute("order", order);
		model.addAttribute("name", name); // 검색 유지

		return "admin";
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
	
	// 관리자 인증 페이지 호출
	@GetMapping("/admin/auth")
	public String adminAuth() {
		return "admin_auth"; 
	}	
	
}
