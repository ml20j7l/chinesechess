/*
Navicat MySQL Data Transfer

Source Server         : 3306
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : rank

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2021-06-29 15:48:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for rank
-- ----------------------------
DROP TABLE IF EXISTS `rank`;
CREATE TABLE `user_data` (
  `username` varchar(255) NOT NULL,
  `num` int(10) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE 'CombatGains' (
  'userName' varchar(32) NOT NULL,
  'opponentName' varchar(32) NOT NULL,
  'gameResult' boolean,
  'gameTime' date,
  PRIMARY KEY ('userName')
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rank
-- ----------------------------


CREATE TABLE 'CombatGains' (
  'userName' varchar(32) NOT NULL,
  'opponentName' varchar(32) NOT NULL,
  PRIMARY KEY ('userName')
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE `CombatGains` (
  `userName` varchar(32) NOT NULL,
  `opponentName` varchar(32) NOT NULL,
  `gameResult` boolean,
  `gameTime` date,
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;