package com.boot.dto;

import java.security.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewDTO {
    private int id;
    private int repairShopId;
    private String userId;
    private int rating;
    private String content;
    private Timestamp createdAt;

    // Getters and Setters
}
