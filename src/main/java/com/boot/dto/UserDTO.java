package com.boot.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
	private int id;
    private String userId;
    private String password;
    private String nickname;
    private String email;
    private String phoneNumber;
    private String region;
    private String role;
    private LocalDateTime registrationDate;
}
