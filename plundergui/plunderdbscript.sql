-- mysql script generated by mysql workbench
-- qua 14 set 2022 19:50:21
-- model: new model    version: 1.0
-- mysql workbench forward engineering

set @old_unique_checks=@@unique_checks, unique_checks=0;
set @old_foreign_key_checks=@@foreign_key_checks, foreign_key_checks=0;
set @old_sql_mode=@@sql_mode, sql_mode='only_full_group_by,strict_trans_tables,no_zero_in_date,no_zero_date,error_for_division_by_zero,no_engine_substitution';

-- -----------------------------------------------------
-- schema plunderdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- schema plunderdb
-- -----------------------------------------------------
create schema if not exists `plunderdb` default character set utf8 ;
use `plunderdb` ;

-- -----------------------------------------------------
-- table `plunderdb`.`pergunta de segurança`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`pergunta de segurança` ;

create table if not exists `plunderdb`.`pergunta de segurança` (
  `idpergunta de segurança` int not null auto_increment,
  `pergunta` varchar(45) not null,
  primary key (`idpergunta de segurança`),
  unique index `idpergunta de segurança_unique` (`idpergunta de segurança` asc) visible)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`conta`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`conta` ;

create table if not exists `plunderdb`.`conta` (
  `idconta` int not null auto_increment,
  `usuário` varchar(45) not null,
  `senha` varchar(45) not null,
  `e-mail` varchar(45) not null,
  `data de criação` date not null,
  `pergunta de segurança_idpergunta de segurança` int not null,
  `resposta de segurança` varchar(45) not null,
  primary key (`idconta`),
  unique index `idconta_unique` (`idconta` asc) visible,
  index `fk_conta_pergunta de segurança1_idx` (`pergunta de segurança_idpergunta de segurança` asc) visible,
  unique index `usuário_unique` (`usuário` asc) visible,
  unique index `e-mail_unique` (`e-mail` asc) visible,
  constraint `fk_conta_pergunta de segurança1`
    foreign key (`pergunta de segurança_idpergunta de segurança`)
    references `plunderdb`.`pergunta de segurança` (`idpergunta de segurança`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`guilda`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`guilda` ;

create table if not exists `plunderdb`.`guilda` (
  `idguilda` int not null auto_increment,
  `nome` varchar(45) not null,
  `nível` varchar(45) not null,
  `experiência` varchar(45) not null,
  `sigla` varchar(45) null,
  primary key (`idguilda`),
  unique index `idguilda_unique` (`idguilda` asc) visible)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`personagem`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`personagem` ;

create table if not exists `plunderdb`.`personagem` (
  `idpersonagem` int not null auto_increment,
  `conta_idconta` int not null,
  `nome` varchar(45) not null,
  `nível` varchar(45) not null,
  `experiência` varchar(45) not null,
  `dinheiro` varchar(45) not null,
  `data de criação` date not null,
  `guilda_idguilda` int null,
  `hp` int not null,
  `avatar` mediumblob not null,
  primary key (`idpersonagem`),
  index `fk_personagem_conta_idx` (`conta_idconta` asc) visible,
  index `fk_personagem_guilda1_idx` (`guilda_idguilda` asc) visible,
  constraint `fk_personagem_conta`
    foreign key (`conta_idconta`)
    references `plunderdb`.`conta` (`idconta`)
    on delete no action
    on update no action,
  constraint `fk_personagem_guilda1`
    foreign key (`guilda_idguilda`)
    references `plunderdb`.`guilda` (`idguilda`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`inventário`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`inventário` ;

create table if not exists `plunderdb`.`inventário` (
  `personagem_idpersonagem` int not null,
  `peso total` varchar(45) not null,
  index `fk_inventário_personagem1_idx` (`personagem_idpersonagem` asc) visible,
  primary key (`personagem_idpersonagem`),
  constraint `fk_inventário_personagem1`
    foreign key (`personagem_idpersonagem`)
    references `plunderdb`.`personagem` (`idpersonagem`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`item`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`item` ;

create table if not exists `plunderdb`.`item` (
  `iditem` int not null auto_increment,
  `nome i` varchar(45) not null,
  `peso` varchar(45) not null,
  `preço de compra` varchar(45) not null,
  `preço de venda` varchar(45) not null,
  primary key (`iditem`),
  unique index `iditem_unique` (`iditem` asc) visible)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`inventário tem item`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`inventário tem item` ;

create table if not exists `plunderdb`.`inventário tem item` (
  `inventário_personagem_idpersonagem` int not null,
  `item_iditem` int not null,
  `quantidade` varchar(45) null,
  primary key (`inventário_personagem_idpersonagem`, `item_iditem`),
  index `fk_inventário_has_item_item1_idx` (`item_iditem` asc) visible,
  index `fk_inventário_has_item_inventário1_idx` (`inventário_personagem_idpersonagem` asc) visible,
  constraint `fk_inventário_has_item_inventário1`
    foreign key (`inventário_personagem_idpersonagem`)
    references `plunderdb`.`inventário` (`personagem_idpersonagem`)
    on delete no action
    on update no action,
  constraint `fk_inventário_has_item_item1`
    foreign key (`item_iditem`)
    references `plunderdb`.`item` (`iditem`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`tripulação`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`tripulação` ;

create table if not exists `plunderdb`.`tripulação` (
  `personagem_idpersonagem` int not null,
  `número` int not null,
  `nível` int not null,
  `experiência` int not null,
  primary key (`personagem_idpersonagem`),
  constraint `fk_tripulação_personagem1`
    foreign key (`personagem_idpersonagem`)
    references `plunderdb`.`personagem` (`idpersonagem`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`navio`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`navio` ;

create table if not exists `plunderdb`.`navio` (
  `idnavio` int not null auto_increment,
  `nome` varchar(45) not null,
  `vida` int not null,
  `defesa` int not null,
  `ataque` int not null,
  `destreza` int null,
  `preço compra` int not null,
  `preço venda` int not null,
  primary key (`idnavio`))
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`atributos`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`atributos` ;

create table if not exists `plunderdb`.`atributos` (
  `personagem_idpersonagem` int not null,
  `ataque` int not null,
  `defesa` int not null,
  `destreza` int not null,
  `sorte` int not null,
  `carisma` int not null,
  `velocidade` int not null,
  primary key (`personagem_idpersonagem`),
  index `fk_atributos_personagem1_idx` (`personagem_idpersonagem` asc) visible,
  constraint `fk_atributos_personagem1`
    foreign key (`personagem_idpersonagem`)
    references `plunderdb`.`personagem` (`idpersonagem`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`mapa`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`mapa` ;

create table if not exists `plunderdb`.`mapa` (
  `idmapa` int not null auto_increment,
  `largura` varchar(45) null,
  `altura` varchar(45) null,
  primary key (`idmapa`),
  unique index `idmapa_unique` (`idmapa` asc) visible)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`tipo`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`tipo` ;

create table if not exists `plunderdb`.`tipo` (
  `idtipo` int not null auto_increment,
  `descrição` varchar(45) not null,
  primary key (`idtipo`))
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`coordenada`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`coordenada` ;

create table if not exists `plunderdb`.`coordenada` (
  `mapa_idmapa` int not null,
  `linha` varchar(45) not null,
  `coluna` varchar(45) not null,
  `tipo_idtipo` int not null,
  primary key (`mapa_idmapa`, `linha`, `coluna`, `tipo_idtipo`),
  index `fk_coordenada_mapa1_idx` (`mapa_idmapa` asc) visible,
  index `fk_coordenada_tipo1_idx` (`tipo_idtipo` asc) visible,
  constraint `fk_coordenada_mapa1`
    foreign key (`mapa_idmapa`)
    references `plunderdb`.`mapa` (`idmapa`)
    on delete no action
    on update no action,
  constraint `fk_coordenada_tipo1`
    foreign key (`tipo_idtipo`)
    references `plunderdb`.`tipo` (`idtipo`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`npc inimigo`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`npc inimigo` ;

create table if not exists `plunderdb`.`npc inimigo` (
  `idnpc inimigo` int not null auto_increment,
  `ataque` int not null,
  `defesa` int not null,
  `destreza` int not null,
  `sorte` int not null,
  `velocidade` int not null,
  primary key (`idnpc inimigo`))
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`evento`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`evento` ;

create table if not exists `plunderdb`.`evento` (
  `idevento` int not null auto_increment,
  `tipo_idtipo` int not null,
  `amigavel` tinyint not null,
  primary key (`idevento`, `tipo_idtipo`),
  index `fk_evento_tipo1_idx` (`tipo_idtipo` asc) visible,
  constraint `fk_evento_tipo1`
    foreign key (`tipo_idtipo`)
    references `plunderdb`.`tipo` (`idtipo`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`peixe`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`peixe` ;

create table if not exists `plunderdb`.`peixe` (
  `idpeixe` int not null auto_increment,
  `preço de venda` int not null,
  `peso` varchar(45) not null,
  primary key (`idpeixe`))
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`inventário tem peixe`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`inventário tem peixe` ;

create table if not exists `plunderdb`.`inventário tem peixe` (
  `inventário_personagem_idpersonagem` int not null,
  `peixe_idpeixe` int not null,
  `quantidade` int not null,
  primary key (`inventário_personagem_idpersonagem`, `peixe_idpeixe`),
  index `fk_inventário_has_peixe_peixe1_idx` (`peixe_idpeixe` asc) visible,
  index `fk_inventário_has_peixe_inventário1_idx` (`inventário_personagem_idpersonagem` asc) visible,
  constraint `fk_inventário_has_peixe_inventário1`
    foreign key (`inventário_personagem_idpersonagem`)
    references `plunderdb`.`inventário` (`personagem_idpersonagem`)
    on delete no action
    on update no action,
  constraint `fk_inventário_has_peixe_peixe1`
    foreign key (`peixe_idpeixe`)
    references `plunderdb`.`peixe` (`idpeixe`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`personagem_has_navio`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`personagem_has_navio` ;

create table if not exists `plunderdb`.`personagem_has_navio` (
  `personagem_idpersonagem` int not null,
  `navio_idnavio` int not null,
  primary key (`personagem_idpersonagem`, `navio_idnavio`),
  index `fk_personagem_has_navio_navio1_idx` (`navio_idnavio` asc) visible,
  index `fk_personagem_has_navio_personagem1_idx` (`personagem_idpersonagem` asc) visible,
  constraint `fk_personagem_has_navio_personagem1`
    foreign key (`personagem_idpersonagem`)
    references `plunderdb`.`personagem` (`idpersonagem`)
    on delete no action
    on update no action,
  constraint `fk_personagem_has_navio_navio1`
    foreign key (`navio_idnavio`)
    references `plunderdb`.`navio` (`idnavio`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`tipo equip`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`tipo equip` ;

create table if not exists `plunderdb`.`tipo equip` (
  `idtipo equip` int not null auto_increment,
  `descrição` varchar(45) null,
  primary key (`idtipo equip`))
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`equipamento`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`equipamento` ;

create table if not exists `plunderdb`.`equipamento` (
  `idequipamento` int not null auto_increment,
  `nome e` varchar(45) null,
  `peso e` varchar(45) null,
  `preço de compra e` varchar(45) null,
  `preço de venta e` varchar(45) null,
  `tipo equip_idtipo equip` int not null,
  `defesa e` varchar(45) null,
  primary key (`idequipamento`),
  index `fk_equipamento_tipo equip1_idx` (`tipo equip_idtipo equip` asc) visible,
  constraint `fk_equipamento_tipo equip1`
    foreign key (`tipo equip_idtipo equip`)
    references `plunderdb`.`tipo equip` (`idtipo equip`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`inventario tem equipamento`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`inventario tem equipamento` ;

create table if not exists `plunderdb`.`inventario tem equipamento` (
  `inventário_personagem_idpersonagem` int not null,
  `equipamento_idequipamento` int not null,
  `quantidade` varchar(45) null,
  primary key (`inventário_personagem_idpersonagem`, `equipamento_idequipamento`),
  index `fk_inventário_has_equipamento_equipamento1_idx` (`equipamento_idequipamento` asc) visible,
  index `fk_inventário_has_equipamento_inventário1_idx` (`inventário_personagem_idpersonagem` asc) visible,
  constraint `fk_inventário_has_equipamento_inventário1`
    foreign key (`inventário_personagem_idpersonagem`)
    references `plunderdb`.`inventário` (`personagem_idpersonagem`)
    on delete no action
    on update no action,
  constraint `fk_inventário_has_equipamento_equipamento1`
    foreign key (`equipamento_idequipamento`)
    references `plunderdb`.`equipamento` (`idequipamento`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`tipo armas`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`tipo armas` ;

create table if not exists `plunderdb`.`tipo armas` (
  `idtipo armas` int not null auto_increment,
  `descrição` varchar(45) null,
  primary key (`idtipo armas`))
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`armas`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`armas` ;

create table if not exists `plunderdb`.`armas` (
  `idarmas` int not null auto_increment,
  `tipo armas_idtipo armas` int not null,
  `preço de compra` varchar(45) null,
  `preço de venda` varchar(45) null,
  `peso` varchar(45) null,
  `ataque` varchar(45) null,
  primary key (`idarmas`, `tipo armas_idtipo armas`),
  index `fk_armas_tipo armas1_idx` (`tipo armas_idtipo armas` asc) visible,
  constraint `fk_armas_tipo armas1`
    foreign key (`tipo armas_idtipo armas`)
    references `plunderdb`.`tipo armas` (`idtipo armas`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`equipado`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`equipado` ;

create table if not exists `plunderdb`.`equipado` (
  `personagem_idpersonagem` int not null,
  `navio_idnavio` int,
  `equipamento_idequipamento (capacete)` int,
  `equipamento_idequipamento (armadura)` int,
  `equipamento_idequipamento (botas)` int,
  `armas_idarmas (espada)` int,
  `armas_idarmas (pistola)` int,
  index `fk_equipado_navio1_idx` (`navio_idnavio` asc) visible,
  index `fk_equipado_equipamento1_idx` (`equipamento_idequipamento (capacete)` asc) visible,
  index `fk_equipado_equipamento2_idx` (`equipamento_idequipamento (armadura)` asc) visible,
  index `fk_equipado_equipamento3_idx` (`equipamento_idequipamento (botas)` asc) visible,
  index `fk_equipado_armas1_idx` (`armas_idarmas (espada)` asc) visible,
  index `fk_equipado_armas2_idx` (`armas_idarmas (pistola)` asc) visible,
  primary key (`personagem_idpersonagem`),
  constraint `fk_equipado_personagem1`
    foreign key (`personagem_idpersonagem`)
    references `plunderdb`.`personagem` (`idpersonagem`)
    on delete no action
    on update no action,
  constraint `fk_equipado_navio1`
    foreign key (`navio_idnavio`)
    references `plunderdb`.`navio` (`idnavio`)
    on delete no action
    on update no action,
  constraint `fk_equipado_equipamento1`
    foreign key (`equipamento_idequipamento (capacete)`)
    references `plunderdb`.`equipamento` (`idequipamento`)
    on delete no action
    on update no action,
  constraint `fk_equipado_equipamento2`
    foreign key (`equipamento_idequipamento (armadura)`)
    references `plunderdb`.`equipamento` (`idequipamento`)
    on delete no action
    on update no action,
  constraint `fk_equipado_equipamento3`
    foreign key (`equipamento_idequipamento (botas)`)
    references `plunderdb`.`equipamento` (`idequipamento`)
    on delete no action
    on update no action,
  constraint `fk_equipado_armas1`
    foreign key (`armas_idarmas (espada)`)
    references `plunderdb`.`armas` (`idarmas`)
    on delete no action
    on update no action,
  constraint `fk_equipado_armas2`
    foreign key (`armas_idarmas (pistola)`)
    references `plunderdb`.`armas` (`idarmas`)
    on delete no action
    on update no action)
engine = innodb;


-- -----------------------------------------------------
-- table `plunderdb`.`inventário tem armas`
-- -----------------------------------------------------
drop table if exists `plunderdb`.`inventário tem armas` ;

create table if not exists `plunderdb`.`inventário tem armas` (
  `idpersonagem` int not null,
  `idarmas` int not null,
  `quantidade` int null,
  primary key (`idpersonagem`, `idarmas`),
  index `fk_inventário_has_armas_armas1_idx` (`idarmas` asc) visible,
  index `fk_inventário_has_armas_inventário1_idx` (`idpersonagem` asc) visible,
  constraint `fk_inventário_has_armas_inventário1`
    foreign key (`idpersonagem`)
    references `plunderdb`.`inventário` (`personagem_idpersonagem`)
    on delete no action
    on update no action,
  constraint `fk_inventário_has_armas_armas1`
    foreign key (`idarmas`)
    references `plunderdb`.`armas` (`idarmas`)
    on delete no action
    on update no action)
engine = innodb;


set sql_mode=@old_sql_mode;
set foreign_key_checks=@old_foreign_key_checks;
set unique_checks=@old_unique_checks;
