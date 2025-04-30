package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.dto.CarRepairDTO;

@Mapper
public interface CarRepairDAO {
	List<CarRepairDTO> getAllRepairShops();
	List<CarRepairDTO> getAllCarRepairs();
	CarRepairDTO getRepairById(int id);
	
    List<CarRepairDTO> getRepairShopsInBounds(
            @Param("swLat") double swLat,
            @Param("swLng") double swLng,
            @Param("neLat") double neLat,
            @Param("neLng") double neLng
        );
    
    //25.04.29 권준우
    List<CarRepairDTO> findAllPaged(@Param("startRow") int startRow, @Param("rowCount") int rowCount);
	List<CarRepairDTO> findByName(String name);
	CarRepairDTO findById(int id);
	int updateRepairShop(CarRepairDTO dto);
	int deleteRepairShop(int id);
	int countShops();
	List<CarRepairDTO> findAllPagedSorted(@Param("sortField") String sortField,
            @Param("order") String order,
            @Param("startRow") int startRow,
            @Param("rowCount") int rowCount);
	
	void insertShop(CarRepairDTO dto);	// API -> DB 저장
}
