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

@Controller
public class CarRepairAdminController {

	@Autowired
	private CarRepairService carRepairService;

	// 전체 조회
	@GetMapping("/admin/repairShop/list")
	public String listRepairShops(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		int pageSize = 20; // 한 페이지당 20개
		List<CarRepairDTO> list = carRepairService.getPagedShops(page, pageSize);
		model.addAttribute("list", list);
		model.addAttribute("currentPage", page);
		return "admin";
	}
	
/*
	@GetMapping("/admin/repairShop/list")
	public String listRepairShops(Model model) {
		List<CarRepairDTO> list = carRepairService.getAllShops();
		model.addAttribute("list", list);
		return "admin/repairShop/list"; // => /WEB-INF/views/admin/repairShop/list.jsp
	}
*/
	
	// 이름으로 검색
	@GetMapping("/admin/repairShop/search")
	public String searchRepairShops(@RequestParam("name") String name, Model model) {
		List<CarRepairDTO> list = carRepairService.searchByName(name);
		model.addAttribute("list", list);
		return "admin/repairShop/list"; // 검색 결과도 list.jsp로 보여줄거야
	}

	// 수정 (폼으로부터 POST 요청 받는다고 가정)
	@PostMapping("/admin/repairShop/update")
	public String updateRepairShop(CarRepairDTO dto) {
		carRepairService.updateShop(dto);
		return "redirect:/admin/repairShop/list"; // 수정 후 목록으로 리다이렉트
	}

	// 삭제
	@GetMapping("/admin/repairShop/delete")
	public String deleteRepairShop(@RequestParam("id") int id) {
		carRepairService.deleteShop(id);
		return "redirect:/admin/repairShop/list"; // 삭제 후 목록으로 리다이렉트
	}
}
