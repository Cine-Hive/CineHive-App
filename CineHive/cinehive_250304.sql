-- MariaDB dump 10.17  Distrib 10.5.5-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: cinehive
-- ------------------------------------------------------
-- Server version	10.5.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cinehive`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cinehive` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `cinehive`;

--
-- Table structure for table `animation`
--

DROP TABLE IF EXISTS `animation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animation` (
  `id` bigint(20) NOT NULL,
  `back_drop_path` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `overview` longtext DEFAULT NULL,
  `popularity` double NOT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `vote_average` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animation`
--

LOCK TABLES `animation` WRITE;
/*!40000 ALTER TABLE `animation` DISABLE KEYS */;
/*!40000 ALTER TABLE `animation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animation_directors`
--

DROP TABLE IF EXISTS `animation_directors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animation_directors` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `animation_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4g8wc9noq4321ab5o43h64dpo` (`animation_id`),
  CONSTRAINT `FK4g8wc9noq4321ab5o43h64dpo` FOREIGN KEY (`animation_id`) REFERENCES `animation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animation_directors`
--

LOCK TABLES `animation_directors` WRITE;
/*!40000 ALTER TABLE `animation_directors` DISABLE KEYS */;
/*!40000 ALTER TABLE `animation_directors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animation_genre_ids`
--

DROP TABLE IF EXISTS `animation_genre_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animation_genre_ids` (
  `animation_id` bigint(20) NOT NULL,
  `genre_ids` int(11) DEFAULT NULL,
  KEY `FKm18uvdy6dcop67q7iga4rs5g9` (`animation_id`),
  CONSTRAINT `FKm18uvdy6dcop67q7iga4rs5g9` FOREIGN KEY (`animation_id`) REFERENCES `animation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animation_genre_ids`
--

LOCK TABLES `animation_genre_ids` WRITE;
/*!40000 ALTER TABLE `animation_genre_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `animation_genre_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animation_genres`
--

DROP TABLE IF EXISTS `animation_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animation_genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `animation_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7v7p16vpklsdbx61ajwd7bnws` (`animation_id`),
  CONSTRAINT `FK7v7p16vpklsdbx61ajwd7bnws` FOREIGN KEY (`animation_id`) REFERENCES `animation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animation_genres`
--

LOCK TABLES `animation_genres` WRITE;
/*!40000 ALTER TABLE `animation_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `animation_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animation_videos`
--

DROP TABLE IF EXISTS `animation_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animation_videos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `video_key` varchar(255) DEFAULT NULL,
  `animation_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqhgm85ciwpcrpib3vhh44a43l` (`animation_id`),
  CONSTRAINT `FKqhgm85ciwpcrpib3vhh44a43l` FOREIGN KEY (`animation_id`) REFERENCES `animation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animation_videos`
--

LOCK TABLES `animation_videos` WRITE;
/*!40000 ALTER TABLE `animation_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `animation_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bookmark_count` int(11) NOT NULL DEFAULT 0,
  `brd_content` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `brd_title` varchar(255) DEFAULT NULL,
  `comment_count` int(11) NOT NULL DEFAULT 0,
  `dislike_count` int(11) NOT NULL DEFAULT 0,
  `like_count` int(11) NOT NULL DEFAULT 0,
  `report_count` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL,
  `mem_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKegcaiyfnd6d2h82dfqxfy0qh5` (`mem_id`),
  CONSTRAINT `FKegcaiyfnd6d2h82dfqxfy0qh5` FOREIGN KEY (`mem_id`) REFERENCES `users` (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_dis_like`
--

DROP TABLE IF EXISTS `board_dis_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_dis_like` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `board_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlr7mgsejy9rgchkkra4ndw7pw` (`board_id`),
  KEY `FK4ta9vv6pyx0tutabcg6xgj915` (`user_id`),
  CONSTRAINT `FK4ta9vv6pyx0tutabcg6xgj915` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`),
  CONSTRAINT `FKlr7mgsejy9rgchkkra4ndw7pw` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_dis_like`
--

LOCK TABLES `board_dis_like` WRITE;
/*!40000 ALTER TABLE `board_dis_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_dis_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_like`
--

DROP TABLE IF EXISTS `board_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_like` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `board_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk7rxm8vl1ptqqhwdj2sjmlpvq` (`board_id`),
  KEY `FKbqijkv4rxx65r8ktbui2eb44e` (`user_id`),
  CONSTRAINT `FKbqijkv4rxx65r8ktbui2eb44e` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`),
  CONSTRAINT `FKk7rxm8vl1ptqqhwdj2sjmlpvq` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_like`
--

LOCK TABLES `board_like` WRITE;
/*!40000 ALTER TABLE `board_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookmark`
--

DROP TABLE IF EXISTS `bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmark` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `board_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9ok583i44955hw16uacv1v9pv` (`board_id`),
  KEY `FKo4vbqvq5trl11d85bqu5kl870` (`user_id`),
  CONSTRAINT `FK9ok583i44955hw16uacv1v9pv` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`),
  CONSTRAINT `FKo4vbqvq5trl11d85bqu5kl870` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmark`
--

LOCK TABLES `bookmark` WRITE;
/*!40000 ALTER TABLE `bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `board_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlij9oor1nav89jeat35s6kbp1` (`board_id`),
  KEY `FKqm52p1v3o13hy268he0wcngr5` (`user_id`),
  CONSTRAINT `FKlij9oor1nav89jeat35s6kbp1` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`),
  CONSTRAINT `FKqm52p1v3o13hy268he0wcngr5` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drama`
--

DROP TABLE IF EXISTS `drama`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drama` (
  `id` bigint(20) NOT NULL,
  `back_drop_path` varchar(255) DEFAULT NULL,
  `first_air_date` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `overview` longtext DEFAULT NULL,
  `popularity` double NOT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `vote_average` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drama`
--

LOCK TABLES `drama` WRITE;
/*!40000 ALTER TABLE `drama` DISABLE KEYS */;
/*!40000 ALTER TABLE `drama` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drama_actors`
--

DROP TABLE IF EXISTS `drama_actors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drama_actors` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `drama_id` bigint(20) NOT NULL,
  `poster_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlyw62i67u4m5bc39d0n9knhl` (`drama_id`),
  CONSTRAINT `FKlyw62i67u4m5bc39d0n9knhl` FOREIGN KEY (`drama_id`) REFERENCES `drama` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drama_actors`
--

LOCK TABLES `drama_actors` WRITE;
/*!40000 ALTER TABLE `drama_actors` DISABLE KEYS */;
/*!40000 ALTER TABLE `drama_actors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drama_directors`
--

DROP TABLE IF EXISTS `drama_directors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drama_directors` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `drama_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKsyhcrcn5lv7k2vvic3q3nbwd0` (`drama_id`),
  CONSTRAINT `FKsyhcrcn5lv7k2vvic3q3nbwd0` FOREIGN KEY (`drama_id`) REFERENCES `drama` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drama_directors`
--

LOCK TABLES `drama_directors` WRITE;
/*!40000 ALTER TABLE `drama_directors` DISABLE KEYS */;
/*!40000 ALTER TABLE `drama_directors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drama_genre_ids`
--

DROP TABLE IF EXISTS `drama_genre_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drama_genre_ids` (
  `drama_id` bigint(20) NOT NULL,
  `genre_ids` int(11) DEFAULT NULL,
  KEY `FKq9jqbr1l978e2m9tgsj7gg1dd` (`drama_id`),
  CONSTRAINT `FKq9jqbr1l978e2m9tgsj7gg1dd` FOREIGN KEY (`drama_id`) REFERENCES `drama` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drama_genre_ids`
--

LOCK TABLES `drama_genre_ids` WRITE;
/*!40000 ALTER TABLE `drama_genre_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `drama_genre_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drama_genres`
--

DROP TABLE IF EXISTS `drama_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drama_genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `drama_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKf7t8dlltfqhba44pex6wwt836` (`drama_id`),
  CONSTRAINT `FKf7t8dlltfqhba44pex6wwt836` FOREIGN KEY (`drama_id`) REFERENCES `drama` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drama_genres`
--

LOCK TABLES `drama_genres` WRITE;
/*!40000 ALTER TABLE `drama_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `drama_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `google_user`
--

DROP TABLE IF EXISTS `google_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `google_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mem_email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9v0hsf8df76nhk1f4qxjwedlm` (`user_id`),
  CONSTRAINT `FK9v0hsf8df76nhk1f4qxjwedlm` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `google_user`
--

LOCK TABLES `google_user` WRITE;
/*!40000 ALTER TABLE `google_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `google_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `google_user_genres`
--

DROP TABLE IF EXISTS `google_user_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `google_user_genres` (
  `google_user_id` bigint(20) NOT NULL,
  `genre` varchar(255) DEFAULT NULL,
  KEY `FKg48opeih7sjjfeqlfuytlyg46` (`google_user_id`),
  CONSTRAINT `FKg48opeih7sjjfeqlfuytlyg46` FOREIGN KEY (`google_user_id`) REFERENCES `google_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `google_user_genres`
--

LOCK TABLES `google_user_genres` WRITE;
/*!40000 ALTER TABLE `google_user_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `google_user_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kakao_user_genres`
--

DROP TABLE IF EXISTS `kakao_user_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kakao_user_genres` (
  `kakao_user_id` bigint(20) NOT NULL,
  `genre` varchar(255) DEFAULT NULL,
  KEY `FKl4904f0keq7cqynjhtjgnxmfc` (`kakao_user_id`),
  CONSTRAINT `FKl4904f0keq7cqynjhtjgnxmfc` FOREIGN KEY (`kakao_user_id`) REFERENCES `kakao_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kakao_user_genres`
--

LOCK TABLES `kakao_user_genres` WRITE;
/*!40000 ALTER TABLE `kakao_user_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `kakao_user_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kakao_users`
--

DROP TABLE IF EXISTS `kakao_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kakao_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mem_email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4rkpr1gxfhm8le2bxcelad3co` (`user_id`),
  CONSTRAINT `FK4rkpr1gxfhm8le2bxcelad3co` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kakao_users`
--

LOCK TABLES `kakao_users` WRITE;
/*!40000 ALTER TABLE `kakao_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `kakao_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie` (
  `id` bigint(20) NOT NULL,
  `back_drop_path` varchar(255) DEFAULT NULL,
  `overview` longtext DEFAULT NULL,
  `popularity` double NOT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `runtime` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `vote_average` double NOT NULL,
  `director_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKctqut6lf5jlg8fyr395aofqlj` (`director_id`),
  CONSTRAINT `FKctqut6lf5jlg8fyr395aofqlj` FOREIGN KEY (`director_id`) REFERENCES `movie_directors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (13,'/mzfx54nfDPTUXZOG48u4LaEheDy.jpg','불편한 다리, 남들보다 조금 떨어지는 지능을 가진 포레스트 검프는 헌신적인 어머니의 보살핌과 첫사랑 제니와의 만남으로 편견과 괴롭힘 속에서도 따뜻한 마음을 지니고 성장한다. 또래들의 괴롭힘을 피해 도망치던 포레스트는 누구보다 빠르게 달릴 수 있는 자신의 재능을 깨닫는다. 그의 재능을 알아 본 대학에서 그를 미식축구 선수로 발탁하고, 졸업 후에도 뛰어난 신체능력으로 군에 들어가 무공훈장을 수여받는 등 탄탄한 인생 가도에 오르게 된 포레스트. 하지만 어머니가 병에 걸려 죽음을 맞이하고, 첫사랑 제니 역시 그의 곁을 떠나가며 다시 한 번 인생의 전환점을 맞이하게 되는데...',83.522,'/iraQz6gdAe8JL45QcBifM1UhQ38.jpg','1994-06-23',142,'포레스트 검프',8.468,12),(122,'/2u7zbn8EudG6kLlBzUYqP8RyFU4.jpg','사우론이 인간들의 마지막 요새인 곤도르를 향해 야욕을 드러내고 있는 한편, 아라곤은 쇠락해가고 있는 곤도르의 재건을 위해 왕위 계승을 신중하게 결정지어야만 하는 상황. 이제 중간대륙의 미래는 그의 어깨에 달려있는 것. 사우론이 이끄는 어둠의 군대와의 마지막 전투를 위해 간달프는 곤도르에 흩어져 있던 병사들을 모으고, 로한의 왕 세오덴에게 도움을 받기도 하지만 사우론의 군대에 비하면 열세를 면치 못한다. 그러나 그들은 중간대륙을 사우론의 야욕으로부터 지키려는 사명감과, 마지막 반지 운반자에게 임무를 끝낼 기회를 주기 위해 어둠의 군대를 향해 돌진하게 되는데...',161.784,'/n8BPIRqvj1SdTRND828ANXhmSng.jpg','2003-12-17',199,'반지의 제왕: 왕의 귀환',8.5,11),(129,'/6oaL4DP75yABrd5EbC4H2zq5ghc.jpg','평범한 열 살 짜리 소녀 치히로 식구는 이사 가던 중 길을 잘못 들어 낡은 터널을 지나가게 된다. 터널 저편엔 폐허가 된 놀이공원이 있었고 그곳엔 이상한 기운이 흘렀다. 인기척 하나 없는 이 마을의 낯선 분위기에 불길한 기운을 느낀 치히로는 부모님에게 돌아가자고 조르지만 부모님은 호기심에 들떠 마을 곳곳을 돌아다니기 시작한다. 어느 음식점에 도착한 치히로의 부모님은 그 곳에 차려진 음식들을 보고 즐거워하며 허겁지겁 먹어대다가 돼지로 변해버린다. 겁에 질려 당황하는 치히로에게 낯선 소년 하쿠가 나타나 빨리 이곳을 나가라고 소리치는데...',93.449,'/aZuBfbR0PnCb2up7lqHDsgJlLjs.jpg','2001-07-20',124,'센과 치히로의 행방불명',8.538,5),(155,'/oOv2oUXcAaNXakRqUPxYq5lJURz.jpg','범죄와 부정부패를 제거하여 고담시를 지키려는 배트맨. 그는 짐 고든 형사와 패기 넘치는 고담시 지방 검사 하비 덴트와 함께 도시를 범죄 조직으로부터 영원히 구원하고자 한다. 세 명의 의기투합으로 위기에 처한 악당들이 모인 자리에 보라색 양복을 입고 얼굴에 짙게 화장을 한 괴이한 존재가 나타나 배트맨을 죽이자는 사상 초유의 제안을 한다. 그는 바로 어떠한 룰도, 목적도 없는 사상 최악의 악당 미치광이 살인광대 조커. 배트맨을 죽이고 고담시를 끝장내버리기 위한 조커의 광기 어린 행각에 도시는 혼란에 빠지는데...',170.244,'/f6dNinWX8rBM79JXKcShkfSh2oA.jpg','2008-07-16',152,'다크 나이트',8.519,7),(238,'/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg','시실리에서 이민온 뒤, 정치권까지 영향력을 미치는 거물로 자리잡은 돈 꼴레오네는 갖가지 고민을 호소하는 사람들의 문제를 해결해주며 대부라 불리운다. 한편 솔로소라는 인물은 꼴레오네가와 라이벌인 탓타리아 패밀리와 손잡고 새로운 마약 사업을 제안한다. 돈 꼴레오네가 마약 사업에 참여하지 않기로 하자, 돈 꼴레오네를 저격해 그는 중상을 입고 사경을 헤매게 된다. 그 뒤, 돈 꼴레오네의 아들 소니는 조직력을 총 동원해 다른 패밀리들과 피를 부르는 전쟁을 시작하는데... 가족의 사업과 상관없이 대학에 진학한 뒤 인텔리로 지내왔던 막내 아들 마이클은 아버지가 총격을 당한 뒤, 아버지를 구하기 위해 위험천만한 협상 자리에 나선다.',177.805,'/I1fkNd5CeJGv56mhrTDoOeMc2r.jpg','1972-03-14',175,'대부',8.689,2),(240,'/kGzFbGhp99zva6oZODW5atUtnqi.jpg','아버지의 장례식 도중에 맏아들 파올로가 총에 맞아 죽고, 비토(로버트 드니로)는 겨우 도망쳐 미국으로 건너온다. 대부로 성장한 후 비토는 다시 치치오를 찾아 복수를 한다. 새롭게 등장한 젊은 대부 마이클(알 파치노)은 본거지를 라스베가스로 옮기고 가족의 사업을 가능한 합법적인 것으로 바꾸려고 애쓴다. 그런 과중 중에 자신을 제거하려는 음모를 알게되고 그는 냉혹하고 신속하게 반대파들을 제거, 조직을 더욱 확대해 나간다. 이를 위해 마이클은 배신한 형마저 죽이고, 일 때문에 아내와 헤어지는 등 인간적으로는 계속 외로워져 가는데...',95.931,'/bhqvqYuAgrTGwyNAmMR0ZVmjXel.jpg','1974-12-20',202,'대부 2',8.57,2),(278,'/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg','촉망받는 은행 간부 앤디 듀프레인은 아내와 그녀의 정부를 살해했다는 누명을 쓴다. 주변의 증언과 살해 현장의 그럴듯한 증거들로 그는 종신형을 선고받고 악질범들만 수용한다는 지옥같은 교도소 쇼생크로 향한다. 인간 말종 쓰레기들만 모인 그곳에서 그는 이루 말할 수 없는 억압과 짐승보다 못한 취급을 당한다. 그러던 어느 날, 간수의 세금을 면제받게 해 준 덕분에 그는 일약 교도소의 비공식 회계사로 일하게 된다. 그 와중에 교도소 소장은 죄수들을 이리저리 부리면서 검은 돈을 긁어 모으고 앤디는 이 돈을 세탁하여 불려주면서 그의 돈을 관리하는데...',168.49,'/oAt6OtpwYCdJI76AVtVKW1eorYx.jpg','1994-09-23',142,'쇼생크 탈출',8.708,1),(346,'/sJNNMCc6B7KZIY3LH3JMYJJNH5j.jpg','일본의 전국시대. 주민들은 황폐한 땅에서 어렵게 수확한 식량으로 한해 한해를 넘기는 빈촌에 살고 있다. 이 빈촌엔 보리 수확이 끝날 무렵이면 어김없이 산적들이 찾아와 모든 식량을 모조리 약탈해 간다. 싸워도 애원해도 소용이 없었다. 가만히 있을 수만은 없던 촌장의 결단으로 사무라이들을 모집하는데, 이들은 풍부한 전쟁 경험을 가진 시마다 칸베에를 포함한 7명이었다. 시마다의 지휘하에 마을은 방위태세를 갖추고 전투훈련도 시작한다. 이윽고 산적들의 공격이 시작되어 치열한 사투가 벌어진다.',34.251,'/6Y8Q5t79ybiDA7XubUTneqZhjA3.jpg','1954-04-26',207,'7인의 사무라이',8.458,14),(389,'/bxgTSUenZDHNFerQ1whRKplrMKF.jpg','뉴욕시의 법정에 아버지를 칼로 찌른 한 소년의 살인혐의를 두고, 12인의 배심원들은 만장일치 합의를 통해 소년의 유무죄 여부를 가려줄 것을 요구받는다. 판사는 유죄일 경우 이 소년은 사형이 불가피하다는 것을 이들에게 미리 일러둔다.  배심원 방에 모인 이들은 투표를 통해 유무죄 여부를 가리기로 한다. 사람들이 전부 소년이 유죄로 판단하는 가운데, 오직 한 배심원만이 소년이 무죄라고 주장하는데...',58.816,'/xzh6Rq9cKnE1M309PzC5S5QWF9S.jpg','1957-04-10',97,'12명의 성난 사람들',8.548,4),(424,'/zb6fM1CX41D9rF9hdgclu0peUmy.jpg','2차 세계대전 당시 독일군이 점령한 폴란드. 시류에 맞춰 자신의 성공을 추구하는 기회주의자 쉰들러는 유태인이 경영하는 그릇 공장을 인수한다. 그는 공장을 인수하기 위해 나찌 당원이 되고 독일군에게 뇌물을 바치는 등 갖은 방법을 동원한다. 그러나 냉혹한 기회주의자였던 쉰들러는 유태인 회계사인 스턴과 친분을 맺으면서 냉혹한 유태인 학살에 대한 양심의 소리를 듣기 시작한다. 마침내 그는 강제 수용소로 끌려가 죽음을 맞게될 유태인들을 구해내기로 결심하고, 독일군 장교에게 빼내는 사람 숫자대로 뇌물을 주는 방법으로 유태인들을 구해내려는 계획을 세우는데...',96.084,'/oyyUcGwLX7LTFS1pQbLrQpyzIyt.jpg','1993-12-15',195,'쉰들러 리스트',8.567,3),(429,'/x4biAVdPVCghBlsVIzB6NmbghIz.jpg','미국의 남북전쟁이 한창인 때, 블론디는 멕시코인 총잡이 투코와 함께 동업 중이다. 블론디는 현상범 투코를 잡아 현상금을 받고, 투코가 교수형을 당하는 순간 구해주는 역할. 한편 세텐자라 불리우는 범죄자는 엄청나 돈이 묻힌 비밀장소를 추적 중이다. 그런데, 투코와 실랑이를 벌이던 블론디는 돈이 묻힌 장소를 죽어가는 사람에게 듣게 되고, 결국 둘은 돈을 찾아 나서는데...',77.924,'/s7qPuoj4liolAtmx9vcL6AyaZzR.jpg','1966-12-22',161,'석양의 무법자',8.462,13),(497,'/vxJ08SvwomfKbpboCWynC3uqUg4.jpg','미국 루이지애나의 콜드 마운틴 교도소. 폴은 사형수 감방의 간수장으로 일하고 있다. 그의 일은 사형수들을 감독하고, 그린 마일이라 불리는 초록색 복도를 거쳐 그들을 사형 집행장까지 안내하는 것. 폴은 그들이 죽음을 맞이하는 순간까지 평화롭게 지낼 수 있도록 최선을 다한다. 어느 날 존 커피라는 사형수가 이송되어 온다. 그는 쌍둥이 여자아이를 살해한 흉악범. 하지만 순진한 눈망울에 겁을 잔뜩 집어먹은 그의 모습에 폴은 당혹감을 느낀다. 게다가 그는 초자연적 능력으로 폴의 지병을 깨끗하게 치료해주기까지 한다. 존을 전기 의자로 데려가야 할 날이 다가오면서 폴은 그가 무죄라는 확신을 갖게 되는데...',81.242,'/yuSpRhrTIJa5JN8oESrfD2bndp1.jpg','1999-12-10',189,'그린 마일',8.5,1),(637,'/gavyCu1UaTaTNPsVaGXT6pe5u24.jpg','로마에 갓 상경한 시골 총각 귀도는 운명처럼 만난 여인 도라에게 첫눈에 반한다. 넘치는 재치와 유머로 약혼자가 있던 그녀를 사로잡은 귀도는 가정을 꾸리며 분신과도 같은 아들 조수아를 얻는다. 조수아의 다섯 살 생일, 갑작스레 들이닥친 군인들은 귀도와 조수아를 수용소 행 기차에 실어버리고, 소식을 들은 도라 역시 기차에 따라 오른다. 귀도는 아들을 달래기 위해 무자비한 수용소 생활을 단체게임이라 속이고 1,000점을 따는 우승자에게는 진짜 탱크가 주어진다고 말한다. 하루하루가 지나 어느덧 전쟁이 끝났다는 말을 들은 귀도는 조수아를 창고에 숨겨둔 채 아내를 찾아 나서는데...',50.121,'/yjOqQsQHdsEZfAosZERqHiwjaty.jpg','1997-12-20',116,'인생은 아름다워',8.446,17),(680,'/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg','펌프킨와 허니 버니가 레스토랑에서 강도 행각을 벌이기 시작한다. 빈센트와 그 동료 쥴스는 두목의 금가방을 찾기 위해 다른 건달이 사는 아파트를 찾아간다. 마르셀러스는 부치에게 돈을 주며 상대 선수에게 져 주라고 하지만 부치는 상대 선수를 때려 눕히고 도망치다, 어릴 때 아버지에게 물려받은 시계를 찾기 위해 아파트로 향한다. 아무런 상관 없이 보이는 이 사건들이 서로 얽히고 섥히면서 예상치 못한 인과관계가 만들어지는데...',123.251,'/6lXRHGoEbnnBUKsuqpL9JxD4DzT.jpg','1994-09-10',154,'펄프 픽션',8.489,9),(769,'/7TF4p86ZafnxFuNqWdhpHXFO244.jpg','아일랜드계 이탈리아인 헨리 힐와 토미는 13살에 마피아에 입문해 지미와 함께 트럭이나 공항 화물을 훔치는 일을 한다. 결혼 후에도 마피아 생활을 계속하는 헨리는 이제 조직에서도 안정된 위치와 경제적 여유를 갖는다.  어느 날 헨리와 지미는 공항터미널 사건을 모의해 현금 6백만 달러라는 엄청한 돈을 훔친다. 이 사건을 은폐하기 위해 혈안이 된 지미는 모의에 참여했던 사람들을 죽이고, 토미는 마피아 조직에 가담했다가 살해당한다. 엎친데 덮친격으로 헨리마저 마약거래로 경찰서에 잡혀 들어가는데...',75.447,'/zF9hSBS1t7PVFLo01GrJ3OjGi67.jpg','1990-09-12',146,'좋은 친구들',8.5,15),(12477,'/tDFvXn4tane9lUvFAFAUkMylwSr.jpg','2차 세계대전, 일본의 한 마을에 폭격기로 인한 대공습이 일어난다. 마을이 화염으로 휩싸이자, 14살인 세이타는 부모님과 따로 만나기로 약속한 채 4살짜리 여동생 세츠코를 업고 피신한다. 결국 집과 어머니를 잃고 먼 친척아주머니의 집으로 향하는 세이타와 세츠코. 힘들고 어려운 환경에서도 오빠 세이타는 천진하고 착한 여동생 세츠코를 보면서 희망과 용기를 잃지 않는다. 하지만 시간이 지날수록 친척아주머니의 남매에 대한 냉대는 더욱 심해지고, 세이타는 어머니가 남겨주었던 마지막 여비를 챙겨 세츠코와 함께 산 속에 있는 방공호로 거처를 옮긴다. 두 남매는 산 속 동굴에서 반딧불이를 잡아 불을 밝히고, 물고기와 개구리를 잡아먹으며 살아가는데...',0.046,'/uN0x0G4uuRjFJIFN57iYihBV2Qh.jpg','1988-04-16',89,'반딧불이의 묘',8.451,16),(19404,'/90ez6ArvpO8bvpyIngBuwXOqJm5.jpg','영국에서 유학중인 라즈(샤룩 칸)와 인도 처녀 심란(까졸).  심란은 부모님이 정해주신 약혼자가 있는데 약혼을 앞두고 친구들과 유럽 여행을 떠나게 된다.  여행 중 우연히 만남 샤룩과 까졸. 두 남녀의 연속된 우연과 좌충우돌 사랑 만들기.  그렇게 사랑하게 된 그들이지만 까졸은 약혼자가 있는 몸. 인도로 돌아가게 된다.  샤룩 또한 그녀를 못 잊어 인도로 뒤 따라 들어가지만 엄격한 까졸의 부모를 설득하기가 힘이 든다. 도망가자는 까졸의 제안을 거부하고 샤룩은 끝내 그녀의 부모님의 허락을 얻어 내기 위해 고군분투한다.',31.895,'/2CAL2433ZeIihfX1Hb2139CX0pW.jpg','1995-10-20',190,'용감한 자가 신부를 데려가리',8.5,6),(157336,'/8sNiAPPYU14PUepFNeSNGUTiHW.jpg','세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다. 지난 20세기에 범한 잘못이 전 세계적인 식량 부족을 불러왔고, NASA도 해체되었다. 나사 소속 우주비행사였던 쿠퍼는 지구에 몰아친 식량난으로 옥수수나 키우며 살고 있다. 거센 황사가 몰아친 어느 날 알 수 없는 힘에 이끌려 딸과 함께 도착한 곳은 인류가 이주할 행성을 찾는 나사의 비밀본부. 이 때 시공간에 불가사의한 틈이 열리고, 이 곳을 탐험해 인류를 구해야 하는 임무를 위해 쿠퍼는 만류하는 딸을 뒤로한 채 우주선에 탑승하는데...',272.983,'/evoEi8SBSvIIEveM3V6nCJ6vKj8.jpg','2014-11-05',169,'인터스텔라',8.5,7),(372058,'/8x9iKH8kWA0zdkgNdpAew7OstYe.jpg','시골에 사는 소녀 미츠하(가미시라이시 모네)는 어느 날 잠에서 깬 후 자신의 몸이 남자로 바뀐 걸 알게 된다. 같은 시간, 도쿄에 사는 소년 타키(가미키 류노스케) 역시 이 기이한 상황을 겪고 있다. 낯선 가족, 낯선 친구들, 낯선 풍경들... 서로에게 이어진 끈을 알게 된 둘은 둘만의 규칙을 정하고 점차 상황을 받아들이기 시작한다. 서로에게 남긴 메모를 확인하며  점점 친구가 되어가는 타키와 미츠하. 언제부턴가 더 이상 몸이 바뀌지 않자  자신들이 특별하게 이어져있었음을 깨달은  타키는 미츠하를 만나러 가는데...',86.347,'/2DJCufz3Oa703PbLjNX1pM6MCG2.jpg','2016-08-26',106,'너의 이름은',8.5,10),(402431,'/uKb22E0nlzr914bA9KyA5CVCOlV.jpg','자신의 진정한 힘을 아직 발견하지 못한 엘파바와 자신의 진정한 본성을 발견하지 못한 글린다, 전혀 다른 두 인물이 우정을 쌓아가며 맞닥뜨리는 예상치 못한 위기와 모험을 그린 이야기',751.017,'/mHozMgx7w29qC9gLzUQDQEP7AEM.jpg','2024-11-20',162,'위키드',6.901,38),(496243,'/8eihUxjQsJ7WvGySkVMC0EwbPAD.jpg','전원 백수로 살 길 막막하지만 사이는 좋은 기택 가족. 장남 기우에게 명문대생 친구가 연결시켜 준 고액 과외 자리는 모처럼 싹튼 고정수입의 희망이다. 온 가족의 도움과 기대 속에 박 사장 집으로 향하는 기우. 글로벌 IT기업의 CEO인 박 사장의 저택에 도착하자 젊고 아름다운 사모님 연교와 가정부 문광이 기우를 맞이한다. 큰 문제 없이 박 사장의 딸 다혜의 과외를 시작한 기우. 그러나 이렇게 시작된 두 가족의 만남 뒤로, 걷잡을 수 없는 사건이 기다리고  있는데.....',150.591,'/mSi0gskYpmf1FbXngM37s2HppXh.jpg','2019-05-30',131,'기생충',8.5,8),(516729,'/hfTyu2VPBqLRPo2DauW8q7bh9bm.jpg','영국 국민으로 거듭난 ‘패딩턴’에게 어느 날 고향인 페루에서 날아온 의문의 편지 한 통. “루시 숙모님이 사라졌어요!” 지도 한 장만 남긴 채 감쪽같이 사라져 버린 ‘루시’ 숙모를 찾아 떠난 ‘패딩턴’과 브라운 가족은 페루의 정글을 둘러싼 비밀을 찾아 모험을 떠나게 되는데… https://justwatch.pro/movie/516729/paddington-in-peru',425.621,'/1rfxGlRaFe8bqKOtebXl2CFel8F.jpg','2024-11-08',106,'패딩턴: 페루에 가다!',6.8,34),(539972,'/v9Du2HC3hlknAvGlWhquRbeifwW.jpg','죽음의 문턱에서 맹수의 초인적인 힘을 얻고 살아 돌아온 크레이븐이 무자비한 복수의 길을 택하며 거침없는 사냥을 펼치는 액션 블록버스터',886.374,'/bA45ooXcp2B2qnMePfZ9QDL4wR5.jpg','2024-12-11',127,'크레이븐 더 헌터',6.7,53),(549509,'/iKXXPYBWQ0B6BMRHAFbg3wKafWb.jpg','전쟁의 상흔을 뒤로하고 미국에 정착한 건축가 라즐로 토스. 미국 이민자의 냉혹한 현실 속에 전쟁의 트라우마를 견뎌내던 어느 날. 라즐로의 천재성을 알아본 부유한 사업가 해리슨이 기념비적인 건축물 설계를 제안한다. 하지만, 시대와 공간, 빛의 경계를 넘어 대담하고 혁신적인 그의 건축 설계는 사람들의 공감을 얻지 못하고 반대에 부딪히게 된다. 후원자 해리슨의 감시와 압박, 주변의 비난이 거세질수록 오히려 더 자신의 설계에 집착하던 라즐로. 혁신적인 브루탈리즘 건축에 자신을 투영하던 라즐로는 결국 공사가 중단될 위기에 처하는데...',1065.25,'/dKFjxIZ6tPAUQInMKZCE3BfcrO2.jpg','2024-12-20',215,'브루탈리스트',7.1,25),(558449,'/bHeUgZKqduubnNl8GshjrpHS9lF.jpg','로마의 영웅이자 최고의 검투사였던 막시무스가 콜로세움에서 죽음을 맞이한 뒤 20여 년이 흐른 후. 쌍둥이 황제 게타와 카라칼라의 폭압 아래 시민을 위한 자유로운 나라 로마의 꿈은 잊힌 지 오래다. 한편 아카시우스 장군이 이끄는 로마군에 대패한 후 모든 것을 잃고 노예로 전락한 루시우스는 강한 권력욕을 지닌 마크리누스의 눈에 띄어 검투사로 발탁된다. 로마를 향한 걷잡을 수 없는 분노, 타고난 투사의 기질로 콜로세움에 입성하게 된 루시우스는 결투를 거듭하며 자신이 진짜 누구인지 알게 되고 마침내 로마의 운명을 건 결전을 준비하게 되는데...!',729.732,'/b5UXjzW5cLZhprMnlAmsVAA3G4t.jpg','2024-11-13',148,'글래디에이터 II',6.8,55),(604685,'/mKIxSo3p1QKlsdegcOwapcbiV74.jpg','빅 닉(Big Nick)이 유럽에서 다시 추적을 시작하며, 거대한 다이아몬드 거래소를 털려는 거대한 강도 계획에 연루된 도니(Donnie)를 쫓는다. 도니는 위험하고 예측할 수 없는 다이아몬드 도둑들의 세계와 악명 높은 팬서 마피아(Panther Mafia) 속에서 살아남기 위해 몸부림친다.',191.886,'/t4xbJSo5FflDCHTo2iEUG2TO0V2.jpg','2025-01-08',144,'크리미널 스쿼드 2: 판테라',6.7,47),(696506,'/2P0PUkQ1tNHNYTEmtbBmM8MfXBG.jpg','친구 티모와 함께 차린 마카롱 가게가 쫄딱 망해 거액의 빚을 지고 못 갚으면 죽이겠다는 사채업자를 피해 지구를 떠나야 하는 미키. 기술이 없는 그는, 정치인 마셜의 얼음행성 개척단에서 위험한 일을 도맡고, 죽으면 다시 프린트되는 익스펜더블로 지원한다. 4년의 항해와 얼음행성 니플하임에 도착한 뒤에도 늘 미키를 지켜준 여자친구 나샤. 그와 함께, 미키는 반복되는 죽음과 출력의 사이클에도 익숙해진다. 그러나 미키 17이 얼음행성의 생명체인 크리퍼와 만난 후 죽을 위기에서 돌아와 보니 이미 미키 18이 프린트되어 있다. 행성 당 1명만 허용된 익스펜더블이 둘이 된 멀티플 상황. 둘 중 하나는 죽어야 하는 현실 속에 걷잡을 수 없는 사건이 기다리고 있었으니…',423.368,'/7KghOYtsxFquUuw4THbARsSEo6g.jpg','2025-02-28',137,'미키 17',7.7,8),(710295,'/nNF4ZB0UDL4qAUjQfbYZDq3Ck7J.jpg','세상을 떠난 아버지의 짐을 정리하기 위해 사랑하는 아내 ‘샬롯’, 딸 ‘진저’와 함께 어릴 적 고향 집을 방문하기로 한 ‘블레이크’. 늦은 밤, 깊은 숲 속에 위치한 고향 집에 다다를 무렵 정체 모를 존재와 맞닥뜨린 ‘블레이크’는 가족을 지키려다 공격을 당한다. 가까스로 몸을 숨긴 이들에게 위협은 계속되고 설상가상으로 ‘블레이크’가 원인 모를 병에 감염돼 변하기 시작하면서 모두를 위험에 빠트리는데…',363.204,'/g7uNXsPA4Z0oLsvOQ6Gbc0sE19G.jpg','2025-01-15',103,'울프맨',6.5,39),(762509,'/oHPoF0Gzu8xwK4CtdXDaWdcuZxZ.jpg','길을 잃고 혼자가 된 새끼 사자 무파사는 광활한 야생을 떠돌던 중 왕의 혈통이자 예정된 후계자 타카와 우연히 만나게 된다. 마치 친형제처럼 끈끈한 우애를 나누며 함께 자란 무파사와 타카는 운명을 개척하기 위해 거대한 여정을 함께 떠난다. 한 치 앞을 알 수 없는 적들의 위협 속에서 두 형제의 끈끈했던 유대에 금이 가기 시작하고 예상치 못한 위기까지 맞닥뜨리게 되는데…',2050.558,'/1VUExee8iFohFTwYVi4IOArYyaM.jpg','2024-12-18',118,'무파사: 라이온 킹',7.467,50),(774370,'/iXU87IdtNsYt7n6OigPJBDdbFf1.jpg','\"반쪽은 개, 반쪽은 인간, 그야말로 영웅의 탄생!\"\r 한 경찰견과 그의 파트너인 경찰관이 함께 부상당한 후, 기적 같은 수술로 하나가 되어 \'도그맨\'이 탄생한다. 이제 도그맨은 그의 새로운 정체성을 받아들이며, 도시를 지키기 위해 애쓴다. 하지만 도시를 위협하는 악당, 페티 더 캣과의 싸움에서 도그맨의 진정한 힘이 시험받게 되는데...',722.633,'/89wNiexZdvLQ41OQWIsQy4O6jAQ.jpg','2025-01-24',89,'도그맨',7.7,24),(799766,'/3QeuagbU1YARTkGrPS4dvYSQGZi.jpg','',230.269,'/fbGCmMp0HlYnAPv28GOENPShezM.jpg','2024-12-06',136,'베러맨',7.648,45),(822119,'/qfAfE5auxsuxhxPpnETRAyTP5ff.jpg','대통령이 된 새디우스 로스와 재회 후, 국제적인 사건의 중심에 서게 된 샘이 전 세계를 붉게 장악하려는 사악한 음모 뒤에 숨겨진 존재와 이유를 파헤쳐 나가는 액션 블록버스터',1295.113,'/2MQdtfioyYSqgwkK07PSrBidOBC.jpg','2025-02-12',119,'캡틴 아메리카: 브레이브 뉴 월드',6.2,21),(823219,'/b3mdmjYTEL70j7nuXATUAD9qgu4.jpg','인간이 살았던 흔적만이 남아있는 세상, 홀로 집을 지키던 \'고양이\'는 갑작스러운 대홍수로 평화롭던 일상과 아늑했던 터전을 잃고 만다. 때마침 다가온 낡은 배에 올라탄 \'고양이\'는 그 안에서 \'골든 리트리버\', \'카피바라\', \'여우원숭이\', \'뱀잡이수리\'를 만나고 서로의 차이점을 극복하고 팀을 이뤄 험난한 파도를 헤쳐나간다.',885.787,'/8ntMUYy0b0NIGWSWvMr07ui7CCJ.jpg','2024-08-29',85,'플로우',8.3,33),(912649,'/vZG7PrX9HmdgL5qfZRjhJsFYEIA.jpg','환상의 케미스트리의 에디 브록과 그의 심비오트 베놈은 그들을 노리는 정체불명 존재의 추격을 피해 같이 도망을 다니게 된다. 한편 베놈의 창조자 널은 고향 행성에서부터 그들을 찾아내기 위해 지구를 침략하고 에디와 베놈은 그동안 겪어보지 못한 최악의 위기를 맞이하게 되는데…',820.402,'/ptfoRD0MmL8Ry0iBVccYbqoN9Xc.jpg','2024-10-22',109,'베놈: 라스트 댄스',6.788,54),(927342,'/7cNE2qydew1c8fqnlhWjkE3DHc2.jpg','',1329.454,'/eCB06m1KUGilEOlIzb40nkQhVY0.jpg','2024-10-31',169,'அமரன்',7.4,52),(933260,'/bVSOgrxasVJF6V71T7v2KfBRSzu.jpg','한때 아카데미상을 수상하고 명예의 거리까지 입성한 대스타였지만 지금은 TV 에어로빅 쇼 진행자로 전락한 엘리자베스. 50살이 되던 날, 프로듀서에게서 어리고 섹시하지 않다는 이유로 해고를 당한다. 돌아가던 길에 차 사고로 병원에 실려간 엘리자베스는 매력적인 남성 간호사로부터 서브스턴스라는 약물을 권유받는다. 한 번의 주사로 젊고 아름답고 완벽한 수가 탄생하는데...',970.749,'/5TPPefBI1OzWnSQfBkOrv1OFGq5.jpg','2024-09-07',140,'서브스턴스',7.127,26),(939243,'/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg','너클즈, 테일즈와 함께 평화로운 일상을 보내던 초특급 히어로 소닉. 연구 시설에 50년간 잠들어 있던 사상 최강의 비밀 병기 \"섀도우\"가 탈주하자, 세계 수호 통합 부대(약칭 세.수.통)에 의해 극비 소집된다. 소중한 것을 잃은 분노와 복수심에 불타는 섀도우는 소닉의 초고속 스피드와 너클즈의 최강 펀치를 단 단숨에 제압해버린다. 세상을 지배하려는 닥터 로보트닉과 그의 할아버지 제럴드 박사는 섀도우의 엄청난 힘 카오스 에너지를 이용해 인류를 정복하려고 하는데…',1976.892,'/5ZoI48Puf5i5FwI6HOpunDuJOw0.jpg','2024-12-19',110,'수퍼 소닉 3',7.7,20),(950396,'/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg','고도의 훈련을 받은 두 요원는 비밀스러운 협곡의 양쪽을 지키는 임무를 받은 후 멀리서 서로와 서서히 친해진다. 도사리고 있던 악이 드러나자, 둘은 협곡 안의 위험으로부터 살아남기 위해 협력해야만 한다.',3135.209,'/fhPj5pWbCoVoz8sehfaCeIWWFxc.jpg','2025-02-13',127,'\'더 캐니언\' - The Gorge',7.791,18),(974576,'/tkRDTu9hyWgaBSSzfkYDCZYd1kV.jpg','교황의 예기치 못한 죽음 이후 새로운 교황을 선출하는 콘클라베가 시작되고, 로렌스는 단장으로서 선거를 총괄하게 된다. 한편 당선에 유력했던 후보들이 스캔들에 휘말리면서 교활한 음모와 탐욕이 수면 위로 드러나는데…',705.54,'/aPPUy4JBYrJeRlQwMxdKwa3Ozkd.jpg','2024-10-25',120,'콘클라베',7.141,37),(974950,'/u2eA9pqi1q3DvevT7RuDuJHxxBT.jpg','능력 있는 변호사 \'리타\'는 \'큰돈을 벌게 해주겠다\'는 비밀 의뢰를 받고 멕시코 카르텔의 수장 \'델 몬테\'를 만나러 간다. 그의 요청은 놀랍게도 \"자신을 여자로 다시 태어나게 해달라는 것. 아내도 모르게 새로운 삶을 살 수 있게 세팅하라는 것.\" 얼마 뒤, 새로운 그녀 ‘에밀리아 페레즈’가 나타나면서 모두의 인생에 2막이 오른다.',393.985,'/t1XuL5308zcEGjeeN2wzsqlwSDR.jpg','2024-08-21',130,'에밀리아 페레즈',6.8,44),(978796,'/gmYpUbSGOwmZnevCr0iwLEYdpVB.jpg','',179.579,'/53IK9rlZJbwFYbNnJZiLq7UWxkT.jpg','2024-09-20',92,'백맨',6.3,49),(980477,'/zxi6WQPVc0uQAG5TtLsKvxYHApC.jpg','\"그가 돌아왔다, 더욱 강력해진 영웅의 전설\"\r 천계의 시련 이후, 혼은 유지했으나 육신이 소멸 위기에 처한 나타와 오병. 태을진인은 일곱 빛깔의 보련으로 그들의 육신을 재건하려 하지만, 과정은 순탄치 않다. 신공표는 심해에 갇혀 있던 사룡왕을 해방시키고, 동해의 용왕 오광은 \"내가 전쟁에 나서면, 천당관은 남김없이 파괴될 것이다\"라고 선언한다. 나타는 천당관을 지키기 위해 사해의 용왕들과 맞서 싸우게 되는데...',226.098,'/bTMf8M7rZ21fChGdtsZtJj4Dfqh.jpg','2025-01-29',144,'나타지마동요해',7.7,46),(1000837,'/j9uruwRe9qM8RnP758dF7ISB8Bj.jpg','\"그녀의 목소리, 침묵 속에서 울려퍼지다\"\r 1970년대 브라질 군사 독재 시절, 변호사이자 정치 활동가인 유니스 파이바(페르난다 토레스 분)는 남편인 루벤스 파이바(셀튼 멜로 분)의 실종 이후 홀로 남겨진다. 남편의 부재 속에서도 그녀는 가족을 지키기 위해 고군분투하며, 진실을 밝히기 위한 여정을 시작한다. 억압과 두려움이 가득한 시대 속에서 유니스는 용기와 결단력으로 맞서게 되는데...',327.782,'/zNAw7jK8bwCK56rIW676pdgkwhd.jpg','2024-09-19',138,'아임 스틸 히어',7.9,42),(1043905,'/dWkdmxIkH9y23s9v1PjQFhTGIwo.jpg','2021년 미국의 아프가니스탄 철군 당시, 의료 구호 팀으로 위장한 여성 군인들이 납치된 십대 소년·소녀들을 구출하기 위해 다시 투입된다. 이들은 ISIS와 탈레반 사이에 갇힌 피해자들을 구출하는 임무를 맡는다.',318.044,'/3O3qSGmjRGc10hMwFul8WDxKE5t.jpg','2024-12-11',104,'더티 엔젤스',6.193,40),(1064213,'/kEYWal656zP5Q2Tohm91aw6orlT.jpg','뉴욕의 스트리퍼 아노라는 자신의 바를 찾은 철부지 러시아 재벌2세 이반을 만나게 되고 충동적인 사랑을 믿고 허황된 신분 상승을 꿈꾸며 결혼식을 올리게 된다. 그러나 신데렐라 스토리를 꿈꿨던 것도 잠시, 한 번도 본 적 없는 이반의 부모님이 아들의 결혼 사실을 알게 되자 길길이 날뛰며 미국에 있는 하수인 3인방에게 둘을 잡아 혼인무효소송을 진행할 것을 지시한다. 하수인 3인이 들이닥치자 부모님이 무서워 겁에 질린 남편 이반은 아노라를 버린채 홀로 도망친다. 이반을 찾아 결혼 생활을 유지하고 싶은 아노라와 어떻게든 이반을 찾아 혼인무효소송을 시켜야만 하는 하수인 3인방의 대환장 발악이 시작된다.',1016.68,'/mwguqSMRCA3NgpPoRsXdFhid25m.jpg','2024-10-14',140,'아노라',7.1,28),(1064486,'/jl2YIADk391yc6Qjy9JhgCRkHJk.jpg','쌍둥이 동생 길버트와 함께 태어나 입양된 그레이스는 옷장 속 달팽이로 위로를 삼는다.',664.263,'/lWh5OlerPR1c1cfn1ZLq0lpqFds.jpg','2024-10-17',94,'달팽이의 회고록',7.8,29),(1084199,'/sc1abgWNXc29wSBaerrjGBih06l.jpg','서로에게 딱 맞는 커플 ‘아이리스’와 ‘조시’는 친구들과 함께 호숫가의 별장으로 호화로운 휴가를 떠난다. 하지만 그곳에는 충격적인 사건이 기다리고 있는데…',1222.243,'/dq7CEYFCvQPfYIpAXOvJr3w6VLY.jpg','2025-01-22',97,'컴패니언',7.1,22),(1124620,'/6dC7ULfiutxwEAs7LjWHL2Tc7Zv.jpg','',268.742,'/yYa8Onk9ow7ukcnfp2QWVvjWYel.jpg','2025-02-14',98,'더 몽키',5.957,43),(1126166,'/gFFqWsjLjRfipKzlzaYPD097FNC.jpg','미셸 도커리가 연기하는 부지런한 미국 연방보호관 매들린 해리스는 마피아 조직의 회계사였던 윈스턴(토퍼 그레이스)을 증인 보호 프로그램으로 이송하는 임무를 맡게 된다. 그들은 알래스카의 황량한 설원을 가로지르는 작은 비행기에 탑승하며, 이 비행기의 조종사는 다릴 부스(마크 월버그)다. 그러나 비행 도중, 이들이 탑승한 비행기는 예상치 못한 위험에 직면하게 되고, 매들린은 조종사와 승객들의 숨겨진 의도를 의심하게 된다. 한정된 공간에서 긴장감이 고조되는 가운데, 매들린은 비행기의 조종을 직접 맡아야 하는 상황에 이르게 되는데...',2568.332,'/zstC9sgsPaV98TaZtHL6aTtBUtB.jpg','2025-01-22',91,'플라이트 리스크',6.038,19),(1138194,'/ag66gJCiZ06q1GSJuQlhGLi3Udx.jpg','요청을 받고 선교를 위해 낯선 남자의 집을 방문한 두 명의 젊은 여성 선교사가 이상함을 느끼고 그 집에서 벗어나려고 하면서 일어나는 일들을 그린 극영화',252.726,'/fr96XzlzsONrQrGfdLMiwtQjott.jpg','2024-10-31',111,'헤레틱',7.162,41),(1160956,'/u7AZ5CdT2af8buRjmYCPXNyJssd.jpg','액션 스타 재키가 우연히 전 세계적인 인기를 한 몸에 받고 있는 ‘후후’라는 아기 판다 구출 작전에 합류하게 되면서 벌어지는 이야기',1005.555,'/zNU7A18Py3jHArZFLH2d4WUTbMS.jpg','2024-10-01',99,'판다 플랜',7.1,23),(1182387,'/evFChfYeD2LqobEJf8iQsrYcGTw.jpg','무장강도단 VS 철갑 현금수송차. 치밀한 계획의 현금 탈취 프로젝트가 가동된다. 전직 경찰 부자가 운전하는 현금수송차가 다리 위에서 습격을 받고 완전 포위된다. 철갑수송차를 뚫으려는 무장강도단과 지키려는 부자의 막다른 대결이 시작된다.',147.943,'/25ii5T20EyAkuNNqoZzVJiEEzZY.jpg','2024-10-30',89,'아머: 현금수송차',5.5,48),(1184918,'/mQZJoIhTEkNhCYAqcHrQqhENLdu.jpg','우연한 사고로 거대한 야생에 불시착한 로봇 로즈는 주변 동물들의 행동을 배우며 낯선 환경 속에 적응해 가던 중, 사고로 세상에 홀로 남겨진 아기 기러기 브라이트빌의 보호자가 된다. 로즈는 입력되어 있지 않은 새로운 역할과 관계에 낯선 감정을 마주하고 겨울이 오기 전에 남쪽으로 떠나야 하는 브라이트빌을 위해 동물들의 도움을 받아 이주를 위한 생존 기술을 가르쳐준다. 그러나 선천적으로 몸집이 작은 브라이트빌은 짧은 비행도 힘겨워 하는데...',500.759,'/8dkuf9IuVh0VZjDTk7kAY67lU0U.jpg','2024-09-12',102,'와일드 로봇',8.3,35),(1201012,'/l2QSVFR5aLcW1Vl4cGKrQkEp6fY.jpg','도무지 어울릴 것 같지 않은 커플의 결혼식 날 밤. 예상치 못한 사건이 발생하면서 두 사람은 깡패들과 경찰들을 피해 \'찰리\'라는 미스터리한 인물을 찾아야 하는 혼돈의 추격전에 휘말린다.',568.961,'/2E7me3rPi8HqaeheuD86YlpNX6k.jpg','2025-02-13',109,'둠 담',6.4,30),(1241982,'/zo8CIjJ2nfNOevqNajwMRO6Hwka.jpg','바다를 누볐던 선조들에게서 예기치 못한 부름을 받은 모아나가 마우이와 다시 만나 새로운 선원들과 함께 오랫동안 잊혀진 멀고 위험한 바다 너머로 떠나는 특별한 모험을 담은 이야기',1861.245,'/hwmwTFtMbzxAWbIOp1RyyiOCyx0.jpg','2024-11-21',99,'모아나 2',7.149,51),(1247019,'/vfkzNcVzTRCq3C2jYIZtIjSdwf7.jpg','여동생을 잃은 남자. 3년이 흐른 후에도 식지 않는 복수심으로 여동생을 죽인 어둠의 영혼을 집요하게 쫓는다.',530.143,'/xPTyukOmTrJDwGPwHYwxEMieaqk.jpg','2024-10-10',112,'데스 위스퍼러 2',7.038,32),(1249289,'/qSOMdbZ6AOdHR999HWwVAh6ALFI.jpg','조(스콧 이스트우드)와 로라(윌라 피츠제럴드)는 임무 중 만나 사랑에 빠진 정부 스파이 커플이다. 그들은 각자의 기관을 떠나 결혼한다.  영화는 이들의 첫 만남 5년 후, 폴란드의 한 리조트에서 휴가를 보내던 중 시작된다. 근처 숲에서 비행기 추락 사고가 발생하고, 조는 사고 현장을 조사하다 미스터리한 플래시 드라이브를 발견한다. 이 플래시 드라이브를 둘러싸고 여러 집단이 조를 공격하기 시작한다. 한 집단은 오린(마이크 콜터)이 이끄는 용병들이고, 다른 한 집단은 조의 전 소속 기관이다. 그들은 조가 글로벌 정보망을 무너뜨리려는 비밀 조직 \'Alarum\'에 가입했다고 의심한다. 조와 로라는 서로 헤어지게 되고, 로라가 실제로 Alarum의 일원임이 밝혀진다. 두 사람은 수많은 킬러들과 싸우며 재회를 시도합니다. 이 과정에서 체스터(실베스터 스탤론)라는 옛 동료가 등장하여 조를 제거하려 하지만, 결국 그와 함께 행동하며 폭발적인 액션을 펼치게 되는데... https://justwatch.pro/movie/1249289/alarum',578.695,'/z6A7WqyKJI9COZkxKLI1hyiAhPK.jpg','2025-01-16',95,'알라룸',5.792,27),(1294203,'/uJK0jjJ8QDOQw5lcNBwu059ht4D.jpg','영국의 부유한 사업가 윌리엄과 최근 사랑에 빠진 엄마를 따라 미국에서 영국으로 거처를 옮긴 18세 노아는 윌리엄의 불량한 아들 닉을 만나게 되고 둘은 서로에게 거부할 수 없는 매력을 느낀다. 여름 내내 노아는 새로운 생활에 적응하며 처음으로 사랑에 빠지지만 과거의 괴로운 기억이 노아의 발목을 잡는다.',549.7,'/h7H6Kd9kX1dvN8FZjUy6FcNdXxQ.jpg','2025-02-12',119,'나의 잘못: 런던',7.482,31),(1352774,'/tehewlwOPFDDf4syutyopaY23AY.jpg','',422.701,'/5wZNFUJAwyX6RCxdqrLO9lLWJ20.jpg','2025-01-25',83,'Piglet',5.7,36);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_actors`
--

DROP TABLE IF EXISTS `movie_actors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie_actors` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `movie_id` bigint(20) NOT NULL,
  `poster_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbsto8yef4btokhveihmkg8876` (`movie_id`),
  CONSTRAINT `FKbsto8yef4btokhveihmkg8876` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=771 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_actors`
--

LOCK TABLES `movie_actors` WRITE;
/*!40000 ALTER TABLE `movie_actors` DISABLE KEYS */;
INSERT INTO `movie_actors` VALUES (1,'모건 프리먼','https://image.tmdb.org/t/p/w500/jPsLqiYGSofU4s6BjrxnefMfabb.jpg',278,NULL),(2,'팀 로빈스','https://image.tmdb.org/t/p/w500/djLVFETFTvPyVUdrd7aLVykobof.jpg',278,NULL),(3,'밥 건턴','https://image.tmdb.org/t/p/w500/ulbVvuBToBN3aCGcV028hwO0MOP.jpg',278,NULL),(4,'William Sadler','https://image.tmdb.org/t/p/w500/rWeb2kjYCA7V9MC9kRwRpm57YoY.jpg',278,NULL),(5,'클랜시 브라운','https://image.tmdb.org/t/p/w500/xjg0ZIxP0tFcEQCTeRgKxNtLdpe.jpg',278,NULL),(6,'Gil Bellows','https://image.tmdb.org/t/p/w500/eCOIv2nSGnWTHdn88NoMyNOKWyR.jpg',278,NULL),(7,'James Whitmore','https://image.tmdb.org/t/p/w500/nYMAbkfwFIgKK84vnLoQctI6vHg.jpg',278,NULL),(8,'Mark Rolston','https://image.tmdb.org/t/p/w500/hcrNRIptYMRXgkJ9k76BlQu6DQp.jpg',278,NULL),(9,'Jeffrey DeMunn','https://image.tmdb.org/t/p/w500/eSouAAduXaziFpqLw59AG55jtGY.jpg',278,NULL),(10,'Larry Brandenburg','https://image.tmdb.org/t/p/w500/y13c1a4keaLnoTbi3dERwolQXWP.jpg',278,NULL),(11,'말론 브란도','https://image.tmdb.org/t/p/w500/vklkhX4QlRKnEG8ylhWzoBdcuev.jpg',238,NULL),(12,'알 파치노','https://image.tmdb.org/t/p/w500/2dGBb1fOcNdZjtQToVPFxXjm4ke.jpg',238,NULL),(13,'제임스 칸','https://image.tmdb.org/t/p/w500/v3flJtQEyczxENi29yJyvnN6LVt.jpg',238,NULL),(14,'로버트 듀발','https://image.tmdb.org/t/p/w500/ybMmK25h4IVtfE7qrnlVp47RQlh.jpg',238,NULL),(15,'Richard S. Castellano','https://image.tmdb.org/t/p/w500/1vr75BdHWret81vuSJ3ugiCBkxw.jpg',238,NULL),(16,'다이앤 키튼','https://image.tmdb.org/t/p/w500/tnx7pJqisfAzvXOR5wHQsbnH9XH.jpg',238,NULL),(17,'탈리아 샤이어','https://image.tmdb.org/t/p/w500/RkFJejmEKM80ly6fPSN7octO5c.jpg',238,NULL),(18,'Gianni Russo','https://image.tmdb.org/t/p/w500/jfeGnQfXMzKXsuSPm9oTxm6FOuz.jpg',238,NULL),(19,'스털링 헤이든','https://image.tmdb.org/t/p/w500/eRKaKeHjMKjNPOuENLccfVuyfVm.jpg',238,NULL),(20,'John Marley','https://image.tmdb.org/t/p/w500/xyzwd0CiBjXfowH3HcPhvuWcV5B.jpg',238,NULL),(21,'알 파치노','https://image.tmdb.org/t/p/w500/2dGBb1fOcNdZjtQToVPFxXjm4ke.jpg',240,NULL),(22,'로버트 듀발','https://image.tmdb.org/t/p/w500/ybMmK25h4IVtfE7qrnlVp47RQlh.jpg',240,NULL),(23,'다이앤 키튼','https://image.tmdb.org/t/p/w500/tnx7pJqisfAzvXOR5wHQsbnH9XH.jpg',240,NULL),(24,'로버트 드 니로','https://image.tmdb.org/t/p/w500/cT8htcckIuyI1Lqwt1CvD02ynTh.jpg',240,NULL),(25,'존 카제일','https://image.tmdb.org/t/p/w500/7uKBc2BVbLlAiHuSdfioe1OUnCX.jpg',240,NULL),(26,'탈리아 샤이어','https://image.tmdb.org/t/p/w500/RkFJejmEKM80ly6fPSN7octO5c.jpg',240,NULL),(27,'Lee Strasberg','https://image.tmdb.org/t/p/w500/niSM7ejzddgaTcxjgJMYEFCr9Y2.jpg',240,NULL),(28,'Michael V. Gazzo','https://image.tmdb.org/t/p/w500/cTY2Hlf6sIR9xLI95bBir7eI0N.jpg',240,NULL),(29,'G. D. Spradlin','https://image.tmdb.org/t/p/w500/pWNa9H3ABB3Ug9CwTfVNtHsCFjV.jpg',240,NULL),(30,'Richard Bright','https://image.tmdb.org/t/p/w500/potMaJ2u5PRjXZb7qF9lSW1ldNZ.jpg',240,NULL),(31,'리암 니슨','https://image.tmdb.org/t/p/w500/sRLev3wJioBgun3ZoeAUFpkLy0D.jpg',424,NULL),(32,'벤 킹슬리','https://image.tmdb.org/t/p/w500/vQtBqpF2HDdzbfXHDzR4u37i1Ac.jpg',424,NULL),(33,'레이프 파인스','https://image.tmdb.org/t/p/w500/tJr9GcmGNHhLVVEH3i7QYbj6hBi.jpg',424,NULL),(34,'Caroline Goodall','https://image.tmdb.org/t/p/w500/4cagGtMqACvkuw6Llq8Li8UJ1AR.jpg',424,NULL),(35,'Jonathan Sagall','https://image.tmdb.org/t/p/w500/waxNDsgfw7CXXO3LH8EdKi8z7VV.jpg',424,NULL),(36,'엠베스 데이비츠','https://image.tmdb.org/t/p/w500/nwsdu9lOsKJ5v9RwOCc7kAiuxSO.jpg',424,NULL),(37,'Malgorzata Gebel','https://image.tmdb.org/t/p/w500/svp3UfxWkJGuFWq5REZdwp8o91z.jpg',424,NULL),(38,'Shmuel Levy','https://image.tmdb.org/t/p/w500/eZDmJaS0Z0Fj2377wBul9xmm27S.jpg',424,NULL),(39,'Mark Ivanir','https://image.tmdb.org/t/p/w500/1kxGAsP4YRiR7LgmlM9KgtekMLk.jpg',424,NULL),(40,'Béatrice Macola','https://image.tmdb.org/t/p/w500/dXdt4Ti4mbJilnsm0wtvwb13eny.jpg',424,NULL),(41,'마틴 발삼','https://image.tmdb.org/t/p/w500/2j4LJJfTPQtvnjp8LfSGOvWFATO.jpg',389,NULL),(42,'John Fiedler','https://image.tmdb.org/t/p/w500/6vfLLGeGuO6Ko0VRnyhgE2v6RUu.jpg',389,NULL),(43,'리J.콥','https://image.tmdb.org/t/p/w500/yxMxBvM0PZwu7YXQamG0kFwt9DZ.jpg',389,NULL),(44,'E.G. Marshall','https://image.tmdb.org/t/p/w500/psimeVoRk64DV7UNm4cLQylRFy2.jpg',389,NULL),(45,'Jack Klugman','https://image.tmdb.org/t/p/w500/oJxveOxlunD8C9OczqKeryU0k6D.jpg',389,NULL),(46,'Edward Binns','https://image.tmdb.org/t/p/w500/s3fk0d0fwuj6bDVP9AcPUXFsGmK.jpg',389,NULL),(47,'Jack Warden','https://image.tmdb.org/t/p/w500/hSShXiYMfRpMByaB5euZ59qCKN.jpg',389,NULL),(48,'헨리 폰다','https://image.tmdb.org/t/p/w500/6wXWsqSXF3wCsGcwVqiszy6RX9X.jpg',389,NULL),(49,'Joseph Sweeney','https://image.tmdb.org/t/p/w500/m0liVGH2JrhcvCr3buYUeXwhAyV.jpg',389,NULL),(50,'Ed Begley','https://image.tmdb.org/t/p/w500/AuPwjGgPphtfQOShb8pTtp5W7Ft.jpg',389,NULL),(51,'히이라기 루미','https://image.tmdb.org/t/p/w500/zITaVtFyc4xSM3mxSoPRWHbqgJI.jpg',129,NULL),(52,'이리노 미유','https://image.tmdb.org/t/p/w500/8qEEhHUObNvGQr4e6eqLu5z4qTz.jpg',129,NULL),(53,'나츠키 마리','https://image.tmdb.org/t/p/w500/aRs3dGqA2bCuGSZ7lJGhQKe8rhp.jpg',129,NULL),(54,'나이토 타카시','https://image.tmdb.org/t/p/w500/zfs63NZKNG3Uy6WqqXSQWYMQXKZ.jpg',129,NULL),(55,'사와구치 야스코','https://image.tmdb.org/t/p/w500/rWspusb13VeJowmctnniXYYTcqq.jpg',129,NULL),(56,'카미죠 츠네히코','https://image.tmdb.org/t/p/w500/v2poQi0qYEWdTaMf2pVTWmcdwZp.jpg',129,NULL),(57,'오노 타케히코','https://image.tmdb.org/t/p/w500/8gcT8znk0l3YVZKvL7eVxYublTl.jpg',129,NULL),(58,'스가와라 분타','https://image.tmdb.org/t/p/w500/jKjHk0whJCaJt7wKDTVA7VNEjqx.jpg',129,NULL),(59,'나카무라 아키오','https://image.tmdb.org/t/p/w500/z7GzSvEkb3vhA77FFS6JnkpEEbv.jpg',129,NULL),(60,'타마이 유미','https://image.tmdb.org/t/p/w500/x9Td7e5F21cK9S1FCkobfqiJZ1c.jpg',129,NULL),(61,'카졸','https://image.tmdb.org/t/p/w500/h4m0TkDuEMCUNaPrQxMRyFb2AQ7.jpg',19404,NULL),(62,'샤 룩 칸','https://image.tmdb.org/t/p/w500/tCEppfUu0g2Luu0rS5VKMoL4eSw.jpg',19404,NULL),(63,'Amrish Puri','https://image.tmdb.org/t/p/w500/uhMGFS7tuG71LDv2wk9LfZZ4EG6.jpg',19404,NULL),(64,'Farida Jalal','https://image.tmdb.org/t/p/w500/tJdqL4BRSAWVFX1W6cmwxFs9IFh.jpg',19404,NULL),(65,'Anupam Kher','https://image.tmdb.org/t/p/w500/f7hWJ4tvzR7uXmYoTiB41TpQ2NZ.jpg',19404,NULL),(66,'Pooja Ruparel','https://image.tmdb.org/t/p/w500/evHnj6s0Z2sbV1Mq0dfXxQQU8Mf.jpg',19404,NULL),(67,'Parmeet Sethi','https://image.tmdb.org/t/p/w500/paTrHCbnwMxBZREfoGcfY5TlvyY.jpg',19404,NULL),(68,'Satish Shah','https://image.tmdb.org/t/p/w500/AaXbQI0fAoTW4Qjg4dAtC5xkK1G.jpg',19404,NULL),(69,'Mandira Bedi','https://image.tmdb.org/t/p/w500/l50tq0OwzIxE4Z5JXDUSQvqCltN.jpg',19404,NULL),(70,'Achala Sachdev','https://image.tmdb.org/t/p/w500/6kgq6Mnmd01HZzvbsEDQAFBurog.jpg',19404,NULL),(71,'크리스찬 베일','https://image.tmdb.org/t/p/w500/v2Oks7DTbZcKzSi2Pw58C7SSLzM.jpg',155,NULL),(72,'히스 레저','https://image.tmdb.org/t/p/w500/5Y9HnYYa9jF4NunY9lSgJGjSe8E.jpg',155,NULL),(73,'에런 엑하트','https://image.tmdb.org/t/p/w500/u5JjnRMr9zKEVvOP7k3F6gdcwT6.jpg',155,NULL),(74,'마이클 케인','https://image.tmdb.org/t/p/w500/bVZRMlpjTAO2pJK6v90buFgVbSW.jpg',155,NULL),(75,'메기 질렌할','https://image.tmdb.org/t/p/w500/vsfkWdYWmA9CpzMHTJzrFxlDnEZ.jpg',155,NULL),(76,'게리 올드만','https://image.tmdb.org/t/p/w500/2v9FVVBUrrkW2m3QOcYkuhq9A6o.jpg',155,NULL),(77,'모건 프리먼','https://image.tmdb.org/t/p/w500/jPsLqiYGSofU4s6BjrxnefMfabb.jpg',155,NULL),(78,'모니크 커넨','https://image.tmdb.org/t/p/w500/lJgLQs7cfM49m8VzVviwxIByz76.jpg',155,NULL),(79,'론 딘','https://image.tmdb.org/t/p/w500/mgqdr4VFrTVZatkki2suNLYxeDG.jpg',155,NULL),(80,'킬리언 머피','https://image.tmdb.org/t/p/w500/llkbyWKwpfowZ6C8peBjIV9jj99.jpg',155,NULL),(81,'톰 행크스','https://image.tmdb.org/t/p/w500/oFvZoKI6lvU03n4YoNGAll9rkas.jpg',497,NULL),(82,'데이비드 모스','https://image.tmdb.org/t/p/w500/A6zGbkFjM3uajIakgsSeNTmSKqY.jpg',497,NULL),(83,'Bonnie Hunt','https://image.tmdb.org/t/p/w500/tT9C6uLztgN8OxJULq6F9iEzqlA.jpg',497,NULL),(84,'마이클 클라크 덩컨','https://image.tmdb.org/t/p/w500/3RX8OBqt3gbvFwKYZqiom4O3Ta6.jpg',497,NULL),(85,'제임스 크롬웰','https://image.tmdb.org/t/p/w500/vpNQQbM5PtxsYmVm4oh79SGFyUK.jpg',497,NULL),(86,'Michael Jeter','https://image.tmdb.org/t/p/w500/9QUh9fO8A5Dt6AIl9jCd4ZIQxTp.jpg',497,NULL),(87,'그레이엄 그린','https://image.tmdb.org/t/p/w500/c0Hbq95FMlfGElLqxUN8Dk7ra3e.jpg',497,NULL),(88,'Doug Hutchison','https://image.tmdb.org/t/p/w500/afAENhxoHikCAKFaILFdSwVdkCw.jpg',497,NULL),(89,'샘 록웰','https://image.tmdb.org/t/p/w500/ruaUgtATy70VygkqtfHPwpJ0Gcj.jpg',497,NULL),(90,'Barry Pepper','https://image.tmdb.org/t/p/w500/pmdNUqrpsoozh7QYqUgEgZQ69cA.jpg',497,NULL),(91,'송강호','https://image.tmdb.org/t/p/w500/7dw9wIpFZ5nJZ3zqrue8t7hUUgQ.jpg',496243,NULL),(92,'이선균','https://image.tmdb.org/t/p/w500/nHFBbSFohzOUOvMxPVwe3Es2nJw.jpg',496243,NULL),(93,'조여정','https://image.tmdb.org/t/p/w500/5MgWM8pkUiYkj9MEaEpO0Ir1FD9.jpg',496243,NULL),(94,'최우식','https://image.tmdb.org/t/p/w500/hRDiuKWwe156zRjEu826eci7H3r.jpg',496243,NULL),(95,'박소담','https://image.tmdb.org/t/p/w500/fGVOikpvivopeATDy6ZzLdKYXDu.jpg',496243,NULL),(96,'이정은','https://image.tmdb.org/t/p/w500/gVygLFn4dZklaYIAlgozYJcRLiA.jpg',496243,NULL),(97,'장혜진','https://image.tmdb.org/t/p/w500/pZiQXSWwo9F4gncHfa1yw0CQjxk.jpg',496243,NULL),(98,'박명훈','https://image.tmdb.org/t/p/w500/5SucrxkigHss7UuJKrkfAZX5MXz.jpg',496243,NULL),(99,'정지소','https://image.tmdb.org/t/p/w500/jsUPFmY1HlML92ubVtSE8L8ovz6.jpg',496243,NULL),(100,'정현준','https://image.tmdb.org/t/p/w500/vZadA6ip6V2kh0VZW9RwnLcYFgW.jpg',496243,NULL),(101,'존 트래볼타','https://image.tmdb.org/t/p/w500/eVWcevrvGLLqt9gkDMruqgLJPsp.jpg',680,NULL),(102,'사무엘 L. 잭슨','https://image.tmdb.org/t/p/w500/AiAYAqwpM5xmiFrAIeQvUXDCVvo.jpg',680,NULL),(103,'우마 서먼','https://image.tmdb.org/t/p/w500/lg04iEqT6TC40H1jz10Z99OFMXx.jpg',680,NULL),(104,'브루스 윌리스','https://image.tmdb.org/t/p/w500/w3aXr1e7gQCn8MSp1vW4sXHn99P.jpg',680,NULL),(105,'빙 레임스','https://image.tmdb.org/t/p/w500/4gpLVNKPZlVucc4fT2fSZ7DksTK.jpg',680,NULL),(106,'하비 카이텔','https://image.tmdb.org/t/p/w500/7P30hza1neYWW3r7rSQOC736K2Z.jpg',680,NULL),(107,'에릭 스톨츠','https://image.tmdb.org/t/p/w500/idFuM00MeVmwGAiqvDaJcBiLAmD.jpg',680,NULL),(108,'팀 로스','https://image.tmdb.org/t/p/w500/qSizF2i9gz6c6DbAC5RoIq8sVqX.jpg',680,NULL),(109,'Amanda Plummer','https://image.tmdb.org/t/p/w500/wEwyajjePFVVn2wFdH1NH7z9Qn5.jpg',680,NULL),(110,'Maria de Medeiros','https://image.tmdb.org/t/p/w500/v53G55qSYaVRvbgUZ2uch4gVHT6.jpg',680,NULL),(111,'카미키 류노스케','https://image.tmdb.org/t/p/w500/ut7ewXjdgUmgkhJ1EtbOo9tbc7s.jpg',372058,NULL),(112,'카미시라이시 모네','https://image.tmdb.org/t/p/w500/lqg6mKq8eLNYS6nckKSEWStHjgt.jpg',372058,NULL),(113,'나리타 료','https://image.tmdb.org/t/p/w500/2EFimbwi4lf9B19cgu2bJaNJiVq.jpg',372058,NULL),(114,'유우키 아오이','https://image.tmdb.org/t/p/w500/4kHNZSUIux52UU2BD3H6b5c5ymZ.jpg',372058,NULL),(115,'시마자키 노부나가','https://image.tmdb.org/t/p/w500/qke5rZusHsjSlvB0NKlJ5dQF5D.jpg',372058,NULL),(116,'이시카와 카이토','https://image.tmdb.org/t/p/w500/fzjIkotjUHHs3wgftM9tqdsG8ph.jpg',372058,NULL),(117,'타니 카논','https://image.tmdb.org/t/p/w500/xY3JBxs6blBe2AvyS678bcs76Vc.jpg',372058,NULL),(118,'테라소마 마사키','https://image.tmdb.org/t/p/w500/eol7Ul4buAam9SmJDuFIWln0Cd3.jpg',372058,NULL),(119,'오하라 사야카','https://image.tmdb.org/t/p/w500/4lAqrOmkOP3U9Owwijtvc8PaCDx.jpg',372058,NULL),(120,'이노우에 카즈히코','https://image.tmdb.org/t/p/w500/3BpYtYRiLAmTNbCm2LXlXnkMRit.jpg',372058,NULL),(121,'일라이저 우드','https://image.tmdb.org/t/p/w500/7UKRbJBNG7mxBl2QQc5XsAh6F8B.jpg',122,NULL),(122,'이안 맥켈런','https://image.tmdb.org/t/p/w500/5cnnnpnJG6TiYUSS7qgJheUZgnv.jpg',122,NULL),(123,'비고 모텐슨','https://image.tmdb.org/t/p/w500/vH5gVSpHAMhDaFWfh0Q7BG61O1y.jpg',122,NULL),(124,'숀 애스틴','https://image.tmdb.org/t/p/w500/ywH1VvdwqlcnuwUVr0pV0HUZJQA.jpg',122,NULL),(125,'앤디 서키스','https://image.tmdb.org/t/p/w500/eNGqhebQ4cDssjVeNFrKtUvweV5.jpg',122,NULL),(126,'도미닉 모너핸','https://image.tmdb.org/t/p/w500/lOWmAvBu6evsj9MCcIHqy7Sg3iZ.jpg',122,NULL),(127,'빌리 보이드','https://image.tmdb.org/t/p/w500/uiWlsIOakNnUgda21PJF9wswzEJ.jpg',122,NULL),(128,'John Noble','https://image.tmdb.org/t/p/w500/t9dB8uU27sQDaEEFMiQvp5sbrXU.jpg',122,NULL),(129,'데이비드 웬햄','https://image.tmdb.org/t/p/w500/F7CWSqUE75HtrcdqIQ7UMZ9aTX.jpg',122,NULL),(130,'미란다 오토','https://image.tmdb.org/t/p/w500/szME1IBVTLgiKrO5D5wvOGnvUDW.jpg',122,NULL),(131,'톰 행크스','https://image.tmdb.org/t/p/w500/oFvZoKI6lvU03n4YoNGAll9rkas.jpg',13,NULL),(132,'로빈 라이트','https://image.tmdb.org/t/p/w500/d3rIv0y2p0jMsQ7ViR7O1606NZa.jpg',13,NULL),(133,'게리 시나이즈','https://image.tmdb.org/t/p/w500/olRjiV8ZhBixQiTvrGwXhpVXxsV.jpg',13,NULL),(134,'샐리 필드','https://image.tmdb.org/t/p/w500/5fBK36MdmdwQQMuP0W70rXADXih.jpg',13,NULL),(135,'Mykelti Williamson','https://image.tmdb.org/t/p/w500/dR16zD9AjnHWbeN5OVmJWE0vSax.jpg',13,NULL),(136,'Michael Conner Humphreys','https://image.tmdb.org/t/p/w500/irYRs3COggVHg91jL3CrlCIWmnx.jpg',13,NULL),(137,'Hanna Hall','https://image.tmdb.org/t/p/w500/xkZ2Hwz1QLXvQCgGlWgVgx00Rtd.jpg',13,NULL),(138,'헤일리 조엘 오스먼트','https://image.tmdb.org/t/p/w500/2rnMTQB9Q3vLtmRyyUaenVwSgfY.jpg',13,NULL),(139,'Siobhan Fallon Hogan','https://image.tmdb.org/t/p/w500/5OExagnRsUcOYLMPTSrv4x2G95R.jpg',13,NULL),(140,'Rebecca Williams','https://image.tmdb.org/t/p/w500null',13,NULL),(141,'클린트 이스트우드','https://image.tmdb.org/t/p/w500/8TwdCfeOZH7ucRlfLZ6wObxa7cO.jpg',429,NULL),(142,'일라이 월릭','https://image.tmdb.org/t/p/w500/s452wxFLaOwAIs6juD0rrvxaFxL.jpg',429,NULL),(143,'리 밴클리프','https://image.tmdb.org/t/p/w500/yQc5wjNCdRZzPp5E2wRPRYsEq9a.jpg',429,NULL),(144,'Aldo Giuffrè','https://image.tmdb.org/t/p/w500/aT6eECl1R3YGYL4KatyIQrq0zG8.jpg',429,NULL),(145,'Luigi Pistilli','https://image.tmdb.org/t/p/w500/bH5vmD2CMBHzJyBe0P0bL6iTUNL.jpg',429,NULL),(146,'Rada Rassimov','https://image.tmdb.org/t/p/w500/xJhnSHn2vKp0MJ2KZaihrgqq0Mc.jpg',429,NULL),(147,'Enzo Petito','https://image.tmdb.org/t/p/w500null',429,NULL),(148,'Claudio Scarchilli','https://image.tmdb.org/t/p/w500null',429,NULL),(149,'Antonio Casale','https://image.tmdb.org/t/p/w500/uAhNOD1ZA9Gh1CmCWkb4RRI1OKd.jpg',429,NULL),(150,'Livio Lorenzon','https://image.tmdb.org/t/p/w500/quxiG5nXHz2sZq5VrlWLBGD0ZaK.jpg',429,NULL),(151,'미후네 토시로','https://image.tmdb.org/t/p/w500/3A9PqrtiXHLp8B2JL7m3YvVXrmL.jpg',346,NULL),(152,'시무라 타카시','https://image.tmdb.org/t/p/w500/ydyAm2vyBbEPZRICIMqqjDm0NM9.jpg',346,NULL),(153,'이나바 요시오','https://image.tmdb.org/t/p/w500/5qIAqM5PegWTNq67qNofz78fb6U.jpg',346,NULL),(154,'미야구치 세이지','https://image.tmdb.org/t/p/w500/97XiJh1TSdu4hmJUp4Am5afgBZx.jpg',346,NULL),(155,'치아키 미노루','https://image.tmdb.org/t/p/w500/7gxmZcpEK95BVskWxKJaJvJsTPZ.jpg',346,NULL),(156,'카토 다이수케','https://image.tmdb.org/t/p/w500/7VATRGIU5NNhzdb6ZdJLKdqEvPW.jpg',346,NULL),(157,'키무라 이사오','https://image.tmdb.org/t/p/w500/afLPuf3x7UYXryAbqAGqmRcVNNW.jpg',346,NULL),(158,'츠시마 케이코','https://image.tmdb.org/t/p/w500/c4h0z00YkEUav0lGHoqVpeUzbul.jpg',346,NULL),(159,'사마자키 유키코','https://image.tmdb.org/t/p/w500/wX1QqvkIdBQbNexTCxbmXyu6dUf.jpg',346,NULL),(160,'藤原釜足','https://image.tmdb.org/t/p/w500/jf1aok2Ln5XG805BDzBJc2PjZQg.jpg',346,NULL),(161,'로버트 드 니로','https://image.tmdb.org/t/p/w500/cT8htcckIuyI1Lqwt1CvD02ynTh.jpg',769,NULL),(162,'레이 리오타','https://image.tmdb.org/t/p/w500/jdwGJbJNSRQiG2kB5MJxiu2clCQ.jpg',769,NULL),(163,'조 페시','https://image.tmdb.org/t/p/w500/1WHLXwT0TDZDWFVRcFve1B0EjNK.jpg',769,NULL),(164,'로렌 브라코','https://image.tmdb.org/t/p/w500/cmVcc09jfmoOqGLY595aBQu3IsP.jpg',769,NULL),(165,'폴 소비노','https://image.tmdb.org/t/p/w500/1gF0UskusEdDcNaBDJ2CMsz5Agi.jpg',769,NULL),(166,'Frank Sivero','https://image.tmdb.org/t/p/w500/eqvhj0iNtcsN6EJhd21Goqi1DSq.jpg',769,NULL),(167,'Tony Darrow','https://image.tmdb.org/t/p/w500/kc6cGKm2yYx5ekHo4zGizhMLBge.jpg',769,NULL),(168,'Mike Starr','https://image.tmdb.org/t/p/w500/hJGhV91dSUiFJ8GwGDTEEri79LX.jpg',769,NULL),(169,'Frank Vincent','https://image.tmdb.org/t/p/w500/fa1gikNsPKvX1roWUo2bBmixnvp.jpg',769,NULL),(170,'Chuck Low','https://image.tmdb.org/t/p/w500/zaw5Tyk2K6aawV13fQ4tSPdbEUp.jpg',769,NULL),(171,'매튜 매커너히','https://image.tmdb.org/t/p/w500/lCySuYjhXix3FzQdS4oceDDrXKI.jpg',157336,NULL),(172,'앤 해서웨이','https://image.tmdb.org/t/p/w500/s6tflSD20MGz04ZR2R1lZvhmC4Y.jpg',157336,NULL),(173,'마이클 케인','https://image.tmdb.org/t/p/w500/bVZRMlpjTAO2pJK6v90buFgVbSW.jpg',157336,NULL),(174,'제시카 차스테인','https://image.tmdb.org/t/p/w500/xRvRzxiiHhgUErl0yf9w8WariRE.jpg',157336,NULL),(175,'케이시 애플렉','https://image.tmdb.org/t/p/w500/vD5MtCjHPHpmU9XNn74EPGMHT7o.jpg',157336,NULL),(176,'웨스 벤틀리','https://image.tmdb.org/t/p/w500/qwFi0SsOqm7feN4ps7cAiQDTNHL.jpg',157336,NULL),(177,'토퍼 그레이스','https://image.tmdb.org/t/p/w500/oJQxl4DG0KSCtOGrpWNhYz9gUZA.jpg',157336,NULL),(178,'맥켄지 포이','https://image.tmdb.org/t/p/w500/6n8yZKJ3YHkm4Ds3zNjJpankHUk.jpg',157336,NULL),(179,'앨런 버스틴','https://image.tmdb.org/t/p/w500/wjxo9Yw8ZoKewcRlHShfTIZGVQF.jpg',157336,NULL),(180,'존 리스고','https://image.tmdb.org/t/p/w500/8Y1sjBdnVR483S8PrnAQzlESwhx.jpg',157336,NULL),(181,'辰巳努','https://image.tmdb.org/t/p/w500null',12477,NULL),(182,'白石綾乃','https://image.tmdb.org/t/p/w500null',12477,NULL),(183,'志乃原良子','https://image.tmdb.org/t/p/w500null',12477,NULL),(184,'山口朱美','https://image.tmdb.org/t/p/w500null',12477,NULL),(185,'Masayo Sakai','https://image.tmdb.org/t/p/w500null',12477,NULL),(186,'Kozo Hashida','https://image.tmdb.org/t/p/w500null',12477,NULL),(187,'Kazumi Nozaki','https://image.tmdb.org/t/p/w500null',12477,NULL),(188,'Yoshio Matsuoka','https://image.tmdb.org/t/p/w500null',12477,NULL),(189,'Masahiro Kanetake','https://image.tmdb.org/t/p/w500null',12477,NULL),(190,'Kiyoshi Yanagawa','https://image.tmdb.org/t/p/w500null',12477,NULL),(191,'로베르토 베니니','https://image.tmdb.org/t/p/w500/ba1Sg02XxCphu6E1dWDMAH1GzeE.jpg',637,NULL),(192,'Nicoletta Braschi','https://image.tmdb.org/t/p/w500/9IeE3Iz9HXZVTrvhjSCKlR4FLxB.jpg',637,NULL),(193,'Giorgio Cantarini','https://image.tmdb.org/t/p/w500/1tKZHpVTYcw8EP3naVTZFlrOkhQ.jpg',637,NULL),(194,'Giustino Durano','https://image.tmdb.org/t/p/w500/o302wA8DHLHDLhTXOF5wEi3C99G.jpg',637,NULL),(195,'Sergio Bini Bustric','https://image.tmdb.org/t/p/w500/crnlLn1SxP2LqbsXNr8CQrvaiNc.jpg',637,NULL),(196,'Marisa Paredes','https://image.tmdb.org/t/p/w500/71esuRUCyeSyib35mTFPkR24zH7.jpg',637,NULL),(197,'Horst Buchholz','https://image.tmdb.org/t/p/w500/9V38Di9T0qsjKBl2dR7sZMN1N0i.jpg',637,NULL),(198,'Lidia Alfonsi','https://image.tmdb.org/t/p/w500/85BrcBOeIcfV9XkV523wN0VGNRR.jpg',637,NULL),(199,'Giuliana Lojodice','https://image.tmdb.org/t/p/w500/cACsY8JyWaR3WeX7w1D09YssXbq.jpg',637,NULL),(200,'Amerigo Fontani','https://image.tmdb.org/t/p/w500/uRQn3gGNPGQzG6XNli1b1TiEu6G.jpg',637,NULL),(331,'Asha Banks','https://image.tmdb.org/t/p/w500/9McWYJPSySGOcNr5KuFWyW2bLe7.jpg',1294203,NULL),(332,'Matthew Broome','https://image.tmdb.org/t/p/w500/nSjPuDG5IVQfyMU8TkZl0ZQkLu6.jpg',1294203,NULL),(333,'Eve Macklin','https://image.tmdb.org/t/p/w500/2LaLgZbTBwLy1KojJ8UQivli4fF.jpg',1294203,NULL),(334,'Ray Fearon','https://image.tmdb.org/t/p/w500/ou2cqhqdhfQoKVEBpIh0P3sKZti.jpg',1294203,NULL),(335,'Enva Lewis','https://image.tmdb.org/t/p/w500/hFBuqi7NFiFgHho2J2IM43nZcrG.jpg',1294203,NULL),(336,'제이슨 플레밍','https://image.tmdb.org/t/p/w500/nYl0180ACnLzVlGbaAfuPtdGr9K.jpg',1294203,NULL),(337,'Kerim Hassan','https://image.tmdb.org/t/p/w500/b1LNPysqfX5XmCkF8En67RR3aPI.jpg',1294203,NULL),(338,'Sam Buchanan','https://image.tmdb.org/t/p/w500/au5WjiUcUjheDEJ8BEXRFXhsIS8.jpg',1294203,NULL),(339,'Amelia Kenworthy','https://image.tmdb.org/t/p/w500/3QgUXGc7iOEHDlK7MQhTBmkKpP.jpg',1294203,NULL),(340,'Harry Gilby','https://image.tmdb.org/t/p/w500/eHaNRhInsS2ore7iJIByaZREjfU.jpg',1294203,NULL),(341,'ณเดชน์ คูกิมิยะ','https://image.tmdb.org/t/p/w500/w58HrktpHZ7UVGY5SKoJxFkitCy.jpg',1247019,NULL),(342,'องอาจ เจียมเจริญพรกุล','https://image.tmdb.org/t/p/w500/i3e4IuDngcByoViRZ8HMwNMNdRw.jpg',1247019,NULL),(343,'กาจบัณฑิต ใจดี','https://image.tmdb.org/t/p/w500/4XCjfePa5LYyYoUjWfwsODxszT0.jpg',1247019,NULL),(344,'พีระกฤตย์ พชรบุณยเกียรติ','https://image.tmdb.org/t/p/w500/tr7Lmmqp1iRKlSaoJCyec0OZ1sf.jpg',1247019,NULL),(345,'Denise Jelilcha Kapaun','https://image.tmdb.org/t/p/w500/d7rfzM7mmsHNKor8dXJ2f81I9qR.jpg',1247019,NULL),(346,'รัตนวดี วงศ์ทอง','https://image.tmdb.org/t/p/w500/cF5AWXXOleumTIEIp4DRFri9RxF.jpg',1247019,NULL),(347,'ณัฐชา พาโดวัน','https://image.tmdb.org/t/p/w500/3xvUSnerABXxlaX4x1bTDhlMvt3.jpg',1247019,NULL),(348,'ปรเมศร์ น้อยอ่ำ','https://image.tmdb.org/t/p/w500/8qu82ac9tKjRGBHlCoKZRT864TT.jpg',1247019,NULL),(349,'อริศรา วงษ์ชาลี','https://image.tmdb.org/t/p/w500/p8KgolBImhMDs12qjzYiuYo9iUM.jpg',1247019,NULL),(350,'พีรวิชญ์ อรรถชิตสถาพร','https://image.tmdb.org/t/p/w500/hcXDLPQsfejMwERMgUdOCajQpaL.jpg',1247019,NULL),(361,'루피타 뇽오','https://image.tmdb.org/t/p/w500/y40Wu1T742kynOqtwXASc5Qgm49.jpg',1184918,NULL),(362,'페드로 파스칼','https://image.tmdb.org/t/p/w500/9VYK7oxcqhjd5LAH6ZFJ3XzOlID.jpg',1184918,NULL),(363,'킷 코너','https://image.tmdb.org/t/p/w500/6BDubD35VfSa0uyPr0UuYznuiM4.jpg',1184918,NULL),(364,'빌 나이','https://image.tmdb.org/t/p/w500/acbigDOU1L1vMWAL3Wf0r8h8qLA.jpg',1184918,NULL),(365,'스테파니 수','https://image.tmdb.org/t/p/w500/8gb3lfIHKQAGOQyeC4ynQPsCiHr.jpg',1184918,NULL),(366,'Matt Berry','https://image.tmdb.org/t/p/w500/7a1sWg1W7ZmNF8bLSnyAlJgQQGD.jpg',1184918,NULL),(367,'빙 레임스','https://image.tmdb.org/t/p/w500/4gpLVNKPZlVucc4fT2fSZ7DksTK.jpg',1184918,NULL),(368,'마크 해밀','https://image.tmdb.org/t/p/w500/2ZulC2Ccq1yv3pemusks6Zlfy2s.jpg',1184918,NULL),(369,'캐서린 오하라','https://image.tmdb.org/t/p/w500/gI2RyymLJ9ZrhEyJSD5EqSvFpCX.jpg',1184918,NULL),(370,'Boone Storm','https://image.tmdb.org/t/p/w500/kn5JY9C0oHq09MFLB5vFpoqgop7.jpg',1184918,NULL),(371,'Alina Desmond','https://image.tmdb.org/t/p/w500/x9oJMfVNpf75klfBFfJ5hwRcjY0.jpg',1352774,NULL),(372,'Alex Butler','https://image.tmdb.org/t/p/w500/bsX3iYEz4EsgYabM0s93ey9o7XK.jpg',1352774,NULL),(373,'Lauren Staerck','https://image.tmdb.org/t/p/w500/nLQCRFarkWMd7ZUE4iF6SBrNCvD.jpg',1352774,NULL),(374,'Valery Danko','https://image.tmdb.org/t/p/w500/7k7b9miMSdMXKrFRh0EkyiR3TaJ.jpg',1352774,NULL),(375,'Shayli Reagan','https://image.tmdb.org/t/p/w500/xPZvbN5jmO5m4dOJj0R2DD6wUhx.jpg',1352774,NULL),(376,'Jamie Langlands','https://image.tmdb.org/t/p/w500/3o7Bdjt3DKyGrFHTnk2VwNfsJri.jpg',1352774,NULL),(377,'Tyler Winchcombe','https://image.tmdb.org/t/p/w500/h0hdrwZKJQGtXtmhDz3NfzvfVdr.jpg',1352774,NULL),(378,'Alina Varakuta','https://image.tmdb.org/t/p/w500/ioncsWDGAT9QFMh2iY7wRZyZb3G.jpg',1352774,NULL),(379,'Max Arlott','https://image.tmdb.org/t/p/w500/2yVa6dsNl8GItIZmYGwHb0DgU09.jpg',1352774,NULL),(380,'Rory Forder','https://image.tmdb.org/t/p/w500/7FCsW5a69qvOe6tFAw5zQaP7yxI.jpg',1352774,NULL),(431,'신시아 에리보','https://image.tmdb.org/t/p/w500/oQcFwHu50upW6Soz4Ycc9iHge1k.jpg',402431,NULL),(432,'아리아나 그란데','https://image.tmdb.org/t/p/w500/cslFyOh3sTWDeWXgsxmjJ1uqE0P.jpg',402431,NULL),(433,'제프 골드블룸','https://image.tmdb.org/t/p/w500/o3PahuK7OmCI0RAQUq38CUBWYZ9.jpg',402431,NULL),(434,'양자경','https://image.tmdb.org/t/p/w500/nrbHNzSMydpWK9um5VqWIFJihB5.jpg',402431,NULL),(435,'조나단 베일리','https://image.tmdb.org/t/p/w500/mZNzekZo8eaHMuXKgDTNLp0EvYM.jpg',402431,NULL),(436,'Ethan Slater','https://image.tmdb.org/t/p/w500/xIgqyrM78FPt7Pb2Vv3IvJcnOWS.jpg',402431,NULL),(437,'Marissa Bode','https://image.tmdb.org/t/p/w500/uqifog9p62A6dW9T4yivfWnSFXQ.jpg',402431,NULL),(438,'피터 딘클리지','https://image.tmdb.org/t/p/w500/9CAd7wr8QZyIN0E7nm8v1B6WkGn.jpg',402431,NULL),(439,'앤디 나이맨','https://image.tmdb.org/t/p/w500/9bN9RVoPWmsmV3VBI7hp4VKD9Kg.jpg',402431,NULL),(440,'Courtney Mae-Briggs','https://image.tmdb.org/t/p/w500/ofOEXvhJpbFV7v8ZnH0ztTPGKkr.jpg',402431,NULL),(441,'벤 위쇼','https://image.tmdb.org/t/p/w500/2GBtQ6scGeSHkX1urOP1EJbmksx.jpg',516729,NULL),(442,'휴 보네빌','https://image.tmdb.org/t/p/w500/skbxj8MUuNiI39ZkP38uEirU0bC.jpg',516729,NULL),(443,'에밀리 모티머','https://image.tmdb.org/t/p/w500/eh0AebcU5ag535e3KLb6ydWR09d.jpg',516729,NULL),(444,'Samuel Joslin','https://image.tmdb.org/t/p/w500/gXthNRK0BN9IqXnhKIc4glxOB7P.jpg',516729,NULL),(445,'Madeleine Harris','https://image.tmdb.org/t/p/w500/a0leGmuuQslxiuP7g52sMxET6rm.jpg',516729,NULL),(446,'안토니오 반데라스','https://image.tmdb.org/t/p/w500/n8YlGookYzgD3cmpMP45BYRNIoh.jpg',516729,NULL),(447,'올리비아 콜먼','https://image.tmdb.org/t/p/w500/lawJUdbLb1YW0niaYjiVGR9IBG8.jpg',516729,NULL),(448,'줄리 월터스','https://image.tmdb.org/t/p/w500/bCTkV2OUgzbJdQEoCk3GesE4DXq.jpg',516729,NULL),(449,'짐 브로드벤트','https://image.tmdb.org/t/p/w500/s7lXYfrsJoGA4vKmyv61SPgABmR.jpg',516729,NULL),(450,'Carla Tous','https://image.tmdb.org/t/p/w500/8wriPsd59p97mH9vXCq4JW5DmYz.jpg',516729,NULL),(451,'레이프 파인스','https://image.tmdb.org/t/p/w500/tJr9GcmGNHhLVVEH3i7QYbj6hBi.jpg',974576,NULL),(452,'스탠리 투치','https://image.tmdb.org/t/p/w500/q4TanMDI5Rgsvw4SfyNbPBh4URr.jpg',974576,NULL),(453,'존 리스고','https://image.tmdb.org/t/p/w500/8Y1sjBdnVR483S8PrnAQzlESwhx.jpg',974576,NULL),(454,'이사벨라 로셀리니','https://image.tmdb.org/t/p/w500/z0zojT6nwDxi35HMcXlVpBfuBAU.jpg',974576,NULL),(455,'루시안 므사마티','https://image.tmdb.org/t/p/w500/vGPnCNjSL4JwVQ4yqh0XLK2GpXM.jpg',974576,NULL),(456,'카를로스 디에즈','https://image.tmdb.org/t/p/w500/nFUIkEhybpBsIIUOWVUOJIgKUh5.jpg',974576,NULL),(457,'세르조 카스텔리토','https://image.tmdb.org/t/p/w500/uq5xz7kinzgdclGOcechgfPBgYC.jpg',974576,NULL),(458,'Brían F. O\'Byrne','https://image.tmdb.org/t/p/w500/9obqr2sZ0cf4z2ZsZoaHslSx45V.jpg',974576,NULL),(459,'Merab Ninidze','https://image.tmdb.org/t/p/w500/jnJ4lQULt6Ga3lXkIqAhMR7xYdE.jpg',974576,NULL),(460,'Thomas Loibl','https://image.tmdb.org/t/p/w500/8p5ojGY95pCQnI1xaiBprzKrwpb.jpg',974576,NULL),(461,'크리스토퍼 애벗','https://image.tmdb.org/t/p/w500/qWmlTycQb3yXaGhxPb6LCyaDjqh.jpg',710295,NULL),(462,'줄리아 가너','https://image.tmdb.org/t/p/w500/3ssgMsIWiTafSrjHNYdxYYZcvuf.jpg',710295,NULL),(463,'마틸다 퍼스','https://image.tmdb.org/t/p/w500/jmNWhQKAWy0uzGus4BpbKkQjWZ9.jpg',710295,NULL),(464,'Sam Jaeger','https://image.tmdb.org/t/p/w500/8t4wSekn6vUyEmg9etTnvTaGJEV.jpg',710295,NULL),(465,'Ben Prendergast','https://image.tmdb.org/t/p/w500/3xwPaoqFzk9t9uJlzcmvsvgBGaf.jpg',710295,NULL),(466,'Benedict Hardie','https://image.tmdb.org/t/p/w500/9TTxsMDyHr8W8ZerV1EIj1f8dKP.jpg',710295,NULL),(467,'Zac Chandler','https://image.tmdb.org/t/p/w500/z7g1R5mGfTFNlvlzsMqnNCciSWY.jpg',710295,NULL),(468,'Milo Cawthorne','https://image.tmdb.org/t/p/w500/4BRryDvdn2evnXtKb7ZWbOyya2y.jpg',710295,NULL),(469,'Leigh Whannell','https://image.tmdb.org/t/p/w500/wvoTbsROOHfCqJ3Voe9zpal429L.jpg',710295,NULL),(470,'Rob MacBride','https://image.tmdb.org/t/p/w500/uLizFZ1UwlHqRmnqzmhDmQaYP52.jpg',710295,NULL),(471,'에바 그린','https://image.tmdb.org/t/p/w500/xCK90nAZWwElzmWwgvKyEwoCTrI.jpg',1043905,NULL),(472,'마리아 바칼로바','https://image.tmdb.org/t/p/w500/vCz0ycZr1PgJVOAeS29fIiZE8pN.jpg',1043905,NULL),(473,'루비 로즈','https://image.tmdb.org/t/p/w500/djhT0A2hZxpYKPnCeRtim8qUdPi.jpg',1043905,NULL),(474,'Reza Brojerdi','https://image.tmdb.org/t/p/w500/oimN6FyXti8HU3qkxNGTiRol4UB.jpg',1043905,NULL),(475,'Jojo T. Gibbs','https://image.tmdb.org/t/p/w500/sIHpG5ux9C14XADUHa11EWOMA6I.jpg',1043905,NULL),(476,'Emily Bruni','https://image.tmdb.org/t/p/w500/g4nb8Ws5YpkDCD7S68H0TfY4nCh.jpg',1043905,NULL),(477,'Aziz Çapkurt','https://image.tmdb.org/t/p/w500/c4Xo3ysMTRleXYBDOkBwGaRKLCk.jpg',1043905,NULL),(478,'Rona-Lee Shim\'on','https://image.tmdb.org/t/p/w500/tsbVNfgRukCyPEVog2bIhcOSJWx.jpg',1043905,NULL),(479,'George Iskandar','https://image.tmdb.org/t/p/w500null',1043905,NULL),(480,'Christopher Backus','https://image.tmdb.org/t/p/w500/g48BUWwmbbZDD8fgZACIO5G9NuN.jpg',1043905,NULL),(481,'휴 그랜트','https://image.tmdb.org/t/p/w500/hsSfxSHzkKJ6ZKq1Ofngcp7aAnT.jpg',1138194,NULL),(482,'소피 대처','https://image.tmdb.org/t/p/w500/rUEPZaDxFdDGM76t4g6cYa8Ru7b.jpg',1138194,NULL),(483,'클로이 이스트','https://image.tmdb.org/t/p/w500/7yFO6DB8O7FmkJpi2mBRJZApbiQ.jpg',1138194,NULL),(484,'토퍼 그레이스','https://image.tmdb.org/t/p/w500/oJQxl4DG0KSCtOGrpWNhYz9gUZA.jpg',1138194,NULL),(485,'Elle Young','https://image.tmdb.org/t/p/w500/rEcGyAm06RMBgR8T7xPOjZNMElO.jpg',1138194,NULL),(486,'Julie Lynn-Mortensen','https://image.tmdb.org/t/p/w500/47bJBypW6YVBeQuTaaQQuusGRMm.jpg',1138194,NULL),(487,'Haylie Hansen','https://image.tmdb.org/t/p/w500/gWsrbcsRQYoyxZp7LdUZ8kissc6.jpg',1138194,NULL),(488,'Elle McKinnon','https://image.tmdb.org/t/p/w500/qBrsyaF4EM6cdBQfU7XnyFmx7Ym.jpg',1138194,NULL),(489,'Hanna Huffman','https://image.tmdb.org/t/p/w500null',1138194,NULL),(490,'Anesha Bailey','https://image.tmdb.org/t/p/w500/kMuEZEvppyRzsNV8uxpqfmOXdMY.jpg',1138194,NULL),(491,'페르난다 토히스','https://image.tmdb.org/t/p/w500/dkxdADNwbM7ZLQK5YBNeKBqVJNM.jpg',1000837,NULL),(492,'Selton Mello','https://image.tmdb.org/t/p/w500/sd9pWha3ThWyX5DPsVnZVPKSJ9W.jpg',1000837,NULL),(493,'Valentina Herszage','https://image.tmdb.org/t/p/w500/uJxN1QpU7XJzeg2navvMIQOGAjj.jpg',1000837,NULL),(494,'Bárbara Luz','https://image.tmdb.org/t/p/w500/im8iKs98xlvkUjnwt2wVRkzLNm5.jpg',1000837,NULL),(495,'Guilherme Silveira','https://image.tmdb.org/t/p/w500null',1000837,NULL),(496,'Cora Mora','https://image.tmdb.org/t/p/w500null',1000837,NULL),(497,'Luiza Kosovski','https://image.tmdb.org/t/p/w500/zu3oHbqfqfc6u72wkWq5FCirmgS.jpg',1000837,NULL),(498,'Pri Helena','https://image.tmdb.org/t/p/w500/7IX1aFRFIGOVuNb5hDYlBv5HMLu.jpg',1000837,NULL),(499,'Luiz Bertazzo','https://image.tmdb.org/t/p/w500/9rpkxfChPTkNkOscTfd2lqqENix.jpg',1000837,NULL),(500,'Maeve Jinkings','https://image.tmdb.org/t/p/w500/s1pZd8CgUIll9ALVcgtUJhsB8uF.jpg',1000837,NULL),(501,'로버트 패틴슨','https://image.tmdb.org/t/p/w500/8A4PS5iG7GWEAVFftyqMZKl3qcr.jpg',696506,NULL),(502,'나오미 애키','https://image.tmdb.org/t/p/w500/kRJHgH4ATdFrHmWS48enQn2qiZj.jpg',696506,NULL),(503,'마크 러팔로','https://image.tmdb.org/t/p/w500/5GilHMOt5PAQh6rlUKZzGmaKEI7.jpg',696506,NULL),(504,'토니 콜렛','https://image.tmdb.org/t/p/w500/lzXRh16qe4HHeBN6tMyw0DHvaMn.jpg',696506,NULL),(505,'아나마리아 바르톨로메이','https://image.tmdb.org/t/p/w500/MBAMikxTFkYkCVurQignL6W0nE.jpg',696506,NULL),(506,'스티븐 연','https://image.tmdb.org/t/p/w500/5XU0L0drBa7JlGrLg2w3LhAgjG0.jpg',696506,NULL),(507,'팻시 페란','https://image.tmdb.org/t/p/w500/m2twb29so7T5cW5IVs611FhQkZl.jpg',696506,NULL),(508,'스티브 박','https://image.tmdb.org/t/p/w500/4VJHB0du5M5khzcCeapKlbxxDxc.jpg',696506,NULL),(509,'팀 키','https://image.tmdb.org/t/p/w500/5qaZxWpm3lXDbngjZJvnSbVS9I0.jpg',696506,NULL),(510,'홀리데이 그레인저','https://image.tmdb.org/t/p/w500/fHveeGXgEfTZ9slB5OvHDG4LAPw.jpg',696506,NULL),(511,'테오 제임스','https://image.tmdb.org/t/p/w500/lSC4cMhcQeCjPFkK6qCjSGDSeR3.jpg',1124620,NULL),(512,'타티아나 마슬라니','https://image.tmdb.org/t/p/w500/c0VY8bB10l2oJvEnDmSxiEHNN1g.jpg',1124620,NULL),(513,'Christian Convery','https://image.tmdb.org/t/p/w500/c1l5tNjmxzDAIaTHvzEfooUsAf8.jpg',1124620,NULL),(514,'Colin O\'Brien','https://image.tmdb.org/t/p/w500/qF38oBiO1b7nEua71FY2XfIayZl.jpg',1124620,NULL),(515,'애덤 스콧','https://image.tmdb.org/t/p/w500/b82C29R6fGiPoqIglQ4lzS6q2YX.jpg',1124620,NULL),(516,'일라이저 우드','https://image.tmdb.org/t/p/w500/7UKRbJBNG7mxBl2QQc5XsAh6F8B.jpg',1124620,NULL),(517,'Rohan Campbell','https://image.tmdb.org/t/p/w500/52LIlmT5Pv7sqhlKBRHCkBkl1qT.jpg',1124620,NULL),(518,'Sarah Levy','https://image.tmdb.org/t/p/w500/l37vAd4fkzv9EH8r9eChuzrSPxu.jpg',1124620,NULL),(519,'오즈 퍼킨스','https://image.tmdb.org/t/p/w500/sshAqrQ2DV2TUsgBAr1XaYqqxkm.jpg',1124620,NULL),(520,'Nicco Del Rio','https://image.tmdb.org/t/p/w500/c9UyLuVDwwrInDQt2BiDWRXKTOw.jpg',1124620,NULL),(521,'조 샐다나','https://image.tmdb.org/t/p/w500/iOVbUH20il632nj2v01NCtYYeSg.jpg',974950,NULL),(522,'카를라 소피아 가스콘','https://image.tmdb.org/t/p/w500/vmg6gqpaXnoRFP7NWdSTrsr1CED.jpg',974950,NULL),(523,'셀레나 고메즈','https://image.tmdb.org/t/p/w500/MtZ9pJrCcZ1ckxOZym7Jk1QNVB.jpg',974950,NULL),(524,'Adriana Paz','https://image.tmdb.org/t/p/w500/aUBNKmudV1CCMUHskWemg58vc3n.jpg',974950,NULL),(525,'에드가 라미레즈','https://image.tmdb.org/t/p/w500/7VZnIAI7Yye0rfs7fPM5wI2CI6N.jpg',974950,NULL),(526,'Mark Ivanir','https://image.tmdb.org/t/p/w500/1kxGAsP4YRiR7LgmlM9KgtekMLk.jpg',974950,NULL),(527,'Eduardo Aladro','https://image.tmdb.org/t/p/w500/xIp49DJjGiQilC6NK94hGdKnOw0.jpg',974950,NULL),(528,'Emiliano Hasan','https://image.tmdb.org/t/p/w500/xb2wmTZkuflhYxp6Mp9b2cyQd8k.jpg',974950,NULL),(529,'Gaël Murgia-Fur','https://image.tmdb.org/t/p/w500null',974950,NULL),(530,'Tirso Pietriga','https://image.tmdb.org/t/p/w500null',974950,NULL),(531,'로비 윌리엄스','https://image.tmdb.org/t/p/w500/f1zx0gcYjBCo8802WBr3egRcDDl.jpg',799766,NULL),(532,'Jonno Davies','https://image.tmdb.org/t/p/w500/oI68xvcPqZjRIfteTbtT3jAVUV1.jpg',799766,NULL),(533,'스티브 펨버턴','https://image.tmdb.org/t/p/w500/j4AFPsF6DM9nfccol3VFQgPJ6Ia.jpg',799766,NULL),(534,'앨리슨 스테드먼','https://image.tmdb.org/t/p/w500/BY0jL3IrAx7TA2OlQhY03ISk9i.jpg',799766,NULL),(535,'Kate Mulvany','https://image.tmdb.org/t/p/w500/y80VZs4JwiXFlTvr5n8Y5Ezr3HS.jpg',799766,NULL),(536,'Frazer Hadfield','https://image.tmdb.org/t/p/w500/tygdh1voUl3FxGWtBiGquLZxQlM.jpg',799766,NULL),(537,'데이먼 헤리먼','https://image.tmdb.org/t/p/w500/wMCYFY8qzKEvg9Jq6cQmLnHHyLl.jpg',799766,NULL),(538,'Raechelle Banno','https://image.tmdb.org/t/p/w500/5DcDDA98ePCpcRLMPsuOkQBj9X4.jpg',799766,NULL),(539,'Tom Budge','https://image.tmdb.org/t/p/w500/m2IOaOruyGh2zBTyW0WMwztye6w.jpg',799766,NULL),(540,'Jake Simmance','https://image.tmdb.org/t/p/w500/7LOahL8irYepnFzHh5T8MbJZseH.jpg',799766,NULL),(541,'吕艳婷','https://image.tmdb.org/t/p/w500/vKpOzPutTaPf03rWXiLuK8R2K3B.jpg',980477,NULL),(542,'囧森瑟夫','https://image.tmdb.org/t/p/w500/58Ytg6PBGpqB2s7DkHB82dRvdFO.jpg',980477,NULL),(543,'瀚墨','https://image.tmdb.org/t/p/w500/6Ueom0Y4pjIG9B6zjQlfIbgcGhH.jpg',980477,NULL),(544,'陈浩','https://image.tmdb.org/t/p/w500/eBZJW1NCBFDh3U3xImf0vCCnDpy.jpg',980477,NULL),(545,'绿绮','https://image.tmdb.org/t/p/w500/eGoSeaM1c6KCLiRIqM8LJq5S5L5.jpg',980477,NULL),(546,'张珈铭','https://image.tmdb.org/t/p/w500/7iL4a5fYc2ZLqFtzgJXYJwzXl8x.jpg',980477,NULL),(547,'Yang Wei','https://image.tmdb.org/t/p/w500/rTi0M7yePiL3NqEGg5pTL7x56De.jpg',980477,NULL),(548,'王德顺','https://image.tmdb.org/t/p/w500/oMYVIRpr1t7L8mOYZAMXGf8XhmC.jpg',980477,NULL),(549,'雨辰','https://image.tmdb.org/t/p/w500/zZ15ZOUpH7yNZ5Rz71l7YUhveMN.jpg',980477,NULL),(550,'Zhou Yongxi','https://image.tmdb.org/t/p/w500/8wjA8e2JOk4C11cGwqCo7uRLPem.jpg',980477,NULL),(551,'제라드 버틀러','https://image.tmdb.org/t/p/w500/n7sTgAGHyL3u9KIOVWjVLRA1fyi.jpg',604685,NULL),(552,'오셰이 잭슨 주니어','https://image.tmdb.org/t/p/w500/zov23iUpL3QFHqzjdtzrBGOQYaF.jpg',604685,NULL),(553,'Evin Ahmad','https://image.tmdb.org/t/p/w500/806b9K90Q2Da3IKvm3EISMDnSfQ.jpg',604685,NULL),(554,'Salvatore Esposito','https://image.tmdb.org/t/p/w500/lvTeMD1NqYmYbaH0jYek2oXaSvR.jpg',604685,NULL),(555,'Meadow Williams','https://image.tmdb.org/t/p/w500/7CQHKHgjAEcKaeTOZ2XsBVoT6Uz.jpg',604685,NULL),(556,'Swen Temmel','https://image.tmdb.org/t/p/w500/z6zLmf3PBsTGMU3RBnguAqfHUn3.jpg',604685,NULL),(557,'Michael Bisping','https://image.tmdb.org/t/p/w500/xF6wdVG9pYbYRhS0ncaweWPpb7Y.jpg',604685,NULL),(558,'Orli Shuka','https://image.tmdb.org/t/p/w500/hw3IkKmeCC9m9xW7qovY3SOt7Pp.jpg',604685,NULL),(559,'Rico Verhoeven','https://image.tmdb.org/t/p/w500/6KmeuM6XcSzCT4v8Wy8rVCyPvy2.jpg',604685,NULL),(560,'조던 브리지스','https://image.tmdb.org/t/p/w500/nY1ojfUERgNcPj9PpsygP4hbofh.jpg',604685,NULL),(561,'Jason Patric','https://image.tmdb.org/t/p/w500/nbAfpao6sJBk3TvGRDwjDAfKu7X.jpg',1182387,NULL),(562,'실베스터 스탤론','https://image.tmdb.org/t/p/w500/gn3pDWthJqR0VDYGViGD3048og7.jpg',1182387,NULL),(563,'Josh Wiggins','https://image.tmdb.org/t/p/w500/8ibSjOrx62IRfcBVssu6q3lzlQp.jpg',1182387,NULL),(564,'Dash Mihok','https://image.tmdb.org/t/p/w500/jnruNUJv57nNtO66SR3oJ5tQuM5.jpg',1182387,NULL),(565,'Blake Shields','https://image.tmdb.org/t/p/w500/95XAe4FcX8CG2reCPFrJ74W2Vt5.jpg',1182387,NULL),(566,'Josh Whites','https://image.tmdb.org/t/p/w500/pJAN0zyuX7lwW97uYDmAe081DHA.jpg',1182387,NULL),(567,'Jeff Chase','https://image.tmdb.org/t/p/w500/Ahj74X5BioIUDRhdWD8i43j0pXM.jpg',1182387,NULL),(568,'Martin Bats Bradford','https://image.tmdb.org/t/p/w500/AdvVKzkT8dtNoRPm5i1Q7UvUriN.jpg',1182387,NULL),(569,'Erin Ownbey','https://image.tmdb.org/t/p/w500/oQTx5FXse1SLLXLHaqwhu0ZwPVn.jpg',1182387,NULL),(570,'Justin William Davis','https://image.tmdb.org/t/p/w500/no5yrkN4h426uMYEsS4b2LdHSfW.jpg',1182387,NULL),(571,'샘 클라플린','https://image.tmdb.org/t/p/w500/e5CU4tjCNZFfm7ITmZfzjZse2Bb.jpg',978796,NULL),(572,'Antonia Thomas','https://image.tmdb.org/t/p/w500/ybmnPYUzcr3RMdaXnZIw2jEw9ju.jpg',978796,NULL),(573,'Caréll Vincent Rhoden','https://image.tmdb.org/t/p/w500/vaEX3jxuAHQ6qQZ2TNuoDK0UqBX.jpg',978796,NULL),(574,'Will Davis','https://image.tmdb.org/t/p/w500null',978796,NULL),(575,'Adelle Leonce','https://image.tmdb.org/t/p/w500/zL3CdzHhQQdqNi6hrronOoh9jHQ.jpg',978796,NULL),(576,'William Hope','https://image.tmdb.org/t/p/w500/blKMEeCftWVBPI2hqvzycmdE9nS.jpg',978796,NULL),(577,'Steven Cree','https://image.tmdb.org/t/p/w500/oH9uSQMJPdFHeVggqvMwheW7nZl.jpg',978796,NULL),(578,'Rosalie Craig','https://image.tmdb.org/t/p/w500/6kbA9rb7GHBEcWuImDlAcnYXKYv.jpg',978796,NULL),(579,'Peter McDonald','https://image.tmdb.org/t/p/w500/ahacAWWP4zzuVumOUB8hZoJcHTA.jpg',978796,NULL),(580,'Henry Pettigrew','https://image.tmdb.org/t/p/w500/5RzqnELZmgPpVILLFGfhVGim6wu.jpg',978796,NULL),(581,'마일스 텔러','https://image.tmdb.org/t/p/w500/cg3LW0xX6RKr8dmescxq1bepcb5.jpg',950396,NULL),(582,'안야 테일러조이','https://image.tmdb.org/t/p/w500/qYNofOjlRke2MlJVihmJmEdQI4v.jpg',950396,NULL),(583,'시고니 위버','https://image.tmdb.org/t/p/w500/wTSnfktNBLd6kwQxgvkqYw6vEon.jpg',950396,NULL),(584,'쇼페 디리수','https://image.tmdb.org/t/p/w500/24Se9voPxrO200Ae8GQRbMkE55B.jpg',950396,NULL),(585,'William Houston','https://image.tmdb.org/t/p/w500/4J4TG1dbyJcSs78hP9fU2x8jrJs.jpg',950396,NULL),(586,'Kobna Holdbrook-Smith','https://image.tmdb.org/t/p/w500/6KNQjNWVdosnKAehV7FHpxQV2dD.jpg',950396,NULL),(587,'James Marlowe','https://image.tmdb.org/t/p/w500/grKtqA62ni9yBqGekfq3Aw1GM1o.jpg',950396,NULL),(588,'Julianna Kurokawa','https://image.tmdb.org/t/p/w500/lcUwHeEaEEo2prfegN7q616Wp7E.jpg',950396,NULL),(589,'루타 게드민터스','https://image.tmdb.org/t/p/w500/ArRuSKwJJwr3venBPjwoukApa8j.jpg',950396,NULL),(590,'Oliver Trevena','https://image.tmdb.org/t/p/w500/j0ejU7vdE7lRxYKKrhA5aWw1zCT.jpg',950396,NULL),(591,'마크 월버그','https://image.tmdb.org/t/p/w500/bTEFpaWd7A6AZVWOqKKBWzKEUe8.jpg',1126166,NULL),(592,'미셸 도커리','https://image.tmdb.org/t/p/w500/pgPJGf2wAPgoC6Bp5PBJYQV7IVt.jpg',1126166,NULL),(593,'토퍼 그레이스','https://image.tmdb.org/t/p/w500/oJQxl4DG0KSCtOGrpWNhYz9gUZA.jpg',1126166,NULL),(594,'Leah Remini','https://image.tmdb.org/t/p/w500/19QpURecs6wDY9G46AmT7JnTchS.jpg',1126166,NULL),(595,'Paul Ben-Victor','https://image.tmdb.org/t/p/w500/qhxGWVppbnwF4YuzQQtIym5z99E.jpg',1126166,NULL),(596,'Maaz Ali','https://image.tmdb.org/t/p/w500/o9vhi2B5f0XfwYPNAG49nrhzDFW.jpg',1126166,NULL),(597,'Monib Abhat','https://image.tmdb.org/t/p/w500/pxpDoJBaRAKHplTIFzTOuBdZ4JW.jpg',1126166,NULL),(598,'Eilise Patton','https://image.tmdb.org/t/p/w500/2QPmKLkfs56ca7Qp4OaAUwdxUsk.jpg',1126166,NULL),(599,'Senor Pablo','https://image.tmdb.org/t/p/w500null',1126166,NULL),(600,'Savanah Joeckel','https://image.tmdb.org/t/p/w500/yMTCTH5F0U8o8GIItR6hGJVmavx.jpg',1126166,NULL),(601,'에런 피어','https://image.tmdb.org/t/p/w500/z2cMMZyWzv5ztT6pFdAAjB3u7CQ.jpg',762509,NULL),(602,'케빈 해리슨 주니어','https://image.tmdb.org/t/p/w500/6kpDyaZzmSbqCNYuXZUfeMwS1bq.jpg',762509,NULL),(603,'티파니 분','https://image.tmdb.org/t/p/w500/9LwqRFdSzxVtnutDUg98YLq0bSz.jpg',762509,NULL),(604,'Kagiso Lediga','https://image.tmdb.org/t/p/w500/nfqx3CqFVsAMelk6ry560SuN7Y0.jpg',762509,NULL),(605,'Preston Nyman','https://image.tmdb.org/t/p/w500/eidKvLDCRw68tG3CN6fGhvHUnW.jpg',762509,NULL),(606,'블루 아이비 카터','https://image.tmdb.org/t/p/w500/mnaFedkdW9TFCkky7fiiT5dfXye.jpg',762509,NULL),(607,'존 카니','https://image.tmdb.org/t/p/w500/g7tqg3q128a5O2qXMCwVnXsow9I.jpg',762509,NULL),(608,'매즈 미켈슨','https://image.tmdb.org/t/p/w500/ntwPvV4GKGGHO3I7LcHMwhXfsw9.jpg',762509,NULL),(609,'세스 로건','https://image.tmdb.org/t/p/w500/2dPFskUtoiG0xafsSEGl9Oz4teA.jpg',762509,NULL),(610,'Billy Eichner','https://image.tmdb.org/t/p/w500/kScO4moqNlDbyCTZuIoBqyaml4l.jpg',762509,NULL),(611,'짐 캐리','https://image.tmdb.org/t/p/w500/u0AqTz6Y7GHPCHINS01P7gPvDSb.jpg',939243,NULL),(612,'벤 슈와츠','https://image.tmdb.org/t/p/w500/lJVYjPj0P6uvVxNrTy4xO2645D0.jpg',939243,NULL),(613,'키아누 리브스','https://image.tmdb.org/t/p/w500/8RZLOyYGsoRe9p44q3xin9QkMHv.jpg',939243,NULL),(614,'이드리스 엘바','https://image.tmdb.org/t/p/w500/be1bVF7qGX91a6c5WeRPs5pKXln.jpg',939243,NULL),(615,'콜린 오샤우너시','https://image.tmdb.org/t/p/w500/y3Kl5tCX1XD6uyL9wefTRbEXTwj.jpg',939243,NULL),(616,'제임스 마스던','https://image.tmdb.org/t/p/w500/mk142GG0saiSXALY6V4wWcmPROW.jpg',939243,NULL),(617,'티카 섬프터','https://image.tmdb.org/t/p/w500/1zTXufyuQFPXVthryH7KVoZAfb7.jpg',939243,NULL),(618,'리 마이다웁','https://image.tmdb.org/t/p/w500/vpF3R2YRCGHseGevmDAhftmOPkO.jpg',939243,NULL),(619,'크리스틴 리터','https://image.tmdb.org/t/p/w500/iF9jsrcY39uDzJnAbi3FW056D7u.jpg',939243,NULL),(620,'애덤 팰리','https://image.tmdb.org/t/p/w500/yY13PEaVbPoXT5MkitVxTfdAZnU.jpg',939243,NULL),(621,'아울리이 크러발리오','https://image.tmdb.org/t/p/w500/vEroqcnM2g6yY7qXDAie7hx2Cyp.jpg',1241982,NULL),(622,'드웨인 존슨','https://image.tmdb.org/t/p/w500/5QApZVV8FUFlVxQpIK3Ew6cqotq.jpg',1241982,NULL),(623,'Hualālai Chung','https://image.tmdb.org/t/p/w500/x2g5fdHqETY9dZgL4aB0QDP0boR.jpg',1241982,NULL),(624,'Rose Matafeo','https://image.tmdb.org/t/p/w500/zQa39fMjbOTIsovbh1TBTJVlToz.jpg',1241982,NULL),(625,'David Fane','https://image.tmdb.org/t/p/w500/tcozyaTgAa8rRmzc5qeht0loni6.jpg',1241982,NULL),(626,'Awhimai Fraser','https://image.tmdb.org/t/p/w500/276OUDPl2iIsz772HQw3tiz2JN2.jpg',1241982,NULL),(627,'Khaleesi Lambert-Tsuda','https://image.tmdb.org/t/p/w500/3LHXDjy9UijbtR7X2EReX5H57kk.jpg',1241982,NULL),(628,'테무에라 모리슨','https://image.tmdb.org/t/p/w500/1ckHDFgKXJ8pazmvLCW7DeOKqA0.jpg',1241982,NULL),(629,'니콜 셰르징거','https://image.tmdb.org/t/p/w500/pOu2al9UBvBYCHaMQFcmGbPNXeF.jpg',1241982,NULL),(630,'레이철 하우스','https://image.tmdb.org/t/p/w500/m8D9XlTGfI0ZmauMKtYp5tw8eNi.jpg',1241982,NULL),(631,'앤서니 매키','https://image.tmdb.org/t/p/w500/eZSIDrtTzhvabyjrmIITQLsjx8h.jpg',822119,NULL),(632,'해리슨 포드','https://image.tmdb.org/t/p/w500/zVnHagUvXkR2StdOtquEwsiwSVt.jpg',822119,NULL),(633,'대니 라미레즈','https://image.tmdb.org/t/p/w500/1CMMfxwMYOme8AOrl4kZS12nJpM.jpg',822119,NULL),(634,'שירה האס','https://image.tmdb.org/t/p/w500/5mfd9yKnbo2ZjU42vmqVMgvTJ8r.jpg',822119,NULL),(635,'팀 블레이크 넬슨','https://image.tmdb.org/t/p/w500/rWuTGiAMaaHIJ30eRkQS23LbRSW.jpg',822119,NULL),(636,'Carl Lumbly','https://image.tmdb.org/t/p/w500/ew1URcenWNl1Uclsz9ADiRb0uBD.jpg',822119,NULL),(637,'지안카를로 에스포지토','https://image.tmdb.org/t/p/w500/rcXnr82TwDzU4ZGdBeNXfG0ZQnZ.jpg',822119,NULL),(638,'리브 타일러','https://image.tmdb.org/t/p/w500/eQnuADVICaY40nl2ZseYvfkGQCc.jpg',822119,NULL),(639,'Xosha Roquemore','https://image.tmdb.org/t/p/w500/k596seeX26xKN8bZ3Uir9zFJ2gS.jpg',822119,NULL),(640,'Jóhannes Haukur Jóhannesson','https://image.tmdb.org/t/p/w500/oqZftP0WS1rD5NFpR7vLp6JU52I.jpg',822119,NULL),(641,'Sivakarthikeyan','https://image.tmdb.org/t/p/w500/9CWvjeawj9rYRFasyrNjVsqhR48.jpg',927342,NULL),(642,'Sai Pallavi','https://image.tmdb.org/t/p/w500/vn28J0CYDNrsXSiA7XiCTNTV1m.jpg',927342,NULL),(643,'Rahul Bose','https://image.tmdb.org/t/p/w500/6T0xhsganOB8SI48HCGd99XKj9l.jpg',927342,NULL),(644,'Bhuvan Arora','https://image.tmdb.org/t/p/w500/AtEfX9ta8LZTWh7yZ4dVc2wpIRO.jpg',927342,NULL),(645,'Lallu Prasath','https://image.tmdb.org/t/p/w500/f6TVtddrbG1Qk1brFASrpPehpQh.jpg',927342,NULL),(646,'Shyam Mohan','https://image.tmdb.org/t/p/w500/wqUndf8mfVUxKtus68hrh7dlBhX.jpg',927342,NULL),(647,'Mir Salman','https://image.tmdb.org/t/p/w500null',927342,NULL),(648,'Shyamaprasad','https://image.tmdb.org/t/p/w500/7XmS8tF5OGt7y9YdpyySIWBECkH.jpg',927342,NULL),(649,'Geetha Kailasam','https://image.tmdb.org/t/p/w500/8hOXtSmjgIVEq2LhSJAxNirTN95.jpg',927342,NULL),(650,'Gaurav Venkatesh','https://image.tmdb.org/t/p/w500null',927342,NULL),(651,'소피 대처','https://image.tmdb.org/t/p/w500/rUEPZaDxFdDGM76t4g6cYa8Ru7b.jpg',1084199,NULL),(652,'잭 퀘이드','https://image.tmdb.org/t/p/w500/320qW5yEbxpmyxQ3evmClJbtKag.jpg',1084199,NULL),(653,'루카스 게이지','https://image.tmdb.org/t/p/w500/sftjB0MjD92meZqnL9OLtcTI02d.jpg',1084199,NULL),(654,'Megan Suri','https://image.tmdb.org/t/p/w500/zUfiITKJh789PBSdF7B3HUBpJ8g.jpg',1084199,NULL),(655,'하비 길렌','https://image.tmdb.org/t/p/w500/yiNBonobPwqMVweB02JWufzp2l9.jpg',1084199,NULL),(656,'루퍼트 프렌드','https://image.tmdb.org/t/p/w500/mYgY8LrMkQ4OkGTIOf6MtkbMnnW.jpg',1084199,NULL),(657,'Jaboukie Young-White','https://image.tmdb.org/t/p/w500/8OYI8OqsMUpBZica4lM2odjgVH6.jpg',1084199,NULL),(658,'Matthew J. McCarthy','https://image.tmdb.org/t/p/w500/eHKjDZPdHTz5lV1UySfMdRqMrH6.jpg',1084199,NULL),(659,'마크 멘차카','https://image.tmdb.org/t/p/w500/fL0LmdBwau30M4AFPVJrpLRXXsU.jpg',1084199,NULL),(660,'Woody Fu','https://image.tmdb.org/t/p/w500/305m52CIr9Jtb1whdc5i1Lx2iEd.jpg',1084199,NULL),(661,'성룡','https://image.tmdb.org/t/p/w500/nraZoTzwJQPHspAVsKfgl3RXKKa.jpg',1160956,NULL),(662,'Shi Ce','https://image.tmdb.org/t/p/w500/yRBXOk6GMuzDCrIK85AjZn48o1y.jpg',1160956,NULL),(663,'魏翔','https://image.tmdb.org/t/p/w500/j1XqYkSGoRHfBOH59nTOnv7DcRn.jpg',1160956,NULL),(664,'Han Yanbo','https://image.tmdb.org/t/p/w500/anfEMOmBSFXuZJ5jPCdcPIrObSl.jpg',1160956,NULL),(665,'Danny Ray','https://image.tmdb.org/t/p/w500/ruWEqayx8GsA7AerHAG2wL05fUz.jpg',1160956,NULL),(666,'许君聪','https://image.tmdb.org/t/p/w500/5icza1XYiM1ozUTXE8xIhkpA3zm.jpg',1160956,NULL),(667,'Andy Friend','https://image.tmdb.org/t/p/w500/gvSXc5UDHc9JQwmHKG7Eh9V3AHX.jpg',1160956,NULL),(668,'黄允桐','https://image.tmdb.org/t/p/w500/jtWGjymL1Up2UKk3itlCZCUX4ur.jpg',1160956,NULL),(669,'贾冰','https://image.tmdb.org/t/p/w500/pum0e3d2ZVq9XZyNohZSXt46bkH.jpg',1160956,NULL),(670,'Temur Mamisashvili','https://image.tmdb.org/t/p/w500/9gBUlvH0q2IhW3zqkEk5Vbao4Qf.jpg',1160956,NULL),(671,'에런 테일러존슨','https://image.tmdb.org/t/p/w500/pFtHhih2XEaFaD3qOFyQW6q83br.jpg',539972,NULL),(672,'아리아나 드보즈','https://image.tmdb.org/t/p/w500/8HTSA2iVTsDN83OncAvFTcqxsAr.jpg',539972,NULL),(673,'프레드 헤킨저','https://image.tmdb.org/t/p/w500/99ctABEIEwNl4qjIZcLODgwnx0M.jpg',539972,NULL),(674,'알렉산드로 니볼라','https://image.tmdb.org/t/p/w500/53wfpjSwPTMwhfuOSdgGgojMI8m.jpg',539972,NULL),(675,'크리스토퍼 애벗','https://image.tmdb.org/t/p/w500/qWmlTycQb3yXaGhxPb6LCyaDjqh.jpg',539972,NULL),(676,'러셀 크로우','https://image.tmdb.org/t/p/w500/fbzD4utSGJlsV8XbYMLoMdEZ1Fc.jpg',539972,NULL),(677,'Юрий Колокольников','https://image.tmdb.org/t/p/w500/77g4exFoU4FvCWoWVgn6aXR01rA.jpg',539972,NULL),(678,'리바이 밀러','https://image.tmdb.org/t/p/w500/5ovVnN2ffAWzwhZQKZWZWUgf6tZ.jpg',539972,NULL),(679,'Tom Reed','https://image.tmdb.org/t/p/w500/gDvNQXHOQNBM5HyK9GfKu0tzPP1.jpg',539972,NULL),(680,'Billy Barratt','https://image.tmdb.org/t/p/w500/h8XlTs26su2Rg3oLtShERYEnVc6.jpg',539972,NULL),(681,'Peter Hastings','https://image.tmdb.org/t/p/w500/o5BXNCGeMiYS6AlRGigQCGVbr7K.jpg',774370,NULL),(682,'피트 데이비슨','https://image.tmdb.org/t/p/w500/f3kubnZu3KgMniExcq9nJy8RwjW.jpg',774370,NULL),(683,'릴 렐 하워리','https://image.tmdb.org/t/p/w500/v2dgq37Kn9a5TWpXevIsKSwscZv.jpg',774370,NULL),(684,'아일라 피셔','https://image.tmdb.org/t/p/w500/zNKTzzuyMYaCGEZKhwhqV1K8ffo.jpg',774370,NULL),(685,'Lucas Hopkins Calderon','https://image.tmdb.org/t/p/w500null',774370,NULL),(686,'리키 저베이스','https://image.tmdb.org/t/p/w500/2mAjcq9AQA9peQxNoeEW76DPIju.jpg',774370,NULL),(687,'Poppy Liu','https://image.tmdb.org/t/p/w500/i36QkUChZN7K8BQa1ReaZHes6L4.jpg',774370,NULL),(688,'스티븐 루트','https://image.tmdb.org/t/p/w500/2Zwi6AydqQQ9InVdhjYcfJXNzkp.jpg',774370,NULL),(689,'빌리 보이드','https://image.tmdb.org/t/p/w500/uiWlsIOakNnUgda21PJF9wswzEJ.jpg',774370,NULL),(690,'Luenell','https://image.tmdb.org/t/p/w500/5Mz0UEpcu1PHftgmKgoEhSSaiiA.jpg',774370,NULL),(691,'톰 하디','https://image.tmdb.org/t/p/w500/d81K0RH8UX7tZj49tZaQhZ9ewH.jpg',912649,NULL),(692,'추이텔 에지오포','https://image.tmdb.org/t/p/w500/kq5DDnqqofoRI0t6ddtRlsJnNPT.jpg',912649,NULL),(693,'주노 템플','https://image.tmdb.org/t/p/w500/ntBw3aUZmIw9ObmsmvPgk1UKMd8.jpg',912649,NULL),(694,'리스 에반스','https://image.tmdb.org/t/p/w500/1D670EEsbky3EtO7XLG32A09p92.jpg',912649,NULL),(695,'스티븐 그레이엄','https://image.tmdb.org/t/p/w500/1m9RWRRkQzJEAphJm9kQhMk1r1Q.jpg',912649,NULL),(696,'Peggy Lu','https://image.tmdb.org/t/p/w500/ng5eaDcOf9kSwIYGNmwF9wEfIHp.jpg',912649,NULL),(697,'클라크 바코','https://image.tmdb.org/t/p/w500/d24KKFxfoql6PBsBPsejFgzhSlH.jpg',912649,NULL),(698,'Alanna Ubach','https://image.tmdb.org/t/p/w500/ffyBAEoW3bDgVJQV3GaHsZ9x29W.jpg',912649,NULL),(699,'크리스토 페르난데스','https://image.tmdb.org/t/p/w500/irx5BVVLSQWY9m5NrhqyxPekwIY.jpg',912649,NULL),(700,'Jared Abrahamson','https://image.tmdb.org/t/p/w500/3hShByAdCj1Qom9mXeeqJL9zu8d.jpg',912649,NULL),(701,'폴 메스칼','https://image.tmdb.org/t/p/w500/vrzZ41TGNAFgfmZjC2sOJySzBLd.jpg',558449,NULL),(702,'덴젤 워싱턴','https://image.tmdb.org/t/p/w500/9Iyt3wbsla5bM6IzbICDVnBhkER.jpg',558449,NULL),(703,'페드로 파스칼','https://image.tmdb.org/t/p/w500/9VYK7oxcqhjd5LAH6ZFJ3XzOlID.jpg',558449,NULL),(704,'코니 닐센','https://image.tmdb.org/t/p/w500/lvQypTfeH2Gn2PTbzq6XkT2PLmn.jpg',558449,NULL),(705,'조셉 퀸','https://image.tmdb.org/t/p/w500/zshhuioZaH8S5ZKdMcojzWi1ntl.jpg',558449,NULL),(706,'프레드 헤킨저','https://image.tmdb.org/t/p/w500/99ctABEIEwNl4qjIZcLODgwnx0M.jpg',558449,NULL),(707,'Lior Raz','https://image.tmdb.org/t/p/w500/bl3KLFUQ4Q0zC9lCU4qP1Jf4qHS.jpg',558449,NULL),(708,'데릭 재커비','https://image.tmdb.org/t/p/w500/htc4eCYmNlVotcu8AFTbDiLBzsJ.jpg',558449,NULL),(709,'Peter Mensah','https://image.tmdb.org/t/p/w500/t94TFc6f71AUmZFqdaQfjr7LTRp.jpg',558449,NULL),(710,'Matt Lucas','https://image.tmdb.org/t/p/w500/2OhGLJqiknaWlbTkG2KDwT935km.jpg',558449,NULL),(711,'에이드리언 브로디','https://image.tmdb.org/t/p/w500/qBc7ahQrpVpcllaZ5hkivsOEb3C.jpg',549509,NULL),(712,'펠리시티 존스','https://image.tmdb.org/t/p/w500/gsrb1CuyAQtTVZILtNA5tRnhHbs.jpg',549509,NULL),(713,'가이 피어스','https://image.tmdb.org/t/p/w500/wIUR413lEyzEzitCLgToItwVZBr.jpg',549509,NULL),(714,'조 앨윈','https://image.tmdb.org/t/p/w500/qtpsreyKKo2hRco5FAXWoXa4tLt.jpg',549509,NULL),(715,'래피 캐시디','https://image.tmdb.org/t/p/w500/5BJCaQHaNDWL9y6Mfa3NHQf3lno.jpg',549509,NULL),(716,'스테이시 마르탱','https://image.tmdb.org/t/p/w500/2eRIvurxaDFKqC9BzAAiYhJp90Z.jpg',549509,NULL),(717,'이자크 드 방콜레','https://image.tmdb.org/t/p/w500/aGjABQBgTA3tduuh54hzWx0aQ44.jpg',549509,NULL),(718,'알렉산드로 니볼라','https://image.tmdb.org/t/p/w500/53wfpjSwPTMwhfuOSdgGgojMI8m.jpg',549509,NULL),(719,'아리안 라베드','https://image.tmdb.org/t/p/w500/78QyAml6N1HMuHudmrVlKnJfSQY.jpg',549509,NULL),(720,'Michael Epp','https://image.tmdb.org/t/p/w500/3Nz3sX7QISm5e6mWNvJDKUD2Qyd.jpg',549509,NULL),(721,'데미 무어','https://image.tmdb.org/t/p/w500/gPgZSodybMFBodw7nKRTALONIr2.jpg',933260,NULL),(722,'마가렛 퀄리','https://image.tmdb.org/t/p/w500/jStNyMj3acpLuH48awLVLqqlyaV.jpg',933260,NULL),(723,'데니스 퀘이드','https://image.tmdb.org/t/p/w500/lMaDAJHzsKH7U3dln2B3kY3rOhE.jpg',933260,NULL),(724,'Edward Hamilton-Clark','https://image.tmdb.org/t/p/w500/q1EWL2z2xMcbf84TpOTqGs6Csxs.jpg',933260,NULL),(725,'Gore Abrams','https://image.tmdb.org/t/p/w500/bKMTqbl0FYlzIC6aTMKQZNAhhXK.jpg',933260,NULL),(726,'Oscar Lesage','https://image.tmdb.org/t/p/w500/8N31SCzlmRBEHRXD7AIE50Wh7Fs.jpg',933260,NULL),(727,'Christian Erickson','https://image.tmdb.org/t/p/w500/cpEzQNW1EsRmK8SMj4y5xwevXwM.jpg',933260,NULL),(728,'Robin Greer','https://image.tmdb.org/t/p/w500/ndu0tbz16mtOchMROcnJf2pPchg.jpg',933260,NULL),(729,'Tom Morton','https://image.tmdb.org/t/p/w500/aOdP4niQX4ckaFwPQmbf0mlYTC5.jpg',933260,NULL),(730,'Hugo Diego Garcia','https://image.tmdb.org/t/p/w500/mC0Aly8hHgNIYvZSa1SZmYU47pn.jpg',933260,NULL),(731,'스콧 이스트우드','https://image.tmdb.org/t/p/w500/hBqXeKe2Z7VnAYe7tLTzIvr8po4.jpg',1249289,NULL),(732,'실베스터 스탤론','https://image.tmdb.org/t/p/w500/gn3pDWthJqR0VDYGViGD3048og7.jpg',1249289,NULL),(733,'윌라 피츠제럴드','https://image.tmdb.org/t/p/w500/l2xGZi2091DxdCSNEu9xbJ0XRYK.jpg',1249289,NULL),(734,'마이크 콜터','https://image.tmdb.org/t/p/w500/hy6gReVCDUtkP9r01OArQXSYnKd.jpg',1249289,NULL),(735,'D.W. Moffett','https://image.tmdb.org/t/p/w500/7lcIxTqarAgkdLiNlc7Ad57vcP1.jpg',1249289,NULL),(736,'Isis Valverde','https://image.tmdb.org/t/p/w500/3QYulTU0dLFvp0zetmaBcXS4RK7.jpg',1249289,NULL),(737,'노엘 구글리에미','https://image.tmdb.org/t/p/w500/26khzGvkwfTdR3f6rNAtQ39Z8OF.jpg',1249289,NULL),(738,'Mark Polish','https://image.tmdb.org/t/p/w500/5HmEhRjyZa1xIiXQeZALsOmm01E.jpg',1249289,NULL),(739,'Anton Narinskiy','https://image.tmdb.org/t/p/w500/5j5XRHn0IFhwyCxX6GIfQPFkks8.jpg',1249289,NULL),(740,'Patrick Millin','https://image.tmdb.org/t/p/w500/n45TsVKdqrVZt9hxaCluh8s2nyh.jpg',1249289,NULL),(741,'마이키 매디슨','https://image.tmdb.org/t/p/w500/b0HZr4Xa4pIR7MzTPXfIWvUZELx.jpg',1064213,NULL),(742,'마르크 에이델스테인','https://image.tmdb.org/t/p/w500/vlQh0PedEBjpNUIa0vdbWEQPV48.jpg',1064213,NULL),(743,'유리 보리소프','https://image.tmdb.org/t/p/w500/zLcD2UmXJG6m3qOQhNZs13SQRIp.jpg',1064213,NULL),(744,'Karren Karagulian','https://image.tmdb.org/t/p/w500/rxyx8OFgShe0Kolptm5LpbsOUJj.jpg',1064213,NULL),(745,'Vache Tovmasyan','https://image.tmdb.org/t/p/w500/cKHEEer9V0zK96f1gE0gvQ5IvZq.jpg',1064213,NULL),(746,'Luna Sofía Miranda','https://image.tmdb.org/t/p/w500/eSEfNzd7f3Eg6LxWkiA1hjN51YN.jpg',1064213,NULL),(747,'Lindsey Normington','https://image.tmdb.org/t/p/w500/hgPwq6MBIlSMO4zmx9cLMndSITc.jpg',1064213,NULL),(748,'Дарья Екамасова','https://image.tmdb.org/t/p/w500/dfZXPxLvWy8OSi3FyQPhc3VWvFX.jpg',1064213,NULL),(749,'Алексей Серебряков','https://image.tmdb.org/t/p/w500/AaxxJEBqhajmyCPalnrFgsPJ3cM.jpg',1064213,NULL),(750,'Anton Bitter','https://image.tmdb.org/t/p/w500/iWmPlBzc0RQ2XnHQc2tgLJbELlQ.jpg',1064213,NULL),(751,'사라 스누크','https://image.tmdb.org/t/p/w500/tklkrYSxifGOOZBmsxSv2D1XvIR.jpg',1064486,NULL),(752,'코디 스밋맥피','https://image.tmdb.org/t/p/w500/sesCWba9NwPDYDZzbVLs7OgLOti.jpg',1064486,NULL),(753,'재키 위버','https://image.tmdb.org/t/p/w500/Apt5KSRAJENVw3IrTidzyrGv9PE.jpg',1064486,NULL),(754,'Magda Szubanski','https://image.tmdb.org/t/p/w500/fNb650TNqOBG6dSP9bLhoxxI9wA.jpg',1064486,NULL),(755,'Dominique Pinon','https://image.tmdb.org/t/p/w500/rIPUhNwGSglgKLgMQWz0JNCqIzf.jpg',1064486,NULL),(756,'Tony Armstrong','https://image.tmdb.org/t/p/w500/2uEEg0q9RsbgQucvEqwIhH9Aw2v.jpg',1064486,NULL),(757,'Paul Capsis','https://image.tmdb.org/t/p/w500/xZUhRF6oS5n2BQBTHPrz98IYvW4.jpg',1064486,NULL),(758,'에릭 배너','https://image.tmdb.org/t/p/w500/xIjQVywxkymHbbSO7lD2F9f377W.jpg',1064486,NULL),(759,'Bernie Clifford','https://image.tmdb.org/t/p/w500null',1064486,NULL),(760,'Davey Thompson','https://image.tmdb.org/t/p/w500/npZhnmIcnkx7MXNyOrmOWGX8ZW8.jpg',1064486,NULL),(761,'Yami Gautam','https://image.tmdb.org/t/p/w500/qcbOTAdGGwmodTSIh8HTtq4QWDv.jpg',1201012,NULL),(762,'Pratik Gandhi','https://image.tmdb.org/t/p/w500/2sTvUaMSyfJbfexFZtZvac7BK7w.jpg',1201012,NULL),(763,'Eijaz Khan','https://image.tmdb.org/t/p/w500/qCcZ1X4TnOSugw5vcJ4lnbHgAmX.jpg',1201012,NULL),(764,'Mukul Chadda','https://image.tmdb.org/t/p/w500/veGkWux7P6xfXbn5vVmemqDNM9E.jpg',1201012,NULL),(765,'Pavitra Sarkar','https://image.tmdb.org/t/p/w500null',1201012,NULL),(766,'Anand Vikas Potdukhe','https://image.tmdb.org/t/p/w500null',1201012,NULL),(767,'Sahil Gangurde','https://image.tmdb.org/t/p/w500null',1201012,NULL),(768,'Kavin Dave','https://image.tmdb.org/t/p/w500/ktPIGYlclbFUuwLDmtQqXLd0UD.jpg',1201012,NULL),(769,'Prateik Babbar','https://image.tmdb.org/t/p/w500/yDUhU9C4C7fBAse1KmzQxVkSwjn.jpg',1201012,NULL),(770,'Garima Yajnik','https://image.tmdb.org/t/p/w500null',1201012,NULL);
/*!40000 ALTER TABLE `movie_actors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_directors`
--

DROP TABLE IF EXISTS `movie_directors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie_directors` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_directors`
--

LOCK TABLES `movie_directors` WRITE;
/*!40000 ALTER TABLE `movie_directors` DISABLE KEYS */;
INSERT INTO `movie_directors` VALUES (1,'프랭크 다라본트'),(2,'프랜시스 포드 코폴라'),(3,'스티븐 스필버그'),(4,'시드니 루멧'),(5,'미야자키 하야오'),(6,'Aditya Chopra'),(7,'크리스토퍼 놀란'),(8,'봉준호'),(9,'쿠엔틴 타란티노'),(10,'신카이 마코토'),(11,'피터 잭슨'),(12,'로버트 저메키스'),(13,'세르조 레오네'),(14,'구로사와 아키라'),(15,'마틴 스콜세지'),(16,'다카하타 이사오'),(17,'로베르토 베니니'),(18,'스콧 데릭슨'),(19,'멜 깁슨'),(20,'Jeff Fowler'),(21,'줄리어스 오나'),(22,'Drew Hancock'),(23,'張欒'),(24,'Peter Hastings'),(25,'브래디 코베'),(26,'코랄리 파르자'),(27,'Michael Polish'),(28,'션 베이커'),(29,'Adam Elliot'),(30,'Rishab Seth'),(31,'Dani Girdwood'),(32,'Taweewat Wantha'),(33,'Gints Zilbalodis'),(34,'Dougal Wilson'),(35,'크리스 샌더스'),(36,'Andrea M. Catinella'),(37,'에드워드 버거'),(38,'존 M. 추'),(39,'Leigh Whannell'),(40,'마틴 캠벨'),(41,'Scott Beck'),(42,'월터 살레스'),(43,'오즈 퍼킨스'),(44,'자크 오디아르'),(45,'마이클 그레이시'),(46,'饺子'),(47,'Christian Gudegast'),(48,'Justin Routt'),(49,'Colm McCarthy'),(50,'배리 젠킨스'),(51,'David G. Derrick Jr.'),(52,'Rajkumar Periasamy'),(53,'J.C. Chandor'),(54,'Kelly Marcel'),(55,'리들리 스콧');
/*!40000 ALTER TABLE `movie_directors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_genre_ids`
--

DROP TABLE IF EXISTS `movie_genre_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie_genre_ids` (
  `movie_id` bigint(20) NOT NULL,
  `genre_ids` int(11) DEFAULT NULL,
  KEY `FKjbchwbksv5wcb808ly5slgeos` (`movie_id`),
  CONSTRAINT `FKjbchwbksv5wcb808ly5slgeos` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_genre_ids`
--

LOCK TABLES `movie_genre_ids` WRITE;
/*!40000 ALTER TABLE `movie_genre_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `movie_genre_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS `movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie_genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `movie_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKs2xl3sirbon75mjcongwhrbi3` (`movie_id`),
  CONSTRAINT `FKs2xl3sirbon75mjcongwhrbi3` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_genres`
--

LOCK TABLES `movie_genres` WRITE;
/*!40000 ALTER TABLE `movie_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_videos`
--

DROP TABLE IF EXISTS `movie_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie_videos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `video_key` varchar(255) DEFAULT NULL,
  `movie_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKadrow8k20kh0lhol7r27r7e4j` (`movie_id`),
  CONSTRAINT `FKadrow8k20kh0lhol7r27r7e4j` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_videos`
--

LOCK TABLES `movie_videos` WRITE;
/*!40000 ALTER TABLE `movie_videos` DISABLE KEYS */;
INSERT INTO `movie_videos` VALUES (1,'Brooks Was Here','BD0bC2inuAc',278),(2,'Robert De Niro Auditioning for Sonny Corleone in The Godfather','tlFyyzXVEMk',238),(3,'\"I Know It Was You, Fredo\" - Full Scene','qEtuz1ktxeA',240),(4,'Rabbi Levartow Life Is Spared When Two Guns Don’t Work','lx9Ahsr4544',424),(5,'Knife Scene','4_q_IA6LeUw',389),(6,'Official Trailer [Subtitled]','GAp2_0JJskk',129),(7,'Dilwale Dulhania Le Jayenge | 25 Years Weeks Trailer | Shah Rukh Khan, Kajol | Aditya Chopra | DDLJ','oIZ4U21DRlM',19404),(8,'DC Super Scenes: The Hero Gotham Deserves','7pVaGNOp5Vc',155),(9,'10 Minute Preview','YVUz6xZXSzI',497),(10,'Best of Ki-jung | Parasite | #StreamingOnlyOnHulu | Hulu','iYWBGJzXvs0',496243),(11,'Uma Thurman \'Wants To Dance\' in Pulp Fiction w/ John Travolta','r1bm09Xxr0Q',680),(12,'How to be an anime voice actor, with Your Name stars Stephanie Sheh and Michael Sinterniklaas | BFI','SlNVu5pnZuc',372058),(13,'Siege of Gondor Begins','UCyqwsoISMs',122),(14,'\"Life is Like A Box of Chocolates\" Full Scene','vdtqSaJO-iM',13),(15,'THE GOOD, THE BAD AND THE UGLY (1966) | Tuco\'s Ambush | MGM','pyTW_E1st-w',429),(16,'Jim Cummings on SEVEN SAMURAI','faajRQrPPs8',346),(17,'Jimmy Conway Tells His Crew to Lay Low','tRiXxX5Lets',769),(18,'Entering the Wormhole in 4K Ultra HD','u-ElPzExvPA',157336),(19,'Official Netflix Trailer','lhlh7JVcTt8',12477),(20,'Life is Beautiful (1998) Official Trailer - Robert Benigni Movie HD','pAYEQP8gx3w',637),(21,'Levi and Drasa Enter the Gorge Scene','dpw1LDw9ABU',NULL),(22,'Mel Gibson’s ‘Hit Your Mark’','XIHXt9Dms5U',NULL),(23,'Now Streaming','7kz26vJu4Wk',NULL),(24,'Official Clip \'Cap VS Hulk\'','sVIUkLhSDuM',NULL),(25,'Behind the Scenes: I Feel Therefore I Am','aORRYJR-wZk',NULL),(26,'UK Audience Honest Opinion - The Panda','V8vbmeWjK7M',NULL),(27,'An Evil Plan To Take Over The World?! - Extended Preview','rWkr_AwAAms',NULL),(28,'Adrien Brody Best Actor Press Room Speech | 97th Oscars (2025)','dqgi2dTlLts',NULL),(29,'\'The Substance\' Best Makeup and Hairstyling Press Room Speech | 97th Oscars (2025)','W61vdAMBJIg',NULL),(30,'Official International Trailer','Kp6WlyxBHBM',NULL),(31,'\'Anora\' Best Actress Press Room Speech | 97th Oscars (2025)[Mikey Madison]','RjickaRRLtQ',NULL),(32,'Memoir of a Snail writer-director Adam Elliot | BFI Q&A','YUNNA5G2ruM',NULL),(33,'Noah Asks Nick For a Favor','gGEe1LaIBrI',1294203),(34,'[ IMAX Trailer ] ตัวอย่างสุดท้าย ธี่หยด 2','ZCEuUcE9oZw',1247019),(35,'FLOW wins BEST INTERNATIONAL FILM at the 2025 Film Independent Spirit Awards','fRNXjXTMV6E',NULL),(36,'Marmalade Taste Test','VpBE30m0obY',NULL),(37,'The Robots Attack!! Brightbill\'s Wild Goose Chase','fI6IK6ELaf0',1184918),(38,'Piglet - Trailer 2024','r91fRM-_pzg',1352774),(39,'Writer Peter Straughan Dives Deep with Sean Evans on Stanley Kubrick & More','piqHYodsjFk',NULL),(40,'Mel Gibson’s ‘Hit Your Mark’','XIHXt9Dms5U',NULL),(41,'Behind the Scenes: I Feel Therefore I Am','aORRYJR-wZk',NULL),(42,'An Evil Plan To Take Over The World?! - Extended Preview','rWkr_AwAAms',NULL),(43,'Adrien Brody Best Actor Press Room Speech | 97th Oscars (2025)','dqgi2dTlLts',NULL),(44,'FLOW wins BEST INTERNATIONAL FILM at the 2025 Film Independent Spirit Awards','fRNXjXTMV6E',NULL),(45,'A Look Into The Magic','ITvt8Dyh-Q0',402431),(46,'Marmalade Taste Test','VpBE30m0obY',516729),(47,'Writer Peter Straughan Dives Deep with Sean Evans on Stanley Kubrick & More','piqHYodsjFk',974576),(48,'Watch At Home Now','-tWdzz04C3Y',710295),(49,'Official Clip - \'Calling That Number\'','qaiJIfoh8ko',1043905),(50,'Watch At Home Now','Swm7m1xGNwg',1138194),(51,'He\'s Gone [Subtitled]','FauPviSxGRw',1000837),(52,'Bong Joon Ho on Mickey 17','h8t6GVAXY3M',696506),(53,'The Monkey Takes a Drive Around Hollywood','8SezSdZuqJ4',1124620),(54,'\'Emilia Pérez\' Best Supporting Actress Press Room Speech | 97th Oscars (2025)[Zoe Saldaña]','GzDITJvJnjo',974950),(55,'Why is Robbie Williams a Monkey in Better Man? - Behind the Scenes Exclusive','yqr7Aft4kro',799766),(56,'International Trailer [ENG SUB]','nsXQijb0F4I',980477),(57,'Porsche Chase','iPIHckDjN7A',604685),(58,'Official International Trailer','tzQsSmDc8gw',1182387),(59,'Official Trailer','slrzCgYIUPM',978796),(60,'Levi and Drasa Enter the Gorge Scene','dpw1LDw9ABU',950396),(61,'Mel Gibson’s ‘Hit Your Mark’','XIHXt9Dms5U',1126166),(62,'Be the First to Watch at Home Today. Buy It Now Only On Digital','0C-pqKsvp6Y',762509),(63,'Now Streaming','7kz26vJu4Wk',939243),(64,'We\'re Back','Jr4RL-fpC7k',1241982),(65,'Official Clip \'Cap VS Hulk\'','sVIUkLhSDuM',822119),(66,'Amaran - Trailer | Sivakarthikeyan, Sai Pallavi | Rajkumar | GV Prakash | Kamal Haasan | Mahendran','9SSd9L0SxN0',927342),(67,'Behind the Scenes: I Feel Therefore I Am','aORRYJR-wZk',1084199),(68,'UK Audience Honest Opinion - The Panda','V8vbmeWjK7M',1160956),(69,'5 Minute Extended Preview','hDg7Zl_zMB4',539972),(70,'An Evil Plan To Take Over The World?! - Extended Preview','rWkr_AwAAms',774370),(71,'Special Features Preview','tVqo-hIE4qA',912649),(72,'FLOW wins BEST INTERNATIONAL FILM at the 2025 Film Independent Spirit Awards','fRNXjXTMV6E',823219),(73,'20 Years of Making a Sequel - Exclusive Behind the Scenes','_ZBYN01c7OM',558449),(74,'Adrien Brody Best Actor Press Room Speech | 97th Oscars (2025)','dqgi2dTlLts',549509),(75,'\'The Substance\' Best Makeup and Hairstyling Press Room Speech | 97th Oscars (2025)','W61vdAMBJIg',933260),(76,'Official International Trailer','Kp6WlyxBHBM',1249289),(77,'\'Anora\' Best Actress Press Room Speech | 97th Oscars (2025)[Mikey Madison]','RjickaRRLtQ',1064213),(78,'Memoir of a Snail writer-director Adam Elliot | BFI Q&A','YUNNA5G2ruM',1064486);
/*!40000 ALTER TABLE `movie_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `naver_user_genres`
--

DROP TABLE IF EXISTS `naver_user_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `naver_user_genres` (
  `naver_user_id` bigint(20) NOT NULL,
  `genre` varchar(255) DEFAULT NULL,
  KEY `FKfpprbuns0ty44dpnk2xwtbdw6` (`naver_user_id`),
  CONSTRAINT `FKfpprbuns0ty44dpnk2xwtbdw6` FOREIGN KEY (`naver_user_id`) REFERENCES `naver_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `naver_user_genres`
--

LOCK TABLES `naver_user_genres` WRITE;
/*!40000 ALTER TABLE `naver_user_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `naver_user_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `naver_users`
--

DROP TABLE IF EXISTS `naver_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `naver_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mem_email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2eh1q3n484le05jt0aay3xhxw` (`user_id`),
  CONSTRAINT `FK2eh1q3n484le05jt0aay3xhxw` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `naver_users`
--

LOCK TABLES `naver_users` WRITE;
/*!40000 ALTER TABLE `naver_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `naver_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nowplaying_movie`
--

DROP TABLE IF EXISTS `nowplaying_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nowplaying_movie` (
  `id` bigint(20) NOT NULL,
  `back_drop_path` varchar(255) DEFAULT NULL,
  `overview` longtext DEFAULT NULL,
  `popularity` double NOT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `runtime` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `vote_average` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nowplaying_movie`
--

LOCK TABLES `nowplaying_movie` WRITE;
/*!40000 ALTER TABLE `nowplaying_movie` DISABLE KEYS */;
INSERT INTO `nowplaying_movie` VALUES (516729,'/hfTyu2VPBqLRPo2DauW8q7bh9bm.jpg','영국 국민으로 거듭난 ‘패딩턴’에게 어느 날 고향인 페루에서 날아온 의문의 편지 한 통. “루시 숙모님이 사라졌어요!” 지도 한 장만 남긴 채 감쪽같이 사라져 버린 ‘루시’ 숙모를 찾아 떠난 ‘패딩턴’과 브라운 가족은 페루의 정글을 둘러싼 비밀을 찾아 모험을 떠나게 되는데… https://justwatch.pro/movie/516729/paddington-in-peru',425.621,'/1rfxGlRaFe8bqKOtebXl2CFel8F.jpg','2024-11-08',106,'패딩턴: 페루에 가다!',6.8),(549509,'/iKXXPYBWQ0B6BMRHAFbg3wKafWb.jpg','전쟁의 상흔을 뒤로하고 미국에 정착한 건축가 라즐로 토스. 미국 이민자의 냉혹한 현실 속에 전쟁의 트라우마를 견뎌내던 어느 날. 라즐로의 천재성을 알아본 부유한 사업가 해리슨이 기념비적인 건축물 설계를 제안한다. 하지만, 시대와 공간, 빛의 경계를 넘어 대담하고 혁신적인 그의 건축 설계는 사람들의 공감을 얻지 못하고 반대에 부딪히게 된다. 후원자 해리슨의 감시와 압박, 주변의 비난이 거세질수록 오히려 더 자신의 설계에 집착하던 라즐로. 혁신적인 브루탈리즘 건축에 자신을 투영하던 라즐로는 결국 공사가 중단될 위기에 처하는데...',1065.25,'/dKFjxIZ6tPAUQInMKZCE3BfcrO2.jpg','2024-12-20',215,'브루탈리스트',7.1),(774370,'/iXU87IdtNsYt7n6OigPJBDdbFf1.jpg','\"반쪽은 개, 반쪽은 인간, 그야말로 영웅의 탄생!\"\r 한 경찰견과 그의 파트너인 경찰관이 함께 부상당한 후, 기적 같은 수술로 하나가 되어 \'도그맨\'이 탄생한다. 이제 도그맨은 그의 새로운 정체성을 받아들이며, 도시를 지키기 위해 애쓴다. 하지만 도시를 위협하는 악당, 페티 더 캣과의 싸움에서 도그맨의 진정한 힘이 시험받게 되는데...',722.633,'/89wNiexZdvLQ41OQWIsQy4O6jAQ.jpg','2025-01-24',89,'도그맨',7.7),(822119,'/qfAfE5auxsuxhxPpnETRAyTP5ff.jpg','대통령이 된 새디우스 로스와 재회 후, 국제적인 사건의 중심에 서게 된 샘이 전 세계를 붉게 장악하려는 사악한 음모 뒤에 숨겨진 존재와 이유를 파헤쳐 나가는 액션 블록버스터',1295.113,'/2MQdtfioyYSqgwkK07PSrBidOBC.jpg','2025-02-12',119,'캡틴 아메리카: 브레이브 뉴 월드',6.2),(823219,'/b3mdmjYTEL70j7nuXATUAD9qgu4.jpg','인간이 살았던 흔적만이 남아있는 세상, 홀로 집을 지키던 \'고양이\'는 갑작스러운 대홍수로 평화롭던 일상과 아늑했던 터전을 잃고 만다. 때마침 다가온 낡은 배에 올라탄 \'고양이\'는 그 안에서 \'골든 리트리버\', \'카피바라\', \'여우원숭이\', \'뱀잡이수리\'를 만나고 서로의 차이점을 극복하고 팀을 이뤄 험난한 파도를 헤쳐나간다.',885.787,'/8ntMUYy0b0NIGWSWvMr07ui7CCJ.jpg','2024-08-29',85,'플로우',8.3),(933260,'/bVSOgrxasVJF6V71T7v2KfBRSzu.jpg','한때 아카데미상을 수상하고 명예의 거리까지 입성한 대스타였지만 지금은 TV 에어로빅 쇼 진행자로 전락한 엘리자베스. 50살이 되던 날, 프로듀서에게서 어리고 섹시하지 않다는 이유로 해고를 당한다. 돌아가던 길에 차 사고로 병원에 실려간 엘리자베스는 매력적인 남성 간호사로부터 서브스턴스라는 약물을 권유받는다. 한 번의 주사로 젊고 아름답고 완벽한 수가 탄생하는데...',970.749,'/5TPPefBI1OzWnSQfBkOrv1OFGq5.jpg','2024-09-07',140,'서브스턴스',7.127),(939243,'/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg','너클즈, 테일즈와 함께 평화로운 일상을 보내던 초특급 히어로 소닉. 연구 시설에 50년간 잠들어 있던 사상 최강의 비밀 병기 \"섀도우\"가 탈주하자, 세계 수호 통합 부대(약칭 세.수.통)에 의해 극비 소집된다. 소중한 것을 잃은 분노와 복수심에 불타는 섀도우는 소닉의 초고속 스피드와 너클즈의 최강 펀치를 단 단숨에 제압해버린다. 세상을 지배하려는 닥터 로보트닉과 그의 할아버지 제럴드 박사는 섀도우의 엄청난 힘 카오스 에너지를 이용해 인류를 정복하려고 하는데…',1976.892,'/5ZoI48Puf5i5FwI6HOpunDuJOw0.jpg','2024-12-19',110,'수퍼 소닉 3',7.7),(950396,'/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg','고도의 훈련을 받은 두 요원는 비밀스러운 협곡의 양쪽을 지키는 임무를 받은 후 멀리서 서로와 서서히 친해진다. 도사리고 있던 악이 드러나자, 둘은 협곡 안의 위험으로부터 살아남기 위해 협력해야만 한다.',3135.209,'/fhPj5pWbCoVoz8sehfaCeIWWFxc.jpg','2025-02-13',127,'\'더 캐니언\' - The Gorge',7.787),(974576,'/tkRDTu9hyWgaBSSzfkYDCZYd1kV.jpg','교황의 예기치 못한 죽음 이후 새로운 교황을 선출하는 콘클라베가 시작되고, 로렌스는 단장으로서 선거를 총괄하게 된다. 한편 당선에 유력했던 후보들이 스캔들에 휘말리면서 교활한 음모와 탐욕이 수면 위로 드러나는데…',705.54,'/aPPUy4JBYrJeRlQwMxdKwa3Ozkd.jpg','2024-10-25',120,'콘클라베',7.1),(1064213,'/kEYWal656zP5Q2Tohm91aw6orlT.jpg','뉴욕의 스트리퍼 아노라는 자신의 바를 찾은 철부지 러시아 재벌2세 이반을 만나게 되고 충동적인 사랑을 믿고 허황된 신분 상승을 꿈꾸며 결혼식을 올리게 된다. 그러나 신데렐라 스토리를 꿈꿨던 것도 잠시, 한 번도 본 적 없는 이반의 부모님이 아들의 결혼 사실을 알게 되자 길길이 날뛰며 미국에 있는 하수인 3인방에게 둘을 잡아 혼인무효소송을 진행할 것을 지시한다. 하수인 3인이 들이닥치자 부모님이 무서워 겁에 질린 남편 이반은 아노라를 버린채 홀로 도망친다. 이반을 찾아 결혼 생활을 유지하고 싶은 아노라와 어떻게든 이반을 찾아 혼인무효소송을 시켜야만 하는 하수인 3인방의 대환장 발악이 시작된다.',1016.68,'/mwguqSMRCA3NgpPoRsXdFhid25m.jpg','2024-10-14',140,'아노라',7.1),(1064486,'/jl2YIADk391yc6Qjy9JhgCRkHJk.jpg','쌍둥이 동생 길버트와 함께 태어나 입양된 그레이스는 옷장 속 달팽이로 위로를 삼는다.',664.263,'/lWh5OlerPR1c1cfn1ZLq0lpqFds.jpg','2024-10-17',94,'달팽이의 회고록',7.8),(1084199,'/sc1abgWNXc29wSBaerrjGBih06l.jpg','서로에게 딱 맞는 커플 ‘아이리스’와 ‘조시’는 친구들과 함께 호숫가의 별장으로 호화로운 휴가를 떠난다. 하지만 그곳에는 충격적인 사건이 기다리고 있는데…',1222.243,'/dq7CEYFCvQPfYIpAXOvJr3w6VLY.jpg','2025-01-22',97,'컴패니언',7.069),(1126166,'/gFFqWsjLjRfipKzlzaYPD097FNC.jpg','미셸 도커리가 연기하는 부지런한 미국 연방보호관 매들린 해리스는 마피아 조직의 회계사였던 윈스턴(토퍼 그레이스)을 증인 보호 프로그램으로 이송하는 임무를 맡게 된다. 그들은 알래스카의 황량한 설원을 가로지르는 작은 비행기에 탑승하며, 이 비행기의 조종사는 다릴 부스(마크 월버그)다. 그러나 비행 도중, 이들이 탑승한 비행기는 예상치 못한 위험에 직면하게 되고, 매들린은 조종사와 승객들의 숨겨진 의도를 의심하게 된다. 한정된 공간에서 긴장감이 고조되는 가운데, 매들린은 비행기의 조종을 직접 맡아야 하는 상황에 이르게 되는데...',2568.332,'/zstC9sgsPaV98TaZtHL6aTtBUtB.jpg','2025-01-22',91,'플라이트 리스크',6.1),(1160956,'/u7AZ5CdT2af8buRjmYCPXNyJssd.jpg','액션 스타 재키가 우연히 전 세계적인 인기를 한 몸에 받고 있는 ‘후후’라는 아기 판다 구출 작전에 합류하게 되면서 벌어지는 이야기',1005.555,'/zNU7A18Py3jHArZFLH2d4WUTbMS.jpg','2024-10-01',99,'판다 플랜',7.1),(1184918,'/mQZJoIhTEkNhCYAqcHrQqhENLdu.jpg','우연한 사고로 거대한 야생에 불시착한 로봇 로즈는 주변 동물들의 행동을 배우며 낯선 환경 속에 적응해 가던 중, 사고로 세상에 홀로 남겨진 아기 기러기 브라이트빌의 보호자가 된다. 로즈는 입력되어 있지 않은 새로운 역할과 관계에 낯선 감정을 마주하고 겨울이 오기 전에 남쪽으로 떠나야 하는 브라이트빌을 위해 동물들의 도움을 받아 이주를 위한 생존 기술을 가르쳐준다. 그러나 선천적으로 몸집이 작은 브라이트빌은 짧은 비행도 힘겨워 하는데...',500.759,'/8dkuf9IuVh0VZjDTk7kAY67lU0U.jpg','2024-09-12',102,'와일드 로봇',8.3),(1201012,'/l2QSVFR5aLcW1Vl4cGKrQkEp6fY.jpg','도무지 어울릴 것 같지 않은 커플의 결혼식 날 밤. 예상치 못한 사건이 발생하면서 두 사람은 깡패들과 경찰들을 피해 \'찰리\'라는 미스터리한 인물을 찾아야 하는 혼돈의 추격전에 휘말린다.',568.961,'/2E7me3rPi8HqaeheuD86YlpNX6k.jpg','2025-02-13',109,'둠 담',6.4),(1247019,'/vfkzNcVzTRCq3C2jYIZtIjSdwf7.jpg','여동생을 잃은 남자. 3년이 흐른 후에도 식지 않는 복수심으로 여동생을 죽인 어둠의 영혼을 집요하게 쫓는다.',530.143,'/xPTyukOmTrJDwGPwHYwxEMieaqk.jpg','2024-10-10',112,'데스 위스퍼러 2',7.038),(1249289,'/qSOMdbZ6AOdHR999HWwVAh6ALFI.jpg','조(스콧 이스트우드)와 로라(윌라 피츠제럴드)는 임무 중 만나 사랑에 빠진 정부 스파이 커플이다. 그들은 각자의 기관을 떠나 결혼한다.  영화는 이들의 첫 만남 5년 후, 폴란드의 한 리조트에서 휴가를 보내던 중 시작된다. 근처 숲에서 비행기 추락 사고가 발생하고, 조는 사고 현장을 조사하다 미스터리한 플래시 드라이브를 발견한다. 이 플래시 드라이브를 둘러싸고 여러 집단이 조를 공격하기 시작한다. 한 집단은 오린(마이크 콜터)이 이끄는 용병들이고, 다른 한 집단은 조의 전 소속 기관이다. 그들은 조가 글로벌 정보망을 무너뜨리려는 비밀 조직 \'Alarum\'에 가입했다고 의심한다. 조와 로라는 서로 헤어지게 되고, 로라가 실제로 Alarum의 일원임이 밝혀진다. 두 사람은 수많은 킬러들과 싸우며 재회를 시도합니다. 이 과정에서 체스터(실베스터 스탤론)라는 옛 동료가 등장하여 조를 제거하려 하지만, 결국 그와 함께 행동하며 폭발적인 액션을 펼치게 되는데... https://justwatch.pro/movie/1249289/alarum',578.695,'/z6A7WqyKJI9COZkxKLI1hyiAhPK.jpg','2025-01-16',95,'알라룸',5.792),(1294203,'/uJK0jjJ8QDOQw5lcNBwu059ht4D.jpg','영국의 부유한 사업가 윌리엄과 최근 사랑에 빠진 엄마를 따라 미국에서 영국으로 거처를 옮긴 18세 노아는 윌리엄의 불량한 아들 닉을 만나게 되고 둘은 서로에게 거부할 수 없는 매력을 느낀다. 여름 내내 노아는 새로운 생활에 적응하며 처음으로 사랑에 빠지지만 과거의 괴로운 기억이 노아의 발목을 잡는다.',549.7,'/h7H6Kd9kX1dvN8FZjUy6FcNdXxQ.jpg','2025-02-12',119,'나의 잘못: 런던',7.482),(1352774,'/tehewlwOPFDDf4syutyopaY23AY.jpg','',422.701,'/5wZNFUJAwyX6RCxdqrLO9lLWJ20.jpg','2025-01-25',83,'Piglet',5.7);
/*!40000 ALTER TABLE `nowplaying_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nowplaying_movie_genres`
--

DROP TABLE IF EXISTS `nowplaying_movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nowplaying_movie_genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `movie_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt6jaxafiksab3rfqhbxpx34m8` (`movie_id`),
  CONSTRAINT `FKt6jaxafiksab3rfqhbxpx34m8` FOREIGN KEY (`movie_id`) REFERENCES `nowplaying_movie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nowplaying_movie_genres`
--

LOCK TABLES `nowplaying_movie_genres` WRITE;
/*!40000 ALTER TABLE `nowplaying_movie_genres` DISABLE KEYS */;
INSERT INTO `nowplaying_movie_genres` VALUES (12,'모험',516729),(14,'판타지',823219),(16,'애니메이션',1184918),(18,'드라마',974576),(27,'공포',1352774),(28,'액션',1247019),(35,'코미디',516729),(53,'스릴러',974576),(80,'범죄',1249289),(878,'SF',1184918),(10749,'로맨스',1294203),(10751,'가족',1184918);
/*!40000 ALTER TABLE `nowplaying_movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `popular_movie`
--

DROP TABLE IF EXISTS `popular_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popular_movie` (
  `id` bigint(20) NOT NULL,
  `back_drop_path` varchar(255) DEFAULT NULL,
  `overview` longtext DEFAULT NULL,
  `popularity` double NOT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `runtime` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `vote_average` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `popular_movie`
--

LOCK TABLES `popular_movie` WRITE;
/*!40000 ALTER TABLE `popular_movie` DISABLE KEYS */;
INSERT INTO `popular_movie` VALUES (539972,'/v9Du2HC3hlknAvGlWhquRbeifwW.jpg','죽음의 문턱에서 맹수의 초인적인 힘을 얻고 살아 돌아온 크레이븐이 무자비한 복수의 길을 택하며 거침없는 사냥을 펼치는 액션 블록버스터',886.374,'/bA45ooXcp2B2qnMePfZ9QDL4wR5.jpg','2024-12-11',127,'크레이븐 더 헌터',6.7),(549509,'/iKXXPYBWQ0B6BMRHAFbg3wKafWb.jpg','전쟁의 상흔을 뒤로하고 미국에 정착한 건축가 라즐로 토스. 미국 이민자의 냉혹한 현실 속에 전쟁의 트라우마를 견뎌내던 어느 날. 라즐로의 천재성을 알아본 부유한 사업가 해리슨이 기념비적인 건축물 설계를 제안한다. 하지만, 시대와 공간, 빛의 경계를 넘어 대담하고 혁신적인 그의 건축 설계는 사람들의 공감을 얻지 못하고 반대에 부딪히게 된다. 후원자 해리슨의 감시와 압박, 주변의 비난이 거세질수록 오히려 더 자신의 설계에 집착하던 라즐로. 혁신적인 브루탈리즘 건축에 자신을 투영하던 라즐로는 결국 공사가 중단될 위기에 처하는데...',1065.25,'/dKFjxIZ6tPAUQInMKZCE3BfcrO2.jpg','2024-12-20',215,'브루탈리스트',7.1),(558449,'/bHeUgZKqduubnNl8GshjrpHS9lF.jpg','로마의 영웅이자 최고의 검투사였던 막시무스가 콜로세움에서 죽음을 맞이한 뒤 20여 년이 흐른 후. 쌍둥이 황제 게타와 카라칼라의 폭압 아래 시민을 위한 자유로운 나라 로마의 꿈은 잊힌 지 오래다. 한편 아카시우스 장군이 이끄는 로마군에 대패한 후 모든 것을 잃고 노예로 전락한 루시우스는 강한 권력욕을 지닌 마크리누스의 눈에 띄어 검투사로 발탁된다. 로마를 향한 걷잡을 수 없는 분노, 타고난 투사의 기질로 콜로세움에 입성하게 된 루시우스는 결투를 거듭하며 자신이 진짜 누구인지 알게 되고 마침내 로마의 운명을 건 결전을 준비하게 되는데...!',729.732,'/b5UXjzW5cLZhprMnlAmsVAA3G4t.jpg','2024-11-13',148,'글래디에이터 II',6.8),(762509,'/oHPoF0Gzu8xwK4CtdXDaWdcuZxZ.jpg','길을 잃고 혼자가 된 새끼 사자 무파사는 광활한 야생을 떠돌던 중 왕의 혈통이자 예정된 후계자 타카와 우연히 만나게 된다. 마치 친형제처럼 끈끈한 우애를 나누며 함께 자란 무파사와 타카는 운명을 개척하기 위해 거대한 여정을 함께 떠난다. 한 치 앞을 알 수 없는 적들의 위협 속에서 두 형제의 끈끈했던 유대에 금이 가기 시작하고 예상치 못한 위기까지 맞닥뜨리게 되는데…',2050.558,'/1VUExee8iFohFTwYVi4IOArYyaM.jpg','2024-12-18',118,'무파사: 라이온 킹',7.467),(774370,'/iXU87IdtNsYt7n6OigPJBDdbFf1.jpg','\"반쪽은 개, 반쪽은 인간, 그야말로 영웅의 탄생!\"\r 한 경찰견과 그의 파트너인 경찰관이 함께 부상당한 후, 기적 같은 수술로 하나가 되어 \'도그맨\'이 탄생한다. 이제 도그맨은 그의 새로운 정체성을 받아들이며, 도시를 지키기 위해 애쓴다. 하지만 도시를 위협하는 악당, 페티 더 캣과의 싸움에서 도그맨의 진정한 힘이 시험받게 되는데...',722.633,'/89wNiexZdvLQ41OQWIsQy4O6jAQ.jpg','2025-01-24',89,'도그맨',7.7),(822119,'/qfAfE5auxsuxhxPpnETRAyTP5ff.jpg','대통령이 된 새디우스 로스와 재회 후, 국제적인 사건의 중심에 서게 된 샘이 전 세계를 붉게 장악하려는 사악한 음모 뒤에 숨겨진 존재와 이유를 파헤쳐 나가는 액션 블록버스터',1295.113,'/2MQdtfioyYSqgwkK07PSrBidOBC.jpg','2025-02-12',119,'캡틴 아메리카: 브레이브 뉴 월드',6.2),(823219,'/b3mdmjYTEL70j7nuXATUAD9qgu4.jpg','인간이 살았던 흔적만이 남아있는 세상, 홀로 집을 지키던 \'고양이\'는 갑작스러운 대홍수로 평화롭던 일상과 아늑했던 터전을 잃고 만다. 때마침 다가온 낡은 배에 올라탄 \'고양이\'는 그 안에서 \'골든 리트리버\', \'카피바라\', \'여우원숭이\', \'뱀잡이수리\'를 만나고 서로의 차이점을 극복하고 팀을 이뤄 험난한 파도를 헤쳐나간다.',885.787,'/8ntMUYy0b0NIGWSWvMr07ui7CCJ.jpg','2024-08-29',85,'플로우',8.3),(912649,'/vZG7PrX9HmdgL5qfZRjhJsFYEIA.jpg','환상의 케미스트리의 에디 브록과 그의 심비오트 베놈은 그들을 노리는 정체불명 존재의 추격을 피해 같이 도망을 다니게 된다. 한편 베놈의 창조자 널은 고향 행성에서부터 그들을 찾아내기 위해 지구를 침략하고 에디와 베놈은 그동안 겪어보지 못한 최악의 위기를 맞이하게 되는데…',820.402,'/ptfoRD0MmL8Ry0iBVccYbqoN9Xc.jpg','2024-10-22',109,'베놈: 라스트 댄스',6.788),(927342,'/7cNE2qydew1c8fqnlhWjkE3DHc2.jpg','',1329.454,'/eCB06m1KUGilEOlIzb40nkQhVY0.jpg','2024-10-31',169,'அமரன்',7.4),(933260,'/bVSOgrxasVJF6V71T7v2KfBRSzu.jpg','한때 아카데미상을 수상하고 명예의 거리까지 입성한 대스타였지만 지금은 TV 에어로빅 쇼 진행자로 전락한 엘리자베스. 50살이 되던 날, 프로듀서에게서 어리고 섹시하지 않다는 이유로 해고를 당한다. 돌아가던 길에 차 사고로 병원에 실려간 엘리자베스는 매력적인 남성 간호사로부터 서브스턴스라는 약물을 권유받는다. 한 번의 주사로 젊고 아름답고 완벽한 수가 탄생하는데...',970.749,'/5TPPefBI1OzWnSQfBkOrv1OFGq5.jpg','2024-09-07',140,'서브스턴스',7.127),(939243,'/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg','너클즈, 테일즈와 함께 평화로운 일상을 보내던 초특급 히어로 소닉. 연구 시설에 50년간 잠들어 있던 사상 최강의 비밀 병기 \"섀도우\"가 탈주하자, 세계 수호 통합 부대(약칭 세.수.통)에 의해 극비 소집된다. 소중한 것을 잃은 분노와 복수심에 불타는 섀도우는 소닉의 초고속 스피드와 너클즈의 최강 펀치를 단 단숨에 제압해버린다. 세상을 지배하려는 닥터 로보트닉과 그의 할아버지 제럴드 박사는 섀도우의 엄청난 힘 카오스 에너지를 이용해 인류를 정복하려고 하는데…',1976.892,'/5ZoI48Puf5i5FwI6HOpunDuJOw0.jpg','2024-12-19',110,'수퍼 소닉 3',7.7),(950396,'/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg','고도의 훈련을 받은 두 요원는 비밀스러운 협곡의 양쪽을 지키는 임무를 받은 후 멀리서 서로와 서서히 친해진다. 도사리고 있던 악이 드러나자, 둘은 협곡 안의 위험으로부터 살아남기 위해 협력해야만 한다.',3135.209,'/fhPj5pWbCoVoz8sehfaCeIWWFxc.jpg','2025-02-13',127,'\'더 캐니언\' - The Gorge',7.791),(1064213,'/kEYWal656zP5Q2Tohm91aw6orlT.jpg','뉴욕의 스트리퍼 아노라는 자신의 바를 찾은 철부지 러시아 재벌2세 이반을 만나게 되고 충동적인 사랑을 믿고 허황된 신분 상승을 꿈꾸며 결혼식을 올리게 된다. 그러나 신데렐라 스토리를 꿈꿨던 것도 잠시, 한 번도 본 적 없는 이반의 부모님이 아들의 결혼 사실을 알게 되자 길길이 날뛰며 미국에 있는 하수인 3인방에게 둘을 잡아 혼인무효소송을 진행할 것을 지시한다. 하수인 3인이 들이닥치자 부모님이 무서워 겁에 질린 남편 이반은 아노라를 버린채 홀로 도망친다. 이반을 찾아 결혼 생활을 유지하고 싶은 아노라와 어떻게든 이반을 찾아 혼인무효소송을 시켜야만 하는 하수인 3인방의 대환장 발악이 시작된다.',1016.68,'/mwguqSMRCA3NgpPoRsXdFhid25m.jpg','2024-10-14',140,'아노라',7.1),(1064486,'/jl2YIADk391yc6Qjy9JhgCRkHJk.jpg','쌍둥이 동생 길버트와 함께 태어나 입양된 그레이스는 옷장 속 달팽이로 위로를 삼는다.',664.263,'/lWh5OlerPR1c1cfn1ZLq0lpqFds.jpg','2024-10-17',94,'달팽이의 회고록',7.8),(1084199,'/sc1abgWNXc29wSBaerrjGBih06l.jpg','서로에게 딱 맞는 커플 ‘아이리스’와 ‘조시’는 친구들과 함께 호숫가의 별장으로 호화로운 휴가를 떠난다. 하지만 그곳에는 충격적인 사건이 기다리고 있는데…',1222.243,'/dq7CEYFCvQPfYIpAXOvJr3w6VLY.jpg','2025-01-22',97,'컴패니언',7.1),(1126166,'/gFFqWsjLjRfipKzlzaYPD097FNC.jpg','미셸 도커리가 연기하는 부지런한 미국 연방보호관 매들린 해리스는 마피아 조직의 회계사였던 윈스턴(토퍼 그레이스)을 증인 보호 프로그램으로 이송하는 임무를 맡게 된다. 그들은 알래스카의 황량한 설원을 가로지르는 작은 비행기에 탑승하며, 이 비행기의 조종사는 다릴 부스(마크 월버그)다. 그러나 비행 도중, 이들이 탑승한 비행기는 예상치 못한 위험에 직면하게 되고, 매들린은 조종사와 승객들의 숨겨진 의도를 의심하게 된다. 한정된 공간에서 긴장감이 고조되는 가운데, 매들린은 비행기의 조종을 직접 맡아야 하는 상황에 이르게 되는데...',2568.332,'/zstC9sgsPaV98TaZtHL6aTtBUtB.jpg','2025-01-22',91,'플라이트 리스크',6.038),(1160956,'/u7AZ5CdT2af8buRjmYCPXNyJssd.jpg','액션 스타 재키가 우연히 전 세계적인 인기를 한 몸에 받고 있는 ‘후후’라는 아기 판다 구출 작전에 합류하게 되면서 벌어지는 이야기',1005.555,'/zNU7A18Py3jHArZFLH2d4WUTbMS.jpg','2024-10-01',99,'판다 플랜',7.1),(1201012,'/l2QSVFR5aLcW1Vl4cGKrQkEp6fY.jpg','도무지 어울릴 것 같지 않은 커플의 결혼식 날 밤. 예상치 못한 사건이 발생하면서 두 사람은 깡패들과 경찰들을 피해 \'찰리\'라는 미스터리한 인물을 찾아야 하는 혼돈의 추격전에 휘말린다.',568.961,'/2E7me3rPi8HqaeheuD86YlpNX6k.jpg','2025-02-13',109,'둠 담',6.4),(1241982,'/zo8CIjJ2nfNOevqNajwMRO6Hwka.jpg','바다를 누볐던 선조들에게서 예기치 못한 부름을 받은 모아나가 마우이와 다시 만나 새로운 선원들과 함께 오랫동안 잊혀진 멀고 위험한 바다 너머로 떠나는 특별한 모험을 담은 이야기',1861.245,'/hwmwTFtMbzxAWbIOp1RyyiOCyx0.jpg','2024-11-21',99,'모아나 2',7.149),(1249289,'/qSOMdbZ6AOdHR999HWwVAh6ALFI.jpg','조(스콧 이스트우드)와 로라(윌라 피츠제럴드)는 임무 중 만나 사랑에 빠진 정부 스파이 커플이다. 그들은 각자의 기관을 떠나 결혼한다.  영화는 이들의 첫 만남 5년 후, 폴란드의 한 리조트에서 휴가를 보내던 중 시작된다. 근처 숲에서 비행기 추락 사고가 발생하고, 조는 사고 현장을 조사하다 미스터리한 플래시 드라이브를 발견한다. 이 플래시 드라이브를 둘러싸고 여러 집단이 조를 공격하기 시작한다. 한 집단은 오린(마이크 콜터)이 이끄는 용병들이고, 다른 한 집단은 조의 전 소속 기관이다. 그들은 조가 글로벌 정보망을 무너뜨리려는 비밀 조직 \'Alarum\'에 가입했다고 의심한다. 조와 로라는 서로 헤어지게 되고, 로라가 실제로 Alarum의 일원임이 밝혀진다. 두 사람은 수많은 킬러들과 싸우며 재회를 시도합니다. 이 과정에서 체스터(실베스터 스탤론)라는 옛 동료가 등장하여 조를 제거하려 하지만, 결국 그와 함께 행동하며 폭발적인 액션을 펼치게 되는데... https://justwatch.pro/movie/1249289/alarum',578.695,'/z6A7WqyKJI9COZkxKLI1hyiAhPK.jpg','2025-01-16',95,'알라룸',5.792);
/*!40000 ALTER TABLE `popular_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `popular_movie_genres`
--

DROP TABLE IF EXISTS `popular_movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popular_movie_genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `movie_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7ev01ao6n97f0xj3tkfgwpbpy` (`movie_id`),
  CONSTRAINT `FK7ev01ao6n97f0xj3tkfgwpbpy` FOREIGN KEY (`movie_id`) REFERENCES `popular_movie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `popular_movie_genres`
--

LOCK TABLES `popular_movie_genres` WRITE;
/*!40000 ALTER TABLE `popular_movie_genres` DISABLE KEYS */;
INSERT INTO `popular_movie_genres` VALUES (12,'모험',558449),(14,'판타지',823219),(16,'애니메이션',1064486),(18,'드라마',1064486),(27,'공포',933260),(28,'액션',1201012),(35,'코미디',1201012),(53,'스릴러',1249289),(80,'범죄',1249289),(878,'SF',933260),(10749,'로맨스',1201012),(10751,'가족',774370),(10752,'전쟁',927342);
/*!40000 ALTER TABLE `popular_movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) DEFAULT NULL,
  `reported_at` datetime(6) NOT NULL,
  `board_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2mf8ehoy689ord40esx24n26e` (`board_id`),
  KEY `FKq50wsn94sc3mi90gtidk0k34a` (`user_id`),
  CONSTRAINT `FK2mf8ehoy689ord40esx24n26e` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`),
  CONSTRAINT `FKq50wsn94sc3mi90gtidk0k34a` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `top_movie_genre_ids`
--

DROP TABLE IF EXISTS `top_movie_genre_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `top_movie_genre_ids` (
  `top_movie_id` bigint(20) NOT NULL,
  `genre_ids` int(11) DEFAULT NULL,
  KEY `FKqa5blyfpxmp70l2s1mappt0u7` (`top_movie_id`),
  CONSTRAINT `FKqa5blyfpxmp70l2s1mappt0u7` FOREIGN KEY (`top_movie_id`) REFERENCES `topmovie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `top_movie_genre_ids`
--

LOCK TABLES `top_movie_genre_ids` WRITE;
/*!40000 ALTER TABLE `top_movie_genre_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `top_movie_genre_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `top_movie_genres`
--

DROP TABLE IF EXISTS `top_movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `top_movie_genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `movie_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhfaqvx99505nrw3ybgx4tytsj` (`movie_id`),
  CONSTRAINT `FKhfaqvx99505nrw3ybgx4tytsj` FOREIGN KEY (`movie_id`) REFERENCES `topmovie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `top_movie_genres`
--

LOCK TABLES `top_movie_genres` WRITE;
/*!40000 ALTER TABLE `top_movie_genres` DISABLE KEYS */;
INSERT INTO `top_movie_genres` VALUES (12,'모험',157336),(14,'판타지',122),(16,'애니메이션',12477),(18,'드라마',637),(28,'액션',346),(35,'코미디',637),(36,'역사',424),(37,'서부',429),(53,'스릴러',680),(80,'범죄',769),(878,'SF',157336),(10749,'로맨스',13),(10751,'가족',129),(10752,'전쟁',12477);
/*!40000 ALTER TABLE `top_movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topmovie`
--

DROP TABLE IF EXISTS `topmovie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topmovie` (
  `id` bigint(20) NOT NULL,
  `back_drop_path` varchar(255) DEFAULT NULL,
  `overview` longtext DEFAULT NULL,
  `popularity` double NOT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `runtime` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `vote_average` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topmovie`
--

LOCK TABLES `topmovie` WRITE;
/*!40000 ALTER TABLE `topmovie` DISABLE KEYS */;
INSERT INTO `topmovie` VALUES (13,'/mzfx54nfDPTUXZOG48u4LaEheDy.jpg','불편한 다리, 남들보다 조금 떨어지는 지능을 가진 포레스트 검프는 헌신적인 어머니의 보살핌과 첫사랑 제니와의 만남으로 편견과 괴롭힘 속에서도 따뜻한 마음을 지니고 성장한다. 또래들의 괴롭힘을 피해 도망치던 포레스트는 누구보다 빠르게 달릴 수 있는 자신의 재능을 깨닫는다. 그의 재능을 알아 본 대학에서 그를 미식축구 선수로 발탁하고, 졸업 후에도 뛰어난 신체능력으로 군에 들어가 무공훈장을 수여받는 등 탄탄한 인생 가도에 오르게 된 포레스트. 하지만 어머니가 병에 걸려 죽음을 맞이하고, 첫사랑 제니 역시 그의 곁을 떠나가며 다시 한 번 인생의 전환점을 맞이하게 되는데...',83.522,'/iraQz6gdAe8JL45QcBifM1UhQ38.jpg','1994-06-23',142,'포레스트 검프',8.468),(122,'/2u7zbn8EudG6kLlBzUYqP8RyFU4.jpg','사우론이 인간들의 마지막 요새인 곤도르를 향해 야욕을 드러내고 있는 한편, 아라곤은 쇠락해가고 있는 곤도르의 재건을 위해 왕위 계승을 신중하게 결정지어야만 하는 상황. 이제 중간대륙의 미래는 그의 어깨에 달려있는 것. 사우론이 이끄는 어둠의 군대와의 마지막 전투를 위해 간달프는 곤도르에 흩어져 있던 병사들을 모으고, 로한의 왕 세오덴에게 도움을 받기도 하지만 사우론의 군대에 비하면 열세를 면치 못한다. 그러나 그들은 중간대륙을 사우론의 야욕으로부터 지키려는 사명감과, 마지막 반지 운반자에게 임무를 끝낼 기회를 주기 위해 어둠의 군대를 향해 돌진하게 되는데...',161.784,'/n8BPIRqvj1SdTRND828ANXhmSng.jpg','2003-12-17',199,'반지의 제왕: 왕의 귀환',8.5),(129,'/6oaL4DP75yABrd5EbC4H2zq5ghc.jpg','평범한 열 살 짜리 소녀 치히로 식구는 이사 가던 중 길을 잘못 들어 낡은 터널을 지나가게 된다. 터널 저편엔 폐허가 된 놀이공원이 있었고 그곳엔 이상한 기운이 흘렀다. 인기척 하나 없는 이 마을의 낯선 분위기에 불길한 기운을 느낀 치히로는 부모님에게 돌아가자고 조르지만 부모님은 호기심에 들떠 마을 곳곳을 돌아다니기 시작한다. 어느 음식점에 도착한 치히로의 부모님은 그 곳에 차려진 음식들을 보고 즐거워하며 허겁지겁 먹어대다가 돼지로 변해버린다. 겁에 질려 당황하는 치히로에게 낯선 소년 하쿠가 나타나 빨리 이곳을 나가라고 소리치는데...',93.449,'/aZuBfbR0PnCb2up7lqHDsgJlLjs.jpg','2001-07-20',124,'센과 치히로의 행방불명',8.538),(155,'/oOv2oUXcAaNXakRqUPxYq5lJURz.jpg','범죄와 부정부패를 제거하여 고담시를 지키려는 배트맨. 그는 짐 고든 형사와 패기 넘치는 고담시 지방 검사 하비 덴트와 함께 도시를 범죄 조직으로부터 영원히 구원하고자 한다. 세 명의 의기투합으로 위기에 처한 악당들이 모인 자리에 보라색 양복을 입고 얼굴에 짙게 화장을 한 괴이한 존재가 나타나 배트맨을 죽이자는 사상 초유의 제안을 한다. 그는 바로 어떠한 룰도, 목적도 없는 사상 최악의 악당 미치광이 살인광대 조커. 배트맨을 죽이고 고담시를 끝장내버리기 위한 조커의 광기 어린 행각에 도시는 혼란에 빠지는데...',170.244,'/f6dNinWX8rBM79JXKcShkfSh2oA.jpg','2008-07-16',152,'다크 나이트',8.519),(238,'/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg','시실리에서 이민온 뒤, 정치권까지 영향력을 미치는 거물로 자리잡은 돈 꼴레오네는 갖가지 고민을 호소하는 사람들의 문제를 해결해주며 대부라 불리운다. 한편 솔로소라는 인물은 꼴레오네가와 라이벌인 탓타리아 패밀리와 손잡고 새로운 마약 사업을 제안한다. 돈 꼴레오네가 마약 사업에 참여하지 않기로 하자, 돈 꼴레오네를 저격해 그는 중상을 입고 사경을 헤매게 된다. 그 뒤, 돈 꼴레오네의 아들 소니는 조직력을 총 동원해 다른 패밀리들과 피를 부르는 전쟁을 시작하는데... 가족의 사업과 상관없이 대학에 진학한 뒤 인텔리로 지내왔던 막내 아들 마이클은 아버지가 총격을 당한 뒤, 아버지를 구하기 위해 위험천만한 협상 자리에 나선다.',177.805,'/I1fkNd5CeJGv56mhrTDoOeMc2r.jpg','1972-03-14',175,'대부',8.689),(240,'/kGzFbGhp99zva6oZODW5atUtnqi.jpg','아버지의 장례식 도중에 맏아들 파올로가 총에 맞아 죽고, 비토(로버트 드니로)는 겨우 도망쳐 미국으로 건너온다. 대부로 성장한 후 비토는 다시 치치오를 찾아 복수를 한다. 새롭게 등장한 젊은 대부 마이클(알 파치노)은 본거지를 라스베가스로 옮기고 가족의 사업을 가능한 합법적인 것으로 바꾸려고 애쓴다. 그런 과중 중에 자신을 제거하려는 음모를 알게되고 그는 냉혹하고 신속하게 반대파들을 제거, 조직을 더욱 확대해 나간다. 이를 위해 마이클은 배신한 형마저 죽이고, 일 때문에 아내와 헤어지는 등 인간적으로는 계속 외로워져 가는데...',95.931,'/bhqvqYuAgrTGwyNAmMR0ZVmjXel.jpg','1974-12-20',202,'대부 2',8.57),(278,'/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg','촉망받는 은행 간부 앤디 듀프레인은 아내와 그녀의 정부를 살해했다는 누명을 쓴다. 주변의 증언과 살해 현장의 그럴듯한 증거들로 그는 종신형을 선고받고 악질범들만 수용한다는 지옥같은 교도소 쇼생크로 향한다. 인간 말종 쓰레기들만 모인 그곳에서 그는 이루 말할 수 없는 억압과 짐승보다 못한 취급을 당한다. 그러던 어느 날, 간수의 세금을 면제받게 해 준 덕분에 그는 일약 교도소의 비공식 회계사로 일하게 된다. 그 와중에 교도소 소장은 죄수들을 이리저리 부리면서 검은 돈을 긁어 모으고 앤디는 이 돈을 세탁하여 불려주면서 그의 돈을 관리하는데...',168.49,'/oAt6OtpwYCdJI76AVtVKW1eorYx.jpg','1994-09-23',142,'쇼생크 탈출',8.708),(346,'/sJNNMCc6B7KZIY3LH3JMYJJNH5j.jpg','일본의 전국시대. 주민들은 황폐한 땅에서 어렵게 수확한 식량으로 한해 한해를 넘기는 빈촌에 살고 있다. 이 빈촌엔 보리 수확이 끝날 무렵이면 어김없이 산적들이 찾아와 모든 식량을 모조리 약탈해 간다. 싸워도 애원해도 소용이 없었다. 가만히 있을 수만은 없던 촌장의 결단으로 사무라이들을 모집하는데, 이들은 풍부한 전쟁 경험을 가진 시마다 칸베에를 포함한 7명이었다. 시마다의 지휘하에 마을은 방위태세를 갖추고 전투훈련도 시작한다. 이윽고 산적들의 공격이 시작되어 치열한 사투가 벌어진다.',34.251,'/6Y8Q5t79ybiDA7XubUTneqZhjA3.jpg','1954-04-26',207,'7인의 사무라이',8.458),(389,'/bxgTSUenZDHNFerQ1whRKplrMKF.jpg','뉴욕시의 법정에 아버지를 칼로 찌른 한 소년의 살인혐의를 두고, 12인의 배심원들은 만장일치 합의를 통해 소년의 유무죄 여부를 가려줄 것을 요구받는다. 판사는 유죄일 경우 이 소년은 사형이 불가피하다는 것을 이들에게 미리 일러둔다.  배심원 방에 모인 이들은 투표를 통해 유무죄 여부를 가리기로 한다. 사람들이 전부 소년이 유죄로 판단하는 가운데, 오직 한 배심원만이 소년이 무죄라고 주장하는데...',58.816,'/xzh6Rq9cKnE1M309PzC5S5QWF9S.jpg','1957-04-10',97,'12명의 성난 사람들',8.548),(424,'/zb6fM1CX41D9rF9hdgclu0peUmy.jpg','2차 세계대전 당시 독일군이 점령한 폴란드. 시류에 맞춰 자신의 성공을 추구하는 기회주의자 쉰들러는 유태인이 경영하는 그릇 공장을 인수한다. 그는 공장을 인수하기 위해 나찌 당원이 되고 독일군에게 뇌물을 바치는 등 갖은 방법을 동원한다. 그러나 냉혹한 기회주의자였던 쉰들러는 유태인 회계사인 스턴과 친분을 맺으면서 냉혹한 유태인 학살에 대한 양심의 소리를 듣기 시작한다. 마침내 그는 강제 수용소로 끌려가 죽음을 맞게될 유태인들을 구해내기로 결심하고, 독일군 장교에게 빼내는 사람 숫자대로 뇌물을 주는 방법으로 유태인들을 구해내려는 계획을 세우는데...',96.084,'/oyyUcGwLX7LTFS1pQbLrQpyzIyt.jpg','1993-12-15',195,'쉰들러 리스트',8.567),(429,'/x4biAVdPVCghBlsVIzB6NmbghIz.jpg','미국의 남북전쟁이 한창인 때, 블론디는 멕시코인 총잡이 투코와 함께 동업 중이다. 블론디는 현상범 투코를 잡아 현상금을 받고, 투코가 교수형을 당하는 순간 구해주는 역할. 한편 세텐자라 불리우는 범죄자는 엄청나 돈이 묻힌 비밀장소를 추적 중이다. 그런데, 투코와 실랑이를 벌이던 블론디는 돈이 묻힌 장소를 죽어가는 사람에게 듣게 되고, 결국 둘은 돈을 찾아 나서는데...',77.924,'/s7qPuoj4liolAtmx9vcL6AyaZzR.jpg','1966-12-22',161,'석양의 무법자',8.462),(497,'/vxJ08SvwomfKbpboCWynC3uqUg4.jpg','미국 루이지애나의 콜드 마운틴 교도소. 폴은 사형수 감방의 간수장으로 일하고 있다. 그의 일은 사형수들을 감독하고, 그린 마일이라 불리는 초록색 복도를 거쳐 그들을 사형 집행장까지 안내하는 것. 폴은 그들이 죽음을 맞이하는 순간까지 평화롭게 지낼 수 있도록 최선을 다한다. 어느 날 존 커피라는 사형수가 이송되어 온다. 그는 쌍둥이 여자아이를 살해한 흉악범. 하지만 순진한 눈망울에 겁을 잔뜩 집어먹은 그의 모습에 폴은 당혹감을 느낀다. 게다가 그는 초자연적 능력으로 폴의 지병을 깨끗하게 치료해주기까지 한다. 존을 전기 의자로 데려가야 할 날이 다가오면서 폴은 그가 무죄라는 확신을 갖게 되는데...',81.242,'/yuSpRhrTIJa5JN8oESrfD2bndp1.jpg','1999-12-10',189,'그린 마일',8.5),(637,'/gavyCu1UaTaTNPsVaGXT6pe5u24.jpg','로마에 갓 상경한 시골 총각 귀도는 운명처럼 만난 여인 도라에게 첫눈에 반한다. 넘치는 재치와 유머로 약혼자가 있던 그녀를 사로잡은 귀도는 가정을 꾸리며 분신과도 같은 아들 조수아를 얻는다. 조수아의 다섯 살 생일, 갑작스레 들이닥친 군인들은 귀도와 조수아를 수용소 행 기차에 실어버리고, 소식을 들은 도라 역시 기차에 따라 오른다. 귀도는 아들을 달래기 위해 무자비한 수용소 생활을 단체게임이라 속이고 1,000점을 따는 우승자에게는 진짜 탱크가 주어진다고 말한다. 하루하루가 지나 어느덧 전쟁이 끝났다는 말을 들은 귀도는 조수아를 창고에 숨겨둔 채 아내를 찾아 나서는데...',50.121,'/yjOqQsQHdsEZfAosZERqHiwjaty.jpg','1997-12-20',116,'인생은 아름다워',8.446),(680,'/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg','펌프킨와 허니 버니가 레스토랑에서 강도 행각을 벌이기 시작한다. 빈센트와 그 동료 쥴스는 두목의 금가방을 찾기 위해 다른 건달이 사는 아파트를 찾아간다. 마르셀러스는 부치에게 돈을 주며 상대 선수에게 져 주라고 하지만 부치는 상대 선수를 때려 눕히고 도망치다, 어릴 때 아버지에게 물려받은 시계를 찾기 위해 아파트로 향한다. 아무런 상관 없이 보이는 이 사건들이 서로 얽히고 섥히면서 예상치 못한 인과관계가 만들어지는데...',123.251,'/6lXRHGoEbnnBUKsuqpL9JxD4DzT.jpg','1994-09-10',154,'펄프 픽션',8.489),(769,'/7TF4p86ZafnxFuNqWdhpHXFO244.jpg','아일랜드계 이탈리아인 헨리 힐와 토미는 13살에 마피아에 입문해 지미와 함께 트럭이나 공항 화물을 훔치는 일을 한다. 결혼 후에도 마피아 생활을 계속하는 헨리는 이제 조직에서도 안정된 위치와 경제적 여유를 갖는다.  어느 날 헨리와 지미는 공항터미널 사건을 모의해 현금 6백만 달러라는 엄청한 돈을 훔친다. 이 사건을 은폐하기 위해 혈안이 된 지미는 모의에 참여했던 사람들을 죽이고, 토미는 마피아 조직에 가담했다가 살해당한다. 엎친데 덮친격으로 헨리마저 마약거래로 경찰서에 잡혀 들어가는데...',75.447,'/zF9hSBS1t7PVFLo01GrJ3OjGi67.jpg','1990-09-12',146,'좋은 친구들',8.5),(12477,'/tDFvXn4tane9lUvFAFAUkMylwSr.jpg','2차 세계대전, 일본의 한 마을에 폭격기로 인한 대공습이 일어난다. 마을이 화염으로 휩싸이자, 14살인 세이타는 부모님과 따로 만나기로 약속한 채 4살짜리 여동생 세츠코를 업고 피신한다. 결국 집과 어머니를 잃고 먼 친척아주머니의 집으로 향하는 세이타와 세츠코. 힘들고 어려운 환경에서도 오빠 세이타는 천진하고 착한 여동생 세츠코를 보면서 희망과 용기를 잃지 않는다. 하지만 시간이 지날수록 친척아주머니의 남매에 대한 냉대는 더욱 심해지고, 세이타는 어머니가 남겨주었던 마지막 여비를 챙겨 세츠코와 함께 산 속에 있는 방공호로 거처를 옮긴다. 두 남매는 산 속 동굴에서 반딧불이를 잡아 불을 밝히고, 물고기와 개구리를 잡아먹으며 살아가는데...',0.046,'/uN0x0G4uuRjFJIFN57iYihBV2Qh.jpg','1988-04-16',89,'반딧불이의 묘',8.451),(19404,'/90ez6ArvpO8bvpyIngBuwXOqJm5.jpg','영국에서 유학중인 라즈(샤룩 칸)와 인도 처녀 심란(까졸).  심란은 부모님이 정해주신 약혼자가 있는데 약혼을 앞두고 친구들과 유럽 여행을 떠나게 된다.  여행 중 우연히 만남 샤룩과 까졸. 두 남녀의 연속된 우연과 좌충우돌 사랑 만들기.  그렇게 사랑하게 된 그들이지만 까졸은 약혼자가 있는 몸. 인도로 돌아가게 된다.  샤룩 또한 그녀를 못 잊어 인도로 뒤 따라 들어가지만 엄격한 까졸의 부모를 설득하기가 힘이 든다. 도망가자는 까졸의 제안을 거부하고 샤룩은 끝내 그녀의 부모님의 허락을 얻어 내기 위해 고군분투한다.',31.895,'/2CAL2433ZeIihfX1Hb2139CX0pW.jpg','1995-10-20',190,'용감한 자가 신부를 데려가리',8.5),(157336,'/8sNiAPPYU14PUepFNeSNGUTiHW.jpg','세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다. 지난 20세기에 범한 잘못이 전 세계적인 식량 부족을 불러왔고, NASA도 해체되었다. 나사 소속 우주비행사였던 쿠퍼는 지구에 몰아친 식량난으로 옥수수나 키우며 살고 있다. 거센 황사가 몰아친 어느 날 알 수 없는 힘에 이끌려 딸과 함께 도착한 곳은 인류가 이주할 행성을 찾는 나사의 비밀본부. 이 때 시공간에 불가사의한 틈이 열리고, 이 곳을 탐험해 인류를 구해야 하는 임무를 위해 쿠퍼는 만류하는 딸을 뒤로한 채 우주선에 탑승하는데...',272.983,'/evoEi8SBSvIIEveM3V6nCJ6vKj8.jpg','2014-11-05',169,'인터스텔라',8.5),(372058,'/8x9iKH8kWA0zdkgNdpAew7OstYe.jpg','시골에 사는 소녀 미츠하(가미시라이시 모네)는 어느 날 잠에서 깬 후 자신의 몸이 남자로 바뀐 걸 알게 된다. 같은 시간, 도쿄에 사는 소년 타키(가미키 류노스케) 역시 이 기이한 상황을 겪고 있다. 낯선 가족, 낯선 친구들, 낯선 풍경들... 서로에게 이어진 끈을 알게 된 둘은 둘만의 규칙을 정하고 점차 상황을 받아들이기 시작한다. 서로에게 남긴 메모를 확인하며  점점 친구가 되어가는 타키와 미츠하. 언제부턴가 더 이상 몸이 바뀌지 않자  자신들이 특별하게 이어져있었음을 깨달은  타키는 미츠하를 만나러 가는데...',86.347,'/2DJCufz3Oa703PbLjNX1pM6MCG2.jpg','2016-08-26',106,'너의 이름은',8.5),(496243,'/8eihUxjQsJ7WvGySkVMC0EwbPAD.jpg','전원 백수로 살 길 막막하지만 사이는 좋은 기택 가족. 장남 기우에게 명문대생 친구가 연결시켜 준 고액 과외 자리는 모처럼 싹튼 고정수입의 희망이다. 온 가족의 도움과 기대 속에 박 사장 집으로 향하는 기우. 글로벌 IT기업의 CEO인 박 사장의 저택에 도착하자 젊고 아름다운 사모님 연교와 가정부 문광이 기우를 맞이한다. 큰 문제 없이 박 사장의 딸 다혜의 과외를 시작한 기우. 그러나 이렇게 시작된 두 가족의 만남 뒤로, 걷잡을 수 없는 사건이 기다리고  있는데.....',150.591,'/mSi0gskYpmf1FbXngM37s2HppXh.jpg','2019-05-30',131,'기생충',8.5);
/*!40000 ALTER TABLE `topmovie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upcoming_movie`
--

DROP TABLE IF EXISTS `upcoming_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upcoming_movie` (
  `id` bigint(20) NOT NULL,
  `back_drop_path` varchar(255) DEFAULT NULL,
  `overview` longtext DEFAULT NULL,
  `popularity` double NOT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `runtime` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `vote_average` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upcoming_movie`
--

LOCK TABLES `upcoming_movie` WRITE;
/*!40000 ALTER TABLE `upcoming_movie` DISABLE KEYS */;
INSERT INTO `upcoming_movie` VALUES (402431,'/uKb22E0nlzr914bA9KyA5CVCOlV.jpg','자신의 진정한 힘을 아직 발견하지 못한 엘파바와 자신의 진정한 본성을 발견하지 못한 글린다, 전혀 다른 두 인물이 우정을 쌓아가며 맞닥뜨리는 예상치 못한 위기와 모험을 그린 이야기',751.017,'/mHozMgx7w29qC9gLzUQDQEP7AEM.jpg','2024-11-20',162,'위키드',6.901),(516729,'/hfTyu2VPBqLRPo2DauW8q7bh9bm.jpg','영국 국민으로 거듭난 ‘패딩턴’에게 어느 날 고향인 페루에서 날아온 의문의 편지 한 통. “루시 숙모님이 사라졌어요!” 지도 한 장만 남긴 채 감쪽같이 사라져 버린 ‘루시’ 숙모를 찾아 떠난 ‘패딩턴’과 브라운 가족은 페루의 정글을 둘러싼 비밀을 찾아 모험을 떠나게 되는데… https://justwatch.pro/movie/516729/paddington-in-peru',425.621,'/1rfxGlRaFe8bqKOtebXl2CFel8F.jpg','2024-11-08',106,'패딩턴: 페루에 가다!',6.8),(549509,'/iKXXPYBWQ0B6BMRHAFbg3wKafWb.jpg','전쟁의 상흔을 뒤로하고 미국에 정착한 건축가 라즐로 토스. 미국 이민자의 냉혹한 현실 속에 전쟁의 트라우마를 견뎌내던 어느 날. 라즐로의 천재성을 알아본 부유한 사업가 해리슨이 기념비적인 건축물 설계를 제안한다. 하지만, 시대와 공간, 빛의 경계를 넘어 대담하고 혁신적인 그의 건축 설계는 사람들의 공감을 얻지 못하고 반대에 부딪히게 된다. 후원자 해리슨의 감시와 압박, 주변의 비난이 거세질수록 오히려 더 자신의 설계에 집착하던 라즐로. 혁신적인 브루탈리즘 건축에 자신을 투영하던 라즐로는 결국 공사가 중단될 위기에 처하는데...',1065.25,'/dKFjxIZ6tPAUQInMKZCE3BfcrO2.jpg','2024-12-20',215,'브루탈리스트',7.1),(604685,'/mKIxSo3p1QKlsdegcOwapcbiV74.jpg','빅 닉(Big Nick)이 유럽에서 다시 추적을 시작하며, 거대한 다이아몬드 거래소를 털려는 거대한 강도 계획에 연루된 도니(Donnie)를 쫓는다. 도니는 위험하고 예측할 수 없는 다이아몬드 도둑들의 세계와 악명 높은 팬서 마피아(Panther Mafia) 속에서 살아남기 위해 몸부림친다.',191.886,'/t4xbJSo5FflDCHTo2iEUG2TO0V2.jpg','2025-01-08',144,'크리미널 스쿼드 2: 판테라',6.7),(696506,'/2P0PUkQ1tNHNYTEmtbBmM8MfXBG.jpg','친구 티모와 함께 차린 마카롱 가게가 쫄딱 망해 거액의 빚을 지고 못 갚으면 죽이겠다는 사채업자를 피해 지구를 떠나야 하는 미키. 기술이 없는 그는, 정치인 마셜의 얼음행성 개척단에서 위험한 일을 도맡고, 죽으면 다시 프린트되는 익스펜더블로 지원한다. 4년의 항해와 얼음행성 니플하임에 도착한 뒤에도 늘 미키를 지켜준 여자친구 나샤. 그와 함께, 미키는 반복되는 죽음과 출력의 사이클에도 익숙해진다. 그러나 미키 17이 얼음행성의 생명체인 크리퍼와 만난 후 죽을 위기에서 돌아와 보니 이미 미키 18이 프린트되어 있다. 행성 당 1명만 허용된 익스펜더블이 둘이 된 멀티플 상황. 둘 중 하나는 죽어야 하는 현실 속에 걷잡을 수 없는 사건이 기다리고 있었으니…',423.368,'/7KghOYtsxFquUuw4THbARsSEo6g.jpg','2025-02-28',137,'미키 17',7.7),(710295,'/nNF4ZB0UDL4qAUjQfbYZDq3Ck7J.jpg','세상을 떠난 아버지의 짐을 정리하기 위해 사랑하는 아내 ‘샬롯’, 딸 ‘진저’와 함께 어릴 적 고향 집을 방문하기로 한 ‘블레이크’. 늦은 밤, 깊은 숲 속에 위치한 고향 집에 다다를 무렵 정체 모를 존재와 맞닥뜨린 ‘블레이크’는 가족을 지키려다 공격을 당한다. 가까스로 몸을 숨긴 이들에게 위협은 계속되고 설상가상으로 ‘블레이크’가 원인 모를 병에 감염돼 변하기 시작하면서 모두를 위험에 빠트리는데…',363.204,'/g7uNXsPA4Z0oLsvOQ6Gbc0sE19G.jpg','2025-01-15',103,'울프맨',6.5),(774370,'/iXU87IdtNsYt7n6OigPJBDdbFf1.jpg','\"반쪽은 개, 반쪽은 인간, 그야말로 영웅의 탄생!\"\r 한 경찰견과 그의 파트너인 경찰관이 함께 부상당한 후, 기적 같은 수술로 하나가 되어 \'도그맨\'이 탄생한다. 이제 도그맨은 그의 새로운 정체성을 받아들이며, 도시를 지키기 위해 애쓴다. 하지만 도시를 위협하는 악당, 페티 더 캣과의 싸움에서 도그맨의 진정한 힘이 시험받게 되는데...',722.633,'/89wNiexZdvLQ41OQWIsQy4O6jAQ.jpg','2025-01-24',89,'도그맨',7.7),(799766,'/3QeuagbU1YARTkGrPS4dvYSQGZi.jpg','',230.269,'/fbGCmMp0HlYnAPv28GOENPShezM.jpg','2024-12-06',136,'베러맨',7.648),(823219,'/b3mdmjYTEL70j7nuXATUAD9qgu4.jpg','인간이 살았던 흔적만이 남아있는 세상, 홀로 집을 지키던 \'고양이\'는 갑작스러운 대홍수로 평화롭던 일상과 아늑했던 터전을 잃고 만다. 때마침 다가온 낡은 배에 올라탄 \'고양이\'는 그 안에서 \'골든 리트리버\', \'카피바라\', \'여우원숭이\', \'뱀잡이수리\'를 만나고 서로의 차이점을 극복하고 팀을 이뤄 험난한 파도를 헤쳐나간다.',885.787,'/8ntMUYy0b0NIGWSWvMr07ui7CCJ.jpg','2024-08-29',85,'플로우',8.303),(974576,'/tkRDTu9hyWgaBSSzfkYDCZYd1kV.jpg','교황의 예기치 못한 죽음 이후 새로운 교황을 선출하는 콘클라베가 시작되고, 로렌스는 단장으로서 선거를 총괄하게 된다. 한편 당선에 유력했던 후보들이 스캔들에 휘말리면서 교활한 음모와 탐욕이 수면 위로 드러나는데…',705.54,'/aPPUy4JBYrJeRlQwMxdKwa3Ozkd.jpg','2024-10-25',120,'콘클라베',7.141),(974950,'/u2eA9pqi1q3DvevT7RuDuJHxxBT.jpg','능력 있는 변호사 \'리타\'는 \'큰돈을 벌게 해주겠다\'는 비밀 의뢰를 받고 멕시코 카르텔의 수장 \'델 몬테\'를 만나러 간다. 그의 요청은 놀랍게도 \"자신을 여자로 다시 태어나게 해달라는 것. 아내도 모르게 새로운 삶을 살 수 있게 세팅하라는 것.\" 얼마 뒤, 새로운 그녀 ‘에밀리아 페레즈’가 나타나면서 모두의 인생에 2막이 오른다.',393.985,'/t1XuL5308zcEGjeeN2wzsqlwSDR.jpg','2024-08-21',130,'에밀리아 페레즈',6.8),(978796,'/gmYpUbSGOwmZnevCr0iwLEYdpVB.jpg','',179.579,'/53IK9rlZJbwFYbNnJZiLq7UWxkT.jpg','2024-09-20',92,'백맨',6.3),(980477,'/zxi6WQPVc0uQAG5TtLsKvxYHApC.jpg','\"그가 돌아왔다, 더욱 강력해진 영웅의 전설\"\r 천계의 시련 이후, 혼은 유지했으나 육신이 소멸 위기에 처한 나타와 오병. 태을진인은 일곱 빛깔의 보련으로 그들의 육신을 재건하려 하지만, 과정은 순탄치 않다. 신공표는 심해에 갇혀 있던 사룡왕을 해방시키고, 동해의 용왕 오광은 \"내가 전쟁에 나서면, 천당관은 남김없이 파괴될 것이다\"라고 선언한다. 나타는 천당관을 지키기 위해 사해의 용왕들과 맞서 싸우게 되는데...',226.098,'/bTMf8M7rZ21fChGdtsZtJj4Dfqh.jpg','2025-01-29',144,'나타지마동요해',7.7),(1000837,'/j9uruwRe9qM8RnP758dF7ISB8Bj.jpg','\"그녀의 목소리, 침묵 속에서 울려퍼지다\"\r 1970년대 브라질 군사 독재 시절, 변호사이자 정치 활동가인 유니스 파이바(페르난다 토레스 분)는 남편인 루벤스 파이바(셀튼 멜로 분)의 실종 이후 홀로 남겨진다. 남편의 부재 속에서도 그녀는 가족을 지키기 위해 고군분투하며, 진실을 밝히기 위한 여정을 시작한다. 억압과 두려움이 가득한 시대 속에서 유니스는 용기와 결단력으로 맞서게 되는데...',327.782,'/zNAw7jK8bwCK56rIW676pdgkwhd.jpg','2024-09-19',138,'아임 스틸 히어',7.9),(1043905,'/dWkdmxIkH9y23s9v1PjQFhTGIwo.jpg','2021년 미국의 아프가니스탄 철군 당시, 의료 구호 팀으로 위장한 여성 군인들이 납치된 십대 소년·소녀들을 구출하기 위해 다시 투입된다. 이들은 ISIS와 탈레반 사이에 갇힌 피해자들을 구출하는 임무를 맡는다.',318.044,'/3O3qSGmjRGc10hMwFul8WDxKE5t.jpg','2024-12-11',104,'더티 엔젤스',6.193),(1084199,'/sc1abgWNXc29wSBaerrjGBih06l.jpg','서로에게 딱 맞는 커플 ‘아이리스’와 ‘조시’는 친구들과 함께 호숫가의 별장으로 호화로운 휴가를 떠난다. 하지만 그곳에는 충격적인 사건이 기다리고 있는데…',1222.243,'/dq7CEYFCvQPfYIpAXOvJr3w6VLY.jpg','2025-01-22',97,'컴패니언',7.067),(1124620,'/6dC7ULfiutxwEAs7LjWHL2Tc7Zv.jpg','',268.742,'/yYa8Onk9ow7ukcnfp2QWVvjWYel.jpg','2025-02-14',98,'더 몽키',5.957),(1126166,'/gFFqWsjLjRfipKzlzaYPD097FNC.jpg','미셸 도커리가 연기하는 부지런한 미국 연방보호관 매들린 해리스는 마피아 조직의 회계사였던 윈스턴(토퍼 그레이스)을 증인 보호 프로그램으로 이송하는 임무를 맡게 된다. 그들은 알래스카의 황량한 설원을 가로지르는 작은 비행기에 탑승하며, 이 비행기의 조종사는 다릴 부스(마크 월버그)다. 그러나 비행 도중, 이들이 탑승한 비행기는 예상치 못한 위험에 직면하게 되고, 매들린은 조종사와 승객들의 숨겨진 의도를 의심하게 된다. 한정된 공간에서 긴장감이 고조되는 가운데, 매들린은 비행기의 조종을 직접 맡아야 하는 상황에 이르게 되는데...',2568.332,'/zstC9sgsPaV98TaZtHL6aTtBUtB.jpg','2025-01-22',91,'플라이트 리스크',6.053),(1138194,'/ag66gJCiZ06q1GSJuQlhGLi3Udx.jpg','요청을 받고 선교를 위해 낯선 남자의 집을 방문한 두 명의 젊은 여성 선교사가 이상함을 느끼고 그 집에서 벗어나려고 하면서 일어나는 일들을 그린 극영화',252.726,'/fr96XzlzsONrQrGfdLMiwtQjott.jpg','2024-10-31',111,'헤레틱',7.162),(1182387,'/evFChfYeD2LqobEJf8iQsrYcGTw.jpg','무장강도단 VS 철갑 현금수송차. 치밀한 계획의 현금 탈취 프로젝트가 가동된다. 전직 경찰 부자가 운전하는 현금수송차가 다리 위에서 습격을 받고 완전 포위된다. 철갑수송차를 뚫으려는 무장강도단과 지키려는 부자의 막다른 대결이 시작된다.',147.943,'/25ii5T20EyAkuNNqoZzVJiEEzZY.jpg','2024-10-30',89,'아머: 현금수송차',5.5);
/*!40000 ALTER TABLE `upcoming_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upcoming_movie_genres`
--

DROP TABLE IF EXISTS `upcoming_movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upcoming_movie_genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `movie_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7pgsm241gqjxt7brgdo27tr2l` (`movie_id`),
  CONSTRAINT `FK7pgsm241gqjxt7brgdo27tr2l` FOREIGN KEY (`movie_id`) REFERENCES `upcoming_movie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upcoming_movie_genres`
--

LOCK TABLES `upcoming_movie_genres` WRITE;
/*!40000 ALTER TABLE `upcoming_movie_genres` DISABLE KEYS */;
INSERT INTO `upcoming_movie_genres` VALUES (12,'모험',980477),(14,'판타지',980477),(16,'애니메이션',980477),(18,'드라마',1182387),(27,'공포',978796),(28,'액션',1182387),(35,'코미디',1124620),(36,'역사',1000837),(53,'스릴러',978796),(80,'범죄',1182387),(878,'SF',696506),(10402,'음악',799766),(10749,'로맨스',402431),(10751,'가족',516729),(10752,'전쟁',1043905);
/*!40000 ALTER TABLE `upcoming_movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_genres`
--

DROP TABLE IF EXISTS `user_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_genres` (
  `user_id` bigint(20) NOT NULL,
  `genre` varchar(255) DEFAULT NULL,
  KEY `FKmwqpompk5ps1c2gi0569f8mle` (`user_id`),
  CONSTRAINT `FKmwqpompk5ps1c2gi0569f8mle` FOREIGN KEY (`user_id`) REFERENCES `users` (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_genres`
--

LOCK TABLES `user_genres` WRITE;
/*!40000 ALTER TABLE `user_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `mem_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mem_email` varchar(255) NOT NULL,
  `mem_name` varchar(255) DEFAULT NULL,
  `mem_nickname` varchar(255) NOT NULL,
  `mem_pw` varchar(255) DEFAULT NULL,
  `mem_register_datetime` datetime(6) NOT NULL,
  `mem_sex` varchar(255) DEFAULT NULL,
  `mem_type` varchar(255) NOT NULL,
  PRIMARY KEY (`mem_id`),
  UNIQUE KEY `UKqfv0skp9kubqtq4oiey0bcgnk` (`mem_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2025-03-04 22:03:37
