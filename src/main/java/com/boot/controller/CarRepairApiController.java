package com.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dao.CarRepairDAO;
import com.boot.dto.CarRepairDTO;
import com.boot.service.CarRapairInspectionService;
import com.boot.service.CarRepairService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller 
public class CarRepairApiController {


    @Autowired
    private CarRepairDAO carRepairDAO;
    @Autowired
    private CarRepairService carRepairService;
    @Autowired
    private CarRapairInspectionService carRapairInspectionService;

//    @GetMapping("/api/repairShops")
//    @ResponseBody
//    public List<CarRepairDTO> getAllCarRepairs() {
//        return carRepairDAO.getAllCarRepairs();
//    }
    
//    @GetMapping("/api/repairShops")
//    @ResponseBody
//    public List<CarRepairDTO> getCarRepairInBounds(
//            @RequestParam double swLat,
//            @RequestParam double swLng,
//            @RequestParam double neLat,
//            @RequestParam double neLng) {
//    	log.info("swLat={}, swLng={}, neLat={}, neLng={}",
//              swLat, swLng, neLat, neLng);
//        return carRepairDAO.getCarRepairInBounds(swLat, swLng, neLat, neLng);
//    }
    
    @GetMapping("/api/repairShops/search")
    @ResponseBody
    public List<CarRepairDTO> searchShops(@RequestParam String keyword) {
        return carRepairDAO.listSearchByName(keyword);
    }
//    @GetMapping("/api/repairShops/search")
//    public List<CarRepairDTO> searchShops(@RequestParam String keyword, @RequestParam(defaultValue = "recent") String sort) {
//        return CarRepairService.search(keyword, sort);
//    }

    
    // test
    @GetMapping("/api/repairShops")
    @ResponseBody
    public Object getRepairShopsWithRating(
        @RequestParam(required = false) String keyword,
        @RequestParam(required = false) String sort,
        @RequestParam(required = false) Double swLat,
        @RequestParam(required = false) Double swLng,
        @RequestParam(required = false) Double neLat,
        @RequestParam(required = false) Double neLng,
        @RequestParam(required = false) String shopType,
        @RequestParam(required = false) List<String> inspectionOptions,
        HttpSession session
    ) {
    	String userId = (String) session.getAttribute("loginId");
    	if(userId == null) userId = "";
    	log.info("Controller keyword={}, sort={}, userId={}", keyword, sort, userId);
    	
    	// 가져온 값들 출력
        System.out.println("keyword = " + keyword);
        System.out.println("shopType = " + shopType);
        System.out.println("inspectionOptions = " + inspectionOptions);
        
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("sort", sort);
        params.put("swLat", swLat);
        params.put("swLng", swLng);
        params.put("neLat", neLat);
        params.put("neLng", neLng);
        params.put("userId", userId);

        if ("inspection".equals(shopType)) {
        	params.put("inspectionOptions", inspectionOptions);
            return carRapairInspectionService.findCenterWithRating(params); // List<InspectionCenterDTO>
        } else {
            return carRepairService.findShopsWithRating(params); // List<CarRepairDTO>
        }    	
    }

}
