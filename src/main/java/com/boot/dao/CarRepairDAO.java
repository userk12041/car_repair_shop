package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.dto.CarRepairDTO;

@Mapper
public interface CarRepairDAO {
	List<CarRepairDTO> getAllRepairShops();
	
	
    List<CarRepairDTO> getRepairShopsInBounds(
            @Param("swLat") double swLat,
            @Param("swLng") double swLng,
            @Param("neLat") double neLat,
            @Param("neLng") double neLng
        );
}
