package com.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dao.CarRepairDAO;
import com.boot.dto.CarRepairDTO;

@RestController
@RequestMapping("/api/repairShops")
public class CarRepairApiController {

    @Autowired
    private CarRepairDAO carRepairShopDAO;

    @GetMapping
    public List<CarRepairDTO> getAllRepairShops() {
        return carRepairShopDAO.getAllRepairShops();
    }
    
    @GetMapping("/api/repairshops")
    public List<CarRepairDTO> getRepairShopsInBounds(
            @RequestParam double swLat,
            @RequestParam double swLng,
            @RequestParam double neLat,
            @RequestParam double neLng) {

        return carRepairShopDAO.getRepairShopsInBounds(swLat, swLng, neLat, neLng);
    }
}
