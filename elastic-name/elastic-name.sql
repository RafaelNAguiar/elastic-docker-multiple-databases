/*
 Navicat Premium Data Transfer

 Source Server         : elasticsearch
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : elastic

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 25/02/2020 21:49:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

create database elastic;

use elastic;

-- ----------------------------
-- Table structure for name
-- ----------------------------
DROP TABLE IF EXISTS `name`;
CREATE TABLE `name` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of name
-- ----------------------------
BEGIN;
INSERT INTO `name` VALUES (1, 'Sara');
INSERT INTO `name` VALUES (2, 'Manuela');
INSERT INTO `name` VALUES (3, 'Rosana');
INSERT INTO `name` VALUES (4, 'Francielly');
INSERT INTO `name` VALUES (5, 'Olívia');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
