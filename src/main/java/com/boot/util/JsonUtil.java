package com.boot.util;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JsonUtil {
	
	private JsonUtil() {} // 인스턴스 생성 방지
	public static double safeParseDouble(JsonNode node, String fieldName) {
        String value = node.path(fieldName).asText();
        try {
            return (value == null || value.isBlank()) ? 0.0 : Double.parseDouble(value);
        } catch (NumberFormatException e) {
        	log.warn("⚠️ '{}' 필드 값 '{}' → double 파싱 실패", fieldName, value);
            return 0.0;
        }
    }
}
