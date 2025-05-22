package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CarRepairDTO {
	
	private int id;
	private String name;
	private String road_address;
	private String lot_address;
	private Double latitude;
	private Double longitude;
	private String registration_date;
	private String open_time;
	private String close_time;	
	private String tel_number;
	private int view_count;
	
	// review의 평점 평균값 받아오기 위한 컴럼, repair_shop의 컬럼 아님
	private Double avg_rating;

}