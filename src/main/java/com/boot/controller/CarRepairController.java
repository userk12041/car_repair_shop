package com.boot.controller;

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

	@Autowired
	private CarRepairShopDAO carRepairShopDAO;
	private final RestTemplate restTemplate;

	@GetMapping("/searchRepairShop")
	public String searchRepairShop(Model model) {
		
		log.info("@# searchRepairShop");
		try {
			
			String serviceKey = "5LHvB05cdWMw%2B4axztYINRKf23z525pOvkVo4Z4fI0XIT8fsSc0zX6Qm9SFhy%2FIcuS%2F%2BhwZ8SU3fpKSaqEif4Q%3D%3D";
			String apiUrl = "http://api.data.go.kr/openapi/tn_pubr_public_auto_maintenance_company_api"+
//							"?serviceKey=" + URLEncoder.encode(serviceKey, "UTF-8") +
							"?serviceKey="+serviceKey+
							"&pageNo=1"+
			                "&numOfRows=100"+
			                "&type=xml";
			
	
			// API 호출
			String response = restTemplate.getForObject(apiUrl, String.class);
	
			// 전체 JSON 문자열 그대로 넘기는 테스트
			model.addAttribute("apiResult", response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "search"; // search.jsp
	}
	    @GetMapping
    public List<CarRepairShopDTO> getAllRepairShops() {
        return carRepairShopDAO.getAllRepairShops();
    }
    
    @GetMapping("/api/repairshops")
    public List<CarRepairShopDTO> getRepairShopsInBounds(
            @RequestParam double swLat,
            @RequestParam double swLng,
            @RequestParam double neLat,
            @RequestParam double neLng) {

        return carRepairShopDAO.getRepairShopsInBounds(swLat, swLng, neLat, neLng);
    }

}
