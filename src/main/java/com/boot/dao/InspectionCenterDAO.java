package com.boot.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.dto.CarRepairDTO;
import com.boot.dto.InspectionCenterDTO;

@Mapper
public interface InspectionCenterDAO {
	void insert(InspectionCenterDTO dto);
	List<InspectionCenterDTO> selectAll();
	InspectionCenterDTO findByNameAndDate(
			@Param("name") String name,
		    @Param("registration_date") Date registrationDate);
	void update(InspectionCenterDTO dto);
	InspectionCenterDTO getInspectionById(int id);
	void incrementViewCount(int id);
    List<CarRepairDTO> findCenterWithRating(Map<String, Object> params);
}
