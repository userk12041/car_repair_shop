package com.boot.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewInspDTO {
    private int id;
    private int insp_center_id;
    private String userId;
    private int rating;
    private String content;
    private Timestamp createdAt;
}
