package com.boot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.boot.dao.CarRepairDAO;
import com.boot.dto.CarRepairDTO;
import com.boot.dto.SyncResultDTO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CarRepairServiceImpl implements CarRepairService {

	@Autowired
	private CarRepairDAO carRepairDAO;
	@Autowired
	private RestTemplate restTemplate;	

	@Override	//25.04.29 권준우
	public List<CarRepairDTO> searchByName(String name) {
		return carRepairDAO.findByName(name);
	}

	@Override	//25.04.29 권준우
	public int updateShop(CarRepairDTO dto) {
		return carRepairDAO.updateRepairShop(dto);
	}

	@Override	//25.04.29 권준우
	public int deleteShop(int id) {
		return carRepairDAO.deleteRepairShop(id);
	}

	@Override	//25.04.29 권준우
	public List<CarRepairDTO> getPagedShops(int pageNo, int pageSize) {
		int startRow = (pageNo - 1) * pageSize; // ex) 2페이지면 (2-1) * 20 = 20
		return carRepairDAO.findAllPaged(startRow, pageSize);
	}
	
	@Override	//25.04.29 권준우
	public CarRepairDTO getRepairShopById(int id) {
		return carRepairDAO.findById(id);
	}
	
	@Override	//25.04.29 권준우
	public int getTotalCount() {
		return carRepairDAO.countShops();
	}
	
	@Override	//25.04.29 권준우
	public List<CarRepairDTO> getPagedShopsSorted(String sortField, String order, int page, int pageSize) {
		int startRow = (page - 1) * pageSize;
		return carRepairDAO.findAllPagedSorted(sortField, order, startRow, pageSize);
	}
	
	@Override	//25.04.29 권준우
	public void insertShop(CarRepairDTO dto) {
		carRepairDAO.insertShop(dto);
	}
	
	@Override	//25.04.30 권준우 (API -> DB 최초 저장) 
	public void saveInitialRepairShopData() {
		log.info("@# saveInitialRepairShopData 시작");

		try {
			String serviceKey = "dyX6xt1gN2bRdwZi9wnVBU02Xl2/snngu69mYzVxO0mZvFhMzo96NIfl61okMnKATxRS17HNXksMcehLaLd8FA==";
			int pageNo = 1;
			int numOfRows = 1000;
			int totalCount = 0;
			int count = 0;
			boolean firstCall = true;

			while (true) {
				String apiUrl = "http://api.data.go.kr/openapi/tn_pubr_public_auto_maintenance_company_api"
						+ "?serviceKey=" + serviceKey
						+ "&pageNo=" + pageNo
						+ "&numOfRows=" + numOfRows
						+ "&type=json";

				HttpHeaders headers = new HttpHeaders();
				headers.add("Accept", "application/json");

				HttpEntity<String> entity = new HttpEntity<>(headers);
				ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);
				String responseBody = response.getBody();

				ObjectMapper mapper = new ObjectMapper();
				JsonNode root = mapper.readTree(responseBody);

				JsonNode bodyNode = root.path("response").path("body");

				// totalCount는 첫 호출에서만
				if (firstCall) {
					totalCount = bodyNode.path("totalCount").asInt();
					firstCall = false;
					log.info("총 데이터 개수: {}", totalCount);
				}

				JsonNode items = bodyNode.path("items");

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

						carRepairDAO.insertShop(dto);
						count++;

						if (count % 1000 == 0) {
							log.info("🔄 저장 진행 중... 현재까지 {}건 처리됨", count);
						}
					}
				}

				pageNo++;

				if ((pageNo - 1) * numOfRows >= totalCount) {
					break;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		log.info("@# saveInitialRepairShopData 끝");
	}
	
	@Override	//25.04.30 권준우 (API 동기화 -> DB 갱신) 
	public SyncResultDTO syncFromAPI() {
		log.info("@# syncFromAPI 시작");
		SyncResultDTO result = new SyncResultDTO();
		int inserted = 0, updated = 0, skipped = 0;

		try {
			String serviceKey = "dyX6xt1gN2bRdwZi9wnVBU02Xl2/snngu69mYzVxO0mZvFhMzo96NIfl61okMnKATxRS17HNXksMcehLaLd8FA==";
			String apiUrl = "http://api.data.go.kr/openapi/tn_pubr_public_auto_maintenance_company_api"
					+ "?serviceKey=" + serviceKey
					+ "&pageNo=1"
					+ "&numOfRows=1000"
					+ "&type=json";

			HttpHeaders headers = new HttpHeaders();
			headers.add("Accept", "application/json");

			HttpEntity<String> entity = new HttpEntity<>(headers);
			ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);
			String body = response.getBody();

			ObjectMapper mapper = new ObjectMapper();
			JsonNode items = mapper.readTree(body).path("response").path("body").path("items");

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

					List<CarRepairDTO> existingList = carRepairDAO.findByNameAndRoadAddress(dto.getName(), dto.getRoad_address());

					if (existingList.isEmpty()) {
						carRepairDAO.insertShop(dto);
						inserted++;
					} else {
						CarRepairDTO existing = existingList.get(0); // 첫 번째만 기준으로 사용
						if (!existing.equals(dto)) {
							carRepairDAO.updateShop(dto);
							updated++;
						} else {
							skipped++;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		result.setInsertedCount(inserted);
		result.setUpdatedCount(updated);
		result.setSkippedCount(skipped);
		
		log.info("@# syncFromAPI 끝");
		
		return result;
	}

}
