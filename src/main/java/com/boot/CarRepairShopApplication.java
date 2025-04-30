package com.boot;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.boot.dao")
public class CarRepairShopApplication {

	public static void main(String[] args) {
		SpringApplication.run(CarRepairShopApplication.class, args);
	}

}
