package com.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dao.CarRepairDAO;
import com.boot.dto.CarRepairDTO;

@RestController
@RequestMapping("/api/repairShops")
public class CarRepairApiController {

    @Autowired
    private CarRepairDAO carRepairDAO;

    @GetMapping
    public List<CarRepairDTO> getAllCarRepairs() {
        return carRepairDAO.getAllCarRepairs();
    }
    
    @GetMapping("/api/repairshops")
    public List<CarRepairDTO> getCarRepairInBounds(
            @RequestParam double swLat,
            @RequestParam double swLng,
            @RequestParam double neLat,
            @RequestParam double neLng) {

        return carRepairDAO.getCarRepairInBounds(swLat, swLng, neLat, neLng);
    }
    
    @GetMapping("/search")
    @ResponseBody
    public List<CarRepairDTO> searchShops(@RequestParam String keyword) {
        return carRepairDAO.listSearchByName(keyword);
    }
}
