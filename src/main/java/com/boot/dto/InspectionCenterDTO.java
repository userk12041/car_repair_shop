package com.boot.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InspectionCenterDTO {
	
	private int id;
	private String name;
	private String type;
	private String road_address;
	private String lot_address;
	private Double latitude;
	private Double longitude;
	private String tel;
	private String oper_time;
	private int lane_count; 
	private int engineer_count; 
	private String new_insp_yn;
	private String fdrm_insp_yn;
	private String tuning_insp_yn;
	private String temp_insp_yn;
	private String repair_insp_yn;
	private String exhstGas_insp_yn;
	private String taxi_meter_yn;
	private Date registration_date;
	private Integer view_count;
	
	// review의 평점 평균값 받아오기 위한 컴럼
	private Double avg_rating;
	// bookmarked 확인용
	private boolean bookmarked;

}