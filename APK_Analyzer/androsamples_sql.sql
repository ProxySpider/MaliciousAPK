CREATE TABLE IF NOT EXISTS `androsamples` (
  `md5` varchar(50),
  `VTpositives` int DEFAULT 0,
  `package` varchar(255),
  `permissions` varchar(2000),
  `last_scan` varchar(20),
  `verdict` varchar(255),
  `positives` int DEFAULT 1  
   );
