-- MySQL Script generated by MySQL Workbench
-- Thu 03 Oct 2024 12:23:12 PM CST
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
CREATE SCHEMA IF NOT EXISTS `inmosoftDB` DEFAULT CHARACTER SET cp1256 ;
USE `inmosoftDB` ;

-- -----------------------------------------------------
-- Table `inmosoftDB`.`Estado_Propiedades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Estado_Propiedades` (
  `id_estado_propiedades` INT NOT NULL,
  `disponible_venta` TINYINT(1) NULL,
  `disponible_renta` TINYINT(1) NULL,
  `rentada` TINYINT(1) NULL,
  `vendida` TINYINT(1) NULL,
  PRIMARY KEY (`id_estado_propiedades`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Tipo_propiedad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Tipo_propiedad` (
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
-- Table `inmosoftDB`.`Propiedades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Propiedades` (
  `id_propiedad` INT NOT NULL,
  `calle_propiedad` VARCHAR(255) NULL,
  `numero_propiedad` INT NULL,
  `colonia_propiedad` VARCHAR(255) NULL,
  `ciudad_propiedad` VARCHAR(50) NULL,
  `cp_propiedad` INT(5) NULL,
  `num_habitaciones_propiedad` INT NULL,
  `precio_propiedad` DOUBLE NULL,
  `zona_propiedad` VARCHAR(45) NULL,
  `metros_terreno_propiedad` INT NULL,
  `metros_construccion_propiedad` INT NULL,
  `fecha_alta` DATE NULL,
  `num_baños_propiedad` INT NULL,
  `cochera_propiedad` TINYINT(1) NULL,
  `jardin_propiedad` TINYINT(1) NULL,
  `id_estado_propiedades` INT NOT NULL,
  `id_tipo_propiedad` INT NOT NULL,
  `id_propietario` INT NOT NULL,
  PRIMARY KEY (`id_propiedad`),
  INDEX `fk_Propiedades_Estado_Propiedades1_idx` (`id_estado_propiedades` ASC) VISIBLE,
  INDEX `fk_Propiedades_Tipo_propiedad1_idx` (`id_tipo_propiedad` ASC) VISIBLE,
  INDEX `fk_Propiedades_Propietario1_idx` (`id_propietario` ASC) VISIBLE,
  CONSTRAINT `fk_Propiedades_Estado_Propiedades1`
    FOREIGN KEY (`id_estado_propiedades`)
    REFERENCES `inmosoftDB`.`Estado_Propiedades` (`id_estado_propiedades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Propiedades_Tipo_propiedad1`
    FOREIGN KEY (`id_tipo_propiedad`)
    REFERENCES `inmosoftDB`.`Tipo_propiedad` (`id_tipo_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Propiedades_Propietario1`
    FOREIGN KEY (`id_propietario`)
    REFERENCES `inmosoftDB`.`Propietario` (`id_propietario`)
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
  `id_propiedad` INT NOT NULL,
  PRIMARY KEY (`id_imagen`),
  INDEX `fk_Imagenes_Propiedades_idx` (`id_propiedad` ASC) VISIBLE,
  CONSTRAINT `fk_Imagenes_Propiedades`
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
  INDEX `fk_Contratos_Propiedades1_idx` (`id_propiedad` ASC) VISIBLE,
  CONSTRAINT `fk_Contratos_Propiedades1`
    FOREIGN KEY (`id_propiedad`)
    REFERENCES `inmosoftDB`.`Propiedades` (`id_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inmosoftDB`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmosoftDB`.`Usuarios` (
  `id_usuario` INT NOT NULL,
  `correo_usuario` VARCHAR(100) NULL,
  `contraseña_usuario` VARCHAR(45) NULL,
  PRIMARY KEY (`id_usuario`))
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
  `id_propiedad` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `Prospecto_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_citas`),
  INDEX `fk_Citas_Propiedades1_idx` (`id_propiedad` ASC) VISIBLE,
  INDEX `fk_Citas_Usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_Citas_Prospecto1_idx` (`Prospecto_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Citas_Propiedades1`
    FOREIGN KEY (`id_propiedad`)
    REFERENCES `inmosoftDB`.`Propiedades` (`id_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Citas_Usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `inmosoftDB`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Citas_Prospecto1`
    FOREIGN KEY (`Prospecto_id_cliente`)
    REFERENCES `inmosoftDB`.`Prospecto` (`id_cliente`)
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
  `Propiedades_id_propiedad` INT NOT NULL,
  PRIMARY KEY (`id_documento_anexo`),
  INDEX `fk_Documentos_Anexos_Propiedades1_idx` (`Propiedades_id_propiedad` ASC) VISIBLE,
  CONSTRAINT `fk_Documentos_Anexos_Propiedades1`
    FOREIGN KEY (`Propiedades_id_propiedad`)
    REFERENCES `inmosoftDB`.`Propiedades` (`id_propiedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
