-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `armas`
--

DROP TABLE IF EXISTS `armas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `armas` (
  `idArmas` int NOT NULL,
  `Tipo Armas_idTipo Armas` int NOT NULL,
  `Preço de Compra` varchar(45) DEFAULT NULL,
  `Preço de Venda` varchar(45) DEFAULT NULL,
  `Peso` varchar(45) DEFAULT NULL,
  `Ataque` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idArmas`,`Tipo Armas_idTipo Armas`),
  KEY `fk_Armas_Tipo Armas1_idx` (`Tipo Armas_idTipo Armas`),
  CONSTRAINT `fk_Armas_Tipo Armas1` FOREIGN KEY (`Tipo Armas_idTipo Armas`) REFERENCES `tipo armas` (`idTipo Armas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armas`
--

LOCK TABLES `armas` WRITE;
/*!40000 ALTER TABLE `armas` DISABLE KEYS */;
/*!40000 ALTER TABLE `armas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atributos`
--

DROP TABLE IF EXISTS `atributos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atributos` (
  `Personagem_idPersonagem` int NOT NULL,
  `Personagem_Conta_idConta` int NOT NULL,
  `Ataque` int NOT NULL,
  `Defesa` int NOT NULL,
  `Destreza` int NOT NULL,
  `Sorte` int NOT NULL,
  `Carisma` int NOT NULL,
  `Velocidade` int NOT NULL,
  PRIMARY KEY (`Personagem_idPersonagem`,`Personagem_Conta_idConta`),
  KEY `fk_Atributos_Personagem1_idx` (`Personagem_idPersonagem`,`Personagem_Conta_idConta`),
  CONSTRAINT `fk_Atributos_Personagem1` FOREIGN KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`) REFERENCES `personagem` (`idPersonagem`, `Conta_idConta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atributos`
--

LOCK TABLES `atributos` WRITE;
/*!40000 ALTER TABLE `atributos` DISABLE KEYS */;
/*!40000 ALTER TABLE `atributos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conta`
--

DROP TABLE IF EXISTS `conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conta` (
  `idConta` int NOT NULL,
  `Usuário` varchar(45) NOT NULL,
  `Senha` varchar(45) NOT NULL,
  `E-mail` varchar(45) NOT NULL,
  `Data de Criação` date NOT NULL,
  `Pergunta de Segurança_idPergunta de Segurança` int NOT NULL,
  `Resposta de Segurança` varchar(45) NOT NULL,
  PRIMARY KEY (`idConta`),
  UNIQUE KEY `idConta_UNIQUE` (`idConta`),
  UNIQUE KEY `Usuário_UNIQUE` (`Usuário`),
  UNIQUE KEY `E-mail_UNIQUE` (`E-mail`),
  KEY `fk_Conta_Pergunta de Segurança1_idx` (`Pergunta de Segurança_idPergunta de Segurança`),
  CONSTRAINT `fk_Conta_Pergunta de Segurança1` FOREIGN KEY (`Pergunta de Segurança_idPergunta de Segurança`) REFERENCES `pergunta de segurança` (`idPergunta de Segurança`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conta`
--

LOCK TABLES `conta` WRITE;
/*!40000 ALTER TABLE `conta` DISABLE KEYS */;
/*!40000 ALTER TABLE `conta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordenada`
--

DROP TABLE IF EXISTS `coordenada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordenada` (
  `Mapa_idMapa` int NOT NULL,
  `Linha` varchar(45) NOT NULL,
  `Coluna` varchar(45) NOT NULL,
  `Tipo_idTipo` int NOT NULL,
  PRIMARY KEY (`Mapa_idMapa`,`Linha`,`Coluna`,`Tipo_idTipo`),
  KEY `fk_Coordenada_Mapa1_idx` (`Mapa_idMapa`),
  KEY `fk_Coordenada_Tipo1_idx` (`Tipo_idTipo`),
  CONSTRAINT `fk_Coordenada_Mapa1` FOREIGN KEY (`Mapa_idMapa`) REFERENCES `mapa` (`idMapa`),
  CONSTRAINT `fk_Coordenada_Tipo1` FOREIGN KEY (`Tipo_idTipo`) REFERENCES `tipo` (`idTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordenada`
--

LOCK TABLES `coordenada` WRITE;
/*!40000 ALTER TABLE `coordenada` DISABLE KEYS */;
/*!40000 ALTER TABLE `coordenada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipado`
--

DROP TABLE IF EXISTS `equipado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipado` (
  `Personagem_idPersonagem` int NOT NULL,
  `Personagem_Conta_idConta` int NOT NULL,
  `Navio_idNavio` int NOT NULL,
  `Equipamento_idEquipamento (Capacete)` int NOT NULL,
  `Equipamento_idEquipamento (Armadura)` int NOT NULL,
  `Equipamento_idEquipamento (Botas)` int NOT NULL,
  `Armas_idArmas (Espada)` int NOT NULL,
  `Armas_idArmas (Pistola)` int NOT NULL,
  PRIMARY KEY (`Personagem_idPersonagem`,`Personagem_Conta_idConta`),
  KEY `fk_Equipado_Navio1_idx` (`Navio_idNavio`),
  KEY `fk_Equipado_Equipamento1_idx` (`Equipamento_idEquipamento (Capacete)`),
  KEY `fk_Equipado_Equipamento2_idx` (`Equipamento_idEquipamento (Armadura)`),
  KEY `fk_Equipado_Equipamento3_idx` (`Equipamento_idEquipamento (Botas)`),
  KEY `fk_Equipado_Armas1_idx` (`Armas_idArmas (Espada)`),
  KEY `fk_Equipado_Armas2_idx` (`Armas_idArmas (Pistola)`),
  CONSTRAINT `fk_Equipado_Armas1` FOREIGN KEY (`Armas_idArmas (Espada)`) REFERENCES `armas` (`idArmas`),
  CONSTRAINT `fk_Equipado_Armas2` FOREIGN KEY (`Armas_idArmas (Pistola)`) REFERENCES `armas` (`idArmas`),
  CONSTRAINT `fk_Equipado_Equipamento1` FOREIGN KEY (`Equipamento_idEquipamento (Capacete)`) REFERENCES `equipamento` (`idEquipamento`),
  CONSTRAINT `fk_Equipado_Equipamento2` FOREIGN KEY (`Equipamento_idEquipamento (Armadura)`) REFERENCES `equipamento` (`idEquipamento`),
  CONSTRAINT `fk_Equipado_Equipamento3` FOREIGN KEY (`Equipamento_idEquipamento (Botas)`) REFERENCES `equipamento` (`idEquipamento`),
  CONSTRAINT `fk_Equipado_Navio1` FOREIGN KEY (`Navio_idNavio`) REFERENCES `navio` (`idNavio`),
  CONSTRAINT `fk_Equipado_Personagem1` FOREIGN KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`) REFERENCES `personagem` (`idPersonagem`, `Conta_idConta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipado`
--

LOCK TABLES `equipado` WRITE;
/*!40000 ALTER TABLE `equipado` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipamento`
--

DROP TABLE IF EXISTS `equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipamento` (
  `idEquipamento` int NOT NULL,
  `Nome E` varchar(45) DEFAULT NULL,
  `Peso E` varchar(45) DEFAULT NULL,
  `Preço de Compra E` varchar(45) DEFAULT NULL,
  `Preço de Venta E` varchar(45) DEFAULT NULL,
  `Tipo Equip_idTipo Equip` int NOT NULL,
  `Defesa E` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEquipamento`),
  KEY `fk_Equipamento_Tipo Equip1_idx` (`Tipo Equip_idTipo Equip`),
  CONSTRAINT `fk_Equipamento_Tipo Equip1` FOREIGN KEY (`Tipo Equip_idTipo Equip`) REFERENCES `tipo equip` (`idTipo Equip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipamento`
--

LOCK TABLES `equipamento` WRITE;
/*!40000 ALTER TABLE `equipamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `idEvento` int NOT NULL,
  `Tipo_idTipo` int NOT NULL,
  `Amigavel` tinyint NOT NULL,
  PRIMARY KEY (`idEvento`,`Tipo_idTipo`),
  KEY `fk_Evento_Tipo1_idx` (`Tipo_idTipo`),
  CONSTRAINT `fk_Evento_Tipo1` FOREIGN KEY (`Tipo_idTipo`) REFERENCES `tipo` (`idTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guilda`
--

DROP TABLE IF EXISTS `guilda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guilda` (
  `idGuilda` int NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Nível` varchar(45) NOT NULL,
  `Experiência` varchar(45) NOT NULL,
  `Sigla` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idGuilda`),
  UNIQUE KEY `idGuilda_UNIQUE` (`idGuilda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guilda`
--

LOCK TABLES `guilda` WRITE;
/*!40000 ALTER TABLE `guilda` DISABLE KEYS */;
/*!40000 ALTER TABLE `guilda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario tem equipamento`
--

DROP TABLE IF EXISTS `inventario tem equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario tem equipamento` (
  `Inventário_Personagem_Conta_idConta` int NOT NULL,
  `Inventário_Personagem_idPersonagem` int NOT NULL,
  `Equipamento_idEquipamento` int NOT NULL,
  `Quantidade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Inventário_Personagem_Conta_idConta`,`Inventário_Personagem_idPersonagem`,`Equipamento_idEquipamento`),
  KEY `fk_Inventário_has_Equipamento_Equipamento1_idx` (`Equipamento_idEquipamento`),
  KEY `fk_Inventário_has_Equipamento_Inventário1_idx` (`Inventário_Personagem_Conta_idConta`,`Inventário_Personagem_idPersonagem`),
  CONSTRAINT `fk_Inventário_has_Equipamento_Equipamento1` FOREIGN KEY (`Equipamento_idEquipamento`) REFERENCES `equipamento` (`idEquipamento`),
  CONSTRAINT `fk_Inventário_has_Equipamento_Inventário1` FOREIGN KEY (`Inventário_Personagem_Conta_idConta`, `Inventário_Personagem_idPersonagem`) REFERENCES `inventário` (`Personagem_Conta_idConta`, `Personagem_idPersonagem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario tem equipamento`
--

LOCK TABLES `inventario tem equipamento` WRITE;
/*!40000 ALTER TABLE `inventario tem equipamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario tem equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventário`
--

DROP TABLE IF EXISTS `inventário`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventário` (
  `Personagem_idPersonagem` int NOT NULL,
  `Personagem_Conta_idConta` int NOT NULL,
  `Peso Total` varchar(45) NOT NULL,
  PRIMARY KEY (`Personagem_Conta_idConta`,`Personagem_idPersonagem`),
  KEY `fk_Inventário_Personagem1_idx` (`Personagem_idPersonagem`,`Personagem_Conta_idConta`),
  CONSTRAINT `fk_Inventário_Personagem1` FOREIGN KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`) REFERENCES `personagem` (`idPersonagem`, `Conta_idConta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventário`
--

LOCK TABLES `inventário` WRITE;
/*!40000 ALTER TABLE `inventário` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventário` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventário tem armas`
--

DROP TABLE IF EXISTS `inventário tem armas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventário tem armas` (
  `idConta` int NOT NULL,
  `idPersonagem` int NOT NULL,
  `idArmas` int NOT NULL,
  `Quantidade` int DEFAULT NULL,
  PRIMARY KEY (`idConta`,`idPersonagem`,`idArmas`),
  KEY `fk_Inventário_has_Armas_Armas1_idx` (`idArmas`),
  KEY `fk_Inventário_has_Armas_Inventário1_idx` (`idConta`,`idPersonagem`),
  CONSTRAINT `fk_Inventário_has_Armas_Armas1` FOREIGN KEY (`idArmas`) REFERENCES `armas` (`idArmas`),
  CONSTRAINT `fk_Inventário_has_Armas_Inventário1` FOREIGN KEY (`idConta`, `idPersonagem`) REFERENCES `inventário` (`Personagem_Conta_idConta`, `Personagem_idPersonagem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventário tem armas`
--

LOCK TABLES `inventário tem armas` WRITE;
/*!40000 ALTER TABLE `inventário tem armas` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventário tem armas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventário tem item`
--

DROP TABLE IF EXISTS `inventário tem item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventário tem item` (
  `Inventário_Personagem_Conta_idConta` int NOT NULL,
  `Inventário_Personagem_idPersonagem` int NOT NULL,
  `Item_idItem` int NOT NULL,
  `Quantidade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Inventário_Personagem_Conta_idConta`,`Inventário_Personagem_idPersonagem`,`Item_idItem`),
  KEY `fk_Inventário_has_Item_Item1_idx` (`Item_idItem`),
  KEY `fk_Inventário_has_Item_Inventário1_idx` (`Inventário_Personagem_Conta_idConta`,`Inventário_Personagem_idPersonagem`),
  CONSTRAINT `fk_Inventário_has_Item_Inventário1` FOREIGN KEY (`Inventário_Personagem_Conta_idConta`, `Inventário_Personagem_idPersonagem`) REFERENCES `inventário` (`Personagem_Conta_idConta`, `Personagem_idPersonagem`),
  CONSTRAINT `fk_Inventário_has_Item_Item1` FOREIGN KEY (`Item_idItem`) REFERENCES `item` (`idItem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventário tem item`
--

LOCK TABLES `inventário tem item` WRITE;
/*!40000 ALTER TABLE `inventário tem item` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventário tem item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventário tem peixe`
--

DROP TABLE IF EXISTS `inventário tem peixe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventário tem peixe` (
  `Inventário_Personagem_Conta_idConta` int NOT NULL,
  `Inventário_Personagem_idPersonagem` int NOT NULL,
  `Peixe_idPeixe` int NOT NULL,
  `Quantidade` int NOT NULL,
  PRIMARY KEY (`Inventário_Personagem_Conta_idConta`,`Inventário_Personagem_idPersonagem`,`Peixe_idPeixe`),
  KEY `fk_Inventário_has_Peixe_Peixe1_idx` (`Peixe_idPeixe`),
  KEY `fk_Inventário_has_Peixe_Inventário1_idx` (`Inventário_Personagem_Conta_idConta`,`Inventário_Personagem_idPersonagem`),
  CONSTRAINT `fk_Inventário_has_Peixe_Inventário1` FOREIGN KEY (`Inventário_Personagem_Conta_idConta`, `Inventário_Personagem_idPersonagem`) REFERENCES `inventário` (`Personagem_Conta_idConta`, `Personagem_idPersonagem`),
  CONSTRAINT `fk_Inventário_has_Peixe_Peixe1` FOREIGN KEY (`Peixe_idPeixe`) REFERENCES `peixe` (`idPeixe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventário tem peixe`
--

LOCK TABLES `inventário tem peixe` WRITE;
/*!40000 ALTER TABLE `inventário tem peixe` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventário tem peixe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `idItem` int NOT NULL,
  `Nome I` varchar(45) NOT NULL,
  `Peso` varchar(45) NOT NULL,
  `Preço de Compra` varchar(45) NOT NULL,
  `Preço de Venda` varchar(45) NOT NULL,
  PRIMARY KEY (`idItem`),
  UNIQUE KEY `idItem_UNIQUE` (`idItem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mapa`
--

DROP TABLE IF EXISTS `mapa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mapa` (
  `idMapa` int NOT NULL,
  `Largura` varchar(45) DEFAULT NULL,
  `Altura` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMapa`),
  UNIQUE KEY `idMapa_UNIQUE` (`idMapa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapa`
--

LOCK TABLES `mapa` WRITE;
/*!40000 ALTER TABLE `mapa` DISABLE KEYS */;
/*!40000 ALTER TABLE `mapa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navio`
--

DROP TABLE IF EXISTS `navio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navio` (
  `idNavio` int NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Vida` int NOT NULL,
  `Defesa` int NOT NULL,
  `Ataque` int NOT NULL,
  `Destreza` int DEFAULT NULL,
  PRIMARY KEY (`idNavio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navio`
--

LOCK TABLES `navio` WRITE;
/*!40000 ALTER TABLE `navio` DISABLE KEYS */;
/*!40000 ALTER TABLE `navio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc inimigo`
--

DROP TABLE IF EXISTS `npc inimigo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `npc inimigo` (
  `idNPC Inimigo` int NOT NULL,
  `Ataque` int NOT NULL,
  `Defesa` int NOT NULL,
  `Destreza` int NOT NULL,
  `Sorte` int NOT NULL,
  `Velocidade` int NOT NULL,
  PRIMARY KEY (`idNPC Inimigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc inimigo`
--

LOCK TABLES `npc inimigo` WRITE;
/*!40000 ALTER TABLE `npc inimigo` DISABLE KEYS */;
/*!40000 ALTER TABLE `npc inimigo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peixe`
--

DROP TABLE IF EXISTS `peixe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peixe` (
  `idPeixe` int NOT NULL,
  `Preço de Venda` int NOT NULL,
  `Peso` varchar(45) NOT NULL,
  PRIMARY KEY (`idPeixe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peixe`
--

LOCK TABLES `peixe` WRITE;
/*!40000 ALTER TABLE `peixe` DISABLE KEYS */;
/*!40000 ALTER TABLE `peixe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pergunta de segurança`
--

DROP TABLE IF EXISTS `pergunta de segurança`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pergunta de segurança` (
  `idPergunta de Segurança` int NOT NULL AUTO_INCREMENT,
  `Pergunta` varchar(45) NOT NULL,
  PRIMARY KEY (`idPergunta de Segurança`),
  UNIQUE KEY `idPergunta de Segurança_UNIQUE` (`idPergunta de Segurança`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pergunta de segurança`
--

LOCK TABLES `pergunta de segurança` WRITE;
/*!40000 ALTER TABLE `pergunta de segurança` DISABLE KEYS */;
/*!40000 ALTER TABLE `pergunta de segurança` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personagem`
--

DROP TABLE IF EXISTS `personagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personagem` (
  `idPersonagem` int NOT NULL,
  `Conta_idConta` int NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Nível` varchar(45) NOT NULL,
  `Experiência` varchar(45) NOT NULL,
  `Dinheiro` varchar(45) NOT NULL,
  `Data de Criação` date NOT NULL,
  `Guilda_idGuilda` int DEFAULT NULL,
  PRIMARY KEY (`idPersonagem`,`Conta_idConta`),
  KEY `fk_Personagem_Conta_idx` (`Conta_idConta`),
  KEY `fk_Personagem_Guilda1_idx` (`Guilda_idGuilda`),
  CONSTRAINT `fk_Personagem_Conta` FOREIGN KEY (`Conta_idConta`) REFERENCES `conta` (`idConta`),
  CONSTRAINT `fk_Personagem_Guilda1` FOREIGN KEY (`Guilda_idGuilda`) REFERENCES `guilda` (`idGuilda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personagem`
--

LOCK TABLES `personagem` WRITE;
/*!40000 ALTER TABLE `personagem` DISABLE KEYS */;
/*!40000 ALTER TABLE `personagem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personagem_has_navio`
--

DROP TABLE IF EXISTS `personagem_has_navio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personagem_has_navio` (
  `Personagem_idPersonagem` int NOT NULL,
  `Personagem_Conta_idConta` int NOT NULL,
  `Navio_idNavio` int NOT NULL,
  PRIMARY KEY (`Personagem_idPersonagem`,`Personagem_Conta_idConta`,`Navio_idNavio`),
  KEY `fk_Personagem_has_Navio_Navio1_idx` (`Navio_idNavio`),
  KEY `fk_Personagem_has_Navio_Personagem1_idx` (`Personagem_idPersonagem`,`Personagem_Conta_idConta`),
  CONSTRAINT `fk_Personagem_has_Navio_Navio1` FOREIGN KEY (`Navio_idNavio`) REFERENCES `navio` (`idNavio`),
  CONSTRAINT `fk_Personagem_has_Navio_Personagem1` FOREIGN KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`) REFERENCES `personagem` (`idPersonagem`, `Conta_idConta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personagem_has_navio`
--

LOCK TABLES `personagem_has_navio` WRITE;
/*!40000 ALTER TABLE `personagem_has_navio` DISABLE KEYS */;
/*!40000 ALTER TABLE `personagem_has_navio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo`
--

DROP TABLE IF EXISTS `tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo` (
  `idTipo` int NOT NULL,
  `Descrição` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo armas`
--

DROP TABLE IF EXISTS `tipo armas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo armas` (
  `idTipo Armas` int NOT NULL,
  `Descrição` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipo Armas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo armas`
--

LOCK TABLES `tipo armas` WRITE;
/*!40000 ALTER TABLE `tipo armas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo armas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo equip`
--

DROP TABLE IF EXISTS `tipo equip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo equip` (
  `idTipo Equip` int NOT NULL,
  `Descrição` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipo Equip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo equip`
--

LOCK TABLES `tipo equip` WRITE;
/*!40000 ALTER TABLE `tipo equip` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo equip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tripulação`
--

DROP TABLE IF EXISTS `tripulação`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tripulação` (
  `Personagem_idPersonagem` int NOT NULL,
  `Personagem_Conta_idConta` int NOT NULL,
  `Numero` varchar(45) NOT NULL,
  `Nivel` varchar(45) NOT NULL,
  `Experiência` varchar(45) NOT NULL,
  PRIMARY KEY (`Personagem_idPersonagem`,`Personagem_Conta_idConta`),
  CONSTRAINT `fk_Tripulação_Personagem1` FOREIGN KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`) REFERENCES `personagem` (`idPersonagem`, `Conta_idConta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tripulação`
--

LOCK TABLES `tripulação` WRITE;
/*!40000 ALTER TABLE `tripulação` DISABLE KEYS */;
/*!40000 ALTER TABLE `tripulação` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-07 16:34:39
