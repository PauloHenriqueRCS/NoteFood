-- MySQL Script generated by MySQL Workbench
-- Qui 17 Nov 2016 09:38:54 BRST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema notefood
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS notefood ;


-- -----------------------------------------------------
-- Schema notefood
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS notefood DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE notefood ;

-- -----------------------------------------------------
-- Table notefood.USUARIO
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.USUARIO ;

CREATE TABLE IF NOT EXISTS notefood.USUARIO (
  Usuario_ID INT UNSIGNED NOT NULL,
  Nome_Usuario VARCHAR(45) NOT NULL,
  DataNasc VARCHAR(10) NOT NULL,
  Email VARCHAR(45) NOT NULL,
  Sexo CHAR(1) NOT NULL,
  Peso DECIMAL NOT NULL,
  Altura DECIMAL NULL,
  PRIMARY KEY (Usuario_ID))
ENGINE = InnoDB;

CREATE UNIQUE INDEX Usuario_ID_UNIQUE ON notefood.USUARIO (Usuario_ID ASC);


-- -----------------------------------------------------
-- Table notefood.DIETA
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.DIETA ;

CREATE TABLE IF NOT EXISTS notefood.DIETA (
  DIETA_ID INT UNSIGNED NOT NULL,
  ALIMENTO_ID INT NULL,
  QT_PORCAO SMALLINT NOT NULL,
  usuario_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (DIETA_ID, usuario_id))
ENGINE = InnoDB;

CREATE UNIQUE INDEX DIETA_ID_UNIQUE ON notefood.DIETA (DIETA_ID ASC);


-- -----------------------------------------------------
-- Table notefood.REFEICAO
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.REFEICAO ;

CREATE TABLE IF NOT EXISTS notefood.REFEICAO (
  REFEICAO_ID INT NOT NULL,
  Data VARCHAR(10) NOT NULL,
  Hora VARCHAR(10) NOT NULL,
  DIETA_DIETA_ID INT UNSIGNED NOT NULL,
  DIETA_USUARIO_ID INT UNSIGNED NOT NULL,
  PRIMARY KEY (REFEICAO_ID, DIETA_DIETA_ID, DIETA_USUARIO_ID),
  CONSTRAINT fk_REFEICAO_DIETA1
    FOREIGN KEY (DIETA_DIETA_ID , DIETA_USUARIO_ID)
    REFERENCES notefood.DIETA (DIETA_ID , usuario_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX REFEICAO_ID_UNIQUE ON notefood.REFEICAO (REFEICAO_ID ASC);

CREATE INDEX fk_REFEICAO_DIETA1_idx ON notefood.REFEICAO (DIETA_DIETA_ID ASC, DIETA_USUARIO_ID ASC);


-- -----------------------------------------------------
-- Table notefood.GRUPO
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.GRUPO ;

CREATE TABLE IF NOT EXISTS notefood.GRUPO (
  GRUPO_ID INT UNSIGNED NOT NULL,
  Grupo_Nome VARCHAR(45) NOT NULL,
  Nutriente_Principal VARCHAR(45) NOT NULL,
  QT_Diaria_Recomendada SMALLINT NOT NULL,
  PRIMARY KEY (GRUPO_ID))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table notefood.SUB_GRUPO
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.SUB_GRUPO ;

CREATE TABLE IF NOT EXISTS notefood.SUB_GRUPO (
  SUB_GRUPO_ID INT NOT NULL,
  Sub_Grupo_Nome VARCHAR(45) NOT NULL,
  GRUPO_GRUPO_ID INT UNSIGNED NOT NULL,
  PRIMARY KEY (SUB_GRUPO_ID, GRUPO_GRUPO_ID),
  CONSTRAINT fk_SUB_GRUPO_GRUPO1
    FOREIGN KEY (GRUPO_GRUPO_ID)
    REFERENCES notefood.GRUPO (GRUPO_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX SUB_GRUPO_ID_UNIQUE ON notefood.SUB_GRUPO (SUB_GRUPO_ID ASC);

CREATE INDEX fk_SUB_GRUPO_GRUPO1_idx ON notefood.SUB_GRUPO (GRUPO_GRUPO_ID ASC);


-- -----------------------------------------------------
-- Table notefood.ALIMENTO
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.ALIMENTO ;

CREATE TABLE IF NOT EXISTS notefood.ALIMENTO (
  ALIMENTO_ID INT NOT NULL,
  Alimento_Nome VARCHAR(45) NOT NULL,
  Descrição VARCHAR(45) NOT NULL,
  SUB_GRUPO_SUB_GRUPO_ID INT NOT NULL,
  SUB_GRUPO_GRUPO_GRUPO_ID INT UNSIGNED NOT NULL,
  DIETA_DIETA_ID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ALIMENTO_ID, SUB_GRUPO_SUB_GRUPO_ID, SUB_GRUPO_GRUPO_GRUPO_ID, DIETA_DIETA_ID),
  CONSTRAINT fk_ALIMENTO_SUB_GRUPO1
    FOREIGN KEY (SUB_GRUPO_SUB_GRUPO_ID , SUB_GRUPO_GRUPO_GRUPO_ID)
    REFERENCES notefood.SUB_GRUPO (SUB_GRUPO_ID , GRUPO_GRUPO_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX ALIMENTO_ID_UNIQUE ON notefood.ALIMENTO (ALIMENTO_ID ASC);

CREATE INDEX fk_ALIMENTO_SUB_GRUPO1_idx ON notefood.ALIMENTO (SUB_GRUPO_SUB_GRUPO_ID ASC, SUB_GRUPO_GRUPO_GRUPO_ID ASC);


-- -----------------------------------------------------
-- Table notefood.ENERGETICO
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.ENERGETICO ;

CREATE TABLE IF NOT EXISTS notefood.ENERGETICO (
  QT_Carboidrato DECIMAL NOT NULL,
  ALIMENTO_ALIMENTO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ALIMENTO_ALIMENTO_ID, ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID, ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID),
  CONSTRAINT fk_ENERGETICO_ALIMENTO1
    FOREIGN KEY (ALIMENTO_ALIMENTO_ID , ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID , ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID)
    REFERENCES notefood.ALIMENTO (ALIMENTO_ID , SUB_GRUPO_SUB_GRUPO_ID , SUB_GRUPO_GRUPO_GRUPO_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table notefood.REGULADOR
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.REGULADOR ;

CREATE TABLE IF NOT EXISTS notefood.REGULADOR (
  QT_Fibra DECIMAL NOT NULL,
  ALIMENTO_ALIMENTO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ALIMENTO_ALIMENTO_ID, ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID, ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID),
  CONSTRAINT fk_REGULADOR_ALIMENTO1
    FOREIGN KEY (ALIMENTO_ALIMENTO_ID , ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID , ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID)
    REFERENCES notefood.ALIMENTO (ALIMENTO_ID , SUB_GRUPO_SUB_GRUPO_ID , SUB_GRUPO_GRUPO_GRUPO_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table notefood.CONSTRUTOR
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.CONSTRUTOR ;

CREATE TABLE IF NOT EXISTS notefood.CONSTRUTOR (
  QT_Proteina DECIMAL NOT NULL,
  ALIMENTO_ALIMENTO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ALIMENTO_ALIMENTO_ID, ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID, ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID),
  CONSTRAINT fk_CONSTRUTOR_ALIMENTO1
    FOREIGN KEY (ALIMENTO_ALIMENTO_ID , ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID , ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID)
    REFERENCES notefood.ALIMENTO (ALIMENTO_ID , SUB_GRUPO_SUB_GRUPO_ID , SUB_GRUPO_GRUPO_GRUPO_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table notefood.ENERGETIO_EXTRA
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.ENERGETIO_EXTRA ;

CREATE TABLE IF NOT EXISTS notefood.ENERGETIO_EXTRA (
  QT_Permitida SMALLINT NOT NULL,
  ALIMENTO_ALIMENTO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ALIMENTO_ALIMENTO_ID, ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID, ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID),
  CONSTRAINT fk_ENERGETIO_EXTRA_ALIMENTO1
    FOREIGN KEY (ALIMENTO_ALIMENTO_ID , ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID , ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID)
    REFERENCES notefood.ALIMENTO (ALIMENTO_ID , SUB_GRUPO_SUB_GRUPO_ID , SUB_GRUPO_GRUPO_GRUPO_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table notefood.ALIMENTO_USUARIO
-- -----------------------------------------------------
DROP TABLE IF EXISTS notefood.ALIMENTO_USUARIO ;

CREATE TABLE IF NOT EXISTS notefood.ALIMENTO_USUARIO (
  ALIMENTO_ALIMENTO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID INT NOT NULL,
  ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID INT UNSIGNED NOT NULL,
  ALIMENTO_DIETA_DIETA_ID INT UNSIGNED NOT NULL,
  usuario_Usuario_ID INT UNSIGNED NOT NULL,
  DIETA_DIETA_ID INT UNSIGNED NOT NULL,
  DIETA_USUARIO_ID INT UNSIGNED NOT NULL,
  PRIMARY KEY (ALIMENTO_ALIMENTO_ID, ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID, ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID, ALIMENTO_DIETA_DIETA_ID, usuario_Usuario_ID, DIETA_DIETA_ID, DIETA_USUARIO_ID),
  CONSTRAINT fk_ALIMENTO_has_usuário_ALIMENTO1
    FOREIGN KEY (ALIMENTO_ALIMENTO_ID , ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID , ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID , ALIMENTO_DIETA_DIETA_ID)
    REFERENCES notefood.ALIMENTO (ALIMENTO_ID , SUB_GRUPO_SUB_GRUPO_ID , SUB_GRUPO_GRUPO_GRUPO_ID , DIETA_DIETA_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ALIMENTO_has_usuário_usuário1
    FOREIGN KEY (usuario_Usuario_ID)
    REFERENCES notefood.USUARIO (Usuario_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ALIMENTO_USUARIO_DIETA1
    FOREIGN KEY (DIETA_DIETA_ID , DIETA_USUARIO_ID)
    REFERENCES notefood.DIETA (DIETA_ID , usuario_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX fk_ALIMENTO_has_usuário_usuário1_idx ON notefood.ALIMENTO_USUARIO (usuario_Usuario_ID ASC);

CREATE INDEX fk_ALIMENTO_has_usuário_ALIMENTO1_idx ON notefood.ALIMENTO_USUARIO (ALIMENTO_ALIMENTO_ID ASC, ALIMENTO_SUB_GRUPO_SUB_GRUPO_ID ASC, ALIMENTO_SUB_GRUPO_GRUPO_GRUPO_ID ASC, ALIMENTO_DIETA_DIETA_ID ASC);

CREATE INDEX fk_ALIMENTO_USUARIO_DIETA1_idx ON notefood.ALIMENTO_USUARIO (DIETA_DIETA_ID ASC, DIETA_USUARIO_ID ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

Select * from usuario;
insert usuario value (1, 'Paulo', '03/11/1992', 'paulohenriquercs@gmail.com', 'M', 100.0, 1.87);
desc usuario;

