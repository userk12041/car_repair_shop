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
    
    //25.04.29 권준우 (메서드 4개)
    List<CarRepairDTO> findAllPaged(@Param("startRow") int startRow, @Param("rowCount") int rowCount);
	List<CarRepairDTO> findByName(String name);
	int updateRepairShop(CarRepairDTO dto);
	int deleteRepairShop(int id);
}
