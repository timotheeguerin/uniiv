-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: uniiv_development
-- ------------------------------------------------------
-- Server version	5.5.31-0ubuntu0.13.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `badges_sashes`
--

DROP TABLE IF EXISTS `badges_sashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges_sashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `badge_id` int(11) DEFAULT NULL,
  `sash_id` int(11) DEFAULT NULL,
  `notified_user` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_badges_sashes_on_badge_id_and_sash_id` (`badge_id`,`sash_id`),
  KEY `index_badges_sashes_on_badge_id` (`badge_id`),
  KEY `index_badges_sashes_on_sash_id` (`sash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges_sashes`
--

LOCK TABLES `badges_sashes` WRITE;
/*!40000 ALTER TABLE `badges_sashes` DISABLE KEYS */;
/*!40000 ALTER TABLE `badges_sashes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_exprs`
--

DROP TABLE IF EXISTS `course_exprs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_exprs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_course_exprs_on_node_id` (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_exprs`
--

LOCK TABLES `course_exprs` WRITE;
/*!40000 ALTER TABLE `course_exprs` DISABLE KEYS */;
INSERT INTO `course_exprs` VALUES (9,9,'2013-07-30 21:04:43','2013-07-30 21:04:43'),(10,12,'2013-08-02 14:46:35','2013-08-02 14:46:35'),(11,13,'2013-08-02 14:48:08','2013-08-02 14:48:08'),(12,14,'2013-08-02 14:49:12','2013-08-02 14:49:12'),(13,17,'2013-08-02 14:51:26','2013-08-02 14:51:26'),(14,18,'2013-08-05 21:24:19','2013-08-05 21:24:19'),(15,19,'2013-08-05 21:24:32','2013-08-05 21:24:32'),(16,20,'2013-08-07 18:38:34','2013-08-07 18:38:34'),(17,21,'2013-08-07 18:39:16','2013-08-07 18:39:16'),(18,22,'2013-08-07 18:39:30','2013-08-07 18:39:30'),(19,23,'2013-08-07 18:39:41','2013-08-07 18:39:41'),(20,24,'2013-08-07 18:39:53','2013-08-07 18:39:53'),(21,25,'2013-08-07 18:44:23','2013-08-07 18:44:23'),(22,26,'2013-08-07 18:48:41','2013-08-07 18:48:41'),(23,27,'2013-08-07 18:52:59','2013-08-07 18:52:59'),(24,30,'2013-08-07 18:54:05','2013-08-07 18:54:05'),(25,31,'2013-08-07 18:54:56','2013-08-07 18:54:56'),(26,34,'2013-08-07 18:55:40','2013-08-07 18:55:40'),(27,35,'2013-08-07 18:55:41','2013-08-07 18:55:41'),(28,38,'2013-08-07 18:56:58','2013-08-07 18:56:58'),(29,41,'2013-08-07 18:58:03','2013-08-07 18:58:03'),(30,42,'2013-08-07 19:05:01','2013-08-07 19:05:01'),(31,45,'2013-08-07 19:17:51','2013-08-07 19:17:51'),(32,48,'2013-08-07 20:37:37','2013-08-07 20:37:37'),(33,49,'2013-08-07 20:41:01','2013-08-07 20:41:01'),(34,50,'2013-08-07 20:43:21','2013-08-07 20:43:21'),(36,52,'2013-08-07 20:51:44','2013-08-07 20:51:44'),(37,53,'2013-08-07 20:54:34','2013-08-07 20:54:34');
/*!40000 ALTER TABLE `course_exprs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_grading_system_entities`
--

DROP TABLE IF EXISTS `course_grading_system_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_grading_system_entities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` float DEFAULT NULL,
  `pass` tinyint(1) DEFAULT NULL,
  `pass_core` tinyint(1) DEFAULT NULL,
  `system_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_course_grading_system_entities_on_system_id` (`system_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_grading_system_entities`
--

LOCK TABLES `course_grading_system_entities` WRITE;
/*!40000 ALTER TABLE `course_grading_system_entities` DISABLE KEYS */;
INSERT INTO `course_grading_system_entities` VALUES (2,'A',4,1,1,2,'2013-08-05 14:12:28','2013-08-05 14:26:24'),(3,'A-',3.7,1,1,2,'2013-08-05 14:17:54','2013-08-05 14:26:16'),(4,'B+',3.3,1,1,2,'2013-08-05 14:18:09','2013-08-05 14:26:02'),(5,'B',3,1,1,2,'2013-08-05 14:18:19','2013-08-05 14:25:57'),(6,'B-',2.7,1,1,2,'2013-08-05 14:19:25','2013-08-05 14:25:40'),(7,'C+',2.3,1,1,2,'2013-08-05 14:19:39','2013-08-05 14:25:24'),(8,'C',2,1,1,2,'2013-08-05 14:19:55','2013-08-05 14:25:18'),(9,'D',1,1,0,2,'2013-08-05 14:20:20','2013-08-05 14:25:12'),(10,'F',0,0,0,2,'2013-08-05 14:20:27','2013-08-05 14:25:05');
/*!40000 ALTER TABLE `course_grading_system_entities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_grading_systems`
--

DROP TABLE IF EXISTS `course_grading_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_grading_systems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_grading_systems`
--

LOCK TABLES `course_grading_systems` WRITE;
/*!40000 ALTER TABLE `course_grading_systems` DISABLE KEYS */;
INSERT INTO `course_grading_systems` VALUES (2,'GPA','2013-08-05 14:15:24','2013-08-05 14:15:24');
/*!40000 ALTER TABLE `course_grading_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_nodes`
--

DROP TABLE IF EXISTS `course_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_course_nodes_on_parent_id` (`parent_id`),
  KEY `index_course_nodes_on_course_id` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_nodes`
--

LOCK TABLES `course_nodes` WRITE;
/*!40000 ALTER TABLE `course_nodes` DISABLE KEYS */;
INSERT INTO `course_nodes` VALUES (9,'OR',NULL,NULL,'2013-07-30 21:04:43','2013-07-30 21:04:43'),(10,'NODE',9,9,'2013-07-30 21:04:43','2013-07-30 21:04:43'),(11,'NODE',9,8,'2013-07-30 21:04:43','2013-07-30 21:04:43'),(12,'NODE',NULL,9,'2013-08-02 14:46:35','2013-08-02 14:46:35'),(13,'NODE',NULL,11,'2013-08-02 14:48:08','2013-08-02 14:48:08'),(14,'AND',NULL,NULL,'2013-08-02 14:49:12','2013-08-02 14:49:12'),(15,'NODE',14,11,'2013-08-02 14:49:12','2013-08-02 14:49:12'),(16,'NODE',14,12,'2013-08-02 14:49:12','2013-08-02 14:49:12'),(17,'NODE',NULL,16,'2013-08-02 14:51:26','2013-08-02 14:51:26'),(18,'NODE',NULL,13,'2013-08-05 21:24:19','2013-08-05 21:24:19'),(19,'NODE',NULL,14,'2013-08-05 21:24:32','2013-08-05 21:24:32'),(20,'NODE',NULL,49,'2013-08-07 18:38:34','2013-08-07 18:38:34'),(21,'NODE',NULL,50,'2013-08-07 18:39:16','2013-08-07 18:39:16'),(22,'NODE',NULL,40,'2013-08-07 18:39:30','2013-08-07 18:39:30'),(23,'NODE',NULL,43,'2013-08-07 18:39:41','2013-08-07 18:39:41'),(24,'NODE',NULL,42,'2013-08-07 18:39:53','2013-08-07 18:39:53'),(25,'NODE',NULL,19,'2013-08-07 18:44:23','2013-08-07 18:44:23'),(26,'NODE',NULL,24,'2013-08-07 18:48:41','2013-08-07 18:48:41'),(27,'AND',NULL,NULL,'2013-08-07 18:52:59','2013-08-07 18:52:59'),(28,'NODE',27,20,'2013-08-07 18:52:59','2013-08-07 18:52:59'),(29,'NODE',27,24,'2013-08-07 18:52:59','2013-08-07 18:52:59'),(30,'NODE',NULL,20,'2013-08-07 18:54:05','2013-08-07 18:54:05'),(31,'AND',NULL,NULL,'2013-08-07 18:54:56','2013-08-07 18:54:56'),(32,'NODE',31,20,'2013-08-07 18:54:56','2013-08-07 18:54:56'),(33,'NODE',31,23,'2013-08-07 18:54:56','2013-08-07 18:54:56'),(34,'NODE',NULL,23,'2013-08-07 18:55:40','2013-08-07 18:55:40'),(35,'AND',NULL,NULL,'2013-08-07 18:55:41','2013-08-07 18:55:41'),(36,'NODE',35,18,'2013-08-07 18:55:41','2013-08-07 18:55:41'),(37,'NODE',35,42,'2013-08-07 18:55:41','2013-08-07 18:55:41'),(38,'AND',NULL,NULL,'2013-08-07 18:56:58','2013-08-07 18:56:58'),(39,'NODE',38,20,'2013-08-07 18:56:58','2013-08-07 18:56:58'),(40,'NODE',38,21,'2013-08-07 18:56:58','2013-08-07 18:56:58'),(41,'NODE',NULL,18,'2013-08-07 18:58:03','2013-08-07 18:58:03'),(42,'AND',NULL,NULL,'2013-08-07 19:05:01','2013-08-07 19:05:01'),(43,'NODE',42,40,'2013-08-07 19:05:01','2013-08-07 19:05:01'),(44,'NODE',42,42,'2013-08-07 19:05:01','2013-08-07 19:05:01'),(45,'AND',NULL,NULL,'2013-08-07 19:17:51','2013-08-07 19:17:51'),(46,'NODE',45,18,'2013-08-07 19:17:51','2013-08-07 19:17:51'),(47,'NODE',45,43,'2013-08-07 19:17:51','2013-08-07 19:17:51'),(48,'NODE',NULL,67,'2013-08-07 20:37:37','2013-08-07 20:37:37'),(49,'NODE',NULL,34,'2013-08-07 20:41:01','2013-08-07 20:41:01'),(50,'NODE',NULL,35,'2013-08-07 20:43:21','2013-08-07 20:43:21'),(51,'NODE',NULL,35,'2013-08-07 20:43:21','2013-08-07 20:43:21'),(52,'NODE',NULL,76,'2013-08-07 20:51:44','2013-08-07 20:51:44'),(53,'NODE',NULL,36,'2013-08-07 20:54:34','2013-08-07 20:54:34');
/*!40000 ALTER TABLE `course_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_subjects`
--

DROP TABLE IF EXISTS `course_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_course_subjects_on_university_id` (`university_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_subjects`
--

LOCK TABLES `course_subjects` WRITE;
/*!40000 ALTER TABLE `course_subjects` DISABLE KEYS */;
INSERT INTO `course_subjects` VALUES (1,'COMP','Computer Science',1,'2013-07-22 20:15:23','2013-07-22 20:15:23'),(2,'MATH','Mathematics and Statistics',1,'2013-07-29 18:07:16','2013-07-29 18:20:32'),(3,'MGCR','Management Core',1,'2013-08-07 16:29:31','2013-08-07 16:29:31'),(4,'INSY','Information Systems',1,'2013-08-07 16:33:04','2013-08-07 16:33:04'),(5,'FINE','Finance',1,'2013-08-07 16:42:20','2013-08-07 16:42:20'),(6,'MGSC','Management Science',1,'2013-08-07 17:16:23','2013-08-07 17:16:23'),(7,'ACCT','Accounting',1,'2013-08-07 17:30:23','2013-08-07 17:30:23'),(8,'ECON','Economics',1,'2013-08-07 18:12:41','2013-08-07 18:12:41'),(9,'BUSA','Business Administration',1,'2013-08-07 19:22:46','2013-08-07 19:22:46');
/*!40000 ALTER TABLE `course_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `hours` int(11) DEFAULT NULL,
  `credit` float DEFAULT NULL,
  `prerequisite_id` int(11) DEFAULT NULL,
  `corequisite_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_courses_on_subject_id` (`subject_id`),
  KEY `index_courses_on_prerequisite_id` (`prerequisite_id`),
  KEY `index_courses_on_corequisite_id` (`corequisite_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (8,'Foundations of Programming',1,202,'Computer Science (Sci) : Introduction to programming in a modern high-level language, modular software design and debugging. Programming concepts are illustrated using a variety of application areas.',3,3,NULL,NULL,'2013-07-30 21:00:06','2013-07-30 21:00:06'),(9,'Introduction to Computer Science',1,250,'Computer Science (Sci) : An introduction to the design of computer algorithms, including basic data structures, analysis of algorithms, and establishing correctness of programs. Overview of topics in computer science.',3,3,NULL,NULL,'2013-07-30 21:00:34','2013-07-30 21:00:34'),(10,'Introduction to Computer Systems',1,206,'Computer Science (Sci) : Comprehensive overview of programming in C, use of system calls and libraries, debugging and testing of code; use of developmental tools like make, version control systems.',3,3,9,NULL,'2013-07-30 21:01:11','2013-07-30 21:04:59'),(11,'Algorithms and Data Structures',1,251,'Computer Science (Sci) : Introduction to algorithm design and analysis. Graph algorithms, greedy algorithms, data structures, dynamic programming, maximum flows.',3,3,10,NULL,'2013-08-02 14:47:04','2013-08-02 14:47:04'),(12,'Discrete Structures 1',2,240,'Mathematics & Statistics (Sci) : Mathematical foundations of logical thinking and reasoning. Mathematical language and proof techniques. Quantifiers. Induction. Elementary number theory. Modular arithmetic. Recurrence relations and asymptotics. Combinatorial enumeration. Functions and relations. Partially ordered sets and lattices. Introduction to graphs, digraphs and rooted trees.',3,3,NULL,NULL,'2013-08-02 14:47:51','2013-08-02 14:47:51'),(13,'Theory of Computation',1,330,'Computer Science (Sci) : Mathematical models of computers, finite automata, Turing machines, counter machines, push-down machines, computational complexity.',3,3,11,NULL,'2013-08-02 14:48:41','2013-08-02 14:48:41'),(14,'Algorithm Design',1,360,'Computer Science (Sci) : Advanced algorithm design and analysis. Linear programming, complexity and NP-completeness, advanced algorithmic techniques.',3,3,12,14,'2013-08-02 14:49:43','2013-08-05 21:24:52'),(15,'Calculus 3',2,222,'Mathematics & Statistics (Sci) : Taylor series, Taylor\'s theorem in one and several variables. Review of vector geometry. Partial differentiation, directional derivative. Extreme of functions of 2 or 3 variables. Parametric curves and arc length. Polar and spherical coordinates. Multiple integrals.',3,3,NULL,NULL,'2013-08-02 14:50:36','2013-08-02 14:50:36'),(16,'Probability',2,323,'Mathematics & Statistics (Sci) : Sample space, events, conditional probability, independence of events, Bayes\' Theorem. Basic combinatorial probability, random variables, discrete and continuous univariate and multivariate distributions. Independence of random variables. Inequalities, weak law of large numbers, central limit theorem.',3,3,NULL,NULL,'2013-08-02 14:51:03','2013-08-02 14:56:33'),(17,'Statistics',2,324,'Mathematics & Statistics (Sci) : Sampling distributions, point and interval estimation, hypothesis testing, analysis of variance, contingency tables, nonparametric inference, regression, Bayesian inference.',3,3,13,NULL,'2013-08-02 14:52:04','2013-08-02 14:52:04'),(18,'Introduction to Financial Accounting',3,211,'Management Core: The role of financial accounting in the reporting of the financial performance of a business. The principles, components and uses of financial accounting and reporting from a user\'s perspective, including the recording of accounting transactions and events, the examination of the elements of financial statements, the preparation of financial statements and the analysis of financial results.',3,3,NULL,NULL,'2013-08-07 16:31:08','2013-08-07 16:31:08'),(19,'Finance 2',5,342,'In-depth study of corporate finance, risk, diversification, portfolio analysis, and capital market theory.',3,3,19,NULL,'2013-08-07 16:42:57','2013-08-07 18:42:49'),(20,'Investment Management',5,441,'Application of investment principles and security analysis to the selection and comparison of equity and fixed income securities in the current economic and financial environment. Also covered are: determinants of stock prices, growth models and portfolio diversification.',3,3,19,NULL,'2013-08-07 17:01:46','2013-08-07 18:43:40'),(21,'Applied Corporate Finance',5,443,'Concepts and techniques are applied to problems faced by managers in Corporate Finance, such as working capital management, capital budgeting, capital structure, dividend policy, cost of capital, and mergers and acquisition. Application of theory and techniques through case studies.',3,3,21,NULL,'2013-08-07 17:02:46','2013-08-07 18:44:46'),(22,'Financial Derivatives',5,448,'The course will concentrate on both the analytical and practical aspects of investments in options and futures. The first part of the course concentrates on option and futures valuation, considering both discrete and continuous time models. The second part of the course concentrates on the practical aspects of options and futures trading.',3,3,22,NULL,'2013-08-07 17:04:08','2013-08-07 18:48:56'),(23,'International Finance 1',5,482,'The international financial environment as it affects the multinational manager. Balance of payments concepts, adjustment process of the external imbalances and the international monetary system. In depth study of the institutional and theoretical aspects of foreign exchange markets; international capital markets, including Eurobonds and eurocredit markets.',3,3,19,NULL,'2013-08-07 17:15:39','2013-08-07 18:49:42'),(24,'Advanced Business Statistics',6,372,'A practical managerial approach to advanced simple and multiple regression analysis, with application in finance, economics and business, including a review of probability theory, an introduction to methods of least squares and maximum likelihood estimation, autoregressive forecasting models and analysis of variance.',3,3,18,NULL,'2013-08-07 17:16:52','2013-08-07 18:50:14'),(25,'Topics in Finance 1',5,434,'Topics will be selected from current issues in the Finance Area.',3,3,19,NULL,'2013-08-07 17:17:39','2013-08-07 18:50:45'),(26,'Capital Markets and Institutions',5,442,'Functions of the capital market through flow of funds analysis and an examination of portfolio activities of financial intermediaries. Also covered are: securities regulations and ethical considerations, the term structure of interest rates and risk and rates of return in debt and equity markets.',3,3,19,NULL,'2013-08-07 17:18:07','2013-08-07 18:51:22'),(27,'Market Risk Models',5,449,'Dynamic market risk models including GARCH volatility models, dynamic conditional correlation models, non-normal return distributions, option pricing allowing for skewness and kurtosis, and option risk management using delta, delta-gamma and full-valuation.',3,3,23,NULL,'2013-08-07 17:18:47','2013-08-07 18:53:10'),(28,'Fixed Income Analysis',5,451,'Fixed income financial instruments and their uses for both financial engineering and risk management (at the trading desk and aggregate firm level). This will involve coverage of fixed income mathematics, risk management concepts, term structure modeling, derivatives valuation and credit risk analysis.',3,3,24,NULL,'2013-08-07 17:19:31','2013-08-07 18:54:24'),(29,'Global Invesments',5,480,'Major principles of international investments and global asset allocation, focusing on recent developments in modeling and predicting global asset returns. Main approaches to stock selection, style investing, and special issues such as indirect diversification and country and industry effects in equity pricing. Use of Datastream and other financial data sources.',3,3,25,NULL,'2013-08-07 17:20:09','2013-08-07 18:55:22'),(30,'International Finance 2',5,492,'Focus on the operational problems of financial management in the multinational enterprise: Financing of international trade, international capital budgeting, multinational cost of capital, working capital management; International banking and recent developments in international capital markets.',3,3,26,NULL,'2013-08-07 17:20:34','2013-08-07 18:56:08'),(31,'Applied Investments ',5,541,'Students are exposed to practical aspects of managing investment portfolios. A principal activity of students is participation in the management of a substantial investment fund.',3,3,24,NULL,'2013-08-07 17:23:14','2013-08-07 18:56:42'),(32,'Advanced Finance Seminar',5,547,'Selected topics will be discussed by Faculty members, invited guest speakers, and the students. Each student is required to select a topic for study and prepare a written report for presentation.',3,3,28,NULL,'2013-08-07 17:28:45','2013-08-07 18:57:22'),(33,'Intermediate Financial Accounting 1',7,351,'An examination of the theoretical foundation for financial reporting and revenue recognition. The tools of accounting, including a review of the accounting process and compound interest concepts. Asset recognition, measurement and disclosure. Partnership accounting.',3,3,29,NULL,'2013-08-07 17:30:52','2013-08-07 18:58:12'),(34,'Intermediate Financial Accounting 2',7,352,'A continuation of Intermediate Financial Accounting 1. An examination of liability recognition, measurement and disclosure, including leases, pension costs and corporate income tax. Shareholders\' equity, dilutive securities and earnings per share. The statement of changes in financial position, basic financial statement analysis and full disclosure in financial reporting.\r\n',3,3,NULL,NULL,'2013-08-07 17:31:26','2013-08-07 17:31:26'),(35,'Financial Statement Analysis',7,354,'Interpretative nature of the conceptual framework underlying a multitude of financial reporting standards, including the impact of alternative accounting methods, management biases and stakeholder interests in the analysis and valuation of the firm.',3,3,31,NULL,'2013-08-07 17:31:59','2013-08-07 19:18:16'),(36,'Principles of Taxation',7,385,'An introduction to the concepts underlying the Canadian tax system and how they are applied in relation to the taxation of individuals and businesses.',3,3,19,NULL,'2013-08-07 17:45:13','2013-08-07 19:18:52'),(37,'Real Estate Finance',5,385,'Fundamentals of mortgages from the viewpoint of both consumer and the firm. Emphasis on legal, mathematical and financial structure, provides a micro basis for analysis of the functions and performance of the mortgage market, in conjunction with the housing market.',3,3,19,NULL,'2013-08-07 17:45:46','2013-08-07 19:19:12'),(38,'Macroeconomic Policy',8,295,' This applied macroeconomics course focuses on current and recurrent macroeconomic issues important in understanding the public policy environment in which firms make their decisions. Topics include national accounts; national income determination; economic growth and fluctuations; money, monetary policy and financial markets; international trade and finance.',3,3,NULL,NULL,'2013-08-07 18:22:01','2013-08-07 18:22:01'),(39,'Introduction to Organizational Behaviour',3,222,'Individual motivation and communication style; group dynamics as related to problem solving and decision making, leadership style, work structuring and the larger environment. Interdependence of individual, group and organization task and structure.',3,3,NULL,NULL,'2013-08-07 18:28:09','2013-08-07 18:28:09'),(40,'Business Statistics',3,271,'Statistical concepts and methodology, their application to managerial decision-making, real-life data, problem-solving and spreadsheet modeling. Topics include: descriptive statistics; normal distributions, sampling distributions and estimation, hypothesis testing for one and two populations, goodness of fit, analysis of variance, simple and multiple regression.',3,3,NULL,NULL,'2013-08-07 18:28:46','2013-08-07 18:28:46'),(41,'Managerial Economics',3,293,'The course focuses on the application of economic theory to management problems and the economic foundations of marketing, finance, and production. Attention is given to the following topics: price and cost analysis; demand and supply analysis, conditions of competition.',3,3,NULL,NULL,'2013-08-07 18:29:19','2013-08-07 18:29:19'),(42,'Introduction to Information Systems',3,331,'Introduction to principles and concepts of information systems in organizations. Topics include information technology, transaction processing systems, decision support systems, database and systems development. Students are required to have background preparation on basic micro computer skills including spreadsheet and word-processing.',3,3,NULL,NULL,'2013-08-07 18:29:59','2013-08-07 18:29:59'),(43,'Finance 1',3,341,'An introduction to the principles, issues, and institutions of Finance. Topics include valuation, risk, capital investment, financial structure, cost of capital, working capital management, financial markets, and securities.',3,3,NULL,NULL,'2013-08-07 18:30:22','2013-08-07 18:30:22'),(44,'Marketing Management 1',3,352,'Introduction to marketing principles, focusing on problem solving and decision making. Topics include: the marketing concept; marketing strategies; buyer behaviour; Canadian demographics; internal and external constraints; product; promotion; distribution; price. Lectures, text material and case studies.',3,3,NULL,NULL,'2013-08-07 18:30:53','2013-08-07 18:32:37'),(45,'Social Context of Business',3,360,'This course examines how business interacts with the larger society. It explores the development of modern capitalist society, and the dilemmas that organizations face in acting in a socially responsible manner. Students will examine these issues with reference to sustainable development, business ethics, globalization and developing countries, and political activity.',3,3,NULL,NULL,'2013-08-07 18:31:24','2013-08-07 18:31:24'),(46,'International Business',3,382,'An introduction to the world of international business. Economic foundations of international trade and investment. The international trade, finance, and regulatory frameworks. Relations between international companies and nation-states, including costs and benefits of foreign investment and alternative controls and responses. Effects of local environmental characteristics on the operations of multi-national enterprises.',3,3,NULL,NULL,'2013-08-07 18:31:50','2013-08-07 18:31:50'),(47,'Organizational Policy',3,423,'Focus on the primary functions of general management: the formation of a corporate strategy that relates the company\'s opportunities to its resources, competence, and leadership style. Measures to improve organization effectiveness.',3,3,NULL,NULL,'2013-08-07 18:32:28','2013-08-07 18:32:28'),(48,'Operations Management',3,472,'Design, planning, establishment, control, and improvement of the activities/processes that create a firm\'s final products and/or services. The interaction of operations with other business areas will also be discussed. Topics include forecasting, product and process design, waiting lines, capacity planning, inventory management and total quality management.',3,3,NULL,NULL,'2013-08-07 18:33:02','2013-08-07 18:33:02'),(49,'Calculus for Management',2,122,'Review of functions, exponents and radicals, exponential and logorithm. Examples of functions in business applications. Limits, continuity and derivatives. Differentiation of elementary functions. Antiderivatives. The definite integral. Techniques of Integration. Applications of differentiation and integration including differential equations. Trigonometric functions are not discussed in this course.',3,3,NULL,NULL,'2013-08-07 18:36:52','2013-08-07 18:36:52'),(50,'Linear Algebra and Probability',2,123,'Geometric vectors in low dimensions. Lines and planes. Dot and cross product. Linear equations and matrices. Matrix operations, properties and rank. Linear dependence and independence. Inverses and determinants. Linear programming and tableaux. Sample space, probability, combination of events. Conditional probability and Bayes Law. Random sampling. Random variables and common distributions.',3,3,NULL,NULL,'2013-08-07 18:37:49','2013-08-07 18:37:49'),(51,'Systems Analysis and Modelling',4,333,'First two phases of the software development life cycle. Techniques used to conduct system requirement analysis, practical application of the analyst role in identifying operational problems, defining information system requirements, working with technical and non-technical staff, and making recommendations for system improvement.',3,3,20,NULL,'2013-08-07 18:38:09','2013-08-07 19:14:35'),(52,'Managing Information Technology',4,331,'Tools and concepts necessary to manage information systems in an organization: hardware/software/telecom administration, knowledge discovery/management, web-technologies, and computer security. Focuses on both mechanical aspects of IT and conceptual understanding with regard to impact on business organizations',3,3,20,NULL,'2013-08-07 18:39:57','2013-08-07 19:14:57'),(53,'IT in Business',4,432,'Discusses the role of the information systems department within an organization, information systems resource management, staff organization and leadership, strategic systems, planning, and end-user computing. Focuses on key IT trends in industries such as banking, insurance, manufacturing, retailing & distribution, and health.',3,3,20,NULL,'2013-08-07 18:43:42','2013-08-07 19:15:12'),(54,'Managing Data and Databases',4,437,'Management of organizational data, implementation of database management systems, and the roles and responsibilities of data management personnel. Explores different models of data representation with an emphasis on the relational model; simple and complex SQL queries.',3,3,20,NULL,'2013-08-07 18:45:40','2013-08-07 19:15:29'),(55,'IS Project Management',4,450,'Practical principles of project management essential to successful IS development projects or other complex undertakings within an organization; includes methods for defining, planning, and scheduling activities and resources. Discusses managerial and behavioural issues.',3,3,20,NULL,'2013-08-07 18:47:21','2013-08-07 19:16:11'),(56,'Developing Business Apps',4,341,'Fundamental programming techniques, concepts, and data structures. Discusses modularization and maintainability. Emphasis on facilitating communication and understanding between systems analysts and programmers to support decision-making.',3,3,20,NULL,'2013-08-07 18:51:30','2013-08-07 19:15:48'),(57,'Accounting Information Systems',4,332,'Accounting cycles and information flows and the systems that manage those flows. Principals of systems development and data management as relates to accounting information. Relationship between accounting applications and transaction processing systems. Practical experience with accounting packages',3,3,27,NULL,'2013-08-07 18:54:00','2013-08-07 19:16:28'),(58,'IT Consulting',4,339,'Examination of the full \"life-cycle\" from initial contact to project termination. How an IT consultant manages their practice.',3,3,20,NULL,'2013-08-07 18:57:11','2013-08-07 19:16:47'),(59,'IT in Financial Markets',4,430,'How IT has impacted various parts of the financial services sector including stock markets, brokerage houses, retail banking and insurance.',3,3,20,NULL,'2013-08-07 18:58:18','2013-08-07 19:17:02'),(60,'IT Implementation Management',4,431,'Exposure to a variety of real-life strategic and operational issues that arise when implementing IT. It may involve the selection process of an information technology, its introduction, implementation, management and/or improvement.',3,3,20,NULL,'2013-08-07 18:59:17','2013-08-07 19:17:19'),(61,'Topics in IS',4,434,'Current topics in the area of information systems',3,NULL,20,NULL,'2013-08-07 18:59:53','2013-08-07 19:28:57'),(62,'E-Business',4,440,'Build the knowledge base and skills needed to face today\'s electronic business challenges, opportunities, and issues. Explore important concepts, models, tools and applications related to e-business.',3,3,20,NULL,'2013-08-07 19:00:55','2013-08-07 19:14:05'),(63,'Business Intelligence and Data Analytics',4,442,'Introduction to the methods and tools for analyzing business data to improve business decision-making, focusing on extracting business intelligence by analyzing data and online content for various business applications.',3,3,30,NULL,'2013-08-07 19:03:23','2013-08-07 19:05:26'),(64,'Managing Knowledge with IT',4,444,'Types of organizational knowledge and their value for organizations, analyzing knowledge processes, and assessing tools and technologies for managing knowledge.',3,3,20,NULL,'2013-08-07 19:06:28','2013-08-07 19:06:28'),(65,'Technological Foundation for E-Commerce',4,454,'Technology trends and vocabulary pertaining to current technology developments in E-Commerce. Practical IT skills in web application design, including ASP, XML, etc. Discusses business issues affected by the introduction of e-technologies.',3,3,20,NULL,'2013-08-07 19:13:46','2013-08-07 19:13:46'),(66,'Case Analysis and Presentation',9,499,'Integration of core knowledge and practice for preparing and presenting case studies, including professor coaching, preparation and presentation feedback, presentation skills, leadership skills, team building skills, analytical skills, logical thinking, debating, persuasive communications and cross discipline work.',3,3,NULL,NULL,'2013-08-07 19:24:16','2013-08-07 19:24:16'),(67,'Management Accounting',7,361,'The role of management accounting information to support internal management decisions and to provide performance incentives',3,3,29,NULL,'2013-08-07 20:32:05','2013-08-07 20:32:05'),(68,'Cost Accounting',7,362,'An examination of a number of recurring issues in the area of decision-making and control, including cost allocation, alternative costing systems, and innovations in costing and performance measurement.',3,3,32,NULL,'2013-08-07 20:34:51','2013-08-07 20:39:33'),(69,'Development of Accounting Thought',7,455,'The conceptual underpinning of accounting thought, including its historical development and the modifications that have occurred over time. A review of accounting literature and its relevance to practice',3,3,33,NULL,'2013-08-07 20:40:32','2013-08-07 20:41:23'),(70,'Financial Reporting Valuation',7,452,'Models to determine firm value from accounting information and a broader perspective on key sources of information, key value drivers, in a setting where evaluating firm value is the ultimate purpose.',3,3,34,NULL,'2013-08-07 20:44:05','2013-08-07 20:44:35'),(71,'Advanced Financial Accounting',7,453,'Reporting relevant financial information subsequent to long term intercorporate investments. The preparation of consolidated financial statements with emphasis on their economic substance rather than legal form.',3,3,33,NULL,'2013-08-07 20:46:23','2013-08-07 20:46:23'),(72,'Financial Reporting',7,454,'An in-depth study of Canadian accounting standards and how Canadian corporations apply them in their financial reporting.',3,3,33,NULL,'2013-08-07 20:47:42','2013-08-07 20:47:42'),(73,'Management Control',7,463,'The theoretical frameworks for the examination and evaluation of management accounting and control systems. The technical aspects of accounting along with behavioural issues of management control.',3,3,32,NULL,'2013-08-07 20:48:14','2013-08-07 20:48:46'),(75,'Non-Profit Accounting',7,471,'The foundations and practices of non-profit accounting for organizations including government, volunteer, charitable, health care and educational. The framework to evaluate and understand emerging issues.',3,3,33,NULL,'2013-08-07 20:49:35','2013-08-07 20:49:35'),(76,'Principles of Auditing',7,475,'An introduction to basic auditing concepts and internal controls of an accounting system. Topics include current auditing standards, ethical conduct, legal liability, planning of an audit, sampling techniques, non-audit engagements, the study and evaluation of internal controls in an accounting system.',3,3,33,NULL,'2013-08-07 20:51:12','2013-08-07 20:51:12'),(77,'Internal Auditing',7,476,'The modern internal audit approach including operational and management audit practices within the internal audit framework. Topics include objectives of an internal audit, communication by internal auditors, planning audit projects, audit of EDP systems, audit testing, operational areas.',3,3,36,NULL,'2013-08-07 20:52:42','2013-08-07 20:52:42'),(78,'External Auditing',7,477,'The theory of auditing financial statements and the various complexities encountered in these audit environments. A thorough study of auditing standards, ethical conduct, communication by auditors, auditing in an EDP environment, audit of a small business, other reports and services provided by auditors and public accountants.',3,3,36,NULL,'2013-08-07 20:53:32','2013-08-07 20:53:32'),(79,'Business Taxation',7,486,'A study of the Income Tax Act as it applies to the taxation of individuals and corporations, including capital cost allowances, capital gains, corporate reorganisations, trusts and partnerships and administrative regulations. A review of consumption taxes.',3,3,37,NULL,'2013-08-07 20:55:29','2013-08-07 20:55:29');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_program_groups`
--

DROP TABLE IF EXISTS `courses_program_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_program_groups` (
  `program_group_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_program_groups`
--

LOCK TABLES `courses_program_groups` WRITE;
/*!40000 ALTER TABLE `courses_program_groups` DISABLE KEYS */;
INSERT INTO `courses_program_groups` VALUES (1,10),(1,9),(1,8),(4,14),(4,13),(3,17),(3,16),(3,15),(3,9),(9,19),(9,24),(9,23),(9,22),(9,21),(9,20),(10,37),(10,36),(10,35),(10,34),(10,33),(10,32),(10,31),(10,30),(10,29),(10,28),(10,27),(10,26),(10,25),(11,55),(11,54),(11,53),(11,52),(11,51),(11,56),(12,65),(12,64),(12,63),(12,62),(12,61),(12,60),(12,59),(12,58),(12,57),(12,66),(13,36),(13,34),(13,33),(14,35),(14,79),(14,78),(14,77),(14,76),(14,75),(14,73),(14,72),(14,71),(14,70),(13,69),(13,68),(13,67);
/*!40000 ALTER TABLE `courses_program_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculties`
--

DROP TABLE IF EXISTS `faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_faculties_on_university_id` (`university_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculties`
--

LOCK TABLES `faculties` WRITE;
/*!40000 ALTER TABLE `faculties` DISABLE KEYS */;
INSERT INTO `faculties` VALUES (1,'Faculty of Science','http://www.mcgill.ca/science/',1,'2013-07-29 13:28:25','2013-07-29 13:28:25'),(2,'Faculty of Engineering','http://www.mcgill.ca/engineering/',1,'2013-08-05 15:43:41','2013-08-05 15:43:41'),(3,'Faculty of Arts','http://www.mcgill.ca/arts/',1,'2013-08-05 15:44:07','2013-08-05 15:44:07'),(4,'Desautels Faculty of Management','http://www.mcgill.ca/desautels/',1,'2013-08-05 15:44:29','2013-08-05 15:44:29');
/*!40000 ALTER TABLE `faculties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merit_actions`
--

DROP TABLE IF EXISTS `merit_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merit_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `action_method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action_value` int(11) DEFAULT NULL,
  `had_errors` tinyint(1) DEFAULT '0',
  `target_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `processed` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merit_actions`
--

LOCK TABLES `merit_actions` WRITE;
/*!40000 ALTER TABLE `merit_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `merit_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merit_activity_logs`
--

DROP TABLE IF EXISTS `merit_activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merit_activity_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) DEFAULT NULL,
  `related_change_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_change_id` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merit_activity_logs`
--

LOCK TABLES `merit_activity_logs` WRITE;
/*!40000 ALTER TABLE `merit_activity_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `merit_activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merit_score_points`
--

DROP TABLE IF EXISTS `merit_score_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merit_score_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score_id` int(11) DEFAULT NULL,
  `num_points` int(11) DEFAULT '0',
  `log` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merit_score_points`
--

LOCK TABLES `merit_score_points` WRITE;
/*!40000 ALTER TABLE `merit_score_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `merit_score_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merit_scores`
--

DROP TABLE IF EXISTS `merit_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merit_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sash_id` int(11) DEFAULT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'default',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merit_scores`
--

LOCK TABLES `merit_scores` WRITE;
/*!40000 ALTER TABLE `merit_scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `merit_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_groups`
--

DROP TABLE IF EXISTS `program_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `restriction` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `groupparent_id` int(11) DEFAULT NULL,
  `groupparent_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_groups`
--

LOCK TABLES `program_groups` WRITE;
/*!40000 ALTER TABLE `program_groups` DISABLE KEYS */;
INSERT INTO `program_groups` VALUES (1,'McGill Science Software Engineering Core','all',39,1,'Program','2013-07-29 18:06:17','2013-07-29 18:06:17'),(2,'McGill Science Software Engineering Complementary Courses','min_credit',9,1,'Program','2013-07-29 18:08:46','2013-07-29 18:08:46'),(3,'McGill Science Software Engineering Complementary Courses Group A','min_credit',3,2,'ProgramGroup','2013-07-29 18:09:07','2013-07-29 18:09:07'),(4,'McGill Science Software Engineering Complementary Courses Group B','min_credit',3,2,'ProgramGroup','2013-07-29 18:09:25','2013-07-29 18:09:25'),(5,'McGill Science Software Engineering Specializations','min_credit',15,1,'Program','2013-07-29 18:09:47','2013-07-29 18:09:47'),(6,'McGill Science Software Engineering Specializations Software Engineering','min_credit',6,5,'ProgramGroup','2013-07-29 18:10:21','2013-07-29 18:10:21'),(7,'McGill Science Software Engineering Specializations Application','min_credit',6,5,'ProgramGroup','2013-07-29 18:10:53','2013-07-29 18:10:53'),(8,'McGill Management Information Systems Core','all',NULL,NULL,'','2013-08-07 16:28:48','2013-08-07 16:38:32'),(9,'Finance Core','all',NULL,4,'Program','2013-08-07 16:39:08','2013-08-07 16:40:40'),(10,'Finance Complementary','min_credit',15,4,'Program','2013-08-07 16:40:30','2013-08-07 16:40:40'),(11,'Information Systems Core','all',NULL,2,'Program','2013-08-07 18:49:55','2013-08-07 18:49:55'),(12,'Information Systems Complementary','min_credit',12,2,'Program','2013-08-07 19:21:55','2013-08-07 19:21:55'),(13,'Accounting Core','all',NULL,NULL,'Program','2013-08-07 20:25:46','2013-08-07 20:25:46'),(14,'Accounting Complementary','min_credit',12,NULL,'','2013-08-07 20:29:05','2013-08-07 20:29:05');
/*!40000 ALTER TABLE `program_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_programs_on_type_id` (`type_id`),
  KEY `index_programs_on_faculty_id` (`faculty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES (1,'Software Engineering',1,1,'2013-07-29 13:28:46','2013-07-29 13:28:46'),(2,'Information Systems',1,4,'2013-08-07 16:26:07','2013-08-07 16:26:07'),(3,'Management Core',4,4,'2013-08-07 16:37:07','2013-08-07 16:37:07'),(4,'Finance',1,4,'2013-08-07 16:40:40','2013-08-07 16:40:40'),(5,'Accounting',1,4,'2013-08-07 20:22:51','2013-08-07 20:22:51');
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs_types`
--

DROP TABLE IF EXISTS `programs_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs_types`
--

LOCK TABLES `programs_types` WRITE;
/*!40000 ALTER TABLE `programs_types` DISABLE KEYS */;
INSERT INTO `programs_types` VALUES (1,'major','2013-07-23 14:52:52','2013-07-23 14:52:52'),(2,'minor','2013-07-23 14:52:57','2013-07-23 14:52:57'),(3,'concentration','2013-07-24 13:38:15','2013-07-24 13:38:15'),(4,'faculty','2013-07-24 21:21:31','2013-07-24 21:21:42');
/*!40000 ALTER TABLE `programs_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs_users`
--

DROP TABLE IF EXISTS `programs_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs_users`
--

LOCK TABLES `programs_users` WRITE;
/*!40000 ALTER TABLE `programs_users` DISABLE KEYS */;
INSERT INTO `programs_users` VALUES (9,4,1),(10,4,2),(11,4,6),(12,2,4);
/*!40000 ALTER TABLE `programs_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rails_admin_histories`
--

DROP TABLE IF EXISTS `rails_admin_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rails_admin_histories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text COLLATE utf8_unicode_ci,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item` int(11) DEFAULT NULL,
  `table` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `month` smallint(6) DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rails_admin_histories` (`item`,`table`,`month`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rails_admin_histories`
--

LOCK TABLES `rails_admin_histories` WRITE;
/*!40000 ALTER TABLE `rails_admin_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `rails_admin_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','2013-07-23 20:20:03','2013-07-23 20:20:03');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
INSERT INTO `roles_users` VALUES (2,2,1),(3,1,1),(5,4,1),(7,6,1);
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sashes`
--

DROP TABLE IF EXISTS `sashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sashes`
--

LOCK TABLES `sashes` WRITE;
/*!40000 ALTER TABLE `sashes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sashes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20130722183956'),('20130722183957'),('20130722185211'),('20130722185326'),('20130722185352'),('20130722185557'),('20130722185816'),('20130723142707'),('20130723144609'),('20130723145056'),('20130723171513'),('20130723172254'),('20130723184047'),('20130723190844'),('20130723192236'),('20130723200821'),('20130723200924'),('20130725154929'),('20130803202529'),('20130804183421'),('20130805134356'),('20130805134524'),('20130805142413'),('20130805144051'),('20130805150409'),('20130805150526'),('20130805162059'),('20130805163731'),('20130807172855'),('20130807172856'),('20130807172857'),('20130807172858'),('20130807172859'),('20130807173429');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `interpolations` text COLLATE utf8_unicode_ci,
  `is_proc` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (1,'en','error.university.notselected','You have not selected a university.','',0,NULL,'2013-08-06 21:28:42');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universities`
--

DROP TABLE IF EXISTS `universities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `universities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `grading_system_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_universities_on_grading_system_id` (`grading_system_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universities`
--

LOCK TABLES `universities` WRITE;
/*!40000 ALTER TABLE `universities` DISABLE KEYS */;
INSERT INTO `universities` VALUES (1,'Mcgill University','http://mcgill.ca','2013-07-22 19:02:01','2013-08-05 14:43:06',2);
/*!40000 ALTER TABLE `universities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_completed_courses`
--

DROP TABLE IF EXISTS `user_completed_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_completed_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `grade_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_completed_courses_on_user_id` (`user_id`),
  KEY `index_user_completed_courses_on_course_id` (`course_id`),
  KEY `index_user_completed_courses_on_grade_id` (`grade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_completed_courses`
--

LOCK TABLES `user_completed_courses` WRITE;
/*!40000 ALTER TABLE `user_completed_courses` DISABLE KEYS */;
INSERT INTO `user_completed_courses` VALUES (1,1,15,2,'2013-08-05 20:56:44','2013-08-05 20:56:44');
/*!40000 ALTER TABLE `user_completed_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_emails`
--

DROP TABLE IF EXISTS `user_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `validated` tinyint(1) DEFAULT NULL,
  `primary` tinyint(1) DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_emails_on_university_id` (`university_id`),
  KEY `index_user_emails_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_emails`
--

LOCK TABLES `user_emails` WRITE;
/*!40000 ALTER TABLE `user_emails` DISABLE KEYS */;
INSERT INTO `user_emails` VALUES (1,'tlornewr@gmail.com',1,1,NULL,1,'2013-08-03 22:28:15','2013-08-03 22:31:53'),(2,'timothee.guerin@outlook.com',1,1,NULL,2,'2013-08-03 22:29:03','2013-08-03 22:29:05'),(4,'test@test.com',1,0,1,1,'2013-08-05 02:01:45','2013-08-05 02:01:45'),(5,'test@test.co.uk',0,0,NULL,1,'2013-08-05 02:02:19','2013-08-05 02:02:19'),(6,'valentine@dessertenne.org',0,1,NULL,4,'2013-08-06 18:58:37','2013-08-06 18:58:37'),(7,'thibaud.marechal@gmail.com',0,1,NULL,6,'2013-08-07 16:24:10','2013-08-07 16:24:10');
/*!40000 ALTER TABLE `user_emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_taking_courses`
--

DROP TABLE IF EXISTS `user_taking_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_taking_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_taking_courses_on_user_id` (`user_id`),
  KEY `index_user_taking_courses_on_course_id` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_taking_courses`
--

LOCK TABLES `user_taking_courses` WRITE;
/*!40000 ALTER TABLE `user_taking_courses` DISABLE KEYS */;
INSERT INTO `user_taking_courses` VALUES (1,1,9,'2013-08-05 20:56:17','2013-08-05 20:56:17');
/*!40000 ALTER TABLE `user_taking_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `sash_id` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  KEY `index_users_on_university_id` (`university_id`),
  KEY `index_users_on_faculty_id` (`faculty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'tlornewr@gmail.com','$2a$10$gAyqdppxXXIkqwcJmzPlreahPICbXBSnz6Hn6S2WL8kwr0/4AR3LC','mJjqCTaLWxRLveGmJU7s','2013-07-23 18:59:12',NULL,51,'2013-08-07 15:44:25','2013-08-06 23:17:03','18.189.73.138','18.189.46.159','2013-07-22 18:40:24','2013-08-07 17:27:42',1,4,NULL,0),(2,'timothee.guerin@outlook.com','$2a$10$9l8woOOEaZLAFIP7V3CZb.l5aUYcoVBAefwGM8GHBZZ5XwE5/lBOi',NULL,NULL,'2013-08-05 21:57:53',5,'2013-08-05 21:57:53','2013-08-05 20:36:52','18.189.28.75','18.189.76.157','2013-07-22 19:01:21','2013-08-07 16:21:34',1,1,NULL,0),(4,'valentine@dessertenne.org','$2a$10$oIcCyi7yzGjUdqGT5U76dOTBIlBumz.kdEPPrI/JLJAoNljKIeaQC',NULL,NULL,'2013-08-07 16:21:46',4,'2013-08-07 21:23:59','2013-08-07 21:23:58','18.189.53.160','18.189.53.160','2013-08-06 18:58:37','2013-08-07 21:23:59',1,1,NULL,0),(6,'thibaud.marechal@gmail.com','$2a$10$oaO.BlxPZ55a6qg72jB3Cu4MqJOWaj4rp/xE..aMFjn/1e0dOsEIe',NULL,NULL,NULL,1,'2013-08-07 16:24:10','2013-08-07 16:24:10','18.189.76.157','18.189.76.157','2013-08-07 16:24:10','2013-08-07 19:20:15',1,4,NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-08-08 10:07:16
