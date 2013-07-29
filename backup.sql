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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_exprs`
--

LOCK TABLES `course_exprs` WRITE;
/*!40000 ALTER TABLE `course_exprs` DISABLE KEYS */;
INSERT INTO `course_exprs` VALUES (1,1,'2013-07-22 20:17:26','2013-07-22 20:17:26'),(2,2,'2013-07-22 20:19:59','2013-07-22 20:19:59'),(3,3,'2013-07-22 20:23:06','2013-07-22 20:23:42'),(4,4,'2013-07-22 20:23:55','2013-07-22 20:23:55'),(5,4,'2013-07-22 20:24:10','2013-07-22 20:24:10'),(6,2,'2013-07-22 20:24:54','2013-07-22 20:24:54'),(7,5,'2013-07-22 20:25:46','2013-07-22 20:25:46');
/*!40000 ALTER TABLE `course_exprs` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_nodes`
--

LOCK TABLES `course_nodes` WRITE;
/*!40000 ALTER TABLE `course_nodes` DISABLE KEYS */;
INSERT INTO `course_nodes` VALUES (1,'OR',NULL,NULL,'2013-07-22 20:17:26','2013-07-22 20:17:26'),(2,'NODE',1,2,'2013-07-22 20:17:26','2013-07-22 20:17:26'),(3,'NODE',1,1,'2013-07-22 20:17:26','2013-07-22 20:17:26'),(4,'NODE',NULL,3,'2013-07-22 20:23:55','2013-07-22 20:23:55'),(5,'AND',NULL,NULL,'2013-07-22 20:25:46','2013-07-22 20:25:46'),(6,'NODE',5,3,'2013-07-22 20:25:46','2013-07-22 20:25:46'),(7,'NODE',5,2,'2013-07-22 20:25:46','2013-07-22 20:25:46');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_subjects`
--

LOCK TABLES `course_subjects` WRITE;
/*!40000 ALTER TABLE `course_subjects` DISABLE KEYS */;
INSERT INTO `course_subjects` VALUES (1,'COMP','Computer Science',1,'2013-07-22 20:15:23','2013-07-22 20:15:23');
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
  `credit` int(11) DEFAULT NULL,
  `prerequisite_id` int(11) DEFAULT NULL,
  `corequisite_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_courses_on_subject_id` (`subject_id`),
  KEY `index_courses_on_prerequisite_id` (`prerequisite_id`),
  KEY `index_courses_on_corequisite_id` (`corequisite_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Foundations of Programming',1,202,'Computer Science (Sci) : Introduction to programming in a modern high-level language, modular software design and debugging. Programming concepts are illustrated using a variety of application areas.',3,3,NULL,NULL,'2013-07-22 20:16:14','2013-07-22 20:16:14'),(2,'Introduction to Computer Science',1,250,'Computer Science (Sci) : An introduction to the design of computer algorithms, including basic data structures, analysis of algorithms, and establishing correctness of programs. Overview of topics in computer science.',3,3,NULL,NULL,'2013-07-22 20:17:08','2013-07-22 20:17:08'),(3,'Introduction to Software Systems',1,206,'Computer Science (Sci) : Comprehensive overview of programming in C, use of system calls and libraries, debugging and testing of code; use of developmental tools like make, version control systems.',3,3,1,NULL,'2013-07-22 20:18:10','2013-07-22 20:18:10'),(4,'Algorithms and Data Structures',1,251,'Computer Science (Sci) : Introduction to algorithm design and analysis. Graph algorithms, greedy algorithms, data structures, dynamic programming, maximum flows.',3,3,2,NULL,'2013-07-22 20:20:19','2013-07-22 20:20:19'),(5,'Introduction to Computer Systems',1,273,'Computer Science (Sci) : Number representations, combinational and sequential digital circuits, MIPS instructions and architecture datapath and control, caches, virtual memory, interrupts and exceptions, pipelining.',3,3,NULL,5,'2013-07-22 20:24:13','2013-07-22 20:24:13'),(6,'Programming Languages and Paradigms',1,302,'Computer Science (Sci) : Programming language design issues and programming paradigms. Binding and scoping, parameter passing, lambda abstraction, data abstraction, type checking. Functional and logic programming.',3,3,6,NULL,'2013-07-22 20:24:56','2013-07-22 20:24:56'),(7,'Software Development',1,303,'Computer Science (Sci) : Principles, mechanisms, techniques, and tools for object-oriented software development: encapsulation, design patterns, unit testing, etc.',3,3,6,NULL,'2013-07-22 20:26:52','2013-07-22 20:26:52');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculties`
--

LOCK TABLES `faculties` WRITE;
/*!40000 ALTER TABLE `faculties` DISABLE KEYS */;
INSERT INTO `faculties` VALUES (1,'Faculty of Science','http://www.mcgill.ca/science/',1,'2013-07-29 13:28:25','2013-07-29 13:28:25');
/*!40000 ALTER TABLE `faculties` ENABLE KEYS */;
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
  `parent_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_program_groups_on_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_groups`
--

LOCK TABLES `program_groups` WRITE;
/*!40000 ALTER TABLE `program_groups` DISABLE KEYS */;
INSERT INTO `program_groups` VALUES (1,'McGill Science Software Engineering Complementary Courses','min_credit',9,NULL,'2013-07-29 13:30:35','2013-07-29 13:30:35'),(2,'McGill Science Software Engineering Core','all',39,NULL,'2013-07-29 14:44:36','2013-07-29 14:44:36'),(3,'McGill Science Software Engineering Complementary Courses Group A','min_credit',3,4,'2013-07-29 14:45:10','2013-07-29 14:45:50'),(4,'McGill Science Software Engineering Complementary Courses Group B','min_credit',3,4,'2013-07-29 14:45:32','2013-07-29 14:45:50'),(5,'McGill Science Software Engineering Specializations','min_nb',15,NULL,'2013-07-29 14:46:12','2013-07-29 14:47:37'),(6,'McGill Science Software Engineering Specializations Software Engineering','min_credit',6,5,'2013-07-29 14:46:48','2013-07-29 14:47:37'),(7,'McGill Science Software Engineering Specializations Application','min_credit',6,5,'2013-07-29 14:47:09','2013-07-29 14:47:37');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES (1,'Software Engineering',1,1,'2013-07-29 13:28:46','2013-07-29 13:28:46');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
INSERT INTO `roles_users` VALUES (2,2,1),(3,1,1);
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
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
INSERT INTO `schema_migrations` VALUES ('20130722183956'),('20130722183957'),('20130722185211'),('20130722185326'),('20130722185352'),('20130722185557'),('20130722185816'),('20130723142707'),('20130723144609'),('20130723145056'),('20130723171513'),('20130723172254'),('20130723184047'),('20130723190844'),('20130723192236'),('20130723200821'),('20130723200924'),('20130725154929');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universities`
--

LOCK TABLES `universities` WRITE;
/*!40000 ALTER TABLE `universities` DISABLE KEYS */;
INSERT INTO `universities` VALUES (1,'Mcgill University','http://mcgill.ca','2013-07-22 19:02:01','2013-07-22 19:02:01');
/*!40000 ALTER TABLE `universities` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'tlornewr@gmail.com','$2a$10$kUr8lDG09LDIesiGuAFAVO1qSb6aDt371wOrggKdauuZY3VNELYV.','mJjqCTaLWxRLveGmJU7s','2013-07-23 18:59:12','2013-07-29 13:26:16',21,'2013-07-29 13:26:16','2013-07-27 23:08:47','18.189.84.209','64.134.240.110','2013-07-22 18:40:24','2013-07-29 13:26:16'),(2,'timothee.guerin@outlook.com','$2a$10$mYzEBMwceGDFwNaShe42xuRo.epstzN49pd.vdN44d74FD3/HYM1G',NULL,NULL,NULL,1,'2013-07-22 19:01:21','2013-07-22 19:01:21','18.189.95.221','18.189.95.221','2013-07-22 19:01:21','2013-07-22 19:01:21');
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

-- Dump completed on 2013-07-29 11:06:38
