package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RequestDTO {
	private int id;
	private String name;
	private String road_address;
	private String lot_address;
	private String registration_date;
	private String open_time;
	private String close_time;
	private String tel_number;
	private int request_user_id;
	private String status; // PENDING, APPROVED, REJECTED
}