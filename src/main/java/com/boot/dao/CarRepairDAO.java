package com.boot.dao;

public class CarRepairDAO {
	List<CarRepairShopDTO> getAllRepairShops();

    List<CarRepairShopDTO> getRepairShopsInBounds(
            @Param("swLat") double swLat,
            @Param("swLng") double swLng,
            @Param("neLat") double neLat,
            @Param("neLng") double neLng
        );
}
