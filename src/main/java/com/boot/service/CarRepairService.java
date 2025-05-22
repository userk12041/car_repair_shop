package com.boot.service;

import java.util.List;
import java.util.Map;

import com.boot.dto.CarRepairDTO;
import com.boot.dto.SyncResultDTO;

public interface CarRepairService {
	
	//25.04.29 권준우
	List<CarRepairDTO> getPagedShops(int pageNo, int pageSize);	// 정비소 조회
	List<CarRepairDTO> searchByName(String name);	// 정비소 이름으로 조회
	CarRepairDTO getRepairShopById(int id);	// 특정 정비소 1개 조회 (수정용)
	int updateShop(CarRepairDTO dto);	// 정비소 수정
	int deleteShop(int id);	// 정비소 삭제
	void insertShop(CarRepairDTO dto);	// 정비소 추가

	List<CarRepairDTO> getPagedShopsSorted(String sortField, String order, int page, int pageSize); // 정렬
	List<CarRepairDTO> getPagedSearchResults(String name, String sortField, String order, int page, int pageSize); // 검색 정렬
	int getTotalCount();	//정렬에 필요
	int getSearchCount(String name);	//정렬에 필요2

	public void saveInitialRepairShopData();	// API -> DB 저장
	SyncResultDTO syncFromAPI();	// API 동기화 -> DB 갱신
	void incrementViewCount(int id); // 조회수 증가
	static List<CarRepairDTO> search(String keyword, String sort) {
		// TODO Auto-generated method stub
		return null;
	}
	
	// test
	List<CarRepairDTO> findShopsWithRating(Map<String, Object> params);
}
