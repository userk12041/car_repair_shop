package com.boot.dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.dto.InspectionCenterDTO;

@Mapper
public interface InspectionCenterDAO {
	void insert(InspectionCenterDTO dto);
	InspectionCenterDTO selectById(int id);
	List<InspectionCenterDTO> selectAll();
	InspectionCenterDTO findByNameAndDate(
			@Param("name") String name,
		    @Param("registration_date") Date registrationDate);
	void update(InspectionCenterDTO dto);

}
