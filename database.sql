-- MySQL dump 10.13  Distrib 8.0.40, for macos12.7 (arm64)
--
-- Host: 127.0.0.1    Database: ritmize_lms
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `data_matricula` date DEFAULT NULL,
  `senha` varchar(255) NOT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `status` enum('ativo','inativo','suspenso') DEFAULT 'ativo',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES (1,'João Silvaa','joao@exemplo.com','(11) 99999-9999','1995-05-15','2025-01-15','senha123','joao-profile.png','ativo','2025-06-02 19:36:04','2025-07-02 19:14:53'),(2,'Maria Santos','maria@exemplo.com','(11) 88888-8888','1990-03-20','2025-02-01','senha123',NULL,'ativo','2025-06-02 19:36:04','2025-06-02 19:36:04'),(3,'Pedro Costa','pedro@exemplo.com','(11) 77777-7777','2000-12-10','2025-03-10','senha123',NULL,'ativo','2025-06-02 19:36:04','2025-06-02 19:36:04');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aulas`
--

DROP TABLE IF EXISTS `aulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aulas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `descricao` text,
  `data_aula` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  `instrutor` varchar(100) NOT NULL,
  `sala` varchar(50) DEFAULT NULL,
  `max_alunos` int DEFAULT '15',
  `tipo_aula` enum('individual','grupo','masterclass') DEFAULT 'grupo',
  `nivel` enum('iniciante','intermediario','avancado') DEFAULT 'iniciante',
  `status` enum('agendada','em_andamento','concluida','cancelada') DEFAULT 'agendada',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aulas`
--

LOCK TABLES `aulas` WRITE;
/*!40000 ALTER TABLE `aulas` DISABLE KEYS */;
INSERT INTO `aulas` VALUES (1,'Ritmos Básicos','Introdução aos ritmos fundamentais da percussão','2025-06-03','19:00:00','20:30:00','Prof. Carlos','Sala 1',15,'grupo','iniciante','agendada','2025-06-02 18:44:34','2025-06-02 18:44:34'),(2,'Samba e Bossa Nova','Técnicas avançadas de samba e bossa nova','2025-06-04','20:00:00','21:30:00','Prof. Ana','Sala 2',15,'grupo','intermediario','agendada','2025-06-02 18:44:34','2025-06-02 18:44:34'),(3,'Masterclass Jazz','Workshop intensivo de percussão no jazz','2025-06-05','18:00:00','20:00:00','Prof. Roberto','Auditório',15,'masterclass','avancado','agendada','2025-06-02 18:44:34','2025-06-02 18:44:34');
/*!40000 ALTER TABLE `aulas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscricoes`
--

DROP TABLE IF EXISTS `inscricoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscricoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aluno_id` int NOT NULL,
  `turma_id` int NOT NULL,
  `data_inscricao` date NOT NULL,
  `status` enum('ativa','cancelada') DEFAULT 'ativa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_inscricao` (`aluno_id`,`turma_id`),
  KEY `turma_id` (`turma_id`),
  CONSTRAINT `inscricoes_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inscricoes_ibfk_2` FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscricoes`
--

LOCK TABLES `inscricoes` WRITE;
/*!40000 ALTER TABLE `inscricoes` DISABLE KEYS */;
INSERT INTO `inscricoes` VALUES (1,1,1,'2025-01-15','ativa','2025-06-02 19:36:04'),(2,1,2,'2025-01-15','ativa','2025-06-02 19:36:04'),(3,2,2,'2025-02-01','ativa','2025-06-02 19:36:04'),(4,2,3,'2025-02-01','ativa','2025-06-02 19:36:04'),(5,3,1,'2025-03-10','ativa','2025-06-02 19:36:04');
/*!40000 ALTER TABLE `inscricoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensalidades`
--

DROP TABLE IF EXISTS `mensalidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensalidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aluno_id` int NOT NULL,
  `mes_referencia` date NOT NULL,
  `valor_bruto` decimal(8,2) NOT NULL,
  `desconto` decimal(8,2) DEFAULT '0.00',
  `valor_final` decimal(8,2) NOT NULL,
  `data_vencimento` date NOT NULL,
  `data_pagamento` date DEFAULT NULL,
  `status` enum('pendente','pago','atrasado','cancelado') DEFAULT 'pendente',
  `forma_pagamento` enum('dinheiro','pix','cartao','transferencia') DEFAULT NULL,
  `observacoes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `aluno_id` (`aluno_id`),
  CONSTRAINT `mensalidades_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensalidades`
--

LOCK TABLES `mensalidades` WRITE;
/*!40000 ALTER TABLE `mensalidades` DISABLE KEYS */;
INSERT INTO `mensalidades` VALUES (1,1,'2025-06-01',80.00,10.00,75.00,'2025-06-10','2025-06-08','pago','cartao',NULL,'2025-06-02 19:44:25','2025-07-07 19:03:14'),(2,1,'2025-07-01',80.00,10.00,70.00,'2025-07-10',NULL,'pendente',NULL,NULL,'2025-06-02 19:44:25','2025-06-02 19:44:25'),(3,2,'2025-06-01',80.00,10.00,70.00,'2025-06-10','2025-06-05','pago','cartao',NULL,'2025-06-02 19:44:25','2025-06-02 19:44:25'),(4,2,'2025-07-01',80.00,10.00,70.00,'2025-07-10',NULL,'pendente',NULL,NULL,'2025-06-02 19:44:25','2025-06-02 19:44:25'),(5,3,'2025-06-01',40.00,0.00,40.00,'2025-06-10',NULL,'atrasado',NULL,NULL,'2025-06-02 19:44:25','2025-06-02 19:44:25');
/*!40000 ALTER TABLE `mensalidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensalidades_turmas`
--

DROP TABLE IF EXISTS `mensalidades_turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensalidades_turmas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mensalidade_id` int NOT NULL,
  `turma_id` int NOT NULL,
  `valor_turma` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mensalidade_id` (`mensalidade_id`),
  KEY `turma_id` (`turma_id`),
  CONSTRAINT `mensalidades_turmas_ibfk_1` FOREIGN KEY (`mensalidade_id`) REFERENCES `mensalidades` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mensalidades_turmas_ibfk_2` FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensalidades_turmas`
--

LOCK TABLES `mensalidades_turmas` WRITE;
/*!40000 ALTER TABLE `mensalidades_turmas` DISABLE KEYS */;
INSERT INTO `mensalidades_turmas` VALUES (1,1,1,40.00),(2,1,2,40.00),(3,2,1,40.00),(4,2,2,40.00),(5,3,2,40.00),(6,3,3,40.00),(7,4,2,40.00),(8,4,3,40.00),(9,5,1,40.00);
/*!40000 ALTER TABLE `mensalidades_turmas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacoes`
--

DROP TABLE IF EXISTS `notificacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `texto` text NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date DEFAULT NULL,
  `tipo` enum('apresentacao','geral','individual') DEFAULT 'geral',
  `aluno_id` int DEFAULT NULL,
  `visualizada` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `aluno_id` (`aluno_id`),
  CONSTRAINT `notificacoes_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacoes`
--

LOCK TABLES `notificacoes` WRITE;
/*!40000 ALTER TABLE `notificacoes` DISABLE KEYS */;
INSERT INTO `notificacoes` VALUES (1,'Apresentação Patú Sambá','Mais um ciclo está chegando ao fim, e com ele, mais uma formatura! Se prepare, pois a próxima será \r\nTer, 10/04/2025. Já prepare sua camiseta e seu patuá, pois a noite será linda!','formatura-1.png','2025-06-01','2025-09-15','apresentacao',NULL,0,'2025-06-02 19:44:25'),(2,'Atraso na mensalidade','A sua mensalidade venceu Ter, 10/04/2025. Por favor, clique aqui para fazer o pagamento e não sair do ritmo.','instruments-1.png','2025-06-20','2025-08-20','apresentacao',NULL,0,'2025-06-02 19:44:25');
/*!40000 ALTER TABLE `notificacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presencas`
--

DROP TABLE IF EXISTS `presencas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presencas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aluno_id` int NOT NULL,
  `turma_id` int NOT NULL,
  `data_aula` date NOT NULL,
  `presente` tinyint(1) DEFAULT '0',
  `observacoes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_presenca` (`aluno_id`,`turma_id`,`data_aula`),
  KEY `turma_id` (`turma_id`),
  CONSTRAINT `presencas_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `presencas_ibfk_2` FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presencas`
--

LOCK TABLES `presencas` WRITE;
/*!40000 ALTER TABLE `presencas` DISABLE KEYS */;
INSERT INTO `presencas` VALUES (1,1,1,'2025-06-03',1,NULL,'2025-06-02 19:36:04'),(2,1,1,'2025-06-10',0,NULL,'2025-06-02 19:36:04'),(3,1,2,'2025-06-05',1,NULL,'2025-06-02 19:36:04'),(4,2,2,'2025-06-05',1,NULL,'2025-06-02 19:36:04'),(5,2,3,'2025-06-06',0,NULL,'2025-06-02 19:36:04'),(6,3,1,'2025-06-03',0,NULL,'2025-06-02 19:36:04');
/*!40000 ALTER TABLE `presencas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turmas`
--

DROP TABLE IF EXISTS `turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turmas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `dia_semana` tinyint NOT NULL,
  `horario_inicio` time NOT NULL,
  `horario_fim` time NOT NULL,
  `valor_mensal` decimal(8,2) NOT NULL,
  `ciclo_meses` int NOT NULL,
  `descricao` text,
  `data_inicio` date NOT NULL,
  `status` enum('ativa','inativa') DEFAULT 'ativa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turmas`
--

LOCK TABLES `turmas` WRITE;
/*!40000 ALTER TABLE `turmas` DISABLE KEYS */;
INSERT INTO `turmas` VALUES (1,'Patú Sambá Turma 1',3,'19:00:00','20:30:00',40.00,3,'Workshop de percussão com foco em ritmos de samba','2025-01-07','ativa','2025-06-02 19:36:04','2025-06-02 19:36:04'),(2,'Secretinho',5,'20:00:00','21:30:00',40.00,12,'Técnicas avançadas de percussão brasileira','2025-01-09','ativa','2025-06-02 19:36:04','2025-06-02 19:36:04'),(3,'Patú Sambá Turma 2',6,'18:00:00','19:30:00',40.00,3,'Workshop de percussão - turma avançada','2025-01-10','ativa','2025-06-02 19:36:04','2025-06-02 19:36:04');
/*!40000 ALTER TABLE `turmas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-09 19:20:24
