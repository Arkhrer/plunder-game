-- MySQL Script generated by MySQL Workbench
-- qua 07 set 2022 16:04:58
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Pergunta de Segurança`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pergunta de Segurança` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pergunta de Segurança` (
  `idPergunta de Segurança` INT NOT NULL AUTO_INCREMENT,
  `Pergunta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPergunta de Segurança`),
  UNIQUE INDEX `idPergunta de Segurança_UNIQUE` (`idPergunta de Segurança` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Conta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Conta` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Conta` (
  `idConta` INT NOT NULL,
  `Usuário` VARCHAR(45) NOT NULL,
  `Senha` VARCHAR(45) NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  `Data de Criação` DATE NOT NULL,
  `Pergunta de Segurança_idPergunta de Segurança` INT NOT NULL,
  `Resposta de Segurança` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idConta`),
  UNIQUE INDEX `idConta_UNIQUE` (`idConta` ASC) VISIBLE,
  INDEX `fk_Conta_Pergunta de Segurança1_idx` (`Pergunta de Segurança_idPergunta de Segurança` ASC) VISIBLE,
  UNIQUE INDEX `Usuário_UNIQUE` (`Usuário` ASC) VISIBLE,
  UNIQUE INDEX `E-mail_UNIQUE` (`E-mail` ASC) VISIBLE,
  CONSTRAINT `fk_Conta_Pergunta de Segurança1`
    FOREIGN KEY (`Pergunta de Segurança_idPergunta de Segurança`)
    REFERENCES `mydb`.`Pergunta de Segurança` (`idPergunta de Segurança`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Guilda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Guilda` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Guilda` (
  `idGuilda` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Nível` VARCHAR(45) NOT NULL,
  `Experiência` VARCHAR(45) NOT NULL,
  `Sigla` VARCHAR(45) NULL,
  PRIMARY KEY (`idGuilda`),
  UNIQUE INDEX `idGuilda_UNIQUE` (`idGuilda` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Personagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Personagem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Personagem` (
  `idPersonagem` INT NOT NULL,
  `Conta_idConta` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Nível` VARCHAR(45) NOT NULL,
  `Experiência` VARCHAR(45) NOT NULL,
  `Dinheiro` VARCHAR(45) NOT NULL,
  `Data de Criação` DATE NOT NULL,
  `Guilda_idGuilda` INT NULL,
  PRIMARY KEY (`idPersonagem`, `Conta_idConta`),
  INDEX `fk_Personagem_Conta_idx` (`Conta_idConta` ASC) VISIBLE,
  INDEX `fk_Personagem_Guilda1_idx` (`Guilda_idGuilda` ASC) VISIBLE,
  CONSTRAINT `fk_Personagem_Conta`
    FOREIGN KEY (`Conta_idConta`)
    REFERENCES `mydb`.`Conta` (`idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Personagem_Guilda1`
    FOREIGN KEY (`Guilda_idGuilda`)
    REFERENCES `mydb`.`Guilda` (`idGuilda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inventário`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Inventário` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Inventário` (
  `Personagem_idPersonagem` INT NOT NULL,
  `Personagem_Conta_idConta` INT NOT NULL,
  `Peso Total` VARCHAR(45) NOT NULL,
  INDEX `fk_Inventário_Personagem1_idx` (`Personagem_idPersonagem` ASC, `Personagem_Conta_idConta` ASC) VISIBLE,
  PRIMARY KEY (`Personagem_Conta_idConta`, `Personagem_idPersonagem`),
  CONSTRAINT `fk_Inventário_Personagem1`
    FOREIGN KEY (`Personagem_idPersonagem` , `Personagem_Conta_idConta`)
    REFERENCES `mydb`.`Personagem` (`idPersonagem` , `Conta_idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Item` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `idItem` INT NOT NULL,
  `Nome I` VARCHAR(45) NOT NULL,
  `Peso` VARCHAR(45) NOT NULL,
  `Preço de Compra` VARCHAR(45) NOT NULL,
  `Preço de Venda` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idItem`),
  UNIQUE INDEX `idItem_UNIQUE` (`idItem` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inventário tem Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Inventário tem Item` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Inventário tem Item` (
  `Inventário_Personagem_Conta_idConta` INT NOT NULL,
  `Inventário_Personagem_idPersonagem` INT NOT NULL,
  `Item_idItem` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Inventário_Personagem_Conta_idConta`, `Inventário_Personagem_idPersonagem`, `Item_idItem`),
  INDEX `fk_Inventário_has_Item_Item1_idx` (`Item_idItem` ASC) VISIBLE,
  INDEX `fk_Inventário_has_Item_Inventário1_idx` (`Inventário_Personagem_Conta_idConta` ASC, `Inventário_Personagem_idPersonagem` ASC) VISIBLE,
  CONSTRAINT `fk_Inventário_has_Item_Inventário1`
    FOREIGN KEY (`Inventário_Personagem_Conta_idConta` , `Inventário_Personagem_idPersonagem`)
    REFERENCES `mydb`.`Inventário` (`Personagem_Conta_idConta` , `Personagem_idPersonagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventário_has_Item_Item1`
    FOREIGN KEY (`Item_idItem`)
    REFERENCES `mydb`.`Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tripulação`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tripulação` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tripulação` (
  `Personagem_idPersonagem` INT NOT NULL,
  `Personagem_Conta_idConta` INT NOT NULL,
  `Numero` VARCHAR(45) NOT NULL,
  `Nivel` VARCHAR(45) NOT NULL,
  `Experiência` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`),
  CONSTRAINT `fk_Tripulação_Personagem1`
    FOREIGN KEY (`Personagem_idPersonagem` , `Personagem_Conta_idConta`)
    REFERENCES `mydb`.`Personagem` (`idPersonagem` , `Conta_idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Navio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Navio` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Navio` (
  `idNavio` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Vida` INT NOT NULL,
  `Defesa` INT NOT NULL,
  `Ataque` INT NOT NULL,
  `Destreza` INT NULL,
  PRIMARY KEY (`idNavio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Atributos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Atributos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Atributos` (
  `Personagem_idPersonagem` INT NOT NULL,
  `Personagem_Conta_idConta` INT NOT NULL,
  `Ataque` INT NOT NULL,
  `Defesa` INT NOT NULL,
  `Destreza` INT NOT NULL,
  `Sorte` INT NOT NULL,
  `Carisma` INT NOT NULL,
  `Velocidade` INT NOT NULL,
  PRIMARY KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`),
  INDEX `fk_Atributos_Personagem1_idx` (`Personagem_idPersonagem` ASC, `Personagem_Conta_idConta` ASC) VISIBLE,
  CONSTRAINT `fk_Atributos_Personagem1`
    FOREIGN KEY (`Personagem_idPersonagem` , `Personagem_Conta_idConta`)
    REFERENCES `mydb`.`Personagem` (`idPersonagem` , `Conta_idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mapa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Mapa` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mapa` (
  `idMapa` INT NOT NULL,
  `Largura` VARCHAR(45) NULL,
  `Altura` VARCHAR(45) NULL,
  PRIMARY KEY (`idMapa`),
  UNIQUE INDEX `idMapa_UNIQUE` (`idMapa` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tipo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipo` (
  `idTipo` INT NOT NULL,
  `Descrição` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Coordenada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Coordenada` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Coordenada` (
  `Mapa_idMapa` INT NOT NULL,
  `Linha` VARCHAR(45) NOT NULL,
  `Coluna` VARCHAR(45) NOT NULL,
  `Tipo_idTipo` INT NOT NULL,
  PRIMARY KEY (`Mapa_idMapa`, `Linha`, `Coluna`, `Tipo_idTipo`),
  INDEX `fk_Coordenada_Mapa1_idx` (`Mapa_idMapa` ASC) VISIBLE,
  INDEX `fk_Coordenada_Tipo1_idx` (`Tipo_idTipo` ASC) VISIBLE,
  CONSTRAINT `fk_Coordenada_Mapa1`
    FOREIGN KEY (`Mapa_idMapa`)
    REFERENCES `mydb`.`Mapa` (`idMapa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Coordenada_Tipo1`
    FOREIGN KEY (`Tipo_idTipo`)
    REFERENCES `mydb`.`Tipo` (`idTipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NPC Inimigo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`NPC Inimigo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`NPC Inimigo` (
  `idNPC Inimigo` INT NOT NULL,
  `Ataque` INT NOT NULL,
  `Defesa` INT NOT NULL,
  `Destreza` INT NOT NULL,
  `Sorte` INT NOT NULL,
  `Velocidade` INT NOT NULL,
  PRIMARY KEY (`idNPC Inimigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Evento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Evento` (
  `idEvento` INT NOT NULL,
  `Tipo_idTipo` INT NOT NULL,
  `Amigavel` TINYINT NOT NULL,
  PRIMARY KEY (`idEvento`, `Tipo_idTipo`),
  INDEX `fk_Evento_Tipo1_idx` (`Tipo_idTipo` ASC) VISIBLE,
  CONSTRAINT `fk_Evento_Tipo1`
    FOREIGN KEY (`Tipo_idTipo`)
    REFERENCES `mydb`.`Tipo` (`idTipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Peixe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Peixe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Peixe` (
  `idPeixe` INT NOT NULL,
  `Preço de Venda` INT NOT NULL,
  `Peso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPeixe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inventário tem Peixe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Inventário tem Peixe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Inventário tem Peixe` (
  `Inventário_Personagem_Conta_idConta` INT NOT NULL,
  `Inventário_Personagem_idPersonagem` INT NOT NULL,
  `Peixe_idPeixe` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Inventário_Personagem_Conta_idConta`, `Inventário_Personagem_idPersonagem`, `Peixe_idPeixe`),
  INDEX `fk_Inventário_has_Peixe_Peixe1_idx` (`Peixe_idPeixe` ASC) VISIBLE,
  INDEX `fk_Inventário_has_Peixe_Inventário1_idx` (`Inventário_Personagem_Conta_idConta` ASC, `Inventário_Personagem_idPersonagem` ASC) VISIBLE,
  CONSTRAINT `fk_Inventário_has_Peixe_Inventário1`
    FOREIGN KEY (`Inventário_Personagem_Conta_idConta` , `Inventário_Personagem_idPersonagem`)
    REFERENCES `mydb`.`Inventário` (`Personagem_Conta_idConta` , `Personagem_idPersonagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventário_has_Peixe_Peixe1`
    FOREIGN KEY (`Peixe_idPeixe`)
    REFERENCES `mydb`.`Peixe` (`idPeixe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Personagem_has_Navio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Personagem_has_Navio` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Personagem_has_Navio` (
  `Personagem_idPersonagem` INT NOT NULL,
  `Personagem_Conta_idConta` INT NOT NULL,
  `Navio_idNavio` INT NOT NULL,
  PRIMARY KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`, `Navio_idNavio`),
  INDEX `fk_Personagem_has_Navio_Navio1_idx` (`Navio_idNavio` ASC) VISIBLE,
  INDEX `fk_Personagem_has_Navio_Personagem1_idx` (`Personagem_idPersonagem` ASC, `Personagem_Conta_idConta` ASC) VISIBLE,
  CONSTRAINT `fk_Personagem_has_Navio_Personagem1`
    FOREIGN KEY (`Personagem_idPersonagem` , `Personagem_Conta_idConta`)
    REFERENCES `mydb`.`Personagem` (`idPersonagem` , `Conta_idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Personagem_has_Navio_Navio1`
    FOREIGN KEY (`Navio_idNavio`)
    REFERENCES `mydb`.`Navio` (`idNavio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo Equip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tipo Equip` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipo Equip` (
  `idTipo Equip` INT NOT NULL,
  `Descrição` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipo Equip`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Equipamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipamento` (
  `idEquipamento` INT NOT NULL,
  `Nome E` VARCHAR(45) NULL,
  `Peso E` VARCHAR(45) NULL,
  `Preço de Compra E` VARCHAR(45) NULL,
  `Preço de Venta E` VARCHAR(45) NULL,
  `Tipo Equip_idTipo Equip` INT NOT NULL,
  `Defesa E` VARCHAR(45) NULL,
  PRIMARY KEY (`idEquipamento`),
  INDEX `fk_Equipamento_Tipo Equip1_idx` (`Tipo Equip_idTipo Equip` ASC) VISIBLE,
  CONSTRAINT `fk_Equipamento_Tipo Equip1`
    FOREIGN KEY (`Tipo Equip_idTipo Equip`)
    REFERENCES `mydb`.`Tipo Equip` (`idTipo Equip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inventario tem Equipamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Inventario tem Equipamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Inventario tem Equipamento` (
  `Inventário_Personagem_Conta_idConta` INT NOT NULL,
  `Inventário_Personagem_idPersonagem` INT NOT NULL,
  `Equipamento_idEquipamento` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Inventário_Personagem_Conta_idConta`, `Inventário_Personagem_idPersonagem`, `Equipamento_idEquipamento`),
  INDEX `fk_Inventário_has_Equipamento_Equipamento1_idx` (`Equipamento_idEquipamento` ASC) VISIBLE,
  INDEX `fk_Inventário_has_Equipamento_Inventário1_idx` (`Inventário_Personagem_Conta_idConta` ASC, `Inventário_Personagem_idPersonagem` ASC) VISIBLE,
  CONSTRAINT `fk_Inventário_has_Equipamento_Inventário1`
    FOREIGN KEY (`Inventário_Personagem_Conta_idConta` , `Inventário_Personagem_idPersonagem`)
    REFERENCES `mydb`.`Inventário` (`Personagem_Conta_idConta` , `Personagem_idPersonagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventário_has_Equipamento_Equipamento1`
    FOREIGN KEY (`Equipamento_idEquipamento`)
    REFERENCES `mydb`.`Equipamento` (`idEquipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo Armas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tipo Armas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipo Armas` (
  `idTipo Armas` INT NOT NULL,
  `Descrição` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipo Armas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Armas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Armas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Armas` (
  `idArmas` INT NOT NULL,
  `Tipo Armas_idTipo Armas` INT NOT NULL,
  `Preço de Compra` VARCHAR(45) NULL,
  `Preço de Venda` VARCHAR(45) NULL,
  `Peso` VARCHAR(45) NULL,
  `Ataque` VARCHAR(45) NULL,
  PRIMARY KEY (`idArmas`, `Tipo Armas_idTipo Armas`),
  INDEX `fk_Armas_Tipo Armas1_idx` (`Tipo Armas_idTipo Armas` ASC) VISIBLE,
  CONSTRAINT `fk_Armas_Tipo Armas1`
    FOREIGN KEY (`Tipo Armas_idTipo Armas`)
    REFERENCES `mydb`.`Tipo Armas` (`idTipo Armas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Equipado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipado` (
  `Personagem_idPersonagem` INT NOT NULL,
  `Personagem_Conta_idConta` INT NOT NULL,
  `Navio_idNavio` INT NOT NULL,
  `Equipamento_idEquipamento (Capacete)` INT NOT NULL,
  `Equipamento_idEquipamento (Armadura)` INT NOT NULL,
  `Equipamento_idEquipamento (Botas)` INT NOT NULL,
  `Armas_idArmas (Espada)` INT NOT NULL,
  `Armas_idArmas (Pistola)` INT NOT NULL,
  INDEX `fk_Equipado_Navio1_idx` (`Navio_idNavio` ASC) VISIBLE,
  INDEX `fk_Equipado_Equipamento1_idx` (`Equipamento_idEquipamento (Capacete)` ASC) VISIBLE,
  INDEX `fk_Equipado_Equipamento2_idx` (`Equipamento_idEquipamento (Armadura)` ASC) VISIBLE,
  INDEX `fk_Equipado_Equipamento3_idx` (`Equipamento_idEquipamento (Botas)` ASC) VISIBLE,
  INDEX `fk_Equipado_Armas1_idx` (`Armas_idArmas (Espada)` ASC) VISIBLE,
  INDEX `fk_Equipado_Armas2_idx` (`Armas_idArmas (Pistola)` ASC) VISIBLE,
  PRIMARY KEY (`Personagem_idPersonagem`, `Personagem_Conta_idConta`),
  CONSTRAINT `fk_Equipado_Personagem1`
    FOREIGN KEY (`Personagem_idPersonagem` , `Personagem_Conta_idConta`)
    REFERENCES `mydb`.`Personagem` (`idPersonagem` , `Conta_idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipado_Navio1`
    FOREIGN KEY (`Navio_idNavio`)
    REFERENCES `mydb`.`Navio` (`idNavio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipado_Equipamento1`
    FOREIGN KEY (`Equipamento_idEquipamento (Capacete)`)
    REFERENCES `mydb`.`Equipamento` (`idEquipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipado_Equipamento2`
    FOREIGN KEY (`Equipamento_idEquipamento (Armadura)`)
    REFERENCES `mydb`.`Equipamento` (`idEquipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipado_Equipamento3`
    FOREIGN KEY (`Equipamento_idEquipamento (Botas)`)
    REFERENCES `mydb`.`Equipamento` (`idEquipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipado_Armas1`
    FOREIGN KEY (`Armas_idArmas (Espada)`)
    REFERENCES `mydb`.`Armas` (`idArmas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipado_Armas2`
    FOREIGN KEY (`Armas_idArmas (Pistola)`)
    REFERENCES `mydb`.`Armas` (`idArmas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inventário tem Armas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Inventário tem Armas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Inventário tem Armas` (
  `idConta` INT NOT NULL,
  `idPersonagem` INT NOT NULL,
  `idArmas` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`idConta`, `idPersonagem`, `idArmas`),
  INDEX `fk_Inventário_has_Armas_Armas1_idx` (`idArmas` ASC) VISIBLE,
  INDEX `fk_Inventário_has_Armas_Inventário1_idx` (`idConta` ASC, `idPersonagem` ASC) VISIBLE,
  CONSTRAINT `fk_Inventário_has_Armas_Inventário1`
    FOREIGN KEY (`idConta` , `idPersonagem`)
    REFERENCES `mydb`.`Inventário` (`Personagem_Conta_idConta` , `Personagem_idPersonagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventário_has_Armas_Armas1`
    FOREIGN KEY (`idArmas`)
    REFERENCES `mydb`.`Armas` (`idArmas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;