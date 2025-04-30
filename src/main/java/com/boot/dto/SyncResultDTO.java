package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SyncResultDTO {
	private int insertedCount;
	private int updatedCount;
	private int skippedCount;
}
