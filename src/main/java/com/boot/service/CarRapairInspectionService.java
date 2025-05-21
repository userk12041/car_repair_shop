package com.boot.service;

import java.io.IOException;
import java.util.List;

import com.boot.dto.InspectionCenterDTO;

public interface CarRapairInspectionService {
	public void getInspectionData() throws IOException;
	public List<InspectionCenterDTO> getAllInspectionCenters();
}
