package com.boot.service;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.InspectionCenterDAO;
import com.boot.dto.CarRepairDTO;
import com.boot.dto.InspectionCenterDTO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

import java.io.BufferedReader;
import java.io.IOException;

@Slf4j
@Service("CarRapairInspectionService")
public class CarRapairInspectionServiceImpl implements CarRapairInspectionService {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void getInspectionData() throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_car_inspofc_api"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=dyX6xt1gN2bRdwZi9wnVBU02Xl2/snngu69mYzVxO0mZvFhMzo96NIfl61okMnKATxRS17HNXksMcehLaLd8FA=="); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("800", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*XML/JSON 여부*/
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
//        System.out.println(sb.toString());
        
        String jsonStr = sb.toString();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(jsonStr);
        JsonNode items = root.path("response").path("body").path("items");
        
    	int inserted = 0;
    	int updated = 0;
    	int skipped = 0;
    	
        for (JsonNode item : items) {
        	InspectionCenterDTO dto = new InspectionCenterDTO();
        	dto.setName(item.path("inspofcNm").asText());
        	dto.setType(item.path("inspofcType").asText());
        	dto.setRoad_address(item.path("rdnmadr").asText());
        	dto.setLot_address(item.path("lnmadr").asText());
        	dto.setLatitude(item.path("latitude").asDouble());
        	dto.setLongitude(item.path("longitude").asDouble());
        	dto.setTel(item.path("inspofcPhoneNumber").asText());
        	dto.setOper_time(item.path("operTime").asText());
        	dto.setLane_count(item.path("inspofcCo").asInt());
        	dto.setEngineer_count(item.path("inspofcHnfCo").asInt());
        	dto.setNew_insp_yn(item.path("newInspofcYn").asText());
        	dto.setFdrm_insp_yn(item.path("fdrmInspofcYn").asText());
        	dto.setTuning_insp_yn(item.path("tuningInspofcYn").asText());
        	dto.setTemp_insp_yn(item.path("tempInspofcYn").asText());
        	dto.setRepair_insp_yn(item.path("repairInspofcYn").asText());
        	dto.setExhstGas_insp_yn(item.path("exhstGasInspofcYn").asText());
        	dto.setTaxi_meter_yn(item.path("taxiMeterYn").asText());
        	dto.setRegistration_date(null);
        	String dateStr = item.path("referenceDate").asText();
        	if(dateStr != null && !dateStr.isEmpty()) {
        		dto.setRegistration_date(Date.valueOf(dateStr));
        	}
        	
        	InspectionCenterDAO dao = sqlSession.getMapper(InspectionCenterDAO.class);
        	InspectionCenterDTO existing = dao.findByNameAndDate(dto.getName(), dto.getRegistration_date());
        	
        	if(existing == null) {
        		dao.insert(dto);
        		inserted++;
        	} else if (!existing.equals(dto)) {
        		dto.setId(existing.getId());
        		dao.update(dto);
        		updated++;
        	} else {
        		skipped++;
        	}
        }
        log.info("@# syncFromAPI 끝 - inserted: {}, updated: {}, skipped: {}", inserted, updated, skipped);
    }
    public List<InspectionCenterDTO> getAllInspectionCenters(){
    	InspectionCenterDAO dao = sqlSession.getMapper(InspectionCenterDAO.class);
    	return dao.selectAll();
    }
	@Override
	public void incrementViewCount(int id) {
		InspectionCenterDAO dao = sqlSession.getMapper(InspectionCenterDAO.class);
		dao.incrementViewCount(id);
	}
	
    @Override
    public List<CarRepairDTO> findCenterWithRating(Map<String, Object> params) {
    	log.info("findCenterWithRating params: "+params);
    	InspectionCenterDAO dao = sqlSession.getMapper(InspectionCenterDAO.class);
        return dao.findCenterWithRating(params);
    }
}