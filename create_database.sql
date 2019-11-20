CREATE DATABASE vanhack;


CREATE TABLE vanhack.user (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `message` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) 
