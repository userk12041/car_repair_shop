package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.dto.RequestDTO;

@Mapper
public interface RequestDAO {
	void insertRequest(RequestDTO dto);
	List<RequestDTO> findAllPending();
	void updateStatus(@Param("id") int id, @Param("status") String status); // 승인/거절
	RequestDTO findById(int id);
}
