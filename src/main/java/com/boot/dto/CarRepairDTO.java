package com.boot.dto;

import lombok.Data;

public class CarRepairDTO {
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public class RepairShopDTO {
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
}
