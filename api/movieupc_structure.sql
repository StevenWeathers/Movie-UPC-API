# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.34-MariaDB-1~precise)
# Database: movieupc
# Generation Time: 2014-08-03 01:01:34 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table upc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `upc`;

CREATE TABLE `upc` (
  `DVD_Title` varchar(256) NOT NULL,
  `Studio` varchar(256) DEFAULT NULL,
  `Released` varchar(256) DEFAULT NULL,
  `Status` varchar(256) DEFAULT NULL,
  `Sound` varchar(256) DEFAULT NULL,
  `Versions` varchar(256) DEFAULT NULL,
  `Price` varchar(128) DEFAULT NULL,
  `Rating` varchar(64) DEFAULT NULL,
  `Year` varchar(32) NOT NULL DEFAULT '',
  `Genre` varchar(128) DEFAULT NULL,
  `Aspect` varchar(128) DEFAULT NULL,
  `UPC` varchar(32) NOT NULL,
  `DVD_ReleaseDate` varchar(128) DEFAULT NULL,
  `ID` varchar(128) DEFAULT NULL,
  `Timestamp` varchar(128) DEFAULT NULL,
  `movieupc_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`movieupc_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
