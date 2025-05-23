MySQL Table

CREATE TABLE `repair_shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `road_address` varchar(255) DEFAULT NULL,
  `lot_address` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `open_time` varchar(10) DEFAULT NULL,
  `close_time` varchar(10) DEFAULT NULL,
  `tel_number` varchar(20) DEFAULT NULL,
  `view_count` int default 0,
  PRIMARY KEY (`id`)
);

CREATE TABLE `user` (
`id` INT NOT NULL AUTO_INCREMENT,
`userid` VARCHAR(50) NOT NULL UNIQUE,
`password` VARCHAR(255) NOT NULL,
`nickname` VARCHAR(50) NOT NULL,
`email` VARCHAR(100) NOT NULL,
`phone_number` VARCHAR(20) DEFAULT NULL,
`region` VARCHAR(100) DEFAULT NULL,
`region_detail` VARCHAR(100) DEFAULT NULL,
`latitude` DOUBLE DEFAULT NULL,
`longitude` DOUBLE DEFAULT NULL,
`role` VARCHAR(20) NOT NULL DEFAULT 'USER',
`registration_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`id`)
);

CREATE TABLE `review` (
  `id` int AUTO_INCREMENT,
  `repairShopId` int,
  `userId` varchar(50),
  `rating` int NOT NULL,
  `content` text,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`repairShopId`) REFERENCES `repair_shop`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`userId`) REFERENCES `user`(`userid`) ON DELETE CASCADE,
  CONSTRAINT unique_user_shop_review UNIQUE (userId, repairShopId)
);

CREATE TABLE repair_shop_request (
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   road_address VARCHAR(255),
   lot_address VARCHAR(255),
   registration_date DATE,
   open_time VARCHAR(10),
   close_time VARCHAR(10),
   tel_number VARCHAR(20),
   request_user_id varchar(50),
   FOREIGN KEY (`request_user_id`) REFERENCES `user`(`userid`) ON DELETE CASCADE,
   status VARCHAR(20) DEFAULT 'PENDING' -- PENDING, APPROVED, REJECTED
);

CREATE TABLE inspection_center (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(20),
    road_address VARCHAR(255),
    lot_address VARCHAR(255),
    latitude DOUBLE,
    longitude DOUBLE,
    tel VARCHAR(30),
    oper_time VARCHAR(100), 
    lane_count INT, 
    engineer_count INT, 
    new_insp_yn CHAR(1),
    fdrm_insp_yn CHAR(1), 
    tuning_insp_yn CHAR(1),
    temp_insp_yn CHAR(1), 
    repair_insp_yn CHAR(1),
    exhstGas_insp_yn CHAR(1),
    taxi_meter_yn CHAR(1), 
    registration_date DATE,
    view_count int default 0
);

CREATE TABLE bookmark (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    repair_shop_id INT NOT NULL,
    CONSTRAINT fk_bookmark_user FOREIGN KEY (user_id) REFERENCES user(userid) ON DELETE CASCADE,
    CONSTRAINT fk_bookmark_repair_shop FOREIGN KEY (repair_shop_id) REFERENCES repair_shop(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_shop (user_id, repair_shop_id)  -- 중복 찜 방지
);
