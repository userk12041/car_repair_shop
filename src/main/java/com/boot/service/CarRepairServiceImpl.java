package com.boot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.CarRepairDAO;
import com.boot.dto.CarRepairDTO;

@Service
public class CarRepairServiceImpl implements CarRepairService {

	@Autowired
	private CarRepairDAO carRepairDAO;

	@Override	//25.04.29 권준우
	public List<CarRepairDTO> searchByName(String name) {
		return carRepairDAO.findByName(name);
	}

	@Override	//25.04.29 권준우
	public int updateShop(CarRepairDTO dto) {
		return carRepairDAO.updateRepairShop(dto);
	}

	@Override	//25.04.29 권준우
	public int deleteShop(int id) {
		return carRepairDAO.deleteRepairShop(id);
	}

	@Override	//25.04.29 권준우
	public List<CarRepairDTO> getPagedShops(int pageNo, int pageSize) {
		int startRow = (pageNo - 1) * pageSize; // ex) 2페이지면 (2-1) * 20 = 20
		return carRepairDAO.findAllPaged(startRow, pageSize);
	}
	
	@Override	//25.04.29 권준우
	public CarRepairDTO getRepairShopById(int id) {
		return carRepairDAO.findById(id);
	}
	
	@Override	//25.04.29 권준우
	public int getTotalCount() {
		return carRepairDAO.countShops();
	}
}
