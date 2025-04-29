package com.boot.service;

import java.util.List;

import com.boot.dto.CarRepairDTO;

public interface CarRepairService {
	
	//25.04.29 권준우 (메서드 4개)
	List<CarRepairDTO> getPagedShops(int pageNo, int pageSize);
	List<CarRepairDTO> searchByName(String name);
	int updateShop(CarRepairDTO dto);
	int deleteShop(int id);
}
