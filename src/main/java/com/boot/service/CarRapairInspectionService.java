package com.boot.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.boot.dto.CarRepairDTO;
import com.boot.dto.InspectionCenterDTO;

public interface CarRapairInspectionService {
	public void getInspectionData() throws IOException;
	public List<InspectionCenterDTO> getAllInspectionCenters();
	void incrementViewCount(int id);
	List<CarRepairDTO> findCenterWithRating(Map<String, Object> params);
}
