package com.boot.controller;

import java.net.URLEncoder;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CarRepairController {

	private final RestTemplate restTemplate;

	@GetMapping("/searchRepairShop")
	public String searchRepairShop(Model model) {
		
		log.info("@# searchRepairShop");
		try {
			
			//Encoding 버전
			String serviceKey = "5LHvB05cdWMw%2B4axztYINRKf23z525pOvkVo4Z4fI0XIT8fsSc0zX6Qm9SFhy%2FIcuS%2F%2BhwZ8SU3fpKSaqEif4Q%3D%3D";
			//Decoding 버전
//			String serviceKey = "5LHvB05cdWMw+4axztYINRKf23z525pOvkVo4Z4fI0XIT8fsSc0zX6Qm9SFhy/IcuS/+hwZ8SU3fpKSaqEif4Q==";
			
//			String apiUrl = "https://jsonplaceholder.typicode.com/posts"; //무료 테스트 API
			String apiUrl = "http://api.data.go.kr/openapi/tn_pubr_public_auto_maintenance_company_api" +
//							"?serviceKey=" + URLEncoder.encode(serviceKey, "UTF-8") +
							"?serviceKey=" + serviceKey +
							"&pageNo=1" +
			                "&numOfRows=100" +
			                "&type=xml";
	
	
			// API 호출
//			String response = restTemplate.getForObject(apiUrl, String.class);
			
			HttpHeaders headers = new HttpHeaders();
//			headers.add("User-Agent", "Mozilla/5.0");
			
			headers.add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36");
			headers.add("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8");
			headers.add("Accept-Encoding", "gzip, deflate, br");
			headers.add("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
			headers.add("Connection", "keep-alive");
			headers.add("Upgrade-Insecure-Requests", "1");
			headers.add("Sec-Fetch-Dest", "document");
			headers.add("Sec-Fetch-Mode", "navigate");
			headers.add("Sec-Fetch-Site", "none");
			headers.add("Accept-Charset", "UTF-8"); // 추가로 붙이면 안정성 더 좋음
			

			HttpEntity<String> entity = new HttpEntity<>(headers);
			
			headers.add("Accept", "application/xml");  // ★ 추가!			

			ResponseEntity<String> response = restTemplate.exchange(
				apiUrl,
				HttpMethod.GET,
				entity,
				String.class
			);			
			
	
			// 전체 JSON 문자열 그대로 넘기는 테스트
			model.addAttribute("apiResult", response.getBody());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "search"; // search.jsp
	}
	@GetMapping("/map")
	public String mapPage() {
		return "map";  // /WEB-INF/views/map.jsp 로 이동
	}
}
