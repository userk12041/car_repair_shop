package com.boot.service;

import java.util.List;

import com.boot.dto.CarRepairDTO;

public interface CarRepairService {
	
	//25.04.29 권준우 (메서드 4개)
	List<CarRepairDTO> getPagedShops(int pageNo, int pageSize);	// 정비소 조회(페이징 처리)
	List<CarRepairDTO> searchByName(String name);	// 정비소 이름으로 조회
	CarRepairDTO getRepairShopById(int id);	// 특정 정비소 1개 조회
	int updateShop(CarRepairDTO dto);
	int deleteShop(int id);
}
