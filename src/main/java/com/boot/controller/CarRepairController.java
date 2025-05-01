package com.boot.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import com.boot.dto.CarRepairDTO;
import com.boot.service.CarRepairService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CarRepairController {

	private final RestTemplate restTemplate;
	private final CarRepairService carRepairService;

	@GetMapping("/saveRepairShopData")
	public String saveRepairShopData(Model model) {
		log.info("@# saveRepairShopData 시작");

		try {
			String serviceKey = "dyX6xt1gN2bRdwZi9wnVBU02Xl2/snngu69mYzVxO0mZvFhMzo96NIfl61okMnKATxRS17HNXksMcehLaLd8FA=="; // 디코딩 버전
			String apiUrl = "http://api.data.go.kr/openapi/tn_pubr_public_auto_maintenance_company_api"
					+ "?serviceKey=" + serviceKey
					+ "&pageNo=1"
					+ "&numOfRows=1000"
					+ "&type=json"; // ★ JSON 요청

			HttpHeaders headers = new HttpHeaders();
			headers.add("Accept", "application/json");

			HttpEntity<String> entity = new HttpEntity<>(headers);

			ResponseEntity<String> response = restTemplate.exchange(
					apiUrl,
					HttpMethod.GET,
					entity,
					String.class
			);

			String responseBody = response.getBody();

			// JSON 파싱
			ObjectMapper mapper = new ObjectMapper();
			JsonNode root = mapper.readTree(responseBody);

			JsonNode items = root.path("response").path("body").path("items");
			
			System.out.println("item size: " + items.size());

			if (items.isArray()) {
				for (JsonNode item : items) {
					CarRepairDTO dto = new CarRepairDTO();

					dto.setName(item.path("inspofcNm").asText());
					dto.setRoad_address(item.path("rdnmadr").asText());
					dto.setLot_address(item.path("lnmadr").asText());
					dto.setLatitude(item.path("latitude").asText());
					dto.setLongitude(item.path("longitude").asText());
					dto.setRegistration_date(item.path("bizrnoDate").asText());
					dto.setOpen_time(item.path("operOpenHm").asText());
					dto.setClose_time(item.path("operCloseHm").asText());
					dto.setTel_number(item.path("phoneNumber").asText());

					carRepairService.insertShop(dto);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		log.info("@# saveRepairShopData 끝");

		return "redirect:/admin/repairShop/list"; // 저장 끝나면 관리자 리스트로 이동
	}
	
	@GetMapping("/main")
	public String mainPage() {
		return "main";
	}
}
