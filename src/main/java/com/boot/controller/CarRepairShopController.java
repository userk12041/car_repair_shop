package com.boot.controller;

import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CarRepairShopController {

	private final RestTemplate restTemplate;

	@GetMapping("/searchRepairShop")
	public String searchRepairShop(Model model) {
		
		log.info("@# searchRepairShop");
		try {
			
			String serviceKey = "5LHvB05cdWMw+4axztYINRKf23z525pOvkVo4Z4fI0XIT8fsSc0zX6Qm9SFhy/IcuS/+hwZ8SU3fpKSaqEif4Q==";
			String apiUrl = "api.data.go.kr/openapi/tn_pubr_public_auto_maintenance_company_api" +
							"?serviceKey=" + URLEncoder.encode(serviceKey, "UTF-8") +
							"&pageNo=1" +
			                "&numOfRows=10" +
			                "&type=json";
	
			// API 호출
			String response = restTemplate.getForObject(apiUrl, String.class);
	
			// 전체 JSON 문자열 그대로 넘기는 테스트
			model.addAttribute("apiResult", response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "search"; // search.jsp
	}

}
