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
	private String roadaddress;
	private String lotaddress;
	private String latitude;
	private String longitude;
	private String registration_date;
	private String opentime;
	private String closetime;	
	private String telnumber;	
	
}
