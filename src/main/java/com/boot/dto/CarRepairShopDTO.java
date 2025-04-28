package com.boot.dto;

import lombok.Data;

public class CarRepairShopDTO {
	
	@Data
	public class RepairShopDTO {
		private Integer id;
		private String name;
		private String roadAddress;
		private String lotAddress;
		private String telNumber;
		private String registrationDate;
		private String openTime;
		private String closeTime;
	}
}
