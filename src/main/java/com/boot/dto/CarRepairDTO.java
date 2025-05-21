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
	private String latitude;
	private String longitude;
	private String registration_date;
	private String open_time;
	private String close_time;	
	private String tel_number;	
	
	
}