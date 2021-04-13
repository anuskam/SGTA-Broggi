-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema broggi
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `broggi` ;

-- -----------------------------------------------------
-- Schema broggi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `broggi` DEFAULT CHARACTER SET utf8 ;
USE `broggi` ;

-- -----------------------------------------------------
-- Table `broggi`.`tipus_incidencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`tipus_incidencies` ;

CREATE TABLE IF NOT EXISTS `broggi`.`tipus_incidencies` (
  `id` INT NOT NULL,
  `tipus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipus_UNIQUE` (`tipus` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`tipus_alertants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`tipus_alertants` ;

CREATE TABLE IF NOT EXISTS `broggi`.`tipus_alertants` (
  `id` INT NOT NULL,
  `tipus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipus_UNIQUE` (`tipus` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`provincies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`provincies` ;

CREATE TABLE IF NOT EXISTS `broggi`.`provincies` (
  `id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`comarques`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`comarques` ;

CREATE TABLE IF NOT EXISTS `broggi`.`comarques` (
  `id` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `provincies_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comarques_provincies1_idx` (`provincies_id` ASC),
  CONSTRAINT `fk_comarques_provincies1`
    FOREIGN KEY (`provincies_id`)
    REFERENCES `broggi`.`provincies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`municipis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`municipis` ;

CREATE TABLE IF NOT EXISTS `broggi`.`municipis` (
  `id` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `comarques_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_municipis_comarques1_idx` (`comarques_id` ASC),
  CONSTRAINT `fk_municipis_comarques1`
    FOREIGN KEY (`comarques_id`)
    REFERENCES `broggi`.`comarques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`alertants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`alertants` ;

CREATE TABLE IF NOT EXISTS `broggi`.`alertants` (
  `id` INT NOT NULL,
  `telefon` INT(10) NOT NULL,
  `nom` VARCHAR(150) NULL,
  `cognoms` VARCHAR(150) NULL,
  `adreca` VARCHAR(150) NULL,
  `municipis_id` INT NULL,
  `tipus_alertants_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_alertants_tipus_alertants1_idx` (`tipus_alertants_id` ASC),
  INDEX `fk_alertants_municipis1_idx` (`municipis_id` ASC),
  CONSTRAINT `fk_alertants_tipus_alertants1`
    FOREIGN KEY (`tipus_alertants_id`)
    REFERENCES `broggi`.`tipus_alertants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alertants_municipis1`
    FOREIGN KEY (`municipis_id`)
    REFERENCES `broggi`.`municipis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`rols`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`rols` ;

CREATE TABLE IF NOT EXISTS `broggi`.`rols` (
  `id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`tipus_recursos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`tipus_recursos` ;

CREATE TABLE IF NOT EXISTS `broggi`.`tipus_recursos` (
  `id` INT NOT NULL,
  `tipus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipus_UNIQUE` (`tipus` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`recursos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`recursos` ;

CREATE TABLE IF NOT EXISTS `broggi`.`recursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codi` VARCHAR(45) NOT NULL,
  `actiu` TINYINT NOT NULL,
  `tipus_recursos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recursos_tipus_recursos1_idx` (`tipus_recursos_id` ASC),
  CONSTRAINT `fk_recursos_tipus_recursos1`
    FOREIGN KEY (`tipus_recursos_id`)
    REFERENCES `broggi`.`tipus_recursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`usuaris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`usuaris` ;

CREATE TABLE IF NOT EXISTS `broggi`.`usuaris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `contrasenya` VARCHAR(256) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `cognoms` VARCHAR(45) NOT NULL,
  `rols_id` INT NOT NULL,
  `recursos_id` INT,
  PRIMARY KEY (`id`),
  INDEX `fk_usuaris_rols1_idx` (`rols_id` ASC),
  INDEX `fk_usuaris_recursos1_idx` (`recursos_id` ASC),
  CONSTRAINT `fk_usuaris_rols1`
    FOREIGN KEY (`rols_id`)
    REFERENCES `broggi`.`rols` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuaris_recursos1`
    FOREIGN KEY (`recursos_id`)
    REFERENCES `broggi`.`recursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`incidencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`incidencies` ;

CREATE TABLE IF NOT EXISTS `broggi`.`incidencies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `num_incident` INT NOT NULL,
  `data` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `telefon_alertant` INT(10) NOT NULL,
  `adreca` VARCHAR(150) NOT NULL,
  `adreca_complement` VARCHAR(150) NULL,
  `descripcio` VARCHAR(256) NOT NULL,
  `nom_metge` VARCHAR(45) NULL,
  `tipus_incidencies_id` INT NOT NULL,
  `alertants_id` INT NOT NULL,
  `municipis_id` INT NOT NULL,
  `usuaris_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `num_incident_UNIQUE` (`num_incident` ASC),
  INDEX `fk_incidencies_tipus_incidents1_idx` (`tipus_incidencies_id` ASC),
  INDEX `fk_incidencies_alertants1_idx` (`alertants_id` ASC),
  INDEX `fk_incidencies_municipis1_idx` (`municipis_id` ASC),
  INDEX `fk_incidencies_usuaris1_idx` (`usuaris_id` ASC),
  CONSTRAINT `fk_incidencies_tipus_incidents1`
    FOREIGN KEY (`tipus_incidencies_id`)
    REFERENCES `broggi`.`tipus_incidencies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incidencies_alertants1`
    FOREIGN KEY (`alertants_id`)
    REFERENCES `broggi`.`alertants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incidencies_municipis1`
    FOREIGN KEY (`municipis_id`)
    REFERENCES `broggi`.`municipis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incidencies_usuaris1`
    FOREIGN KEY (`usuaris_id`)
    REFERENCES `broggi`.`usuaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`sexes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`sexes` ;

CREATE TABLE IF NOT EXISTS `broggi`.`sexes` (
  `id` INT NOT NULL,
  `sexe` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sexe_UNIQUE` (`sexe` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`afectats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`afectats` ;

CREATE TABLE IF NOT EXISTS `broggi`.`afectats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cip` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(45) NULL,
  `edat` VARCHAR(45) NULL,
  `te_cip` TINYINT NULL,
  `sexes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_afectats_sexes1_idx` (`sexes_id` ASC),
  CONSTRAINT `fk_afectats_sexes1`
    FOREIGN KEY (`sexes_id`)
    REFERENCES `broggi`.`sexes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`incidencies_has_afectats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`incidencies_has_afectats` ;

CREATE TABLE IF NOT EXISTS `broggi`.`incidencies_has_afectats` (
  `incidencies_id` INT NOT NULL,
  `afectats_id` INT NOT NULL,
  PRIMARY KEY (`incidencies_id`, `afectats_id`),
  INDEX `fk_incidencies_has_afectats_afectats1_idx` (`afectats_id` ASC),
  INDEX `fk_incidencies_has_afectats_incidencies_idx` (`incidencies_id` ASC),
  CONSTRAINT `fk_incidencies_has_afectats_incidencies`
    FOREIGN KEY (`incidencies_id`)
    REFERENCES `broggi`.`incidencies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incidencies_has_afectats_afectats1`
    FOREIGN KEY (`afectats_id`)
    REFERENCES `broggi`.`afectats` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `broggi`.`incidencies_has_recursos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`incidencies_has_recursos` ;

CREATE TABLE IF NOT EXISTS `broggi`.`incidencies_has_recursos` (
  `incidencies_id` INT NOT NULL,
  `recursos_id` INT NOT NULL,
  `afectats_id` INT NOT NULL,
  `hora_activacio` TIME NULL,
  `hora_mobilitzacio` TIME NULL,
  `hora_assistencia` TIME NULL,
  `hora_transport` TIME NULL,
  `hora_arribada_hospital` TIME NULL,
  `hora_transferencia` TIME NULL,
  `hora_finalitzacio` TIME NULL,
  `prioritat` INT NULL,
  `desti` VARCHAR(100) NULL,
  PRIMARY KEY (`incidencies_id`, `recursos_id`, `afectats_id`),
  INDEX `fk_incidencies_has_recursos_recursos1_idx` (`recursos_id` ASC),
  INDEX `fk_incidencies_has_recursos_incidencies1_idx` (`incidencies_id` ASC),
  CONSTRAINT `fk_incidencies_has_recursos_incidencies1`
    FOREIGN KEY (`incidencies_id`)
    REFERENCES `broggi`.`incidencies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incidencies_has_recursos_recursos1`
    FOREIGN KEY (`recursos_id`)
    REFERENCES `broggi`.`recursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_incidencies_has_recursos_afectats1`
    FOREIGN KEY (`afectats_id`)
    REFERENCES `broggi`.`afectats` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';

-- -----------------------------------------------------
-- Table `broggi`.`preguntes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`preguntes` ;

CREATE TABLE IF NOT EXISTS `broggi`.`preguntes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pregunta` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pregunta_UNIQUE` (`pregunta` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `broggi`.`respostes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `broggi`.`respostes` ;

CREATE TABLE IF NOT EXISTS `broggi`.`respostes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `resposta` VARCHAR(60) NOT NULL,
  `preguntes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_respostes_preguntes1_idx` (`preguntes_id` ASC),
  CONSTRAINT `fk_respostes_preguntes1`
    FOREIGN KEY (`preguntes_id`)
    REFERENCES `broggi`.`preguntes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `broggi`.`tipus_incidencies`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`tipus_incidencies` (`id`, `tipus`) VALUES (1, 'Accident');
INSERT INTO `broggi`.`tipus_incidencies` (`id`, `tipus`) VALUES (2, 'Traumatisme');
INSERT INTO `broggi`.`tipus_incidencies` (`id`, `tipus`) VALUES (3, 'Malaltia lloc públic');
INSERT INTO `broggi`.`tipus_incidencies` (`id`, `tipus`) VALUES (4, 'Malaltia domicili');
INSERT INTO `broggi`.`tipus_incidencies` (`id`, `tipus`) VALUES (5, 'Consulta mèdica');
INSERT INTO `broggi`.`tipus_incidencies` (`id`, `tipus`) VALUES (6, 'Transport sanitari');

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`tipus_alertants`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`tipus_alertants` (`id`, `tipus`) VALUES (1, 'Centre sanitari');
INSERT INTO `broggi`.`tipus_alertants` (`id`, `tipus`) VALUES (2, 'Afectat');
INSERT INTO `broggi`.`tipus_alertants` (`id`, `tipus`) VALUES (3, 'Entorn afectat');
INSERT INTO `broggi`.`tipus_alertants` (`id`, `tipus`) VALUES (4, 'VIP');
INSERT INTO `broggi`.`tipus_alertants` (`id`, `tipus`) VALUES (5, 'Accidental');

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`provincies`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`provincies` (`id`, `nom`) VALUES (1, 'Barcelona');
INSERT INTO `broggi`.`provincies` (`id`, `nom`) VALUES (2, 'Girona');
INSERT INTO `broggi`.`provincies` (`id`, `nom`) VALUES (3, 'Lleida');
INSERT INTO `broggi`.`provincies` (`id`, `nom`) VALUES (4, 'Tarragona');

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`comarques`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (1, 'Alt Camp', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (2, 'Alt Empordà', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (3, 'Alt Penedès', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (4, 'Alt Urgell', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (5, 'Alta Ribagorça', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (6, 'Anoia', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (7, 'Aran', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (8, 'Bages', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (9, 'Baix Camp', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (10, 'Baix Ebre', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (11, 'Baix Empordà', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (12, 'Baix Llobregat', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (13, 'Baix Penedès', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (14, 'Barcelonès', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (16, 'Berguedà', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (17, 'Cerdanya', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (18, 'Cerdanya', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (19, 'Conca de Barberà', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (20, 'Garraf', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (21, 'Garrigues', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (22, 'Garrotxa', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (23, 'Gironès', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (24, 'Maresme', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (25, 'Moianès', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (26, 'Montsià', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (27, 'Noguera', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (28, 'Osona', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (29, 'Osona', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (30, 'Pallars Jussà', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (31, 'Pla de l\'Estany', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (32, 'Pla d\'Urgell', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (33, 'Priorat', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (34, 'Ribera d\'Ebre', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (35, 'Ripollès', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (36, 'Segarra', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (37, 'Segrià', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (38, 'Selva', 2);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (39, 'Solsonès', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (40, 'Tarragonès', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (41, 'Terra Alta', 4);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (42, 'Urgell', 3);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (43, 'Vallès Occidental', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (44, 'Vallès Oriental', 1);
INSERT INTO `broggi`.`comarques` (`id`, `nom`, `provincies_id`) VALUES (45, 'Pallars Sobirà', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`municipis`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (1, 'Abella de la Conca', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (2, 'Abrera', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (3, 'Àger', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (4, 'Agramunt', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (5, 'Aguilar de Segarra', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (6, 'Agullana', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (7, 'Aiguafreda', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (8, 'Aiguamúrcia', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (9, 'Aiguaviva', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (10, 'Aitona', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (11, 'Els Alamús', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (12, 'Alàs i Cerc', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (13, 'L\'Albagés', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (14, 'Albanyà', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (15, 'Albatàrrec', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (16, 'Albesa', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (17, 'L\'Albi', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (18, 'Albinyana', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (19, 'L\'Albiol', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (20, 'Albons', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (21, 'Alcanar', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (22, 'Alcanó', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (23, 'Alcarràs', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (24, 'Alcoletge', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (25, 'Alcover', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (26, 'L\'Aldea', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (27, 'Aldover', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (28, 'L\'Aleixar', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (29, 'Alella', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (30, 'Alfara de Carles', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (31, 'Alfarràs', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (32, 'Alfés', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (33, 'Alforja', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (34, 'Algerri', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (35, 'Alguaire', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (36, 'Alins', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (37, 'Alió', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (38, 'Almacelles', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (39, 'Almatret', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (40, 'Almenar', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (41, 'Almoster', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (42, 'Alòs de Balaguer', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (43, 'Alp', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (44, 'Alpens', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (45, 'Alpicat', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (46, 'Alt Àneu', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (47, 'Altafulla', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (48, 'Amer', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (49, 'L\'Ametlla de Mar', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (50, 'L\'Ametlla del Vallès', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (51, 'L\'Ampolla', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (52, 'Amposta', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (53, 'Anglès', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (54, 'Anglesola', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (55, 'Arbeca', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (56, 'L\'Arboç', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (57, 'Arbolí', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (58, 'Arbúcies', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (59, 'Arenys de Mar', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (60, 'Arenys de Munt', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (61, 'Argelaguer', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (62, 'Argençola', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (63, 'L\'Argentera', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (64, 'Argentona', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (65, 'L\'Armentera', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (66, 'Arnes', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (67, 'Arres', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (68, 'Arsèguel', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (69, 'Artés', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (70, 'Artesa de Lleida', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (71, 'Artesa de Segre', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (72, 'Ascó', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (73, 'Aspa', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (74, 'Les Avellanes i Santa Linya', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (75, 'Avià', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (76, 'Avinyó', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (77, 'Avinyonet de Puigventós', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (78, 'Avinyonet del Penedès', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (79, 'Badalona', 14);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (80, 'Badia del Vallès', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (81, 'Bagà', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (82, 'Baix Pallars', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (83, 'Balaguer', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (84, 'Balenyà', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (85, 'Balsareny', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (86, 'Banyeres del Penedès', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (87, 'Banyoles', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (88, 'Barbens', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (89, 'Barberà de la Conca', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (90, 'Barberà del Vallès', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (91, 'Barcelona', 14);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (92, 'La Baronia de Rialb', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (93, 'Bàscara', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (94, 'Bassella', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (95, 'Batea', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (96, 'Bausen', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (97, 'Begues', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (98, 'Begur', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (99, 'Belianes', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (100, 'Bellaguarda', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (101, 'Bellcaire d\'Empordà', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (102, 'Bellcaire d\'Urgell', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (103, 'Bell-lloc d\'Urgell', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (104, 'Bellmunt del Priorat', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (105, 'Bellmunt d\'Urgell', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (106, 'Bellprat', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (107, 'Bellpuig', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (108, 'Bellvei', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (109, 'Bellver de Cerdanya', 18);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (110, 'Bellvís', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (111, 'Benavent de Segrià', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (112, 'Benifallet', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (113, 'Benissanet', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (114, 'Berga', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (115, 'Besalú', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (116, 'Bescanó', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (117, 'Beuda', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (118, 'Bigues i Riells', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (119, 'Biosca', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (120, 'La Bisbal de Falset', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (121, 'La Bisbal del Penedès', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (122, 'La Bisbal d\'Empordà', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (123, 'Biure', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (124, 'Blancafort', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (125, 'Blanes', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (126, 'Boadella i les Escaules', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (127, 'Bolvir', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (128, 'Bonastre', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (129, 'Es Bòrdes', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (130, 'Bordils', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (131, 'Les Borges Blanques', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (132, 'Les Borges del Camp', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (133, 'Borrassà', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (134, 'Borredà', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (135, 'Bossòst', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (136, 'Bot', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (137, 'Botarell', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (138, 'Bovera', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (139, 'Bràfim', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (140, 'Breda', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (141, 'El Bruc', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (142, 'El Brull', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (143, 'Brunyola i Sant Martí Sapresa', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (144, 'Cabacés', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (145, 'Cabanabona', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (146, 'Cabanelles', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (147, 'Cabanes', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (148, 'Les Cabanyes', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (149, 'Cabó', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (150, 'Cabra del Camp', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (151, 'Cabrera d\'Anoia', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (152, 'Cabrera de Mar', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (153, 'Cabrils', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (154, 'Cadaqués', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (155, 'Calaf', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (156, 'Calafell', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (157, 'Calders', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (158, 'Caldes de Malavella', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (159, 'Caldes de Montbui', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (160, 'Caldes d\'Estrac', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (161, 'Calella', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (162, 'Calldetenes', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (163, 'Callús', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (164, 'Calonge de Segarra', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (165, 'Calonge i Sant Antoni', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (166, 'Camarasa', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (167, 'Camarles', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (168, 'Cambrils', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (169, 'Camós', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (170, 'Campdevànol', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (171, 'Campelles', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (172, 'Campins', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (173, 'Campllong', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (174, 'Camprodon', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (175, 'Canejan', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (176, 'Canet d\'Adri', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (177, 'Canet de Mar', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (178, 'La Canonja', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (179, 'Canovelles', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (180, 'Cànoves i Samalús', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (181, 'Cantallops', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (182, 'Canyelles', 20);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (183, 'Capafonts', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (184, 'Capçanes', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (185, 'Capellades', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (186, 'Capmany', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (187, 'Capolat', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (188, 'Cardedeu', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (189, 'Cardona', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (190, 'Carme', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (191, 'Caseres', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (192, 'Cassà de la Selva', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (193, 'Casserres', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (194, 'Castell de l\'Areny', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (195, 'Castell de Mur', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (196, 'Castellar de la Ribera', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (197, 'Castellar de n\'Hug', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (198, 'Castellar del Riu', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (199, 'Castellar del Vallès', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (200, 'Castellbell i el Vilar', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (201, 'Castellbisbal', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (202, 'Castellcir', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (203, 'Castelldans', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (204, 'Castelldefels', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (205, 'Castellet i la Gornal', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (206, 'Castellfollit de la Roca', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (207, 'Castellfollit de Riubregós', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (208, 'Castellfollit del Boix', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (209, 'Castellgalí', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (210, 'Castellnou de Bages', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (211, 'Castellnou de Seana', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (212, 'Castelló de Farfanya', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (213, 'Castelló d\'Empúries', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (214, 'Castellolí', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (215, 'Castell-Platja d\'Aro', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (216, 'Castellserà', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (217, 'Castellterçol', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (218, 'Castellvell del Camp', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (219, 'Castellví de la Marca', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (220, 'Castellví de Rosanes', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (221, 'El Catllar', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (222, 'Cava', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (223, 'La Cellera de Ter', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (224, 'Celrà', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (225, 'Centelles', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (226, 'Cercs', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (227, 'Cerdanyola del Vallès', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (228, 'Cervelló', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (229, 'Cervera', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (230, 'Cervià de les Garrigues', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (231, 'Cervià de Ter', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (232, 'Cistella', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (233, 'Ciutadilla', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (234, 'Clariana de Cardener', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (235, 'El Cogul', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (236, 'Colera', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (237, 'Coll de Nargó', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (238, 'Collbató', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (239, 'Colldejou', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (240, 'Collsuspina', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (241, 'Colomers', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (242, 'La Coma i la Pedra', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (243, 'Conca de Dalt', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (244, 'Conesa', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (245, 'Constantí', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (246, 'Copons', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (247, 'Corbera de Llobregat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (248, 'Corbera d\'Ebre', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (249, 'Corbins', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (250, 'Corçà', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (251, 'Cornellà de Llobregat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (252, 'Cornellà del Terri', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (253, 'Cornudella de Montsant', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (254, 'Creixell', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (255, 'Crespià', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (256, 'Cruïlles, Monells i Sant Sadurní de l\'Heura', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (257, 'Cubelles', 20);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (258, 'Cubells', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (259, 'Cunit', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (260, 'Darnius', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (261, 'Das', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (262, 'Deltebre', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (263, 'Dosrius', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (264, 'Duesaigües', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (265, 'L\'Escala', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (266, 'Esparreguera', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (267, 'Espinelves', 29);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (268, 'L\'Espluga Calba', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (269, 'L\'Espluga de Francolí', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (270, 'Esplugues de Llobregat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (271, 'Espolla', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (272, 'Esponellà', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (273, 'Espot', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (274, 'L\'Espunyola', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (275, 'L\'Esquirol', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (276, 'Estamariu', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (277, 'L\'Estany', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (278, 'Estaràs', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (279, 'Esterri d\'Àneu', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (280, 'Esterri de Cardós', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (281, 'Falset', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (282, 'El Far d\'Empordà', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (283, 'Farrera', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (284, 'La Fatarella', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (285, 'La Febró', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (286, 'Figaró-Montmany', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (287, 'Fígols', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (288, 'Fígols i Alinyà', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (289, 'La Figuera', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (290, 'Figueres', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (291, 'Figuerola del Camp', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (292, 'Flaçà', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (293, 'Flix', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (294, 'La Floresta', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (295, 'Fogars de la Selva', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (296, 'Fogars de Montclús', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (297, 'Foixà', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (298, 'Folgueroles', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (299, 'Fondarella', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (300, 'Fonollosa', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (301, 'Fontanals de Cerdanya', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (302, 'Fontanilles', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (303, 'Fontcoberta', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (304, 'Font-rubí', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (305, 'Foradada', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (306, 'Forallac', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (307, 'Forès', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (308, 'Fornells de la Selva', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (309, 'Fortià', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (310, 'Les Franqueses del Vallès', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (311, 'Freginals', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (312, 'La Fuliola', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (313, 'Fulleda', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (314, 'Gaià', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (315, 'La Galera', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (316, 'Gallifa', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (317, 'Gandesa', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (318, 'Garcia', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (319, 'Els Garidells', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (320, 'La Garriga', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (321, 'Garrigàs', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (322, 'Garrigoles', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (323, 'Garriguella', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (324, 'Gavà', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (325, 'Gavet de la Conca', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (326, 'Gelida', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (327, 'Ger', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (328, 'Gimenells i el Pla de la Font', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (329, 'Ginestar', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (330, 'Girona', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (331, 'Gironella', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (332, 'Gisclareny', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (333, 'Godall', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (334, 'Golmés', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (335, 'Gombrèn', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (336, 'Gósol', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (337, 'La Granada', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (338, 'La Granadella', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (339, 'Granera', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (340, 'La Granja d\'Escarp', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (341, 'Granollers', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (342, 'Granyanella', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (343, 'Granyena de les Garrigues', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (344, 'Granyena de Segarra', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (345, 'Gratallops', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (346, 'Gualba', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (347, 'Gualta', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (348, 'Guardiola de Berguedà', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (349, 'Els Guiamets', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (350, 'Guils de Cerdanya', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (351, 'Guimerà', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (352, 'La Guingueta d\'Àneu', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (353, 'Guissona', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (354, 'Guixers', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (355, 'Gurb', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (356, 'Horta de Sant Joan', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (357, 'L\'Hospitalet de Llobregat', 14);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (358, 'Els Hostalets de Pierola', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (359, 'Hostalric', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (360, 'Igualada', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (361, 'Isona i Conca Dellà', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (362, 'Isòvol', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (363, 'Ivars de Noguera', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (364, 'Ivars d\'Urgell', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (365, 'Ivorra', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (366, 'Jafre', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (367, 'La Jonquera', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (368, 'Jorba', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (369, 'Josa i Tuixén', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (370, 'Juià', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (371, 'Juncosa', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (372, 'Juneda', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (373, 'Les', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (374, 'Linyola', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (375, 'La Llacuna', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (376, 'Lladó', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (377, 'Lladorre', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (378, 'Lladurs', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (379, 'La Llagosta', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (380, 'Llagostera', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (381, 'Llambilles', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (382, 'Llanars', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (383, 'Llançà', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (384, 'Llardecans', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (385, 'Llavorsí', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (386, 'Lleida', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (387, 'Llers', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (388, 'Lles de Cerdanya', 18);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (389, 'Lliçà d\'Amunt', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (390, 'Lliçà de Vall', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (391, 'Llimiana', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (392, 'Llinars del Vallès', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (393, 'Llívia', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (394, 'El Lloar', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (395, 'Llobera', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (396, 'Llorac', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (397, 'Llorenç del Penedès', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (398, 'Lloret de Mar', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (399, 'Les Llosses', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (400, 'Lluçà', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (401, 'Maçanet de Cabrenys', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (402, 'Maçanet de la Selva', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (403, 'Madremanya', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (404, 'Maià de Montcal', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (405, 'Maials', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (406, 'Maldà', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (407, 'Malgrat de Mar', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (408, 'Malla', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (409, 'Manlleu', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (410, 'Manresa', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (411, 'Marçà', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (412, 'Margalef', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (413, 'Marganell', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (414, 'Martorell', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (415, 'Martorelles', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (416, 'Mas de Barberans', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (417, 'Masarac', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (418, 'Masdenverge', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (419, 'Les Masies de Roda', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (420, 'Les Masies de Voltregà', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (421, 'Masllorenç', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (422, 'El Masnou', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (423, 'La Masó', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (424, 'Maspujols', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (425, 'Masquefa', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (426, 'El Masroig', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (427, 'Massalcoreig', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (428, 'Massanes', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (429, 'Massoteres', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (430, 'Matadepera', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (431, 'Mataró', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (432, 'Mediona', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (433, 'Menàrguens', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (434, 'Meranges', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (435, 'Mieres', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (436, 'El Milà', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (437, 'Miralcamp', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (438, 'Miravet', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (439, 'Moià', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (440, 'El Molar', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (441, 'Molins de Rei', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (442, 'Mollerussa', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (443, 'Mollet de Peralada', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (444, 'Mollet del Vallès', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (445, 'Molló', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (446, 'La Molsosa', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (447, 'Monistrol de Calders', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (448, 'Monistrol de Montserrat', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (449, 'Montagut i Oix', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (450, 'Montblanc', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (451, 'Montbrió del Camp', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (452, 'Montcada i Reixac', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (453, 'Montclar', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (454, 'Montellà i Martinet', 18);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (455, 'Montesquiu', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (456, 'Montferrer i Castellbò', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (457, 'Montferri', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (458, 'Montgai', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (459, 'Montgat', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (460, 'Montmajor', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (461, 'Montmaneu', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (462, 'El Montmell', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (463, 'Montmeló', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (464, 'Montoliu de Lleida', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (465, 'Montoliu de Segarra', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (466, 'Montornès de Segarra', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (467, 'Montornès del Vallès', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (468, 'Mont-ral', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (469, 'Mont-ras', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (470, 'Mont-roig del Camp', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (471, 'Montseny', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (472, 'Móra d\'Ebre', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (473, 'Móra la Nova', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (474, 'El Morell', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (475, 'La Morera de Montsant', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (476, 'Muntanyola', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (477, 'Mura', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (478, 'Nalec', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (479, 'Naut Aran', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (480, 'Navarcles', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (481, 'Navàs', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (482, 'Navata', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (483, 'Navès', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (484, 'La Nou de Berguedà', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (485, 'La Nou de Gaià', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (486, 'Nulles', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (487, 'Odèn', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (488, 'Òdena', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (489, 'Ogassa', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (490, 'Olèrdola', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (491, 'Olesa de Bonesvalls', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (492, 'Olesa de Montserrat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (493, 'Oliana', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (494, 'Oliola', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (495, 'Olius', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (496, 'Olivella', 20);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (497, 'Olost', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (498, 'Olot', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (499, 'Les Oluges', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (500, 'Olvan', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (501, 'Els Omellons', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (502, 'Els Omells de na Gaia', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (503, 'Ordis', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (504, 'Organyà', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (505, 'Orís', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (506, 'Oristà', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (507, 'Orpí', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (508, 'Òrrius', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (509, 'Os de Balaguer', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (510, 'Osor', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (511, 'Ossó de Sió', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (512, 'Pacs del Penedès', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (513, 'Palafolls', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (514, 'Palafrugell', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (515, 'Palamós', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (516, 'El Palau d\'Anglesola', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (517, 'Palau de Santa Eulàlia', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (518, 'Palau-sator', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (519, 'Palau-saverdera', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (520, 'Palau-solità i Plegamans', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (521, 'Els Pallaresos', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (522, 'Pallejà', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (523, 'La Palma de Cervelló', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (524, 'La Palma d\'Ebre', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (525, 'Palol de Revardit', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (526, 'Pals', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (527, 'El Papiol', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (528, 'Pardines', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (529, 'Parets del Vallès', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (530, 'Parlavà', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (531, 'Passanant i Belltall', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (532, 'Pau', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (533, 'Paüls', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (534, 'Pedret i Marzà', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (535, 'Penelles', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (536, 'La Pera', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (537, 'Perafita', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (538, 'Perafort', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (539, 'Peralada', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (540, 'Peramola', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (541, 'El Perelló', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (542, 'Piera', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (543, 'Les Piles', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (544, 'Pineda de Mar', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (545, 'El Pinell de Brai', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (546, 'Pinell de Solsonès', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (547, 'Pinós', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (548, 'Pira', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (549, 'El Pla de Santa Maria', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (550, 'El Pla del Penedès', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (551, 'Les Planes d\'Hostoles', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (552, 'Planoles', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (553, 'Els Plans de Sió', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (554, 'El Poal', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (555, 'La Pobla de Cérvoles', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (556, 'La Pobla de Claramunt', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (557, 'La Pobla de Lillet', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (558, 'La Pobla de Mafumet', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (559, 'La Pobla de Massaluca', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (560, 'La Pobla de Montornès', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (561, 'La Pobla de Segur', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (562, 'Poboleda', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (563, 'Polinyà', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (564, 'El Pont d\'Armentera', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (565, 'El Pont de Bar', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (566, 'Pont de Molins', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (567, 'El Pont de Suert', 5);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (568, 'El Pont de Vilomara i Rocafort', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (569, 'Pontils', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (570, 'Pontons', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (571, 'Pontós', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (572, 'Ponts', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (573, 'Porqueres', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (574, 'Porrera', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (575, 'El Port de la Selva', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (576, 'Portbou', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (577, 'La Portella', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (578, 'Pradell de la Teixeta', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (579, 'Prades', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (580, 'Prat de Comte', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (581, 'El Prat de Llobregat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (582, 'Pratdip', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (583, 'Prats de Lluçanès', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (584, 'Els Prats de Rei', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (585, 'Prats i Sansor', 18);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (586, 'Preixana', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (587, 'Preixens', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (588, 'Premià de Dalt', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (589, 'Premià de Mar', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (590, 'Les Preses', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (591, 'Prullans', 18);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (592, 'Puigcerdà', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (593, 'Puigdàlber', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (594, 'Puiggròs', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (595, 'Puigpelat', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (596, 'Puig-reig', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (597, 'Puigverd d\'Agramunt', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (598, 'Puigverd de Lleida', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (599, 'Pujalt', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (600, 'La Quar', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (601, 'Quart', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (602, 'Queralbs', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (603, 'Querol', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (604, 'Rabós', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (605, 'Rajadell', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (606, 'Rasquera', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (607, 'Regencós', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (608, 'Rellinars', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (609, 'Renau', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (610, 'Reus', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (611, 'Rialp', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (612, 'La Riba', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (613, 'Riba-roja d\'Ebre', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (614, 'Ribera d\'Ondara', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (615, 'Ribera d\'Urgellet', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (616, 'Ribes de Freser', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (617, 'Riells i Viabrea', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (618, 'La Riera de Gaià', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (619, 'Riner', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (620, 'Ripoll', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (621, 'Ripollet', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (622, 'Riu de Cerdanya', 18);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (623, 'Riudarenes', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (624, 'Riudaura', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (625, 'Riudecanyes', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (626, 'Riudecols', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (627, 'Riudellots de la Selva', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (628, 'Riudoms', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (629, 'Riumors', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (630, 'La Roca del Vallès', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (631, 'Rocafort de Queralt', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (632, 'Roda de Berà', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (633, 'Roda de Ter', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (634, 'Rodonyà', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (635, 'Roquetes', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (636, 'Roses', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (637, 'Rosselló', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (638, 'El Rourell', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (639, 'Rubí', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (640, 'Rubió', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (641, 'Rupià', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (642, 'Rupit i Pruit', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (643, 'Sabadell', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (644, 'Sagàs', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (645, 'Salàs de Pallars', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (646, 'Saldes', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (647, 'Sales de Llierca', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (648, 'Sallent', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (649, 'Salomó', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (650, 'Salou', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (651, 'Salt', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (652, 'Sanaüja', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (653, 'Sant Adrià de Besòs', 14);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (654, 'Sant Agustí de Lluçanès', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (655, 'Sant Andreu de la Barca', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (656, 'Sant Andreu de Llavaneres', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (657, 'Sant Andreu Salou', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (658, 'Sant Aniol de Finestres', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (659, 'Sant Antoni de Vilamajor', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (660, 'Sant Bartomeu del Grau', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (661, 'Sant Boi de Llobregat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (662, 'Sant Boi de Lluçanès', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (663, 'Sant Carles de la Ràpita', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (664, 'Sant Cebrià de Vallalta', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (665, 'Sant Celoni', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (666, 'Sant Climent de Llobregat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (667, 'Sant Climent Sescebes', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (668, 'Sant Cugat del Vallès', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (669, 'Sant Cugat Sesgarrigues', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (670, 'Sant Esteve de la Sarga', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (671, 'Sant Esteve de Palautordera', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (672, 'Sant Esteve Sesrovires', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (673, 'Sant Feliu de Buixalleu', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (674, 'Sant Feliu de Codines', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (675, 'Sant Feliu de Guíxols', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (676, 'Sant Feliu de Llobregat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (677, 'Sant Feliu de Pallerols', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (678, 'Sant Feliu Sasserra', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (679, 'Sant Ferriol', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (680, 'Sant Fost de Campsentelles', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (681, 'Sant Fruitós de Bages', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (682, 'Sant Gregori', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (683, 'Sant Guim de Freixenet', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (684, 'Sant Guim de la Plana', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (685, 'Sant Hilari Sacalm', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (686, 'Sant Hipòlit de Voltregà', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (687, 'Sant Iscle de Vallalta', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (688, 'Sant Jaume de Frontanyà', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (689, 'Sant Jaume de Llierca', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (690, 'Sant Jaume dels Domenys', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (691, 'Sant Jaume d\'Enveja', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (692, 'Sant Joan de les Abadesses', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (693, 'Sant Joan de Mollet', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (694, 'Sant Joan de Vilatorrada', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (695, 'Sant Joan Despí', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (696, 'Sant Joan les Fonts', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (697, 'Sant Jordi Desvalls', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (698, 'Sant Julià de Cerdanyola', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (699, 'Sant Julià de Ramis', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (700, 'Sant Julià de Vilatorta', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (701, 'Sant Julià del Llor i Bonmatí', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (702, 'Sant Just Desvern', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (703, 'Sant Llorenç de la Muga', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (704, 'Sant Llorenç de Morunys', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (705, 'Sant Llorenç d\'Hortons', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (706, 'Sant Llorenç Savall', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (707, 'Sant Martí d\'Albars', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (708, 'Sant Martí de Centelles', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (709, 'Sant Martí de Llémena', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (710, 'Sant Martí de Riucorb', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (711, 'Sant Martí de Tous', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (712, 'Sant Martí Sarroca', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (713, 'Sant Martí Sesgueioles', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (714, 'Sant Martí Vell', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (715, 'Sant Mateu de Bages', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (716, 'Sant Miquel de Campmajor', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (717, 'Sant Miquel de Fluvià', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (718, 'Sant Mori', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (719, 'Sant Pau de Segúries', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (720, 'Sant Pere de Ribes', 20);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (721, 'Sant Pere de Riudebitlles', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (722, 'Sant Pere de Torelló', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (723, 'Sant Pere de Vilamajor', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (724, 'Sant Pere Pescador', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (725, 'Sant Pere Sallavinera', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (726, 'Sant Pol de Mar', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (727, 'Sant Quintí de Mediona', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (728, 'Sant Quirze de Besora', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (729, 'Sant Quirze del Vallès', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (730, 'Sant Quirze Safaja', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (731, 'Sant Ramon', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (732, 'Sant Sadurní d\'Anoia', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (733, 'Sant Sadurní d\'Osormort', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (734, 'Sant Salvador de Guardiola', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (735, 'Sant Vicenç de Castellet', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (736, 'Sant Vicenç de Montalt', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (737, 'Sant Vicenç de Torelló', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (738, 'Sant Vicenç dels Horts', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (739, 'Santa Bàrbara', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (740, 'Santa Cecília de Voltregà', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (741, 'Santa Coloma de Cervelló', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (742, 'Santa Coloma de Farners', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (743, 'Santa Coloma de Gramenet', 14);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (744, 'Santa Coloma de Queralt', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (745, 'Santa Cristina d\'Aro', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (746, 'Santa Eugènia de Berga', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (747, 'Santa Eulàlia de Riuprimer', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (748, 'Santa Eulàlia de Ronçana', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (749, 'Santa Fe del Penedès', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (750, 'Santa Llogaia d\'Àlguema', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (751, 'Santa Margarida de Montbui', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (752, 'Santa Margarida i els Monjos', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (753, 'Santa Maria de Besora', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (754, 'Santa Maria de Martorelles', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (755, 'Santa Maria de Merlès', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (756, 'Santa Maria de Miralles', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (757, 'Santa Maria de Palautordera', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (758, 'Santa Maria d\'Oló', 25);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (759, 'Santa Oliva', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (760, 'Santa Pau', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (761, 'Santa Perpètua de Mogoda', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (762, 'Santa Susanna', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (763, 'Santpedor', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (764, 'Sarral', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (765, 'Sarrià de Ter', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (766, 'Sarroca de Bellera', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (767, 'Sarroca de Lleida', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (768, 'Saus, Camallera i Llampaies', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (769, 'Savallà del Comtat', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (770, 'La Secuita', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (771, 'La Selva de Mar', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (772, 'La Selva del Camp', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (773, 'Senan', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (774, 'La Sénia', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (775, 'Senterada', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (776, 'La Sentiu de Sió', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (777, 'Sentmenat', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (778, 'Serinyà', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (779, 'Seròs', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (780, 'Serra de Daró', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (781, 'Setcases', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (782, 'La Seu d\'Urgell', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (783, 'Seva', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (784, 'Sidamon', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (785, 'Sils', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (786, 'Sitges', 20);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (787, 'Siurana', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (788, 'Sobremunt', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (789, 'El Soleràs', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (790, 'Solivella', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (791, 'Solsona', 39);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (792, 'Sora', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (793, 'Soriguera', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (794, 'Sort', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (795, 'Soses', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (796, 'Subirats', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (797, 'Sudanell', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (798, 'Sunyer', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (799, 'Súria', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (800, 'Susqueda', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (801, 'Tagamanent', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (802, 'Talamanca', 8);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (803, 'Talarn', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (804, 'Talavera', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (805, 'La Tallada d\'Empordà', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (806, 'Taradell', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (807, 'Tarragona', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (808, 'Tàrrega', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (809, 'Tarrés', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (810, 'Tarroja de Segarra', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (811, 'Tavèrnoles', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (812, 'Tavertet', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (813, 'Teià', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (814, 'Térmens', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (815, 'Terrades', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (816, 'Terrassa', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (817, 'Tiana', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (818, 'Tírvia', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (819, 'Tiurana', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (820, 'Tivenys', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (821, 'Tivissa', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (822, 'Tona', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (823, 'Torà', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (824, 'Tordera', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (825, 'Torelló', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (826, 'Els Torms', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (827, 'Tornabous', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (828, 'La Torre de Cabdella', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (829, 'La Torre de Claramunt', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (830, 'La Torre de Fontaubella', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (831, 'La Torre de l\'Espanyol', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (832, 'Torrebesses', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (833, 'Torredembarra', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (834, 'Torrefarrera', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (835, 'Torrefeta i Florejacs', 36);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (836, 'Torregrossa', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (837, 'Torrelameu', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (838, 'Torrelavit', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (839, 'Torrelles de Foix', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (840, 'Torrelles de Llobregat', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (841, 'Torrent', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (842, 'Torres de Segre', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (843, 'Torre-serona', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (844, 'Torroella de Fluvià', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (845, 'Torroella de Montgrí', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (846, 'Torroja del Priorat', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (847, 'Tortellà', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (848, 'Tortosa', 10);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (849, 'Toses', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (850, 'Tossa de Mar', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (851, 'Tremp', 30);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (852, 'Ullà', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (853, 'Ullastrell', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (854, 'Ullastret', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (855, 'Ulldecona', 26);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (856, 'Ulldemolins', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (857, 'Ultramort', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (858, 'Urús', 17);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (859, 'Vacarisses', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (860, 'La Vajol', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (861, 'La Vall de Bianya', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (862, 'La Vall de Boí', 5);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (863, 'Vall de Cardós', 45);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (864, 'La Vall d\'en Bas', 22);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (865, 'Vallbona d\'Anoia', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (866, 'Vallbona de les Monges', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (867, 'Vallcebre', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (868, 'Vallclara', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (869, 'Vallfogona de Balaguer', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (870, 'Vallfogona de Ripollès', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (871, 'Vallfogona de Riucorb', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (872, 'Vallgorguina', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (873, 'Vallirana', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (874, 'Vall-llobrega', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (875, 'Vallmoll', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (876, 'Vallromanes', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (877, 'Valls', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (878, 'Les Valls d\'Aguilar', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (879, 'Les Valls de Valira', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (880, 'Vandellòs i l\'Hospitalet de l\'Infant', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (881, 'La Vansa i Fórnols', 4);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (882, 'Veciana', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (883, 'El Vendrell', 13);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (884, 'Ventalló', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (885, 'Verdú', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (886, 'Verges', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (887, 'Vespella de Gaià', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (888, 'Vic', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (889, 'Vidrà', 29);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (890, 'Vidreres', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (891, 'Vielha e Mijaran', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (892, 'Vilabella', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (893, 'Vilabertran', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (894, 'Vilablareix', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (895, 'Vilada', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (896, 'Viladamat', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (897, 'Viladasens', 23);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (898, 'Viladecans', 12);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (899, 'Viladecavalls', 43);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (900, 'Vilademuls', 31);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (901, 'Viladrau', 29);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (902, 'Vilafant', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (903, 'Vilafranca del Penedès', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (904, 'Vilagrassa', 42);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (905, 'Vilajuïga', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (906, 'Vilalba dels Arcs', 41);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (907, 'Vilalba Sasserra', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (908, 'Vilaller', 5);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (909, 'Vilallonga de Ter', 35);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (910, 'Vilallonga del Camp', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (911, 'Vilamacolum', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (912, 'Vilamalla', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (913, 'Vilamaniscle', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (914, 'Vilamòs', 7);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (915, 'Vilanant', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (916, 'Vilanova de Bellpuig', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (917, 'Vilanova de la Barca', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (918, 'Vilanova de l\'Aguda', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (919, 'Vilanova de Meià', 27);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (920, 'Vilanova de Prades', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (921, 'Vilanova de Sau', 28);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (922, 'Vilanova de Segrià', 37);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (923, 'Vilanova del Camí', 6);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (924, 'Vilanova del Vallès', 44);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (925, 'Vilanova d\'Escornalbou', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (926, 'Vilanova i la Geltrú', 20);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (927, 'Vilaplana', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (928, 'Vila-rodona', 1);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (929, 'Vila-sacra', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (930, 'Vila-sana', 32);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (931, 'Vila-seca', 40);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (932, 'Vilassar de Dalt', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (933, 'Vilassar de Mar', 24);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (934, 'Vilaür', 2);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (935, 'Vilaverd', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (936, 'La Vilella Alta', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (937, 'La Vilella Baixa', 33);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (938, 'Vilobí del Penedès', 3);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (939, 'Vilobí d\'Onyar', 38);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (940, 'Vilopriu', 11);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (941, 'El Vilosell', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (942, 'Vimbodí i Poblet', 19);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (943, 'Vinaixa', 21);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (944, 'Vinebre', 34);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (945, 'Vinyols i els Arcs', 9);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (946, 'Viver i Serrateix', 16);
INSERT INTO `broggi`.`municipis` (`id`, `nom`, `comarques_id`) VALUES (947, 'Xerta', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`alertants`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (1, 973350050, 'Fundació Sant Hospital', '', 'Pg. de Joan Brudieu, 8', 782, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (2, 972880150, 'Hospital de Puigcerdà', '', 'Pl. de Santa Maria, 1', 592, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (3, 973652255, 'Hospital Comarcal del Pallars', '', 'Pau Casals, 5', 851, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (4, 973640004, 'Espitau Val d\'Aran', '', 'Espitau, 8', 891, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (5, 973232943, 'Clínica de Ponent', '', 'Prat de la Riba, 79', 386, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (6, 973727222, 'Hospital Santa Maria', '', 'Av. Alcalde Rovira Roure, 44', 386, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (7, 973248100, 'Hospital Universitari Arnau de Vilanova de Lleida', '', 'Av. Alcalde Rovira Roure, 80', 386, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (8, 977613000, 'Pius Hospital de Valls', '', 'Pl. Sant Francesc, s/n', 877, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (9, 977010800, 'Centre Mèdic Quirúrgic Reus', '', 'Antoni Gaudí, 26', 610, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (10, 977337303, 'Hospital Sant Joan de Reus', '', 'Josep Laporte, s/n', 610, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (11, 977257900, 'Hospital del Vendrell', '', 'Carretera de Barcelona, s/n', 883, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (12, 977259900, 'Hospital Sant Pau i Santa Tecla', '', 'Rambla Vella, 14', 807, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (13, 977295800, 'Hospital Universitari Joan XXIII de Tarragona', '', 'Dr. Mallafré i Guasch, 4', 807, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (14, 977519100, 'Hospital Verge de la Cinta de Tortosa', '', 'Esplanetes, 44-58', 848, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (15, 977588200, 'Clínica Terres de l\'Ebre', '', 'Pl. Joaquim Bau, 6-8', 848, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (16, 977700050, 'Hospital Comarcal d\'Amposta', '', 'Jacint Verdaguer, 11', 52, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (17, 977401674, 'Hospital Comarcal Móra d\'Ebre', '', 'Benet i Messeguer, s/n', 472, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (18, 972501400, 'Hospital de Figueres', '', 'Ronda del Rector Arolas, s/n', 290, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (19, 972600160, 'Hospital de Palamós', '', 'Hospital, 36', 515, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (20, 972261800, 'Hospital Sant Jaume d\'Olot', '', 'Mulleras, 15', 498, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (21, 972204500, 'Clínica Girona', '', 'Joan Maragall, 26', 330, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (22, 972225833, 'ICO Girona', '', 'Av. de França, s/n', 330, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (23, 972940200, 'Hospital Universitari Doctor Josep Trueta de Girona', '', 'Av. de França, s/n', 330, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (24, 972182500, 'Hospital Santa Caterina', '', 'Dr. Castany, s/n (Parc Hospitalari Martí i Julià)', 651, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (25, 937690201, 'Hospital Comarcal Sant Jaume de Calella', '', 'Sant Jaume, 209', 161, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (26, 972570208, 'Clínica Salus Infirmorum', '', 'Av. Mossèn Lluís Constans, 130', 87, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (27, 972730013, 'Hospital de Campdevànol', '', 'Ctra. de Gombrèn, 20', 170, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (28, 972353264, 'Hospital Comarcal de Blanes', '', 'Accés cala Sant Francesc, 5', 125, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (29, 938075500, 'Hospital d\'Igualada', '', 'Av. Catalunya, 11', 360, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (30, 938732550, 'Centre Hospitalari', '', 'Av. de les Bases de Manresa, 6-8', 410, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (31, 938742112, 'Hospital Sant Joan de Déu', '', 'Dr. Joan Soler, s/n', 410, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (32, 938243400, 'Hospital Comarcal Sant Bernabé', '', 'Ctra. de Ribes, s/n', 114, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (33, 938891111, 'Hospital General de Vic', '', 'Francesc Pla El Vigatà, 1', 888, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (34, 938180440, 'Hospital Comarcal de l\'Alt Penedès', '', 'Espirall, s/n', 903, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (35, 937742020, 'Hospital Sant Joan de Déu', '', 'Av. Mancomunitats Comarcals, 1', 414, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (36, 936615208, 'Hospital General. Parc Sanitari Sant Joan de Déu', '', 'Camí Vell de la Colònia, 25', 661, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (37, 936590111, 'Hospital de Viladecans', '', 'Av. de Gavà, 38', 898, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (38, 932532100, 'Hospital Sant Joan de Déu', '', 'Pg. de Sant Joan de Déu, 2', 270, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (39, 935531200, 'Hospital de Sant Joan Despí Moisès Broggi', '', 'Jacint Verdaguer, 90', 695, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (40, 932483000, 'Hospital del Mar', '', 'Pg. Marítim, 25-29', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (41, 933069900, 'Hospital Plató', '', 'Plató, 21', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (42, 933674100, 'Hospital de l\'Esperança', '', 'Sant Josep de la Muntanya, 12', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (43, 934169700, 'Fundació Puigvert / Iuna', '', 'Cartagena, 340', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (44, 935072700, 'Hospital Dos de Maig', '', 'Dos de Maig, 301', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (45, 932275600, 'Hospital Casa Maternitat', '', 'Sabino de Arana, 1', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (46, 933221111, 'Hospital Universitari Sagrat Cor', '', 'Viladomat, 288', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (47, 934893000, 'Hospital Universitari General de la Vall d\'Hebron', '', 'Pg. de la Vall d\'Hebron, 119-129', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (48, 932112508, 'Hospital Sant Rafael', '', 'Pg. de la Vall d\'Hebron, 107', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (49, 934893000, 'Hospital Universitari Maternoinfantil de la Vall d\'Hebron', '', 'Pg. de la Vall d\'Hebron, 119-129', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (50, 934893000, 'Hospital Universitari de Traumatologia i Rehabilitació de la Vall d\'Hebron', '', 'Pg. de la Vall d\'Hebron, 119-129', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (51, 932275400, 'Hospital Clínic i Provincial de Barcelona', '', 'Villarroel, 170', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (52, 935537160, 'Hospital de la Santa Creu i Sant Pau', '', 'Sant Quintí, 89', 91, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (53, 934407500, 'Hospital General de l\'Hospitalet', '', 'Josep Molins, 29', 357, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (54, 932607733, 'ICO L\'Hospitalet', '', 'Av. de la Granvia, s/n km 2,7 (Hospital Duran i Reynals)', 357, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (55, 932607500, 'Hospital Universitari de Bellvitge', '', 'Feixa Llarga, s/n', 357, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (56, 934648300, 'Hospital Municipal Badalona', '', 'Via Augusta, 9-13', 79, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (57, 934977700, 'Institut Guttmann', '', 'Camí de Can Ruti, s/n', 79, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (58, 934978710, 'ICO Badalona', '', 'Ctra. de Canyet, s/n', 79, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (59, 934651200, 'Hospital Universitari Germans Trias i Pujol de Badalona', '', 'Ctra. de Canyet, s/n', 79, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (60, 933860202, 'Fundació Hospital de l\'Esperit Sant', '', 'Av. de Mossèn Josep Pons i Robadà, s/n', 743, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (61, 938931616, 'Fundació Hospital Comarcal Sant Antoni Abat', '', 'Rambla de Sant Josep, 21', 926, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (62, 938960025, 'Fundació Hospital Residència Sant Camil', '', 'Ctra. de Puigmoltó, km 0,8', 720, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (63, 937417700, 'Hospital de Mataró', '', 'Ctra. de Cirera, s/n', 431, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (64, 937231010, 'Hospital de Sabadell', '', 'Parc Taulí, s/n', 643, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (65, 937365050, 'Hospital Mútua Terrassa', '', 'Pl. Dr. Robert, 5', 816, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (66, 937310007, 'Hospital de Terrassa', '', 'Ctra. de Torrebonica, s/n', 816, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (67, 935760300, 'Fundació Privada Hospital de Mollet', '', 'Sant Llorenç, 39', 444, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (68, 938425000, 'Hospital General de Granollers', '', 'Av. de Francesc Ribas, s/n', 341, 1);
INSERT INTO `broggi`.`alertants` (`id`, `telefon`, `nom`, `cognoms`, `adreca`, `municipis_id`, `tipus_alertants_id`) VALUES (69, 938670617, 'Hospital de Sant Celoni', '', 'Av. de l\'Hospital, 19', 665, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`rols`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`rols` (`id`, `nom`) VALUES (1, 'Administrador');
INSERT INTO `broggi`.`rols` (`id`, `nom`) VALUES (2, 'CECOS');
INSERT INTO `broggi`.`rols` (`id`, `nom`) VALUES (3, 'Recurs');

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`tipus_recursos`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`tipus_recursos` (`id`, `tipus`) VALUES (1, 'Amb. Medicalitzada-Mike');
INSERT INTO `broggi`.`tipus_recursos` (`id`, `tipus`) VALUES (2, 'Amb. Sanitaritzada-India');
INSERT INTO `broggi`.`tipus_recursos` (`id`, `tipus`) VALUES (3, 'Amb. Assitencial-Tango');
INSERT INTO `broggi`.`tipus_recursos` (`id`, `tipus`) VALUES (4, 'Helicopter medicalitzat');

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`recursos`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`recursos` (`id`, `codi`, `actiu`, `tipus_recursos_id`) VALUES (null, 'MIKE', true, 1);
INSERT INTO `broggi`.`recursos` (`id`, `codi`, `actiu`, `tipus_recursos_id`) VALUES (null, 'MIKE2', true, 1);
INSERT INTO `broggi`.`recursos` (`id`, `codi`, `actiu`, `tipus_recursos_id`) VALUES (null, 'INDIA', true, 2);
INSERT INTO `broggi`.`recursos` (`id`, `codi`, `actiu`, `tipus_recursos_id`) VALUES (null, 'INDIA2', true, 2);
INSERT INTO `broggi`.`recursos` (`id`, `codi`, `actiu`, `tipus_recursos_id`) VALUES (null, 'TANGO', true, 3);
INSERT INTO `broggi`.`recursos` (`id`, `codi`, `actiu`, `tipus_recursos_id`) VALUES (null, 'TANGO2', true, 3);
INSERT INTO `broggi`.`recursos` (`id`, `codi`, `actiu`, `tipus_recursos_id`) VALUES (null, 'HELI', true, 4);
INSERT INTO `broggi`.`recursos` (`id`, `codi`, `actiu`, `tipus_recursos_id`) VALUES (null, 'HELI2', true, 4);


COMMIT;

-- -----------------------------------------------------
-- Data for table `broggi`.`sexes`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;
INSERT INTO `broggi`.`sexes` (`id`, `sexe`) VALUES (1, 'Home');
INSERT INTO `broggi`.`sexes` (`id`, `sexe`) VALUES (2, 'Dona');

COMMIT;


-- -----------------------------------------------------
-- Data for table `broggi`.`afectats`
-- -----------------------------------------------------
START TRANSACTION;
USE `broggi`;

INSERT INTO `afectats` VALUES (NULL, 'CITE9510263558', 'Citra', 'Terranova', 23, 1, 2);
INSERT INTO `afectats` VALUES (NULL, NULL, 'Belen', 'Esteban', 60, 0, 2);
INSERT INTO `afectats` VALUES (NULL, 'ROMA1102586558', 'Felix', 'Bonito', 5, 1, 1);

COMMIT;