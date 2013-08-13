-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: uniiv_development
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.13.04.1

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
-- Table structure for table `badges`
--

DROP TABLE IF EXISTS `badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desciption` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges`
--

LOCK TABLES `badges` WRITE;
/*!40000 ALTER TABLE `badges` DISABLE KEYS */;
/*!40000 ALTER TABLE `badges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_courses`
--

DROP TABLE IF EXISTS `course_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_courses` (
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
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_courses`
--

LOCK TABLES `course_courses` WRITE;
/*!40000 ALTER TABLE `course_courses` DISABLE KEYS */;
INSERT INTO `course_courses` VALUES (8,'Foundations of Programming',1,202,'Computer Science (Sci) : Introduction to programming in a modern high-level language, modular software design and debugging. Programming concepts are illustrated using a variety of application areas.',3,3,NULL,NULL,'2013-07-30 21:00:06','2013-07-30 21:00:06'),(9,'Introduction to Computer Science',1,250,'Computer Science (Sci) : An introduction to the design of computer algorithms, including basic data structures, analysis of algorithms, and establishing correctness of programs. Overview of topics in computer science.',3,3,NULL,NULL,'2013-07-30 21:00:34','2013-07-30 21:00:34'),(10,'Introduction to Computer Systems',1,206,'Computer Science (Sci) : Comprehensive overview of programming in C, use of system calls and libraries, debugging and testing of code; use of developmental tools like make, version control systems.',3,3,9,NULL,'2013-07-30 21:01:11','2013-07-30 21:04:59'),(11,'Algorithms and Data Structures',1,251,'Computer Science (Sci) : Introduction to algorithm design and analysis. Graph algorithms, greedy algorithms, data structures, dynamic programming, maximum flows.',3,3,10,NULL,'2013-08-02 14:47:04','2013-08-02 14:47:04'),(12,'Discrete Structures 1',2,240,'Mathematics & Statistics (Sci) : Mathematical foundations of logical thinking and reasoning. Mathematical language and proof techniques. Quantifiers. Induction. Elementary number theory. Modular arithmetic. Recurrence relations and asymptotics. Combinatorial enumeration. Functions and relations. Partially ordered sets and lattices. Introduction to graphs, digraphs and rooted trees.',3,3,NULL,NULL,'2013-08-02 14:47:51','2013-08-02 14:47:51'),(13,'Theory of Computation',1,330,'Computer Science (Sci) : Mathematical models of computers, finite automata, Turing machines, counter machines, push-down machines, computational complexity.',3,3,11,NULL,'2013-08-02 14:48:41','2013-08-02 14:48:41'),(14,'Algorithm Design',1,360,'Computer Science (Sci) : Advanced algorithm design and analysis. Linear programming, complexity and NP-completeness, advanced algorithmic techniques.',3,3,12,14,'2013-08-02 14:49:43','2013-08-05 21:24:52'),(15,'Calculus 3',2,222,'Mathematics & Statistics (Sci) : Taylor series, Taylor\'s theorem in one and several variables. Review of vector geometry. Partial differentiation, directional derivative. Extreme of functions of 2 or 3 variables. Parametric curves and arc length. Polar and spherical coordinates. Multiple integrals.',3,3,NULL,NULL,'2013-08-02 14:50:36','2013-08-02 14:50:36'),(16,'Probability',2,323,'Mathematics & Statistics (Sci) : Sample space, events, conditional probability, independence of events, Bayes\' Theorem. Basic combinatorial probability, random variables, discrete and continuous univariate and multivariate distributions. Independence of random variables. Inequalities, weak law of large numbers, central limit theorem.',3,3,NULL,NULL,'2013-08-02 14:51:03','2013-08-02 14:56:33'),(17,'Statistics',2,324,'Mathematics & Statistics (Sci) : Sampling distributions, point and interval estimation, hypothesis testing, analysis of variance, contingency tables, nonparametric inference, regression, Bayesian inference.',3,3,13,NULL,'2013-08-02 14:52:04','2013-08-02 14:52:04'),(18,'Introduction to Financial Accounting',3,211,'Management Core: The role of financial accounting in the reporting of the financial performance of a business. The principles, components and uses of financial accounting and reporting from a user\'s perspective, including the recording of accounting transactions and events, the examination of the elements of financial statements, the preparation of financial statements and the analysis of financial results.',3,3,NULL,NULL,'2013-08-07 16:31:08','2013-08-07 16:31:08'),(19,'Finance 2',5,342,'In-depth study of corporate finance, risk, diversification, portfolio analysis, and capital market theory.',3,3,19,NULL,'2013-08-07 16:42:57','2013-08-07 18:42:49'),(20,'Investment Management',5,441,'Application of investment principles and security analysis to the selection and comparison of equity and fixed income securities in the current economic and financial environment. Also covered are: determinants of stock prices, growth models and portfolio diversification.',3,3,19,NULL,'2013-08-07 17:01:46','2013-08-07 18:43:40'),(21,'Applied Corporate Finance',5,443,'Concepts and techniques are applied to problems faced by managers in Corporate Finance, such as working capital management, capital budgeting, capital structure, dividend policy, cost of capital, and mergers and acquisition. Application of theory and techniques through case studies.',3,3,21,NULL,'2013-08-07 17:02:46','2013-08-07 18:44:46'),(22,'Financial Derivatives',5,448,'The course will concentrate on both the analytical and practical aspects of investments in options and futures. The first part of the course concentrates on option and futures valuation, considering both discrete and continuous time models. The second part of the course concentrates on the practical aspects of options and futures trading.',3,3,22,NULL,'2013-08-07 17:04:08','2013-08-07 18:48:56'),(23,'International Finance 1',5,482,'The international financial environment as it affects the multinational manager. Balance of payments concepts, adjustment process of the external imbalances and the international monetary system. In depth study of the institutional and theoretical aspects of foreign exchange markets; international capital markets, including Eurobonds and eurocredit markets.',3,3,19,NULL,'2013-08-07 17:15:39','2013-08-07 18:49:42'),(24,'Advanced Business Statistics',6,372,'A practical managerial approach to advanced simple and multiple regression analysis, with application in finance, economics and business, including a review of probability theory, an introduction to methods of least squares and maximum likelihood estimation, autoregressive forecasting models and analysis of variance.',3,3,18,NULL,'2013-08-07 17:16:52','2013-08-07 18:50:14'),(25,'Topics in Finance 1',5,434,'Topics will be selected from current issues in the Finance Area.',3,3,19,NULL,'2013-08-07 17:17:39','2013-08-07 18:50:45'),(26,'Capital Markets and Institutions',5,442,'Functions of the capital market through flow of funds analysis and an examination of portfolio activities of financial intermediaries. Also covered are: securities regulations and ethical considerations, the term structure of interest rates and risk and rates of return in debt and equity markets.',3,3,19,NULL,'2013-08-07 17:18:07','2013-08-07 18:51:22'),(27,'Market Risk Models',5,449,'Dynamic market risk models including GARCH volatility models, dynamic conditional correlation models, non-normal return distributions, option pricing allowing for skewness and kurtosis, and option risk management using delta, delta-gamma and full-valuation.',3,3,23,NULL,'2013-08-07 17:18:47','2013-08-07 18:53:10'),(28,'Fixed Income Analysis',5,451,'Fixed income financial instruments and their uses for both financial engineering and risk management (at the trading desk and aggregate firm level). This will involve coverage of fixed income mathematics, risk management concepts, term structure modeling, derivatives valuation and credit risk analysis.',3,3,24,NULL,'2013-08-07 17:19:31','2013-08-07 18:54:24'),(29,'Global Invesments',5,480,'Major principles of international investments and global asset allocation, focusing on recent developments in modeling and predicting global asset returns. Main approaches to stock selection, style investing, and special issues such as indirect diversification and country and industry effects in equity pricing. Use of Datastream and other financial data sources.',3,3,25,NULL,'2013-08-07 17:20:09','2013-08-07 18:55:22'),(30,'International Finance 2',5,492,'Focus on the operational problems of financial management in the multinational enterprise: Financing of international trade, international capital budgeting, multinational cost of capital, working capital management; International banking and recent developments in international capital markets.',3,3,26,NULL,'2013-08-07 17:20:34','2013-08-07 18:56:08'),(31,'Applied Investments ',5,541,'Students are exposed to practical aspects of managing investment portfolios. A principal activity of students is participation in the management of a substantial investment fund.',3,3,24,NULL,'2013-08-07 17:23:14','2013-08-07 18:56:42'),(32,'Advanced Finance Seminar',5,547,'Selected topics will be discussed by Faculty members, invited guest speakers, and the students. Each student is required to select a topic for study and prepare a written report for presentation.',3,3,28,NULL,'2013-08-07 17:28:45','2013-08-07 18:57:22'),(33,'Intermediate Financial Accounting 1',7,351,'An examination of the theoretical foundation for financial reporting and revenue recognition. The tools of accounting, including a review of the accounting process and compound interest concepts. Asset recognition, measurement and disclosure. Partnership accounting.',3,3,29,NULL,'2013-08-07 17:30:52','2013-08-07 18:58:12'),(34,'Intermediate Financial Accounting 2',7,352,'A continuation of Intermediate Financial Accounting 1. An examination of liability recognition, measurement and disclosure, including leases, pension costs and corporate income tax. Shareholders\' equity, dilutive securities and earnings per share. The statement of changes in financial position, basic financial statement analysis and full disclosure in financial reporting.\r\n',3,3,88,NULL,'2013-08-07 17:31:26','2013-08-12 17:59:18'),(35,'Financial Statement Analysis',7,354,'Interpretative nature of the conceptual framework underlying a multitude of financial reporting standards, including the impact of alternative accounting methods, management biases and stakeholder interests in the analysis and valuation of the firm.',3,3,31,NULL,'2013-08-07 17:31:59','2013-08-07 19:18:16'),(36,'Principles of Taxation',7,385,'An introduction to the concepts underlying the Canadian tax system and how they are applied in relation to the taxation of individuals and businesses.',3,3,19,NULL,'2013-08-07 17:45:13','2013-08-07 19:18:52'),(37,'Real Estate Finance',5,445,'Fundamentals of mortgages from the viewpoint of both consumer and the firm. Emphasis on legal, mathematical and financial structure, provides a micro basis for analysis of the functions and performance of the mortgage market, in conjunction with the housing market.',3,3,19,NULL,'2013-08-07 17:45:46','2013-08-10 16:15:13'),(38,'Macroeconomic Policy',8,295,' This applied macroeconomics course focuses on current and recurrent macroeconomic issues important in understanding the public policy environment in which firms make their decisions. Topics include national accounts; national income determination; economic growth and fluctuations; money, monetary policy and financial markets; international trade and finance.',3,3,NULL,NULL,'2013-08-07 18:22:01','2013-08-07 18:22:01'),(39,'Introduction to Organizational Behaviour',3,222,'Individual motivation and communication style; group dynamics as related to problem solving and decision making, leadership style, work structuring and the larger environment. Interdependence of individual, group and organization task and structure.',3,3,NULL,NULL,'2013-08-07 18:28:09','2013-08-07 18:28:09'),(40,'Business Statistics',3,271,'Statistical concepts and methodology, their application to managerial decision-making, real-life data, problem-solving and spreadsheet modeling. Topics include: descriptive statistics; normal distributions, sampling distributions and estimation, hypothesis testing for one and two populations, goodness of fit, analysis of variance, simple and multiple regression.',3,3,85,NULL,'2013-08-07 18:28:46','2013-08-12 14:16:15'),(41,'Managerial Economics',3,293,'The course focuses on the application of economic theory to management problems and the economic foundations of marketing, finance, and production. Attention is given to the following topics: price and cost analysis; demand and supply analysis, conditions of competition.',3,3,NULL,NULL,'2013-08-07 18:29:19','2013-08-07 18:29:19'),(42,'Introduction to Information Systems',3,331,'Introduction to principles and concepts of information systems in organizations. Topics include information technology, transaction processing systems, decision support systems, database and systems development. Students are required to have background preparation on basic micro computer skills including spreadsheet and word-processing.',3,3,NULL,NULL,'2013-08-07 18:29:59','2013-08-07 18:29:59'),(43,'Finance 1',3,341,'An introduction to the principles, issues, and institutions of Finance. Topics include valuation, risk, capital investment, financial structure, cost of capital, working capital management, financial markets, and securities.',3,3,86,NULL,'2013-08-07 18:30:22','2013-08-12 14:17:43'),(44,'Marketing Management 1',3,352,'Introduction to marketing principles, focusing on problem solving and decision making. Topics include: the marketing concept; marketing strategies; buyer behaviour; Canadian demographics; internal and external constraints; product; promotion; distribution; price. Lectures, text material and case studies.',3,3,NULL,NULL,'2013-08-07 18:30:53','2013-08-07 18:32:37'),(45,'Social Context of Business',3,360,'This course examines how business interacts with the larger society. It explores the development of modern capitalist society, and the dilemmas that organizations face in acting in a socially responsible manner. Students will examine these issues with reference to sustainable development, business ethics, globalization and developing countries, and political activity.',3,3,NULL,NULL,'2013-08-07 18:31:24','2013-08-07 18:31:24'),(46,'International Business',3,382,'An introduction to the world of international business. Economic foundations of international trade and investment. The international trade, finance, and regulatory frameworks. Relations between international companies and nation-states, including costs and benefits of foreign investment and alternative controls and responses. Effects of local environmental characteristics on the operations of multi-national enterprises.',3,3,NULL,NULL,'2013-08-07 18:31:50','2013-08-07 18:31:50'),(47,'Organizational Policy',3,423,'Focus on the primary functions of general management: the formation of a corporate strategy that relates the company\'s opportunities to its resources, competence, and leadership style. Measures to improve organization effectiveness.',3,3,NULL,NULL,'2013-08-07 18:32:28','2013-08-07 18:32:28'),(48,'Operations Management',3,472,'Design, planning, establishment, control, and improvement of the activities/processes that create a firm\'s final products and/or services. The interaction of operations with other business areas will also be discussed. Topics include forecasting, product and process design, waiting lines, capacity planning, inventory management and total quality management.',3,3,86,NULL,'2013-08-07 18:33:02','2013-08-12 14:18:51'),(49,'Calculus for Management',2,122,'Review of functions, exponents and radicals, exponential and logorithm. Examples of functions in business applications. Limits, continuity and derivatives. Differentiation of elementary functions. Antiderivatives. The definite integral. Techniques of Integration. Applications of differentiation and integration including differential equations. Trigonometric functions are not discussed in this course.',3,3,NULL,NULL,'2013-08-07 18:36:52','2013-08-07 18:36:52'),(50,'Linear Algebra and Probability',2,123,'Geometric vectors in low dimensions. Lines and planes. Dot and cross product. Linear equations and matrices. Matrix operations, properties and rank. Linear dependence and independence. Inverses and determinants. Linear programming and tableaux. Sample space, probability, combination of events. Conditional probability and Bayes Law. Random sampling. Random variables and common distributions.',3,3,NULL,NULL,'2013-08-07 18:37:49','2013-08-07 18:37:49'),(51,'Systems Analysis and Modelling',4,333,'First two phases of the software development life cycle. Techniques used to conduct system requirement analysis, practical application of the analyst role in identifying operational problems, defining information system requirements, working with technical and non-technical staff, and making recommendations for system improvement.',3,3,20,NULL,'2013-08-07 18:38:09','2013-08-07 19:14:35'),(52,'Managing Information Technology',4,331,'Tools and concepts necessary to manage information systems in an organization: hardware/software/telecom administration, knowledge discovery/management, web-technologies, and computer security. Focuses on both mechanical aspects of IT and conceptual understanding with regard to impact on business organizations',3,3,20,NULL,'2013-08-07 18:39:57','2013-08-07 19:14:57'),(53,'IT in Business',4,432,'Discusses the role of the information systems department within an organization, information systems resource management, staff organization and leadership, strategic systems, planning, and end-user computing. Focuses on key IT trends in industries such as banking, insurance, manufacturing, retailing & distribution, and health.',3,3,20,NULL,'2013-08-07 18:43:42','2013-08-07 19:15:12'),(54,'Managing Data and Databases',4,437,'Management of organizational data, implementation of database management systems, and the roles and responsibilities of data management personnel. Explores different models of data representation with an emphasis on the relational model; simple and complex SQL queries.',3,3,20,NULL,'2013-08-07 18:45:40','2013-08-07 19:15:29'),(55,'IS Project Management',4,450,'Practical principles of project management essential to successful IS development projects or other complex undertakings within an organization; includes methods for defining, planning, and scheduling activities and resources. Discusses managerial and behavioural issues.',3,3,20,NULL,'2013-08-07 18:47:21','2013-08-07 19:16:11'),(56,'Developing Business Apps',4,341,'Fundamental programming techniques, concepts, and data structures. Discusses modularization and maintainability. Emphasis on facilitating communication and understanding between systems analysts and programmers to support decision-making.',3,3,20,NULL,'2013-08-07 18:51:30','2013-08-07 19:15:48'),(57,'Accounting Information Systems',4,332,'Accounting cycles and information flows and the systems that manage those flows. Principals of systems development and data management as relates to accounting information. Relationship between accounting applications and transaction processing systems. Practical experience with accounting packages',3,3,27,NULL,'2013-08-07 18:54:00','2013-08-07 19:16:28'),(58,'IT Consulting',4,339,'Examination of the full \"life-cycle\" from initial contact to project termination. How an IT consultant manages their practice.',3,3,20,NULL,'2013-08-07 18:57:11','2013-08-07 19:16:47'),(59,'IT in Financial Markets',4,430,'How IT has impacted various parts of the financial services sector including stock markets, brokerage houses, retail banking and insurance.',3,3,20,NULL,'2013-08-07 18:58:18','2013-08-07 19:17:02'),(60,'IT Implementation Management',4,431,'Exposure to a variety of real-life strategic and operational issues that arise when implementing IT. It may involve the selection process of an information technology, its introduction, implementation, management and/or improvement.',3,3,20,NULL,'2013-08-07 18:59:17','2013-08-07 19:17:19'),(61,'Topics in IS',4,434,'Current topics in the area of information systems',3,NULL,20,NULL,'2013-08-07 18:59:53','2013-08-07 19:28:57'),(62,'E-Business',4,440,'Build the knowledge base and skills needed to face today\'s electronic business challenges, opportunities, and issues. Explore important concepts, models, tools and applications related to e-business.',3,3,20,NULL,'2013-08-07 19:00:55','2013-08-07 19:14:05'),(63,'Business Intelligence and Data Analytics',4,442,'Introduction to the methods and tools for analyzing business data to improve business decision-making, focusing on extracting business intelligence by analyzing data and online content for various business applications.',3,3,30,NULL,'2013-08-07 19:03:23','2013-08-07 19:05:26'),(64,'Managing Knowledge with IT',4,444,'Types of organizational knowledge and their value for organizations, analyzing knowledge processes, and assessing tools and technologies for managing knowledge.',3,3,20,NULL,'2013-08-07 19:06:28','2013-08-07 19:06:28'),(65,'Technological Foundation for E-Commerce',4,454,'Technology trends and vocabulary pertaining to current technology developments in E-Commerce. Practical IT skills in web application design, including ASP, XML, etc. Discusses business issues affected by the introduction of e-technologies.',3,3,20,NULL,'2013-08-07 19:13:46','2013-08-07 19:13:46'),(66,'Case Analysis and Presentation',9,499,'Integration of core knowledge and practice for preparing and presenting case studies, including professor coaching, preparation and presentation feedback, presentation skills, leadership skills, team building skills, analytical skills, logical thinking, debating, persuasive communications and cross discipline work.',3,3,NULL,NULL,'2013-08-07 19:24:16','2013-08-07 19:24:16'),(67,'Management Accounting',7,361,'The role of management accounting information to support internal management decisions and to provide performance incentives',3,3,29,NULL,'2013-08-07 20:32:05','2013-08-07 20:32:05'),(68,'Cost Accounting',7,362,'An examination of a number of recurring issues in the area of decision-making and control, including cost allocation, alternative costing systems, and innovations in costing and performance measurement.',3,3,32,NULL,'2013-08-07 20:34:51','2013-08-07 20:39:33'),(69,'Development of Accounting Thought',7,455,'The conceptual underpinning of accounting thought, including its historical development and the modifications that have occurred over time. A review of accounting literature and its relevance to practice',3,3,33,NULL,'2013-08-07 20:40:32','2013-08-07 20:41:23'),(70,'Financial Reporting Valuation',7,452,'Models to determine firm value from accounting information and a broader perspective on key sources of information, key value drivers, in a setting where evaluating firm value is the ultimate purpose.',3,3,34,NULL,'2013-08-07 20:44:05','2013-08-07 20:44:35'),(71,'Advanced Financial Accounting',7,453,'Reporting relevant financial information subsequent to long term intercorporate investments. The preparation of consolidated financial statements with emphasis on their economic substance rather than legal form.',3,3,33,NULL,'2013-08-07 20:46:23','2013-08-07 20:46:23'),(72,'Financial Reporting',7,454,'An in-depth study of Canadian accounting standards and how Canadian corporations apply them in their financial reporting.',3,3,33,NULL,'2013-08-07 20:47:42','2013-08-07 20:47:42'),(73,'Management Control',7,463,'The theoretical frameworks for the examination and evaluation of management accounting and control systems. The technical aspects of accounting along with behavioural issues of management control.',3,3,32,NULL,'2013-08-07 20:48:14','2013-08-07 20:48:46'),(75,'Non-Profit Accounting',7,471,'The foundations and practices of non-profit accounting for organizations including government, volunteer, charitable, health care and educational. The framework to evaluate and understand emerging issues.',3,3,33,NULL,'2013-08-07 20:49:35','2013-08-07 20:49:35'),(76,'Principles of Auditing',7,475,'An introduction to basic auditing concepts and internal controls of an accounting system. Topics include current auditing standards, ethical conduct, legal liability, planning of an audit, sampling techniques, non-audit engagements, the study and evaluation of internal controls in an accounting system.',3,3,33,NULL,'2013-08-07 20:51:12','2013-08-07 20:51:12'),(77,'Internal Auditing',7,476,'The modern internal audit approach including operational and management audit practices within the internal audit framework. Topics include objectives of an internal audit, communication by internal auditors, planning audit projects, audit of EDP systems, audit testing, operational areas.',3,3,36,NULL,'2013-08-07 20:52:42','2013-08-07 20:52:42'),(78,'External Auditing',7,477,'The theory of auditing financial statements and the various complexities encountered in these audit environments. A thorough study of auditing standards, ethical conduct, communication by auditors, auditing in an EDP environment, audit of a small business, other reports and services provided by auditors and public accountants.',3,3,36,NULL,'2013-08-07 20:53:32','2013-08-07 20:53:32'),(79,'Business Taxation',7,486,'A study of the Income Tax Act as it applies to the taxation of individuals and corporations, including capital cost allowances, capital gains, corporate reorganisations, trusts and partnerships and administrative regulations. A review of consumption taxes.',3,3,37,NULL,'2013-08-07 20:55:29','2013-08-07 20:55:29'),(80,'Marketing Management 2',10,354,' The decision areas in marketing. Emphasis on the use of marketing theory and concepts in the solution of realistic marketing problems. Decision making in a marketing context using cases, some of which will be computer assisted, and readings.',3,3,38,NULL,'2013-08-08 23:37:14','2013-08-08 23:37:14'),(81,'Marketing Research',10,451,'Theoretical techniques and procedures common in marketing research. Topics include: research design, sampling, questionnaire design, coding, tabulating, data analysis (including statistical techniques). Specialized topics may encompass advertising, motivation and product research; ',3,3,39,NULL,'2013-08-08 23:40:58','2013-08-08 23:40:58'),(82,'Consumer Behavior',10,452,'A study of basic factors influencing consumer behaviour. Attention is focused on psychological, sociological and economic variables including motivation, learning, attitude, personality, small groups, social class, demographic factors and culture, to analyze their effects on purchasing behaviour.',3,3,38,NULL,'2013-08-08 23:42:46','2013-08-08 23:42:46'),(83,'Marketing Planning',10,357,'Marketing Planning is designed as a capstone to previous marketing courses; Structured approach to developing a marketing plan, proceeding from corporate mission and objectives through to detailed marketing mix programs. Lectures, discussions and cases. A field project provides marketing planning experience.',3,3,40,NULL,'2013-08-08 23:44:44','2013-08-08 23:44:44'),(84,'Advertising Management',10,453,'Surveys advertising and promotion in Canadian context. Examines activities as they relate to advertisers, the advertising agency and media. Stresses advertising by objectives as the approach to developing strategy and tactics. Real examples from current campaigns are the focal point of class discussions.',3,3,41,NULL,'2013-08-08 23:46:59','2013-08-08 23:46:59'),(85,'Management of Small Enterprises',9,464,'The distinctive characteristics, risks, opportunities and rewards inherent in the ownership and management of a small enterprise. It will assist students in judging the appropriateness of an entrepreneurial career and in selecting and timing a specific venture.',3,3,19,NULL,'2013-08-08 23:53:26','2013-08-08 23:53:26'),(86,'Marketing and Society',10,351,' The social issues and concerns affecting marketing management are examined and the two way relationship between marketing and social change is explored. Particular attention is paid to consumerism, government regulation in marketing, corporate social responsibility, social marketing and marketing role in a conserve society.',3,3,38,NULL,'2013-08-08 23:54:47','2013-08-08 23:54:47'),(87,'Services Marketing',10,355,'Services are fleeting and involve direct contact between the supplier and the buyer. Inventories disappear every time an aircraft takes off or the night passes for an hotel. Yet services have become the largest sector in modern Western economy and their importance shows every sign of continuing to grow. This course focuses on the key differences between product and services marketing and the skills that are necessary for the services sector.',3,3,38,NULL,'2013-08-08 23:56:07','2013-08-08 23:56:07'),(88,'New Products',10,365,'New products will follow the new product introduction process from idea generation to post introduction. It will use ideas developed in marketing, production and policy. It will use cases and projects and will involve a real life new product project. In the average firm today, 40% of sales come from products not being sold five years ago. The ability of the firm to innovate is at the heart of long term success.',3,3,38,NULL,'2013-08-08 23:56:59','2013-08-08 23:56:59'),(89,'Brand Management',10,438,'Looks at the decisions a brand manager in a major consumer goods company takes. It examines, in particular, the breakdown of advertising and sales promotion expenditures. It looks at the short term nature of the decisions taken. It will concentrate on the vast amount of new information available to brand managers today, especially in the form of scanner data.',3,3,38,NULL,'2013-08-08 23:57:41','2013-08-08 23:57:41'),(90,'Sales Management',10,455,'Responsibilities of the sales manager as they relate to the sales force. These include the selection of process, training alternatives, compensation and incentive plans, supervision and evaluation and budgeting and forecasting. Case studies and discussions of sales force models are used.',3,3,38,NULL,'2013-08-08 23:58:22','2013-08-08 23:58:22'),(91,'Business to Business Marketing',10,456,'Decision-making and management of the marketing effort in a business to business (b-to-b) context, including the b-to-b marketing system; b-to-b purchasing; researching the b-to-b market; product, price distribution, selling and advertising decisions; strategies for business markets.',3,3,38,NULL,'2013-08-08 23:59:06','2013-08-08 23:59:06'),(92,'Retail Management',10,459,'Principles and methods of marketing management as applied to retailing, including strategy and tactics: market structure; consumer behaviour; competition; financial management; human resources planning; promotion; presentation; merchandising; operations; pricing; planning and attaining retail profits. Lectures, text material, outside reading, planned retail visiting, cases.',3,3,38,NULL,'2013-08-08 23:59:50','2013-08-08 23:59:50'),(93,'International Marketing Management',10,483,'Marketing management considerations of a company seeking to extend beyond its domestic market. Required changes in product, pricing, channel, and communications policies. Attention to international trade and export marketing in the Canadian context.',3,3,43,NULL,'2013-08-09 00:02:31','2013-08-09 00:02:31'),(94,'Management in Global Context',9,356,'Contemporary issues in international management illustrating unique challenges faced in IB, including legal and political foundations of international management, cross-cultural awareness, global mindset, global leadership, building effective international workforce and operations.',3,3,NULL,44,'2013-08-09 17:22:49','2013-08-09 17:22:49'),(95,'International Business Law',9,391,'Introduction to the legal aspects of foreign trade and investment transactions. Forms and documentation of types of foreign trade contracts. Conflict avoidance, arbitration, and litigation arising from international transactions. Government regulation of foreign trade. Legal aspects of the international transfer of investments and technology. Conventions and institutions of international economic cooperation (e.g. GATT, ICC, IMF, etc.).',3,3,NULL,44,'2013-08-09 17:23:49','2013-08-09 20:25:26'),(96,'Managing in Asia',9,394,'Environmental aspects, Eastern value systems and distinct patterns of management in the Asia-Pacific region. Patterns of Chinese, Japanese, Korean, Taiwanese and other management philosophies, practices and styles. Interaction between these theories and practices and those of the West and Canada will be contrasted.',3,3,NULL,44,'2013-08-09 17:24:34','2013-08-09 17:24:34'),(97,'Managing in Europe',9,395,'Current social, economic and trade developments in the rapidly-evolving European arena. Focus on both the expanding EU and integrating with emerging market economies and Central and Eastern Europe. Emphasis on managing in the expanded opportunities and challenges facing international and Canadian managers.',3,3,NULL,44,'2013-08-09 17:27:01','2013-08-09 17:27:01'),(98,'Independent Study in International Business',9,401,'Independent study in international business.',3,3,NULL,NULL,'2013-08-09 17:28:11','2013-08-09 17:28:11'),(99,'Topis in International Business',9,433,'Current topics in the area of international business. Topics will be selected from important current issues in international business.',3,3,NULL,44,'2013-08-09 17:29:21','2013-08-09 17:29:21'),(100,'Managing in North America',9,481,'Analysis of corporate strategies in the context of Canada-United States-Mexico Free Trade Agreement. Emphasis on public policy\'s impact on corporate decision-making and implications for management. Examines bilateral experience of major industrial sectors compared with global corporate strategies. Theoretical and empirical literature combined with industrial histories, policy and management case studies.',3,3,NULL,44,'2013-08-09 17:30:15','2013-08-09 17:30:15'),(101,'Global Economic Competitiveness',9,493,'How nations achieve and maintain competitiveness in the rapidly globalizing world economy. Studies the stages of evolution of world competitiveness in 46 nations, incorporating the latest practical business theories and case studies on the dynamics of effective globalization ventures.',3,3,44,NULL,'2013-08-09 17:31:16','2013-08-09 17:31:16'),(102,'International Finance 1',5,482,'The international financial environment as it affects the multinational manager. Balance of payments concepts, adjustment process of the external imbalances and the international monetary system. In depth study of the institutional and theoretical aspects of foreign exchange markets; international capital markets, including Eurobonds and eurocredit markets.',3,3,19,NULL,'2013-08-09 17:32:47','2013-08-09 17:32:47'),(104,'International Finance 2',5,492,'Focus on the operational problems of financial management in the multinational enterprise: Financing of international trade, international capital budgeting, multinational cost of capital, working capital management; International banking and recent developments in international capital markets.',3,3,46,NULL,'2013-08-09 17:37:09','2013-08-09 17:37:09'),(105,'International Employment Relations',11,459,'Examines employment relations systems of other nations including those of the European Union and the Pacific rim, including the existing industrial relations institutional structure, the historical and recent developments in these systems, the role of multi-national corporations, as well as the current economic and political context.',3,3,NULL,NULL,'2013-08-09 17:39:33','2013-08-09 17:39:33'),(106,'International Business Policy',12,383,'Development and application of conceptual approaches to general management policy and strategy formulation in multinational business involvement (exporting, licensing, contractual arrangements, turnkey projects, joint ventures, consortia); technology transfer, location and ownership strategies: competitive multinational relationships. Emphasis on pragmatic analysis, using case studies.',3,3,44,NULL,'2013-08-09 17:41:10','2013-08-09 17:41:10'),(107,'Managing Globalization',12,469,'This course explores economic and social consequences of globalization, focusing on the most pertinent issues at the time. Topics include the existing global imbalances; the opportunities and risks presented by large cross border capital flows; and the role of institutions, and organizational and policy responses in crisis hit countries.',3,3,47,NULL,'2013-08-09 17:43:00','2013-08-09 17:43:00'),(108,'Strategies for Developing Countries',12,475,'Strategic management challenges in developing and emerging economies. Focus on strategies that foster both firm competitiveness and economic development, including: technological capabilities, new forms of organization, small and large firms, global production, social impact, global standards and governance.',3,3,NULL,NULL,'2013-08-09 17:49:08','2013-08-09 17:49:08'),(110,'Cross Cultural Management',13,380,'Addresses dilemmas and opportunities that managers experience in international, multicultural environments. Development of conceptual knowledge and behavioural skills (e.g. bridging skills, communication, tolerance of ambiguity, cognitive complexity) relevant to the interaction of different cultures in business and organizational settings, using several methods including research, case studies and experiential learning.',3,3,NULL,NULL,'2013-08-09 17:56:13','2013-08-09 17:56:13'),(111,'Fundamentals of Entrepreneurship',12,362,'Study of the key aspects involved in starting and managing a new venture: identifying opportunities and analyzing new venture ideas, identifying common causes of failure and strategies for success, understanding intellectual property systems, comparison of multiple modes of funding. Applies to for-profit and not-for-profit start-ups.',3,3,NULL,NULL,'2013-08-09 22:14:33','2013-08-09 22:49:18'),(112,'Entrepreneurship in Practice',12,364,'Provides hands-on experience with the development of an entrepreneurial venture or a contribution to an existing entrepreneurial venture. Involves the creation of a venture development or business plan. Applicable to many kinds of new ventures, both private companies and social enterprises.',3,3,48,NULL,'2013-08-09 22:58:29','2013-08-09 23:09:05'),(113,'Business Law 1',9,364,'An introduction to the legal system and basic legal principles affecting business. Tort negligence, contracts, forms of business organization, creditors\' rights and bankruptcy.',3,3,NULL,NULL,'2013-08-10 15:45:56','2013-08-10 15:45:56'),(114,'Technological Entrepreneurship',9,465,'Concentrating on entrepreneurship and enterprise development, particular attention is given to the start-up, purchasing and management of small to medium-sized industrial firms in an environment that would appeal to Engineering students. The focal point is in understanding the dilemmas faced by entrepreneurs, resolving them, developing a business plan and the maximum utilization of the financial, marketing and human resources that make for a successful operation.',3,3,19,NULL,'2013-08-10 15:47:02','2013-08-10 15:47:02'),(115,'Business-Government Relations',12,365,'The political environment in which business organizations operate: how governments control, regulate, promote, and compete with the private sector and how corporate policy responds to, and seeks to influence, these activities.',3,3,NULL,NULL,'2013-08-10 15:48:10','2013-08-10 15:48:10'),(116,'Topics in Entrepreneurship',12,432,'Specialized advanced topic in entrepreneurship',3,3,48,NULL,'2013-08-10 15:49:06','2013-08-10 15:49:06'),(117,'Social Entrepreneurship and Innovation',12,438,'Explores key concepts associated with social entrepreneurship and social innovation – the application of principles of entrepreneurship and innovation to solve social problems through social ventures, enterprises and not-for-profit organizations. Focuses on the social economy, including how the market system can be leveraged to create social value',3,3,NULL,NULL,'2013-08-10 15:50:03','2013-08-10 15:50:03'),(118,'Strategies for Sustainability',12,440,'This course explores the relationship between economic activity, management, and the natural environment. Using readings, discussions and cases, the course will explore the challenges that the goal of sustainable development poses for our existing notions of economic goals, production and consumption practices and the management of organizations.',3,3,NULL,NULL,'2013-08-10 15:51:04','2013-08-10 15:51:04'),(119,'Industry Analysis & Competitive Strategy',12,445,'Analysis of industry structure, macro-environment, and evolution. Evaluation of strategic position, behaviour, and intent of organizations within industry context. Development of strategic recommendations for these firms.',3,3,NULL,NULL,'2013-08-10 15:51:50','2013-08-10 15:51:50'),(120,'Managing Innovation',12,460,'Firms face difficulties in developing new products. This course examines the new product development process to understand why problems occur and what managers can do. Topics include the creative synthesis of market and technology; the coordination of functions; and the strategic connection between the project and the strategy.',3,3,NULL,NULL,'2013-08-10 15:52:32','2013-08-10 15:52:32'),(121,'Leadership',13,321,'Leadership theories provide students with opportunities to assess and work on improving their leadership skills. Topics include: the ability to know oneself as a leader, to formulate a vision, to have the courage to lead, to lead creatively, and to lead effectively with others.',3,3,49,NULL,'2013-08-10 15:54:02','2013-08-10 15:54:02'),(123,'Introduction to Labour-Management Relations',11,294,'An introduction to labour-management relations, the structure, function and government of labour unions, labour legislation, the collective bargaining process, and the public interest in industrial relations.',3,3,NULL,NULL,'2013-08-10 17:45:25','2013-08-10 17:45:25'),(124,'Collective Bargaining',11,496,'Principles of collective bargaining in Canada and abroad. Problem oriented. Mock collective bargaining sessions provide an opportunity for students to apply knowledge gained.',3,3,50,NULL,'2013-08-10 17:50:14','2013-08-10 17:50:14'),(125,'Human resources Management',13,423,'Issues involved in personnel administration. Topics include: human resource planning, job analysis, recruitment and selection, training and development, performance appraisal, organization development and change, issues in compensation and benefits, and labour-management relations.',3,3,49,NULL,'2013-08-10 17:51:01','2013-08-10 17:51:01'),(126,'Occupational Health and Safety',11,449,'Examines the public policy of occupational health and safety in Canada as well as the dynamics of contemporary occupational health and safety management. Topics include occupational safety and health, human rights and workers\' compensation legislation, accident prevention and investigation, ergonomics, safety training, and workers\' compensation claims management.',3,3,50,NULL,'2013-08-10 17:53:34','2013-08-10 17:53:34'),(127,'Globalization and Labour Policy',11,492,'Examination of labour policy in the context of globalization. The North American Wagner Act model is critically reviewed in light of the global economy. New models of industrial relations regulation are studied that ensure that economic and social benefits are equitably distributed.',3,3,50,NULL,'2013-08-10 17:55:04','2013-08-10 17:55:04'),(128,'Labour Law',11,494,'Introduction to the basic concepts of labour law relevant to the practice of industrial relations. Historical development of labour law in certain social and legal systems and the culmination in the legislative enactments and jurisprudence of Canadian jurisdictions and certain comparative foreign models.',3,3,50,NULL,'2013-08-10 17:57:25','2013-08-10 17:57:25'),(129,'Labour Relations: Public Sector',11,495,'Labour relations in federal, provincial, municipal, and quasi-public services such as hospitals, schools, government agencies and boards. Contentious current issues in public service labour relations and compare and analyze the alternative methods that have been evolved to deal with them.',3,3,50,NULL,'2013-08-10 17:58:03','2013-08-10 17:58:03'),(130,'Contract Administration',11,497,'The processes of grievance handling and arbitration under the terms of collective bargaining agreements. Substantive and procedural issues as well as behavioural and policy aspects of contract administration.',3,3,50,NULL,'2013-08-10 17:58:42','2013-08-10 17:58:42'),(131,'Negotiations and Conflict Resolution',13,325,'A conceptual framework to guide participants through negotiation and conflict resolution process.',3,3,49,NULL,'2013-08-10 17:59:30','2013-08-10 17:59:30'),(132,'Managing Organizational Change',13,421,'Organizational change theory and techniques are examined with an emphasis on techno-structural interventions such as Quality-of-Work-Life approaches. Through simulations and case-studies, the course explores initiatives in organizational change, primarily in contemporary Canadian organizations. It also includes opportunities for \"hands-on\" experience in work and organization redesign.\r\n',3,3,49,NULL,'2013-08-10 18:00:22','2013-08-10 18:00:22'),(133,'Career Theory and Development',13,440,'Includes state of the art theory and research on careers and opportunity for exploration and development of personal career goals and dreams. Analytical and practical skills are honed through the study of careers of \"real life\" individuals as presented in films, panels of guest speakers, and interview assignments.',3,3,49,NULL,'2013-08-10 18:04:36','2013-08-10 18:04:36'),(134,'Topics in Marketing 1',10,434,'Current topics in marketing.',3,3,38,NULL,'2013-08-10 18:22:10','2013-08-10 18:22:10'),(135,'Operations Research',6,373,'A realistic experience of analytical models which have been successfully applied in several areas of managerial decision-making like marketing, finance and IS. Emphasis on the formulation of problems, their solution approaches, limitations, underlying assumptions and practical use. Topics include: decision analysis, project management, simulation, linear and integer programming, sensitivity analysis',3,3,18,NULL,'2013-08-10 18:25:28','2013-08-10 18:27:37'),(136,'Operations Analysis',6,431,'Optimizing cycle-time, throughput and inventory performance of operations, including analytical modeling as well as simulation.',3,3,52,NULL,'2013-08-10 18:31:03','2013-08-10 18:31:03'),(137,'Operations Strategy ',6,402,'Effective management at the operating unit level, including the concept of \"operations strategy\", action-oriented tools and frameworks for designing and managing operations innovation, effective use of operations-related technologies and supply chain ',3,3,NULL,NULL,'2013-08-10 18:32:09','2013-08-10 18:32:09'),(138,'Introduction to Logistics Management',6,403,'Managing logistics systems, including transportation management, facility location, procurement, distribution management, and supply chain management',3,3,52,NULL,'2013-08-10 18:32:58','2013-08-10 18:32:58'),(139,'Quality Management',6,405,'Integrated view of quality management, quality systems and improvement techniques including tools and methodologies for quality improvement, six-sigma methodology.',3,3,NULL,NULL,'2013-08-10 18:33:51','2013-08-10 18:33:51'),(140,'Supplier Management',6,415,'Strategic role of purchasing, supplier selection, supplier relationship management, international sourcing, E-procurement, price determination, purchasing services, and auctions.',3,3,NULL,NULL,'2013-08-10 18:34:41','2013-08-10 18:34:41'),(141,'Applied Optimization',6,479,'Applications of optimization models to management problems, including Linear Programming, Integer Programming and Nonlinear Programming.',3,3,53,NULL,'2013-08-10 18:36:27','2013-08-10 18:36:27'),(142,'Applied Time Series Analysis Managerial Forecasting',6,575,'Management applications of time series analysis. Starting with ratio-to-moving average methods, the course deals successively with Census 2, exponential smoothing methods, the methodology introduced by Box and Jenkins, spectral analysis and time-series regression techniques. Computational aspects and applications of the methodology are emphasized.',3,3,18,NULL,'2013-08-10 18:37:52','2013-08-10 18:37:52'),(143,'Simulation of Management Systems',6,578,'Building simulation models of management systems. Design of simulation experiments and the analysis and implementation of results. Students are expected to design a complete simulation of a real problem using a standard simulation language',3,3,18,NULL,'2013-08-10 18:38:47','2013-08-10 18:38:47'),(144,'Organizational Research Methods',13,409,'Field research in organizational behaviour.',3,3,49,NULL,'2013-08-10 18:51:29','2013-08-10 18:51:29'),(145,'Managing Organizational Teams',13,420,'Theory, research, and applications. Principles of team processes and effectiveness in organizational settings, specifically the theoretical developments and empirical findings of group dynamics and team effectiveness, and practical strategies and skills for successful management of organizational teams.',3,3,49,NULL,'2013-08-10 18:52:05','2013-08-10 18:52:05'),(148,'Organizational Behavior for Course Counsellors',13,429,'Examination of behaviour in organizations, coupled with training in teaching methods, to prepare students to team teach a section of MGCR 222. Selection of course counsellors is made toward the end of the preceding winter term. Only students thus selected will be permitted to register for this course.',3,3,49,NULL,'2013-08-10 18:54:53','2013-08-10 18:54:53'),(149,'Topics in Organizational Behavior',13,434,'This is an advanced course for students with a special interest in Organizational Behaviour. Topics will be selected from current issues or themes in literature',3,3,49,NULL,'2013-08-10 18:55:49','2013-08-10 18:55:49'),(150,'Compensation Management',13,525,'Compensation policies and practices, consistent with motivational theories, are examined. Topics include: design and evaluation of job evaluation systems, salary structures, and performance-based pay; compensation of special employee groups; and current pay equity laws. Projects and simulations provide \"hands-on\" experience in the use of compensation techniques.',3,3,54,NULL,'2013-08-10 19:12:25','2013-08-10 19:12:25'),(151,'Topics in Policy 1',12,434,'This is a specialized course covering an advanced topic in strategy and organization.',3,3,NULL,NULL,'2013-08-11 16:39:58','2013-08-11 16:39:58'),(152,'Strategy and Organization',12,470,'This course explores how strategic change affects the organization and how the organization can be designed to realize its strategy more effectively. It will examine how strategic choices affect organizational structures, processes, culture, human resource policies, leadership styles, etc. and how the organization can be aligned with the organizational mission.',3,3,NULL,NULL,'2013-08-11 16:40:48','2013-08-11 16:40:48'),(153,'Business in Society',12,567,'Examines different ideologies; business ethics and values; the corporation and its constituencies; the social impact of corporate decisions. The focus of this course is on the interaction between business organizations and society and on incorporating social impact analysis into strategic management.',3,3,NULL,NULL,'2013-08-11 16:41:39','2013-08-11 16:41:39'),(154,'Ethics in Management',12,450,' An examination of the economic, legal and ethical responsibilities of managers in both private and public organizations. Through readings, case studies, discussions and projects the class evaluates alternative ethical systems and norms of behaviour and draws conclusions as to the right, proper and just decisions and actions in the face of moral dilemmas. The focus of this course is on the decision process, values and consistency of values of the individual and on the impact of systems control and incentives on managerial morality.',3,3,NULL,NULL,'2013-08-11 16:42:34','2013-08-11 16:42:34'),(155,'International Business History',12,435,'This course covers the evolution of modern business institutions from their roots in the early middle ages to the modern era. Covering economic issues in the context of arts and culture, it offers a \"distant mirror on globalization.\"',3,3,NULL,NULL,'2013-08-11 16:44:44','2013-08-11 16:44:44'),(156,'Managing Organizational Politics',12,468,'Power and politics can be mechanisms of control that maintain the status quo or they can be used as a force for change. Students learn how to recognize politics and use power. There is also a strong focus on the ethical implications.',3,3,NULL,NULL,'2013-08-11 16:47:45','2013-08-11 16:47:45'),(157,'Microeconomic Analysis and Applications',8,208,'A university-level introduction to demand and supply, consumer behaviour, production theory, market structures and income distribution theory.',3,3,NULL,NULL,'2013-08-11 16:53:41','2013-08-11 16:53:41'),(158,'Macroeconomic Analysis and Applications',8,209,'A university-level introduction to national income determination, money and banking, inflation, unemployment and economic policy.',3,3,NULL,NULL,'2013-08-11 16:54:25','2013-08-11 16:54:25'),(159,'Industrial Organization',8,305,'The course analyzes the structure, conduct, and performance of industries, particularly but not exclusively in Canada. Topics include effects of mergers, barriers to entry, product line and promotion policies, vertical integration, and R & D policies of firms.',3,3,56,NULL,'2013-08-11 16:56:48','2013-08-11 17:06:21'),(160,'Microeconomic Theory',8,230,'The introductory course for Economics Major students in microeconomic theory. In depth and critical presentation of the theory of consumer behaviour, theory of production and cost curves, theory of the firm, theory of distribution, welfare economics and the theory of general equilibrium.',NULL,6,NULL,NULL,'2013-08-11 18:23:07','2013-08-11 18:23:07'),(161,'Introduction to Economic Theory: Honours',8,250,'An intermediate level microeconomics course. Includes theory of exchange, theory of consumer behaviour, theory of production and cost curves, theory of the firm, theory of distribution; general equilibrium and welfare economics. The assumptions underlying the traditional neo-classical approach to economic theory will be carefully specified.',NULL,6,58,NULL,'2013-08-11 18:25:21','2013-08-11 18:38:10'),(162,'Calculus 1',2,140,'Review of functions and graphs. Limits, continuity, derivative. Differentiation of elementary functions. Antidifferentiation. Applications.',3,3,NULL,NULL,'2013-08-11 18:26:46','2013-08-11 18:26:46'),(163,'Calculus 2',2,141,'The definite integral. Techniques of integration. Applications. Introduction to sequences and series.',3,4,59,NULL,'2013-08-11 18:27:40','2013-08-11 18:43:33'),(164,'Labour Markets and Wages',8,306,'Examination of the implications on wage structures of differences in job conditions, levels and type training, long-term employment relationships, unionization etc. A variety of socioeconomic policy issues including subsidies for higher education, government regulation of workplace safety, and the role and treatment of women in today\'s labour force are explored.',3,3,60,NULL,'2013-08-11 18:34:11','2013-08-11 19:03:48'),(165,'Calculus 1 with Precalculus',2,139,'Review of trigonometry and other Precalculus topics. Limits, continuity, derivative. Differentiation of elementary functions. Antidifferentiation. Applications.',4,4,NULL,NULL,'2013-08-11 18:40:14','2013-08-11 18:40:14'),(167,'Calculus A',2,150,'Functions, limits and continuity, differentiation, L\'Hospital\'s rule, applications, Taylor polynomials, parametric curves, functions of several variables.',3,4,NULL,NULL,'2013-08-11 18:41:48','2013-08-11 18:41:48'),(168,'Sociology of Work and Industry',14,312,'The development of the world of work from the rise of industrial capitalism to the postindustrial age. Responses of workers and managers to changing organizational, technological and economic realities. Interrelations between changing demands in the workplace and the functioning of the labour market. Canadian materials in comparative perspective.',3,3,NULL,NULL,'2013-08-11 18:55:55','2013-08-11 18:55:55'),(169,'Gender and Work',14,321,'Focus on men\'s and women\'s work in North American societies, historically and contemporarily, in order to understand the dynamisms of gender (in)equality in and outside of the home. Topics explored include: housework; the relationship(s) between gender, organizations and bureaucracy; emotional labour; occupational segregation and stratification; sexual harassment; and work-family policy.',3,3,NULL,NULL,'2013-08-11 18:56:33','2013-08-11 18:56:33'),(170,'Calculus 3',2,222,'Taylor series, Taylor\'s theorem in one and several variables. Review of vector geometry. Partial differentiation, directional derivative. Extreme of functions of 2 or 3 variables. Parametric curves and arc length. Polar and spherical coordinates. Multiple integrals.',3,3,61,NULL,'2013-08-11 21:37:47','2013-08-11 21:37:47'),(171,'Linear Algebra and Geometry',2,133,'Systems of linear equations, matrices, inverses, determinants; geometric vectors in three dimensions, dot product, cross product, lines and planes; introduction to vector spaces, linear dependence and independence, bases; quadratic loci in two and three dimensions.\r\nRestriction: Not open to students who have taken or are taking MATH 123, MATH 130, MATH 131, MATH 221 or MATH 134.',3,3,NULL,NULL,'2013-08-11 21:41:25','2013-08-11 21:41:25'),(172,'Algebra 1',2,235,'Sets, functions and relations. Methods of proof. Complex numbers. Divisibility theory for integers and modular arithmetic. Divisibility theory for polynomials. Rings, ideals and quotient rings. Fields and construction of fields from polynomial rings. Groups, subgroups and cosets; group actions on sets.',3,3,62,NULL,'2013-08-11 21:43:18','2013-08-11 21:43:18'),(173,'Algebra 2',2,236,'Linear equations over a field. Introduction to vector spaces. Linear mappings. Matrix representation of linear mappings. Determinants. Eigenvectors and eigenvalues. Diagonalizable operators. Cayley-Hamilton theorem. Bilinear and quadratic forms. Inner product spaces, orthogonal diagonalization of symmetric matrices. Canonical forms.',3,3,63,NULL,'2013-08-11 21:44:26','2013-08-11 21:44:26'),(174,'Analysis 1',2,242,'A rigorous presentation of sequences and of real numbers and basic properties of continuous and differentiable functions on the real line.',3,3,61,NULL,'2013-08-11 21:45:30','2013-08-11 21:45:30'),(175,'Analysis 2',2,243,'Infinite series; series of functions; power series. The Riemann integral in one variable. A rigorous development of the elementary functions.',3,3,64,NULL,'2013-08-11 21:46:38','2013-08-11 21:46:38'),(176,'Advanced Calculus',2,314,'Derivative as a matrix. Chain rule. Implicit functions. Constrained maxima and minima. Jacobians. Multiple integration. Line and surface integrals. Theorems of Green, Stokes and Gauss. Fourier series with applications.',3,3,65,NULL,'2013-08-11 21:48:44','2013-08-11 21:48:44'),(177,'Ordinary Differential Equations',2,315,'First order ordinary differential equations including elementary numerical methods. Linear differential equations. Laplace transforms. Series solutions.',3,3,66,62,'2013-08-11 21:50:50','2013-08-11 21:50:50'),(178,'Probability',2,323,'Sample space, events, conditional probability, independence of events, Bayes\' Theorem. Basic combinatorial probability, random variables, discrete and continuous univariate and multivariate distributions. Independence of random variables. Inequalities, weak law of large numbers, central limit theorem.',3,3,61,NULL,'2013-08-11 21:52:06','2013-08-11 21:52:06'),(179,'Statistics',2,324,'Sampling distributions, point and interval estimation, hypothesis testing, analysis of variance, contingency tables, nonparametric inference, regression, Bayesian inference.',3,3,67,NULL,'2013-08-11 21:53:22','2013-08-11 21:53:22'),(180,'Principles of Statistics 1',2,203,'Examples of statistical data and the use of graphical means to summarize the data. Basic distributions arising in the natural and behavioural sciences. The logical meaning of a test of significance and a confidence interval. Tests of significance and confidence intervals in the one and two sample setting (means, variances and proportions).',3,3,NULL,NULL,'2013-08-11 21:55:41','2013-08-11 21:55:41'),(181,'Principles of Statistics 2',2,204,'The concept of degrees of freedom and the analysis of variability. Planning of experiments. Experimental designs. Polynomial and multiple regressions. Statistical computer packages (no previous computing experience is needed). General statistical procedures requiring few assumptions about the probability model.',3,3,68,NULL,'2013-08-11 21:56:51','2013-08-11 21:56:51'),(182,'Complex Variables',2,316,'Algebra of complex numbers, Cauchy-Riemann equations, complex integral, Cauchy\'s theorems. Taylor and Laurent series, residue theory and applications.',3,3,69,NULL,'2013-08-11 21:58:25','2013-08-11 21:59:08'),(183,'Honours Ordinary Differential Equations',2,325,'First and second order equations, linear equations, series solutions, Frobenius method, introduction to numerical methods and to linear systems, Laplace transforms, applications.',3,3,66,NULL,'2013-08-11 22:02:47','2013-08-11 22:02:47'),(184,'Intermediate Calculus',2,262,'Series and power series, including Taylor\'s theorem. Brief review of vector geometry. Vector functions and curves. Partial differentiation and differential calculus for vector valued functions. Unconstrained and constrained extremal problems. Multiple integrals including surface area and change of variables.',3,3,70,NULL,'2013-08-11 22:05:21','2013-08-11 22:05:21'),(185,'Ordinary Differential Equations for Engineers',2,263,'First order ODEs. Second and higher order linear ODEs. Series solutions at ordinary and regular singular points. Laplace transforms. Linear systems of differential equations with a short review of linear algebra.',3,3,NULL,71,'2013-08-11 22:06:44','2013-08-11 22:06:44'),(186,'Numerical Analysis',2,317,'Error analysis. Numerical solutions of equations by iteration. Interpolation. Numerical differentiation and integration. Introduction to numerical solutions of differential equations.',3,3,73,NULL,'2013-08-11 22:11:38','2013-08-11 22:11:38'),(187,'Linear Algebra',2,223,'Review of matrix algebra, determinants and systems of linear equations. Vector spaces, linear operators and their matrix representations, orthogonality. Eigenvalues and eigenvectors, diagonalization of Hermitian matrices. Applications.',3,3,62,NULL,'2013-08-11 22:15:07','2013-08-11 22:15:07'),(188,'Introduction to Partial Differential Equations',2,319,'First order equations, geometric theory; second order equations, classification; Laplace, wave and heat equations, Sturm-Liouville theory, Fourier series, boundary and initial value problems.',3,3,74,NULL,'2013-08-11 22:24:24','2013-08-11 22:24:24'),(189,'Nonlinear Dynamics and Chaos',2,326,'Linear systems of differential equations, linear stability theory. Nonlinear systems: existence and uniqueness, numerical methods, one and two dimensional flows, phase space, limit cycles, Poincare-Bendixson theorem, bifurcations, Hopf bifurcation, the Lorenz equations and chaos.',3,3,75,NULL,'2013-08-11 22:25:44','2013-08-11 22:25:44'),(190,'Discrete Structures 2',2,340,'Review of mathematical writing, proof techniques, graph theory and counting. Mathematical logic. Graph connectivity, planar graphs and colouring. Probability and graphs. Introductory group theory, isomorphisms and automorphisms of graphs. Enumeration and listing.',3,3,77,76,'2013-08-11 22:32:21','2013-08-11 22:32:21'),(191,'Dynamic Programming',2,407,'Sequential decision problems, resource allocation, transportation problems, equipment replacement, integer programming, network analysis, inventory systems, project scheduling, queuing theory calculus of variations, markovian decision processes, stochastic path problems, reliability, discrete and continuous control processes.',3,3,78,NULL,'2013-08-11 22:35:40','2013-08-11 22:35:40'),(192,'Majors Project',2,410,'A supervised project, requires departmental approval',NULL,3,NULL,NULL,'2013-08-11 22:36:48','2013-08-11 22:36:48'),(193,'Mathematical Programming',2,417,'An introductory course in optimization by linear algebra, and calculus methods. Linear programming (convex polyhedra, simplex method, duality, multi-criteria problems), integer programming, and some topics in nonlinear programming (convex functions, optimality conditions, numerical methods). Representative applications to various disciplines.',3,3,79,NULL,'2013-08-11 22:39:01','2013-08-11 22:39:01'),(194,'Regression and Analysis of Variance',2,423,'Least-squares estimators and their properties. Analysis of variance. Linear models with general covariance. Multivariate normal and chi-squared distributions; quadratic forms. General linear hypothesis: F-test and t-test. Prediction and confidence intervals. Transformations and residual plot. Balanced designs.',3,3,81,NULL,'2013-08-11 22:42:20','2013-08-11 22:42:20'),(195,'Introduction to Stochastic Processes',2,447,'Conditional probability and conditional expectation, generating functions. Branching processes and random walk. Markov chains, transition matrices, classification of states, ergodic theorem, examples. Birth and death processes, queueing theory.',3,3,67,NULL,'2013-08-11 23:09:30','2013-08-11 23:09:30'),(196,'Generalized Linear Model',2,523,'Modern discrete data analysis. Exponential families, orthogonality, link functions. Inference and model selection using analysis of deviance. Shrinkage (Bayesian, frequentist viewpoints). Smoothing. Residuals. Quasi-likelihood. Sliced inverse regression. Contingency tables: logistic regression, log-linear models. Censored data. Applications to current problems in medicine, biological and physical sciences. GLIM, S, software.',3,4,83,NULL,'2013-08-11 23:10:54','2013-08-11 23:11:34'),(197,'Nonparametric Statistics',2,524,'Distribution free procedures for 2-sample problem: Wilcoxon rank sum, Siegel-Tukey, Smirnov tests. Shift model: power and estimation. Single sample procedures: Sign, Wilcoxon signed rank tests. Nonparametric ANOVA: Kruskal-Wallis, Friedman tests. Association: Spearman\'s rank correlation, Kendall\'s tau. Goodness of fit: Pearson\'s chi-square, likelihood ratio, Kolmogorov-Smirnov tests. Statistical software packages used.',3,4,84,NULL,'2013-08-11 23:12:52','2013-08-11 23:12:52'),(198,'Sampling Theory and Applications',2,525,' Simple random sampling, domains, ratio and regression estimators, superpopulation models, stratified sampling, optimal stratification, cluster sampling, sampling with unequal probabilities, multistage sampling, complex surveys, nonresponse.',3,4,84,NULL,'2013-08-11 23:13:44','2013-08-11 23:13:44'),(199,'Introduction to Management',9,100,'To introduce freshman students to the field of management and integrate them into the Desautels Faculty of Management.',3,3,NULL,NULL,'2013-08-12 14:22:29','2013-08-12 14:22:29'),(200,'Expressive Analysis for Management',9,250,'To develop skills with respect to analysis, writing and presentation',3,3,NULL,NULL,'2013-08-12 14:23:01','2013-08-12 14:23:01'),(201,'Introductory Behavioural Neuroscience',15,211,'An introduction to contemporary research on the relationship between brain and behaviour. Topics include learning, memory and cognition, brain damage and neuroplasticity, emotion and motivation, and drug addiction and brain reward circuits. Much of the evidence will be drawn from the experimental literature on research with animals.',3,3,NULL,NULL,'2013-08-12 22:05:38','2013-08-12 22:05:38'),(202,'Cognition',15,213,'Where do thoughts come from? What is the nature of thought, and how does it arise in the mind and the brain? Cognition is the study of human information processing, and we will explore topics such as memory, attention, categorization, decision making, intelligence, philosophy of mind, and the mind-as computer metaphor.',3,3,NULL,NULL,'2013-08-12 22:13:13','2013-08-12 22:13:13'),(203,'Social Psychology',15,215,'The course offers students an overview of the major topics in social psychology. Three levels of analysis are explored beginning with individual processes (e.g., attitudes, attribution), then interpersonal processes (e.g., attraction, communication, love) and finally social influence processes (e.g., conformity, norms, roles, reference groups).',3,3,NULL,NULL,'2013-08-12 22:13:48','2013-08-12 22:13:48'),(204,'Inter-group Relations',15,331,'The course focuses on the social psychology of societal groups such as racial minorities, aboriginal groups and women. The ideological biases of current theories is first established. This is followed by a review of current theories and finally current controversies are explored including new forms of racism and affirmative action.',3,3,94,NULL,'2013-08-12 22:14:24','2013-08-12 23:14:06'),(205,'Introduction to Personality',15,332,'This course examines some of the major theories of personality, e.g., those of Freud, Rogers, and Bandura. Empirical research inspired by these theories will also be examined. Topics include the nature of human motivation, the role of the self-concept, and the consistency and stability of personality.',3,3,95,NULL,'2013-08-12 22:14:55','2013-08-12 23:19:02'),(206,'Personality and Social Psychology',15,333,'The course builds on and is an extension of Social Psychology (PSYC 215). Traditional approaches to person-situation interactions and a more dynamic approach based on recent research on goals and social cognition.',3,3,94,NULL,'2013-08-12 22:15:33','2013-08-12 23:20:01'),(207,'Research Methods in Social Psychology',15,351,'Designed to introduce students to the issues, strategies, and applications of various research methodologies in social psychology. Through demonstrations, exercises, and pilot studies, students will gain experience with lab and field methods using both correlational and experimental procedures. Classic and contemporary approaches will be examined.',7,3,94,98,'2013-08-12 22:20:00','2013-08-12 23:26:15'),(208,'Cognitive Psychology Laboratory',15,352,'Introduction to research methods and experimental techniques in cognitive psychology for exploring topics such as attention, memory, categorization, reasoning, and language processing.',3,3,99,98,'2013-08-12 22:23:58','2013-08-12 23:28:45'),(209,'Psychological Tests',15,406,'An introduction to the theory and practice of psychological measurement in health, educational, clinical and industrial/organizational settings. Attention to procedures for developing and validating tests and questionnaires. Techniques include: intelligence tests, projective tests, questionnaires, structured interviews, rating scales, and behavioural/performance tests.',3,3,97,NULL,'2013-08-12 22:25:15','2013-08-12 23:29:54'),(210,'Human Motivation',15,471,'The course is designed to explore questions such as \"Why do people often fail to reach their personal goals?\" Current goal-based and need-based theories of human motivation will be reviewed. The instructor will highlight the relevance of motivation research to the domains of education, sports and management.',3,3,94,NULL,'2013-08-12 22:25:58','2013-08-12 23:30:36'),(211,'Social Cognition and the Self',15,473,'This course examines the social psychological literature emphasizing a) social cognition - how people think about and make sense of their social experiences; and b) self theory - how people create and maintain a sense of identity. These frameworks will be applied to social psychological topics including close relationships, attitudes and self-esteem.',3,3,100,NULL,'2013-08-12 22:27:09','2013-08-12 23:33:47'),(212,'Interpersonal Relationships',15,474,'Psychological science approach to interpersonal relationships. Organized in terms of the development of relationships, focusing first on impression formation as a platform for the development of relationships. Then we focus on close relationships, examining interpersonal constructs (intimacy, trust, commitment) and reconsidering social cognitive constructs (attributions, schemas) in an interpersonal context.',3,3,101,NULL,'2013-08-12 22:27:40','2013-08-12 23:36:01'),(213,'Organismal Biology',16,111,'An introduction to the phylogeny, structure, function and adaptation of unicellular organisms, plants and animals in the biosphere.',5,3,NULL,NULL,'2013-08-12 22:37:16','2013-08-12 22:38:22'),(214,'Cell and Molecular Biology',16,112,'The cell: ultrastructure, division, chemical constituents and reactions. Bioenergetics: photosynthesis and respiration. Principles of genetics, the molecular basis of inheritance and biotechnology.',6,3,NULL,NULL,'2013-08-12 22:42:08','2013-08-12 22:42:08'),(215,'Essential Biology',16,115,'An introduction to biological science that emphasizes the manner in which scientific understanding is achieved and evolves and the influence of biological science on society. Topics will include cell structure and function, genetics, evolution, organ physiology, ecology and certain special topics that change from year to year.',3,3,NULL,NULL,'2013-08-12 22:43:14','2013-08-12 22:59:14'),(216,'Introduction to Psychology',15,100,'Introduction to the scientific study of mind and behavior, including basic concepts and methods in psychology while also highlighting the relevance of psychology to everyday life; attachment, aggression, depression, parenting and personality change.',3,3,89,NULL,'2013-08-12 22:44:27','2013-08-12 23:00:42'),(217,'Critical Thinking: Biases and Illusions',15,180,'The course provides students tools to become critical information consumers. Topics include: cognitive tools people use to make intuitive evaluations, factors that bias judgment, errors in calculation, and a general, conceptual introduction to statistical and methodological issues. Illustrative examples will range from medical and economic decision-making to illusions and fraud.',3,3,NULL,NULL,'2013-08-12 23:05:04','2013-08-12 23:05:04'),(218,'FYS: Mind-Body Medecine',15,199,'Health is influenced by biological, psychological and social factors. The interaction between these determinants in the onset, course and recovery from a variety of diseases (e.g. AIDS) will be highlighted. Students will select one phase of a particular illness (e.g. remission following breast cancer treatment) and explore the related biopsychosocial factors.',3,3,NULL,NULL,'2013-08-12 23:06:01','2013-08-12 23:06:01'),(219,'Introduction to Psychological Statistics',15,204,'The statistical analysis of research data; frequency distributions; graphic representation; measures of central tendency and variability; elementary sampling theory and tests of significance.',3,3,NULL,NULL,'2013-08-12 23:06:44','2013-08-12 23:06:44'),(220,'Perception',15,212,'Perception is the organization of sensory input into a representation of the environment. Topics include: survey of sensory coding mechanisms (visual, auditory, tactile, olfactory, gustatory), object recognition, spatial localization, perceptual constancies and higher level influences.',3,3,93,NULL,'2013-08-12 23:07:50','2013-08-12 23:09:48'),(221,'Statistics for Experimental Design',15,305,'An introduction to the design and analysis of experiments, including analysis of variance, planned and post hoc tests and a comparison of anova to correlational analysis.',3,3,97,NULL,'2013-08-12 23:24:04','2013-08-12 23:25:10');
/*!40000 ALTER TABLE `course_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_courses_program_groups`
--

DROP TABLE IF EXISTS `course_courses_program_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_courses_program_groups` (
  `program_group_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_courses_program_groups`
--

LOCK TABLES `course_courses_program_groups` WRITE;
/*!40000 ALTER TABLE `course_courses_program_groups` DISABLE KEYS */;
INSERT INTO `course_courses_program_groups` VALUES (1,10),(1,9),(1,8),(4,14),(4,13),(3,17),(3,16),(3,15),(3,9),(9,19),(9,24),(9,23),(9,22),(9,21),(9,20),(10,37),(10,36),(10,35),(10,34),(10,33),(10,32),(10,31),(10,30),(10,29),(10,28),(10,27),(10,26),(10,25),(11,55),(11,54),(11,53),(11,52),(11,51),(11,56),(12,65),(12,64),(12,63),(12,62),(12,61),(12,60),(12,59),(12,58),(12,57),(12,66),(13,36),(13,34),(13,33),(14,35),(14,79),(14,78),(14,77),(14,76),(14,75),(14,73),(14,72),(14,71),(14,70),(13,69),(13,68),(13,67),(15,84),(15,83),(15,82),(15,81),(15,80),(16,93),(16,92),(16,91),(16,90),(16,89),(16,88),(16,87),(16,86),(16,85),(17,94),(19,95),(19,107),(19,97),(19,96),(19,110),(19,106),(19,105),(19,104),(19,102),(19,103),(19,99),(19,98),(19,93),(19,108),(19,101),(19,100),(19,81),(20,33),(20,67),(21,34),(21,35),(21,68),(21,71),(21,70),(21,72),(21,73),(21,76),(21,79),(21,36),(22,112),(22,111),(23,67),(23,19),(23,52),(23,53),(23,88),(23,81),(23,90),(23,113),(23,114),(23,115),(23,116),(23,117),(23,118),(23,119),(23,120),(23,121),(24,19),(24,21),(24,20),(25,25),(25,26),(25,37),(25,22),(25,28),(25,102),(25,104),(25,31),(25,32),(25,27),(25,103),(26,51),(27,52),(27,57),(27,61),(27,60),(27,53),(27,58),(27,56),(27,59),(27,62),(27,54),(27,63),(27,64),(27,55),(27,65),(28,123),(28,124),(28,125),(29,126),(29,105),(29,127),(29,128),(29,129),(29,130),(29,121),(29,131),(29,132),(29,133),(30,80),(30,83),(30,81),(30,82),(31,86),(31,87),(31,88),(31,89),(31,93),(31,92),(31,91),(31,90),(31,84),(31,134),(32,135),(32,136),(33,24),(33,137),(33,142),(33,141),(33,140),(33,139),(33,138),(33,143),(34,121),(34,131),(34,110),(34,132),(34,125),(34,133),(34,145),(34,144),(34,146),(34,147),(34,148),(34,149),(34,150),(36,115),(36,118),(36,156),(36,154),(36,108),(37,95),(37,155),(37,106),(37,151),(37,119),(37,120),(37,107),(37,152),(37,153),(37,143),(19,29),(39,106),(39,119),(39,120),(39,107),(39,152),(40,155),(40,95),(40,159),(40,156),(40,154),(40,151),(40,115),(40,118),(40,108),(40,143),(41,123),(41,128),(41,124),(41,147),(42,126),(42,105),(42,127),(42,129),(42,130),(42,121),(42,131),(42,110),(42,146),(42,145),(42,149),(42,133),(42,150),(42,169),(42,168),(42,164),(43,170),(43,172),(43,173),(43,175),(43,174),(43,176),(43,177),(43,178),(43,179),(43,135),(45,181),(45,175),(45,186),(45,191),(45,188),(45,189),(45,193),(45,192),(45,194),(45,190),(46,24),(46,142),(46,141),(46,143),(47,170),(47,187),(47,175),(47,174),(47,176),(47,178),(47,179),(47,194),(47,135),(49,142),(49,141),(49,143),(50,181),(50,177),(50,190),(50,192),(50,195),(50,196),(50,197),(50,198),(51,38),(51,46),(51,44),(51,43),(51,42),(51,39),(51,18),(51,40),(51,45),(51,47),(51,48),(51,41),(52,49),(52,50),(52,199),(52,200),(41,125),(53,121),(53,145),(53,125),(42,132),(54,123),(54,124),(54,131),(54,110),(54,144),(54,132),(54,149),(54,133),(54,148);
/*!40000 ALTER TABLE `course_courses_program_groups` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_exprs`
--

LOCK TABLES `course_exprs` WRITE;
/*!40000 ALTER TABLE `course_exprs` DISABLE KEYS */;
INSERT INTO `course_exprs` VALUES (9,9,'2013-07-30 21:04:43','2013-07-30 21:04:43'),(10,10,'2013-08-02 14:46:35','2013-08-13 17:25:06'),(11,13,'2013-08-02 14:48:08','2013-08-02 14:48:08'),(12,14,'2013-08-02 14:49:12','2013-08-02 14:49:12'),(13,17,'2013-08-02 14:51:26','2013-08-02 14:51:26'),(14,18,'2013-08-05 21:24:19','2013-08-05 21:24:19'),(18,22,'2013-08-07 18:39:30','2013-08-07 18:39:30'),(19,23,'2013-08-07 18:39:41','2013-08-07 18:39:41'),(20,24,'2013-08-07 18:39:53','2013-08-07 18:39:53'),(21,25,'2013-08-07 18:44:23','2013-08-07 18:44:23'),(22,26,'2013-08-07 18:48:41','2013-08-07 18:48:41'),(23,27,'2013-08-07 18:52:59','2013-08-07 18:52:59'),(24,28,'2013-08-07 18:54:05','2013-08-13 17:27:13'),(25,31,'2013-08-07 18:54:56','2013-08-07 18:54:56'),(26,33,'2013-08-07 18:55:40','2013-08-13 17:27:40'),(27,35,'2013-08-07 18:55:41','2013-08-07 18:55:41'),(28,38,'2013-08-07 18:56:58','2013-08-07 18:56:58'),(29,36,'2013-08-07 18:58:03','2013-08-13 17:28:01'),(30,42,'2013-08-07 19:05:01','2013-08-07 19:05:01'),(31,45,'2013-08-07 19:17:51','2013-08-07 19:17:51'),(32,48,'2013-08-07 20:37:37','2013-08-07 20:37:37'),(33,49,'2013-08-07 20:41:01','2013-08-07 20:41:01'),(34,50,'2013-08-07 20:43:21','2013-08-07 20:43:21'),(36,52,'2013-08-07 20:51:44','2013-08-07 20:51:44'),(37,53,'2013-08-07 20:54:34','2013-08-07 20:54:34'),(38,54,'2013-08-08 23:35:53','2013-08-08 23:35:53'),(39,55,'2013-08-08 23:40:06','2013-08-08 23:40:06'),(40,58,'2013-08-08 23:43:17','2013-08-08 23:43:17'),(41,61,'2013-08-08 23:45:42','2013-08-13 17:28:34'),(43,63,'2013-08-09 00:01:44','2013-08-09 00:01:44'),(44,65,'2013-08-09 17:21:55','2013-08-13 17:28:41'),(46,33,'2013-08-09 17:36:21','2013-08-13 17:27:54'),(47,71,'2013-08-09 17:41:33','2013-08-09 17:41:33'),(48,72,'2013-08-09 22:57:43','2013-08-09 22:57:43'),(49,73,'2013-08-10 15:53:38','2013-08-10 15:53:38'),(50,74,'2013-08-10 17:46:49','2013-08-10 17:46:49'),(52,76,'2013-08-10 18:30:32','2013-08-10 18:30:32'),(53,77,'2013-08-10 18:35:39','2013-08-10 18:35:39'),(54,78,'2013-08-10 19:07:10','2013-08-10 19:07:10'),(56,79,'2013-08-11 17:04:18','2013-08-11 17:04:18'),(58,88,'2013-08-11 18:36:26','2013-08-11 18:36:26'),(59,91,'2013-08-11 18:42:39','2013-08-11 18:42:39'),(60,95,'2013-08-11 19:02:21','2013-08-11 19:02:21'),(61,90,'2013-08-11 21:36:52','2013-08-13 17:29:40'),(62,102,'2013-08-11 21:42:39','2013-08-11 21:42:39'),(63,103,'2013-08-11 21:43:35','2013-08-11 21:43:35'),(64,104,'2013-08-11 21:45:46','2013-08-11 21:45:46'),(65,105,'2013-08-11 21:47:36','2013-08-11 21:47:36'),(66,106,'2013-08-11 21:49:09','2013-08-13 17:30:20'),(67,17,'2013-08-11 21:52:28','2013-08-13 17:25:49'),(68,110,'2013-08-11 21:56:14','2013-08-11 21:56:14'),(69,111,'2013-08-11 21:57:30','2013-08-11 21:57:30'),(70,114,'2013-08-11 22:03:56','2013-08-11 22:03:56'),(71,117,'2013-08-11 22:05:42','2013-08-11 22:05:42'),(73,119,'2013-08-11 22:10:13','2013-08-11 22:10:13'),(74,125,'2013-08-11 22:23:26','2013-08-11 22:23:26'),(75,130,'2013-08-11 22:24:54','2013-08-11 22:24:54'),(76,133,'2013-08-11 22:30:52','2013-08-11 22:30:52'),(77,136,'2013-08-11 22:31:28','2013-08-11 22:31:28'),(78,140,'2013-08-11 22:34:33','2013-08-11 22:34:33'),(79,148,'2013-08-11 22:37:43','2013-08-11 22:37:43'),(81,155,'2013-08-11 22:41:22','2013-08-11 22:41:22'),(83,161,'2013-08-11 23:10:41','2013-08-11 23:10:41'),(84,156,'2013-08-11 23:11:54','2013-08-13 17:32:07'),(85,163,'2013-08-12 14:15:13','2013-08-12 14:15:13'),(86,22,'2013-08-12 14:17:23','2013-08-13 17:26:32'),(88,167,'2013-08-12 17:58:58','2013-08-12 17:58:58'),(94,189,'2013-08-12 23:13:25','2013-08-12 23:13:25'),(95,174,'2013-08-12 23:16:47','2013-08-13 17:32:49'),(97,186,'2013-08-12 23:24:22','2013-08-13 17:32:55'),(98,192,'2013-08-12 23:25:51','2013-08-12 23:25:51');
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
-- Table structure for table `course_node_childrens`
--

DROP TABLE IF EXISTS `course_node_childrens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_node_childrens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_node_id` int(11) DEFAULT NULL,
  `children_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_node_childrens`
--

LOCK TABLES `course_node_childrens` WRITE;
/*!40000 ALTER TABLE `course_node_childrens` DISABLE KEYS */;
INSERT INTO `course_node_childrens` VALUES (1,9,10),(2,9,11),(4,14,16),(5,27,28),(8,31,33),(9,35,36),(12,38,40),(19,58,59),(20,58,60),(21,58,61),(23,63,65),(26,79,80),(27,79,81),(33,88,89),(34,88,90),(35,91,92),(37,91,94),(40,95,98),(43,105,106),(45,111,112),(46,111,113),(50,119,121),(51,121,122),(52,121,123),(53,121,124),(54,125,126),(55,125,127),(67,140,143),(74,148,151),(77,155,156),(78,155,157),(84,167,169),(169,119,11),(170,140,11),(171,148,11),(172,14,13),(173,136,16),(174,140,17),(175,163,20),(176,163,21),(177,42,22),(178,55,22),(179,45,23),(180,167,23),(181,35,24),(182,42,24),(183,27,26),(184,31,28),(185,38,28),(188,45,36),(189,55,54),(190,63,54),(192,98,80),(194,98,81),(195,95,83),(196,95,84),(197,91,89),(198,114,90),(199,105,102),(200,114,102),(201,136,103),(202,136,104),(203,130,106),(204,125,112),(205,143,112),(206,148,112),(207,125,122),(208,143,122),(209,130,126),(210,133,126),(211,143,126),(212,151,126),(213,157,126),(214,133,127),(215,143,127),(216,151,127),(217,157,127);
/*!40000 ALTER TABLE `course_node_childrens` ENABLE KEYS */;
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
  `course_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_course_nodes_on_course_id` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_nodes`
--

LOCK TABLES `course_nodes` WRITE;
/*!40000 ALTER TABLE `course_nodes` DISABLE KEYS */;
INSERT INTO `course_nodes` VALUES (9,'OR',NULL,'2013-07-30 21:04:43','2013-07-30 21:04:43'),(10,'NODE',9,'2013-07-30 21:04:43','2013-07-30 21:04:43'),(11,'NODE',8,'2013-07-30 21:04:43','2013-07-30 21:04:43'),(13,'NODE',11,'2013-08-02 14:48:08','2013-08-02 14:48:08'),(14,'AND',NULL,'2013-08-02 14:49:12','2013-08-02 14:49:12'),(16,'NODE',12,'2013-08-02 14:49:12','2013-08-02 14:49:12'),(17,'NODE',16,'2013-08-02 14:51:26','2013-08-02 14:51:26'),(18,'NODE',13,'2013-08-05 21:24:19','2013-08-05 21:24:19'),(20,'NODE',49,'2013-08-07 18:38:34','2013-08-07 18:38:34'),(21,'NODE',50,'2013-08-07 18:39:16','2013-08-07 18:39:16'),(22,'NODE',40,'2013-08-07 18:39:30','2013-08-07 18:39:30'),(23,'NODE',43,'2013-08-07 18:39:41','2013-08-07 18:39:41'),(24,'NODE',42,'2013-08-07 18:39:53','2013-08-07 18:39:53'),(25,'NODE',19,'2013-08-07 18:44:23','2013-08-07 18:44:23'),(26,'NODE',24,'2013-08-07 18:48:41','2013-08-07 18:48:41'),(27,'AND',NULL,'2013-08-07 18:52:59','2013-08-07 18:52:59'),(28,'NODE',20,'2013-08-07 18:52:59','2013-08-07 18:52:59'),(31,'AND',NULL,'2013-08-07 18:54:56','2013-08-07 18:54:56'),(33,'NODE',23,'2013-08-07 18:54:56','2013-08-07 18:54:56'),(35,'AND',NULL,'2013-08-07 18:55:41','2013-08-07 18:55:41'),(36,'NODE',18,'2013-08-07 18:55:41','2013-08-07 18:55:41'),(38,'AND',NULL,'2013-08-07 18:56:58','2013-08-07 18:56:58'),(40,'NODE',21,'2013-08-07 18:56:58','2013-08-07 18:56:58'),(42,'AND',NULL,'2013-08-07 19:05:01','2013-08-07 19:05:01'),(45,'AND',NULL,'2013-08-07 19:17:51','2013-08-07 19:17:51'),(48,'NODE',67,'2013-08-07 20:37:37','2013-08-07 20:37:37'),(49,'NODE',34,'2013-08-07 20:41:01','2013-08-07 20:41:01'),(50,'NODE',35,'2013-08-07 20:43:21','2013-08-07 20:43:21'),(52,'NODE',76,'2013-08-07 20:51:44','2013-08-07 20:51:44'),(53,'NODE',36,'2013-08-07 20:54:34','2013-08-07 20:54:34'),(54,'NODE',44,'2013-08-08 23:35:53','2013-08-08 23:35:53'),(55,'AND',NULL,'2013-08-08 23:40:06','2013-08-08 23:40:06'),(58,'AND',NULL,'2013-08-08 23:43:17','2013-08-08 23:43:17'),(59,'NODE',80,'2013-08-08 23:43:17','2013-08-08 23:43:17'),(60,'NODE',81,'2013-08-08 23:43:17','2013-08-08 23:43:17'),(61,'NODE',82,'2013-08-08 23:43:17','2013-08-08 23:43:17'),(63,'AND',NULL,'2013-08-09 00:01:44','2013-08-09 00:01:44'),(65,'NODE',46,'2013-08-09 00:01:44','2013-08-09 00:01:44'),(71,'NODE',47,'2013-08-09 17:41:33','2013-08-09 17:41:33'),(72,'NODE',111,'2013-08-09 22:57:43','2013-08-09 22:57:43'),(73,'NODE',39,'2013-08-10 15:53:38','2013-08-10 15:53:38'),(74,'NODE',123,'2013-08-10 17:46:49','2013-08-10 17:46:49'),(76,'NODE',48,'2013-08-10 18:30:32','2013-08-10 18:30:32'),(77,'NODE',135,'2013-08-10 18:35:39','2013-08-10 18:35:39'),(78,'NODE',125,'2013-08-10 19:07:10','2013-08-10 19:07:10'),(79,'AND',NULL,'2013-08-11 17:04:17','2013-08-11 17:04:17'),(80,'NODE',157,'2013-08-11 17:04:17','2013-08-11 17:04:17'),(81,'NODE',158,'2013-08-11 17:04:17','2013-08-11 17:04:17'),(83,'NODE',160,'2013-08-11 18:31:35','2013-08-11 18:31:35'),(84,'NODE',161,'2013-08-11 18:31:35','2013-08-11 18:31:35'),(88,'AND',NULL,'2013-08-11 18:36:26','2013-08-11 18:36:26'),(89,'NODE',162,'2013-08-11 18:36:26','2013-08-11 18:36:26'),(90,'NODE',163,'2013-08-11 18:36:26','2013-08-11 18:36:26'),(91,'OR',NULL,'2013-08-11 18:42:39','2013-08-11 18:42:39'),(92,'NODE',165,'2013-08-11 18:42:39','2013-08-11 18:42:39'),(94,'NODE',167,'2013-08-11 18:42:39','2013-08-11 18:42:39'),(95,'OR',NULL,'2013-08-11 19:02:21','2013-08-11 19:02:21'),(98,'AND',NULL,'2013-08-11 19:02:21','2013-08-11 19:02:21'),(102,'NODE',171,'2013-08-11 21:42:39','2013-08-11 21:42:39'),(103,'NODE',172,'2013-08-11 21:43:35','2013-08-11 21:43:35'),(104,'NODE',174,'2013-08-11 21:45:46','2013-08-11 21:45:46'),(105,'AND',NULL,'2013-08-11 21:47:36','2013-08-11 21:47:36'),(106,'NODE',15,'2013-08-11 21:47:36','2013-08-11 21:47:36'),(110,'NODE',180,'2013-08-11 21:56:14','2013-08-11 21:56:14'),(111,'AND',NULL,'2013-08-11 21:57:30','2013-08-11 21:57:30'),(112,'NODE',176,'2013-08-11 21:57:30','2013-08-11 21:57:30'),(113,'NODE',175,'2013-08-11 21:57:30','2013-08-11 21:57:30'),(114,'OR',NULL,'2013-08-11 22:03:56','2013-08-11 22:03:56'),(117,'NODE',184,'2013-08-11 22:05:42','2013-08-11 22:05:42'),(119,'AND',NULL,'2013-08-11 22:10:13','2013-08-11 22:10:13'),(121,'OR',NULL,'2013-08-11 22:10:13','2013-08-11 22:10:13'),(122,'NODE',177,'2013-08-11 22:10:13','2013-08-11 22:10:13'),(123,'NODE',183,'2013-08-11 22:10:13','2013-08-11 22:10:13'),(124,'NODE',185,'2013-08-11 22:10:13','2013-08-11 22:10:13'),(125,'OR',NULL,'2013-08-11 22:23:26','2013-08-11 22:23:26'),(126,'NODE',187,'2013-08-11 22:23:26','2013-08-11 22:23:26'),(127,'NODE',173,'2013-08-11 22:23:26','2013-08-11 22:23:26'),(130,'AND',NULL,'2013-08-11 22:24:54','2013-08-11 22:24:54'),(133,'OR',NULL,'2013-08-11 22:30:52','2013-08-11 22:30:52'),(136,'OR',NULL,'2013-08-11 22:31:28','2013-08-11 22:31:28'),(140,'AND',NULL,'2013-08-11 22:34:32','2013-08-11 22:34:32'),(143,'OR',NULL,'2013-08-11 22:34:33','2013-08-11 22:34:33'),(148,'AND',NULL,'2013-08-11 22:37:43','2013-08-11 22:37:43'),(151,'OR',NULL,'2013-08-11 22:37:43','2013-08-11 22:37:43'),(155,'AND',NULL,'2013-08-11 22:41:22','2013-08-11 22:41:22'),(156,'NODE',17,'2013-08-11 22:41:22','2013-08-11 22:41:22'),(157,'OR',NULL,'2013-08-11 22:41:22','2013-08-11 22:41:22'),(161,'NODE',194,'2013-08-11 23:10:41','2013-08-11 23:10:41'),(163,'AND',NULL,'2013-08-12 14:15:13','2013-08-12 14:15:13'),(167,'AND',NULL,'2013-08-12 17:58:58','2013-08-12 17:58:58'),(169,'NODE',33,'2013-08-12 17:58:58','2013-08-12 17:58:58'),(174,'NODE',216,'2013-08-12 22:59:38','2013-08-12 22:59:38'),(186,'NODE',219,'2013-08-12 23:09:05','2013-08-12 23:09:05'),(189,'NODE',203,'2013-08-12 23:13:25','2013-08-12 23:13:25'),(192,'NODE',221,'2013-08-12 23:25:51','2013-08-12 23:25:51');
/*!40000 ALTER TABLE `course_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_rating_criteria`
--

DROP TABLE IF EXISTS `course_rating_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_rating_criteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_rating_criteria`
--

LOCK TABLES `course_rating_criteria` WRITE;
/*!40000 ALTER TABLE `course_rating_criteria` DISABLE KEYS */;
INSERT INTO `course_rating_criteria` VALUES (1,'difficulty','2013-08-10 20:04:08','2013-08-10 20:04:08'),(2,'workload','2013-08-10 20:04:15','2013-08-10 20:04:15'),(3,'interest','2013-08-10 20:04:25','2013-08-12 19:31:45');
/*!40000 ALTER TABLE `course_rating_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_ratings`
--

DROP TABLE IF EXISTS `course_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criteria_id` int(11) DEFAULT NULL,
  `review_id` int(11) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_course_ratings_on_criteria_id` (`criteria_id`),
  KEY `index_course_ratings_on_review_id` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_ratings`
--

LOCK TABLES `course_ratings` WRITE;
/*!40000 ALTER TABLE `course_ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_reviews`
--

DROP TABLE IF EXISTS `course_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_course_reviews_on_user_id` (`user_id`),
  KEY `index_course_reviews_on_course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_reviews`
--

LOCK TABLES `course_reviews` WRITE;
/*!40000 ALTER TABLE `course_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_reviews` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_subjects`
--

LOCK TABLES `course_subjects` WRITE;
/*!40000 ALTER TABLE `course_subjects` DISABLE KEYS */;
INSERT INTO `course_subjects` VALUES (1,'COMP','Computer Science',1,'2013-07-22 20:15:23','2013-07-22 20:15:23'),(2,'MATH','Mathematics and Statistics',1,'2013-07-29 18:07:16','2013-07-29 18:20:32'),(3,'MGCR','Management Core',1,'2013-08-07 16:29:31','2013-08-07 16:29:31'),(4,'INSY','Information Systems',1,'2013-08-07 16:33:04','2013-08-07 16:33:04'),(5,'FINE','Finance',1,'2013-08-07 16:42:20','2013-08-07 16:42:20'),(6,'MGSC','Management Science',1,'2013-08-07 17:16:23','2013-08-07 17:16:23'),(7,'ACCT','Accounting',1,'2013-08-07 17:30:23','2013-08-07 17:30:23'),(8,'ECON','Economics',1,'2013-08-07 18:12:41','2013-08-07 18:12:41'),(9,'BUSA','Business Administration',1,'2013-08-07 19:22:46','2013-08-07 19:22:46'),(10,'MRKT','Marketing',1,'2013-08-08 23:36:44','2013-08-08 23:36:44'),(11,'INDR','Industrial Relations',1,'2013-08-09 17:38:30','2013-08-09 17:38:30'),(12,'MGPO','Management Policy',1,'2013-08-09 17:40:04','2013-08-09 17:40:04'),(13,'ORGB','Organizational Behaviour',1,'2013-08-09 17:54:44','2013-08-09 17:54:44'),(14,'SOCI','Sociology',1,'2013-08-11 18:54:59','2013-08-11 18:54:59'),(15,'PSYC','Psychology',1,'2013-08-12 22:05:18','2013-08-12 22:05:18'),(16,'BIOL','Biology',1,'2013-08-12 22:37:07','2013-08-12 22:37:07');
/*!40000 ALTER TABLE `course_subjects` ENABLE KEYS */;
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
-- Table structure for table `program_group_restrictions`
--

DROP TABLE IF EXISTS `program_group_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_group_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_group_restrictions`
--

LOCK TABLES `program_group_restrictions` WRITE;
/*!40000 ALTER TABLE `program_group_restrictions` DISABLE KEYS */;
INSERT INTO `program_group_restrictions` VALUES (1,'all','2013-08-11 14:41:52','2013-08-11 14:41:52'),(2,'min_credit','2013-08-11 14:41:59','2013-08-11 14:41:59'),(3,'min_prg','2013-08-11 14:42:07','2013-08-11 14:42:07'),(4,'min_grp','2013-08-11 14:42:17','2013-08-11 14:42:17');
/*!40000 ALTER TABLE `program_group_restrictions` ENABLE KEYS */;
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
  `restriction_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `groupparent_id` int(11) DEFAULT NULL,
  `groupparent_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_groups`
--

LOCK TABLES `program_groups` WRITE;
/*!40000 ALTER TABLE `program_groups` DISABLE KEYS */;
INSERT INTO `program_groups` VALUES (1,'Software Engineering Core',1,39,1,'Program','2013-07-29 18:06:17','2013-08-09 19:03:58'),(2,'Software Engineering Complementary Courses',2,9,1,'Program','2013-07-29 18:08:46','2013-08-09 19:03:50'),(3,'Software Engineering Complementary Courses Group A',2,3,2,'ProgramGroup','2013-07-29 18:09:07','2013-08-09 19:03:41'),(4,'Software Engineering Complementary Courses Group B',2,3,2,'ProgramGroup','2013-07-29 18:09:25','2013-08-09 19:03:24'),(5,'Software Engineering Specializations',2,15,1,'Program','2013-07-29 18:09:47','2013-08-09 19:03:15'),(6,'Software Engineering Specializations Software Engineering',2,6,5,'ProgramGroup','2013-07-29 18:10:21','2013-08-09 19:03:05'),(7,'Software Engineering Specializations Application',2,6,5,'ProgramGroup','2013-07-29 18:10:53','2013-08-09 19:02:48'),(8,'McGill Management Information Systems Core',1,NULL,NULL,'','2013-08-07 16:28:48','2013-08-07 16:38:32'),(9,'Finance Core',1,NULL,4,'Program','2013-08-07 16:39:08','2013-08-07 16:40:40'),(10,'Finance Complementary',2,15,4,'Program','2013-08-07 16:40:30','2013-08-07 16:40:40'),(11,'Information Systems Core',1,NULL,2,'Program','2013-08-07 18:49:55','2013-08-07 18:49:55'),(12,'Information Systems Complementary',2,12,2,'Program','2013-08-07 19:21:55','2013-08-07 19:21:55'),(13,'Accounting Core',1,NULL,NULL,'Program','2013-08-07 20:25:46','2013-08-07 20:25:46'),(14,'Accounting Complementary',2,12,NULL,'','2013-08-07 20:29:05','2013-08-07 20:29:05'),(15,'Marketing Core',1,NULL,6,'Program','2013-08-09 00:23:12','2013-08-09 00:23:12'),(16,'Marketing Complementary',2,15,6,'Program','2013-08-09 00:29:52','2013-08-09 00:29:52'),(17,'International Business Core',1,NULL,7,'Program','2013-08-09 20:03:13','2013-08-09 20:03:13'),(19,'International Business Complementary',2,12,7,'Program','2013-08-09 20:24:37','2013-08-09 20:24:37'),(20,'Accounting Core',1,NULL,8,'Program','2013-08-09 21:35:08','2013-08-09 21:35:08'),(21,'Accounting Complementary',2,9,8,'Program','2013-08-09 22:07:16','2013-08-09 22:07:16'),(22,'Entrepreneurship Core',1,NULL,9,'Program','2013-08-10 15:41:04','2013-08-10 15:41:04'),(23,'Entrepreneurship Complementary',2,9,9,'Program','2013-08-10 15:44:36','2013-08-10 15:44:36'),(24,'Finance Core',1,NULL,10,'Program','2013-08-10 16:12:24','2013-08-10 16:12:24'),(25,'Finance Complementary',2,6,10,'Program','2013-08-10 16:15:26','2013-08-10 16:15:26'),(26,'Information Systems Core',1,NULL,11,'Program','2013-08-10 16:21:19','2013-08-10 16:21:19'),(27,'Information Systems Complementary',2,12,11,'Program','2013-08-10 16:26:01','2013-08-10 16:26:01'),(28,'Labour-Management Relations and Human Resources Core',1,NULL,12,'Program','2013-08-10 18:08:09','2013-08-10 18:08:09'),(29,'Labour-Management Relations and Human-Resources',2,6,12,'Program','2013-08-10 18:10:29','2013-08-10 18:10:29'),(30,'Marketing Core',1,NULL,13,'Program','2013-08-10 18:12:21','2013-08-10 18:12:21'),(31,'Marketing Complementary',2,3,13,'Program','2013-08-10 18:20:33','2013-08-10 18:20:33'),(32,'Operations Management Core',1,NULL,14,'Program','2013-08-10 18:39:56','2013-08-10 18:39:56'),(33,'Operations Management Complementary',2,9,14,'Program','2013-08-10 18:43:31','2013-08-10 18:43:31'),(34,'Organizational Behavior Complementary',2,15,15,'Program','2013-08-10 18:50:20','2013-08-10 18:50:20'),(35,'Strategic Management-Social Context ',2,15,17,'Program','2013-08-11 17:08:38','2013-08-11 17:08:38'),(36,'Strategic Management-Social Context Group A',2,9,35,'ProgramGroup','2013-08-11 17:12:23','2013-08-11 17:12:23'),(37,'Strategic Management-Social Context Group B',2,0,35,'ProgramGroup','2013-08-11 17:17:02','2013-08-11 17:17:02'),(38,'Strategic Management-Global Strategy',2,15,16,'Program','2013-08-11 17:21:05','2013-08-11 17:21:05'),(39,'Strategic Management-Global Strategy Group A',2,9,38,'ProgramGroup','2013-08-11 17:23:37','2013-08-11 17:23:37'),(40,'Strategic Management-Global Strategy',2,0,38,'ProgramGroup','2013-08-11 17:27:21','2013-08-11 17:27:21'),(41,'Labour-Management Relations & Human Resources Core',2,12,18,'Program','2013-08-11 17:37:02','2013-08-11 17:39:23'),(42,'Labour-Management Relations & Human Resources Core',2,18,18,'Program','2013-08-11 18:21:54','2013-08-12 21:46:49'),(43,'Mathematics for Management Students Core',1,NULL,19,'Program','2013-08-11 22:47:19','2013-08-11 22:47:19'),(44,'Mathematics for Management Students Complementary',2,9,19,'Program','2013-08-11 22:48:36','2013-08-11 22:48:36'),(45,'Mathematics for Management Students Complementary Group A',2,6,44,'ProgramGroup','2013-08-11 22:52:10','2013-08-11 22:52:10'),(46,'Mathematics for Management Students Complementary Group B',2,3,44,'ProgramGroup','2013-08-11 22:53:45','2013-08-11 22:53:45'),(47,'Mathematics for Management Students Core',1,NULL,20,'Program','2013-08-11 23:01:09','2013-08-11 23:01:09'),(48,'Statistics for Management Students Complementary',2,12,20,'Program','2013-08-11 23:01:58','2013-08-11 23:01:58'),(49,'Statistics for Management Students Complementary Group A',2,6,48,'ProgramGroup','2013-08-11 23:03:04','2013-08-11 23:03:04'),(50,'Statistics for Management Students Complementary Group B',2,6,48,'ProgramGroup','2013-08-11 23:17:04','2013-08-11 23:17:04'),(51,'Management Core Faculty Requirements',1,NULL,3,'Program','2013-08-12 14:10:51','2013-08-12 14:10:51'),(52,'Management Core Freshmen Requirements',1,NULL,3,'Program','2013-08-12 14:13:25','2013-08-12 21:48:29'),(53,'Organizational Behaviour Core',1,NULL,21,'Program','2013-08-12 14:37:02','2013-08-12 14:37:14'),(54,'Organizational Behaviour Complementary',2,21,21,'Program','2013-08-12 21:50:27','2013-08-12 21:50:27');
/*!40000 ALTER TABLE `program_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_groups_programs`
--

DROP TABLE IF EXISTS `program_groups_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_groups_programs` (
  `program_id` int(11) NOT NULL,
  `program_group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_groups_programs`
--

LOCK TABLES `program_groups_programs` WRITE;
/*!40000 ALTER TABLE `program_groups_programs` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_groups_programs` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES (1,'Software Engineering',1,1,'2013-07-29 13:28:46','2013-07-29 13:28:46'),(2,'Information Systems',1,4,'2013-08-07 16:26:07','2013-08-07 16:26:07'),(3,'Management Core',4,4,'2013-08-07 16:37:07','2013-08-07 16:37:07'),(4,'Finance',1,4,'2013-08-07 16:40:40','2013-08-07 16:40:40'),(5,'Accounting',1,4,'2013-08-07 20:22:51','2013-08-07 20:22:51'),(6,'Marketing',1,4,'2013-08-09 00:21:48','2013-08-09 00:21:48'),(7,'International Business',3,4,'2013-08-09 18:02:15','2013-08-09 18:02:46'),(8,'Accounting',3,4,'2013-08-09 21:29:59','2013-08-09 21:29:59'),(9,'Entrepreneurship',3,4,'2013-08-09 22:59:24','2013-08-09 22:59:24'),(10,'Finance',3,4,'2013-08-10 16:11:14','2013-08-10 16:11:14'),(11,'Information Systems',3,4,'2013-08-10 16:20:30','2013-08-10 16:20:30'),(12,'Labour-Management Relations and Human Resources',3,4,'2013-08-10 17:43:47','2013-08-10 17:43:47'),(13,'Marketing',3,4,'2013-08-10 18:10:59','2013-08-10 18:10:59'),(14,'Operations Management',3,4,'2013-08-10 18:23:40','2013-08-10 18:23:40'),(15,'Organizational Behavior',3,4,'2013-08-10 18:46:49','2013-08-10 18:46:49'),(16,'Strategic Management-Global Strategy',3,4,'2013-08-10 19:11:11','2013-08-10 19:11:11'),(17,'Strategic Management-Social Context',3,4,'2013-08-11 16:58:37','2013-08-11 16:58:37'),(18,'Labour-Management Relations & Human Resources',1,4,'2013-08-11 17:36:14','2013-08-11 18:59:23'),(19,'Mathematics for Management Students',1,4,'2013-08-11 22:43:09','2013-08-12 13:40:15'),(20,'Statistics for Management Students',1,4,'2013-08-11 22:58:05','2013-08-11 22:58:05'),(21,'Organizational Behaviour',1,4,'2013-08-12 14:37:14','2013-08-12 14:37:14');
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs_users`
--

LOCK TABLES `programs_users` WRITE;
/*!40000 ALTER TABLE `programs_users` DISABLE KEYS */;
INSERT INTO `programs_users` VALUES (10,4,2),(11,4,6),(12,2,4),(32,9,4),(33,3,4),(35,3,1),(41,6,1),(42,19,1);
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
INSERT INTO `schema_migrations` VALUES ('20130722183956'),('20130722183957'),('20130722185211'),('20130722185326'),('20130722185352'),('20130722185557'),('20130722185816'),('20130723142707'),('20130723144609'),('20130723145056'),('20130723171513'),('20130723172254'),('20130723184047'),('20130723190844'),('20130723192236'),('20130723200821'),('20130723200924'),('20130725154929'),('20130803202529'),('20130804183421'),('20130805134356'),('20130805134524'),('20130805142413'),('20130805144051'),('20130805150409'),('20130805150526'),('20130805162059'),('20130805163731'),('20130808145117'),('20130810200309'),('20130811001745'),('20130811002043'),('20130811142159'),('20130811144004'),('20130812132558'),('20130813141817'),('20130813143109');
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
INSERT INTO `universities` VALUES (1,'McGill University','http://mcgill.ca','2013-07-22 19:02:01','2013-08-12 17:16:52',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_completed_courses`
--

LOCK TABLES `user_completed_courses` WRITE;
/*!40000 ALTER TABLE `user_completed_courses` DISABLE KEYS */;
INSERT INTO `user_completed_courses` VALUES (7,4,41,NULL,'2013-08-11 18:50:23','2013-08-11 18:50:23'),(8,4,42,NULL,'2013-08-11 18:51:20','2013-08-11 18:51:20'),(14,4,112,NULL,'2013-08-12 15:09:04','2013-08-12 15:09:04'),(15,4,44,NULL,'2013-08-12 15:09:53','2013-08-12 15:09:53'),(16,6,18,NULL,'2013-08-12 17:39:26','2013-08-12 17:39:26');
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
INSERT INTO `user_emails` VALUES (1,'tlornewr@gmail.com',1,1,NULL,1,'2013-08-03 22:28:15','2013-08-12 19:47:17'),(2,'timothee.guerin@outlook.com',1,1,NULL,2,'2013-08-03 22:29:03','2013-08-03 22:29:05'),(6,'valentine@dessertenne.org',0,1,NULL,4,'2013-08-06 18:58:37','2013-08-06 18:58:37'),(7,'thibaud.marechal@gmail.com',0,1,NULL,6,'2013-08-07 16:24:10','2013-08-07 16:24:10');
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
INSERT INTO `user_taking_courses` VALUES (1,4,40,'2013-08-12 14:02:37','2013-08-12 14:02:37');
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
INSERT INTO `users` VALUES (1,'tlornewr@gmail.com','$2a$10$6y3pI3kWJcGXH6eF.UnmSexiHaTyvGEJqGbRDxKpnB.berbXvO796','mJjqCTaLWxRLveGmJU7s','2013-07-23 18:59:12',NULL,65,'2013-08-13 12:37:53','2013-08-12 14:32:08','18.189.84.209','18.189.84.209','2013-07-22 18:40:24','2013-08-13 12:37:53',1,4),(2,'timothee.guerin@outlook.com','$2a$10$9l8woOOEaZLAFIP7V3CZb.l5aUYcoVBAefwGM8GHBZZ5XwE5/lBOi',NULL,NULL,'2013-08-05 21:57:53',6,'2013-08-11 19:00:51','2013-08-05 21:57:53','2.12.94.248','18.189.28.75','2013-07-22 19:01:21','2013-08-11 19:00:51',1,1),(4,'valentine@dessertenne.org','$2a$10$oIcCyi7yzGjUdqGT5U76dOTBIlBumz.kdEPPrI/JLJAoNljKIeaQC',NULL,NULL,'2013-08-09 14:59:00',12,'2013-08-12 23:41:40','2013-08-12 23:41:39','18.189.82.246','18.189.82.246','2013-08-06 18:58:37','2013-08-12 23:41:40',1,4),(6,'thibaud.marechal@gmail.com','$2a$10$oaO.BlxPZ55a6qg72jB3Cu4MqJOWaj4rp/xE..aMFjn/1e0dOsEIe',NULL,NULL,'2013-08-09 15:00:54',2,'2013-08-09 15:00:54','2013-08-07 16:24:10','18.189.76.157','18.189.76.157','2013-08-07 16:24:10','2013-08-09 15:00:54',1,4);
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

-- Dump completed on 2013-08-13 14:14:00
