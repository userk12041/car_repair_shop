package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.dto.CarRepairDTO;

@Mapper
public interface CarRepairDAO {
	List<CarRepairDTO> getAllCarRepairs();
	CarRepairDTO getRepairById(int id);
	
	// 좌표
    List<CarRepairDTO> getCarRepairInBounds(
            @Param("swLat") double swLat,
            @Param("swLng") double swLng,
            @Param("neLat") double neLat,
            @Param("neLng") double neLng
        );
    
    //25.05.01 김용철 검색 리스트
    List<CarRepairDTO> listSearchByName(@Param("keyword") String keyword);	
    
    //25.04.29 권준우
    List<CarRepairDTO> findAllPaged(@Param("startRow") int startRow, @Param("rowCount") int rowCount);
	List<CarRepairDTO> findByName(String name);
	CarRepairDTO findById(int id);
	int updateRepairShop(CarRepairDTO dto);
	int deleteRepairShop(int id);
	
	List<CarRepairDTO> findAllPagedSorted(@Param("sortField") String sortField,
            @Param("order") String order,
            @Param("startRow") int startRow,
            @Param("rowCount") int rowCount);
	List<CarRepairDTO> findPagedSearchSorted(@Param("name") String name,
            @Param("sortField") String sortField,
            @Param("order") String order,
            @Param("startRow") int startRow,
            @Param("rowCount") int rowCount);
	void insertShop(CarRepairDTO dto);	// API -> DB 저장
	int countShops();	// API 저장용
	
	List<CarRepairDTO> findByNameAndRoadAddress(@Param("name") String name, @Param("road_address") String road_address);	// API 갱신
	int updateShop(CarRepairDTO dto);	// API 갱신용
	
	int countSearchResults(@Param("name") String name);
}
