-- MySQL Script generated by MySQL Workbench
-- Tue 22 Oct 2024 07:24:18 AM CST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema inmosoftDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inmosoftDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inmosoftDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `inmosoftDB` ;

-- -----------------------------------------------------
-- Table `inmosoftDB`.`Tipo_Propiedad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Tipo_Propiedad` (
  `id_tipo_propiedad` INT NOT NULL,
  `tipo_propiedad` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipo_propiedad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Propietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Propietario` (
  `id_propietario` INT NOT NULL,
  `nombre_propietario` VARCHAR(45) NULL,
  `apellido_paterno_propietario` VARCHAR(45) NULL,
  `apellido_materno_propietario` VARCHAR(45) NULL,
  `telefono_propietario` VARCHAR(45) NULL,
  `correo_propietario` VARCHAR(45) NULL,
  PRIMARY KEY (`id_propietario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Usuarios` (
  `id_usuario` INT NOT NULL,
  `usuario` VARCHAR(100) NULL,
  `password_usuario` VARCHAR(45) NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Propiedades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Propiedades` (
  `id_propiedad` INT NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `fecha_alta` DATE NULL,
  `direccion` VARCHAR(45) NULL,
  `colonia` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `referencia` VARCHAR(45) NULL,
  `precio` DOUBLE NULL,
  `mts_construccion` INT NULL,
  `mts_terreno` INT NULL,
  `habitada` TINYINT NULL,
  `amueblada` TINYINT NULL,
  `num_plantas` INT NULL,
  `num_recamaras` INT NULL,
  `num_banos` INT NULL,
  `size_cochera` INT NULL,
  `mts_jardin` INT NULL,
  `gas` SET('estacionario', 'natural') NULL,
  `comodidades` SET('clima', 'calefaccion', 'hidroneumatico', 'aljibe', 'tinaco') NULL DEFAULT NULL,
  `extras` SET('alberca', 'jardin', 'techada', 'cocineta', 'cuarto_servicio') NULL DEFAULT NULL,
  `utilidades` SET('agua', 'luz', 'internet') NULL DEFAULT NULL,
  `observaciones` VARCHAR(1000) NULL,
  `id_tipo_propiedad` INT NOT NULL,
  `id_propietario` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_propiedad`),
  INDEX `fk_Propiedades_Tipo_propiedad2_idx` (`id_tipo_propiedad` ASC) VISIBLE,
  INDEX `fk_Propiedades_Propietario2_idx` (`id_propietario` ASC) VISIBLE,
  INDEX `fk_Propiedades_Usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Propiedades_Tipo_propiedad2`
    FOREIGN KEY (`id_tipo_propiedad`)
    REFERENCES `inmosoftDB`.`Tipo_Propiedad` (`id_tipo_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Propiedades_Propietario2`
    FOREIGN KEY (`id_propietario`)
    REFERENCES `inmosoftDB`.`Propietario` (`id_propietario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Propiedades_Usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `inmosoftDB`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Imagenes` (
  `id_imagen` INT NOT NULL,
  `ruta_imagen` VARCHAR(255) NULL,
  `descripcion_imagen` VARCHAR(500) NULL,
  `principal` TINYINT NULL,
  `id_propiedad` INT NOT NULL,
  PRIMARY KEY (`id_imagen`),
  INDEX `fk_Imagenes_Propiedades1_idx` (`id_propiedad` ASC) VISIBLE,
  CONSTRAINT `fk_Imagenes_Propiedades1`
    FOREIGN KEY (`id_propiedad`)
    REFERENCES `inmosoftDB`.`Propiedades` (`id_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Estado_Propiedades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Estado_Propiedades` (
  `id_estado_propiedades` INT NOT NULL,
  `tipo_transaccion` ENUM('venta', 'renta') NOT NULL,
  `estado` ENUM('disponible', 'vendida', 'rentada') NOT NULL,
  `fecha_transaccion` DATE NULL,
  `id_propiedad` INT NOT NULL,
  PRIMARY KEY (`id_estado_propiedades`),
  INDEX `fk_Estado_Propiedades_Propiedades1_idx` (`id_propiedad` ASC) VISIBLE,
  CONSTRAINT `fk_Estado_Propiedades_Propiedades1`
    FOREIGN KEY (`id_propiedad`)
    REFERENCES `inmosoftDB`.`Propiedades` (`id_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Contratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Contratos` (
  `id_contrato` INT NOT NULL,
  `descripcion_contrato` VARCHAR(1500) NULL,
  `tipo` VARCHAR(45) NULL,
  `ruta_pdf` VARCHAR(255) NULL,
  `id_propiedad` INT NOT NULL,
  PRIMARY KEY (`id_contrato`),
  INDEX `fk_Contratos_Propiedades2_idx` (`id_propiedad` ASC) VISIBLE,
  CONSTRAINT `fk_Contratos_Propiedades2`
    FOREIGN KEY (`id_propiedad`)
    REFERENCES `inmosoftDB`.`Propiedades` (`id_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Prospecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Prospecto` (
  `id_cliente` INT NOT NULL,
  `nombre_prospecto` VARCHAR(45) NULL,
  `apellido_paterno_prospecto` VARCHAR(45) NULL,
  `apellido_materno_prospecto` VARCHAR(45) NULL,
  `telefono_prospecto` VARCHAR(45) NULL,
  `correo_prospecto` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Citas` (
  `id_citas` INT NOT NULL,
  `titulo_cita` VARCHAR(100) NULL,
  `fecha_cita` DATE NULL,
  `hora_cita` INT NULL,
  `descripcion_cita` VARCHAR(2000) NULL,
  `id_usuario` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_propiedad` INT NOT NULL,
  PRIMARY KEY (`id_citas`),
  INDEX `fk_Citas_Usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_Citas_Prospecto1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_Citas_Propiedades1_idx` (`id_propiedad` ASC) VISIBLE,
  CONSTRAINT `fk_Citas_Usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `inmosoftDB`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Citas_Prospecto1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `inmosoftDB`.`Prospecto` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Citas_Propiedades1`
    FOREIGN KEY (`id_propiedad`)
    REFERENCES `inmosoftDB`.`Propiedades` (`id_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Documentos_Anexos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Documentos_Anexos` (
  `id_documento_anexo` INT NOT NULL,
  `ruta_documento` VARCHAR(255) NULL,
  `descripcion_documento_anexo` VARCHAR(45) NULL,
  `id_propiedad` INT NOT NULL,
  PRIMARY KEY (`id_documento_anexo`),
  INDEX `fk_Documentos_Anexos_Propiedades2_idx` (`id_propiedad` ASC) VISIBLE,
  CONSTRAINT `fk_Documentos_Anexos_Propiedades2`
    FOREIGN KEY (`id_propiedad`)
    REFERENCES `inmosoftDB`.`Propiedades` (`id_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
