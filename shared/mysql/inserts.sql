insert into Usuarios values ('Prueba', 'prueba');
insert into Usuarios values ('Admin', 'admin');
insert into Usuarios values ('Socia', 'Socia');

INSERT INTO `inmosoftDB`.`Tipo_Propiedad` values (1, 'casa');
INSERT INTO `inmosoftDB`.`Tipo_Propiedad` values (2, 'bodega');
INSERT INTO `inmosoftDB`.`Tipo_Propiedad` values (3, 'local');
INSERT INTO `inmosoftDB`.`Tipo_Propiedad` values (4, 'apartamento');
INSERT INTO `inmosoftDB`.`Tipo_Propiedad` values (5, 'terreno');

select * from Tipo_Propiedad;

INSERT INTO `inmosoftDB`.`Propietario` 
(`id_propietario`, `nombre_propietario`, `apellido_paterno_propietario`, `apellido_materno_propietario`, `telefono_propietario`, `correo_propietario`) 
VALUES 
(1, 'Carlos', 'Garcia', 'Lopez', '555-1234', 'carlos.garcia@example.com');

INSERT INTO `inmosoftDB`.`Propietario` 
(`id_propietario`, `nombre_propietario`, `apellido_paterno_propietario`, `apellido_materno_propietario`, `telefono_propietario`, `correo_propietario`) 
VALUES 
(2, 'Maria', 'Fernandez', 'Rodriguez', '555-5678', 'maria.fernandez@example.com');

INSERT INTO `inmosoftDB`.`Propietario` 
(`id_propietario`, `nombre_propietario`, `apellido_paterno_propietario`, `apellido_materno_propietario`, `telefono_propietario`, `correo_propietario`) 
VALUES 
(3, 'Luis', 'Perez', 'Martinez', '555-9876', 'luis.perez@example.com');

select * from Propietario;

-- Insert 1
INSERT INTO `inmosoftDB`.`Propiedades` 
(`id_propiedad`, `titulo`, `fecha_alta`, `direccion`, `colonia`, `ciudad`, `referencia`, `precio`, 
 `mts_construccion`, `mts_terreno`, `habitada`, `amueblada`, `num_plantas`, 
 `num_recamaras`, `num_banos`, `size_cochera`, `mts_jardin`, `gas`, `comodidades`, 
 `extras`, `utilidades`, `observaciones`, `id_tipo_propiedad`, `id_propietario`, `usuario`)
VALUES 
(1, 'Casa Saltillo Parque', '2024-10-11', 'Av. Principal 101', 'Centro', 'Saltillo', 'Frente al parque', 3500000, 
 250, 400, 1, 1, 2, 4, 3, 2, 60, 'natural', 'clima,aljibe', 
 'alberca,jardin,techada', 'agua,luz,internet', 
 'Casa amplia con alberca y jardin en excelente ubicacion', 1, 1, 'Admin');

-- Insert 2
INSERT INTO `inmosoftDB`.`Propiedades` 
(`id_propiedad`, `titulo`, `fecha_alta`, `direccion`, `colonia`, `ciudad`, `referencia`, `precio`, 
 `mts_construccion`, `mts_terreno`, `habitada`, `amueblada`, `num_plantas`, 
 `num_recamaras`, `num_banos`, `size_cochera`, `mts_jardin`, `gas`, `comodidades`, 
 `extras`, `utilidades`, `observaciones`, `id_tipo_propiedad`, `id_propietario`, `usuario`)
VALUES 
(2, 'Casa Ramos escuela','2024-10-12', 'Calle Norte 202', 'Las Flores', 'Ramos', 'Cerca de la escuela', 1800000, 
 150, 300, 0, 0, 1, 2, 1, 1, 30, 'estacionario', 'clima,calefaccion', 
 'techada,cocineta', 'agua,luz', 
 'Casa economica, ideal para familias pequenas', 1, 2, 'Admin');

-- Insert 3
INSERT INTO `inmosoftDB`.`Propiedades` 
(`id_propiedad`, `titulo`, `fecha_alta`, `direccion`, `colonia`, `ciudad`, `referencia`, `precio`, 
 `mts_construccion`, `mts_terreno`, `habitada`, `amueblada`, `num_plantas`, 
 `num_recamaras`, `num_banos`, `size_cochera`, `mts_jardin`, `gas`, `comodidades`, 
 `extras`, `utilidades`, `observaciones`, `id_tipo_propiedad`, `id_propietario`, `usuario`)
VALUES 
(3, 'Casa Saltillo Vista Hermosa', '2024-10-13', 'Calle del Sol 303', 'Vista Hermosa', 'Saltillo', 'Cerca del centro', 2900000, 
 180, 350, 1, 0, 2, 3, 2, 2, 50, 'natural', 'calefaccion,hidroneumatico', 
 'jardin,cuarto_servicio', 'agua,luz,internet', 
 'Propiedad con jardin y cochera techada', 1, 3, 'Admin');

-- Insert 4
INSERT INTO `inmosoftDB`.`Propiedades` 
(`id_propiedad`, `titulo`, `fecha_alta`, `direccion`, `colonia`, `ciudad`, `referencia`, `precio`, 
 `mts_construccion`, `mts_terreno`, `habitada`, `amueblada`, `num_plantas`, 
 `num_recamaras`, `num_banos`, `size_cochera`, `mts_jardin`, `gas`, `comodidades`, 
 `extras`, `utilidades`, `observaciones`, `id_tipo_propiedad`, `id_propietario`, `usuario`)
VALUES 
(4, 'Bodega Saltillo Mercado', '2024-10-14', 'Av. de la Paz 404', 'Granjas', 'Saltillo', 'Junto al mercado', 2200000, 
 170, 320, 0, 1, 1, 2, 1, 1, 40, 'estacionario', 'clima', 
 'techada', 'agua', 
 'Casa pequena con cochera techada, cerca del mercado', 2, 1, 'Admin');

-- Insert 5
INSERT INTO `inmosoftDB`.`Propiedades` 
(`id_propiedad`, `titulo`,`fecha_alta`, `direccion`, `colonia`, `ciudad`, `referencia`, `precio`, 
 `mts_construccion`, `mts_terreno`, `habitada`, `amueblada`, `num_plantas`, 
 `num_recamaras`, `num_banos`, `size_cochera`, `mts_jardin`, `gas`, `comodidades`, 
 `extras`, `utilidades`, `observaciones`, `id_tipo_propiedad`, `id_propietario`, `usuario`)
VALUES 
(5, 'Casa Arteaga iglesia', '2024-10-15', 'Calle Luna 505', 'San Angel', 'Arteaga', 'Junto a la iglesia', 3200000, 
 200, 400, 1, 0, 2, 4, 3, 3, 80, 'natural', 'clima,calefaccion', 
 'alberca,jardin', 'agua,luz,internet', 
 'Casa de lujo con alberca y amplio jardin', 1, 2, 'Admin');

-- Insert 6
INSERT INTO `inmosoftDB`.`Propiedades` 
(`id_propiedad`, `titulo`, `fecha_alta`, `direccion`, `colonia`, `ciudad`, `referencia`, `precio`, 
 `mts_construccion`, `mts_terreno`, `habitada`, `amueblada`, `num_plantas`, 
 `num_recamaras`, `num_banos`, `size_cochera`, `mts_jardin`, `gas`, `comodidades`, 
 `extras`, `utilidades`, `observaciones`, `id_tipo_propiedad`, `id_propietario`, `usuario`)
VALUES 
(6, 'Terreno Derramadero Parque ', '2024-10-16', 'Calle Verde 606', 'Bosques', 'derramadero', 'A un lado del parque', 2600000, 
 190, 370, 1, 1, 2, 3, 2, 2, 60, 'natural', 'clima,aljibe', 
 'jardin,cuarto_servicio,techada', 'agua,luz,internet', 
 'Casa en excelente ubicacion con cochera techada y amplio jardin', 5, 3, 'Admin');

select * from Propiedades;

INSERT INTO `inmosoftDB`.`Estado_Propiedades` values (1, 'venta', 'disponible', null, 1);
INSERT INTO `inmosoftDB`.`Estado_Propiedades` values (2, 'renta', 'rentada', null, 2);
INSERT INTO `inmosoftDB`.`Estado_Propiedades` values (3, 'venta', 'vendida', null, 3);
INSERT INTO `inmosoftDB`.`Estado_Propiedades` values (4, 'renta', 'disponible', null, 4);
INSERT INTO `inmosoftDB`.`Estado_Propiedades` values (5, 'venta', 'disponible', null, 5);
INSERT INTO `inmosoftDB`.`Estado_Propiedades` values (6, 'renta', 'rentada', null, 6);   

-- INSERT INTO `inmosoftDB`.`Prospecto` 
-- (`id_cliente`, `nombre_prospecto`, `apellido_paterno_prospecto`, `apellido_materno_prospecto`, `telefono_prospecto`, `correo_prospecto`) 
-- VALUES 
-- (1, 'Juan', 'Gonzalez', 'Perez', '555-1234', 'juan.gonzalez@example.com');

-- INSERT INTO `inmosoftDB`.`Prospecto` 
-- (`id_cliente`, `nombre_prospecto`, `apellido_paterno_prospecto`, `apellido_materno_prospecto`, `telefono_prospecto`, `correo_prospecto`) 
-- VALUES 
-- (2, 'Maria', 'Martinez', 'Lopez', '555-5678', 'maria.martinez@example.com');

-- INSERT INTO `inmosoftDB`.`Prospecto` 
-- (`id_cliente`, `nombre_prospecto`, `apellido_paterno_prospecto`, `apellido_materno_prospecto`, `telefono_prospecto`, `correo_prospecto`) 
-- VALUES 
-- (3, 'Carlos', 'Hernandez', 'Garcia', '555-9101', 'carlos.hernandez@example.com');

-- INSERT INTO `inmosoftDB`.`Prospecto` 
-- (`id_cliente`, `nombre_prospecto`, `apellido_paterno_prospecto`, `apellido_materno_prospecto`, `telefono_prospecto`, `correo_prospecto`) 
-- VALUES 
-- (4, 'Ana', 'Ramirez', 'Sanchez', '555-1122', 'ana.ramirez@example.com');

-- INSERT INTO `inmosoftDB`.`Citas` 
-- (`id_citas`, `titulo_cita`, `fecha_cita`, `hora_cita`, `descripcion_cita`, `usuario`, `id_cliente`) 
-- VALUES 
-- (1, 'Primera visita de inspeccion', '2024-11-10', 1000, 'Primera inspeccion para revisar el estado de la propiedad.', 'Admin', 1);

-- INSERT INTO `inmosoftDB`.`Citas` 
-- (`id_citas`, `titulo_cita`, `fecha_cita`, `hora_cita`, `descripcion_cita`, `usuario`, `id_cliente`) 
-- VALUES 
-- (2, 'Reunion de negociacion', '2024-11-12', 1500, 'Reunion con el cliente para discutir terminos de negociacion.', 'Admin', 2);

-- INSERT INTO `inmosoftDB`.`Citas` 
-- (`id_citas`, `titulo_cita`, `fecha_cita`, `hora_cita`, `descripcion_cita`, `usuario`, `id_cliente`) 
-- VALUES 
-- (3, 'Firma de contrato', '2024-11-15', 1100, 'Cita para la firma de contrato de arrendamiento.', 'Admin', 3);

-- INSERT INTO `inmosoftDB`.`Citas` 
-- (`id_citas`, `titulo_cita`, `fecha_cita`, `hora_cita`, `descripcion_cita`, `usuario`, `id_cliente`) 
-- VALUES 
-- (4, 'Segunda visita de inspeccion', '2024-11-15', 1600, 'Inspeccion para verificar reparaciones y estado final.', 'Admin', 4);

INSERT INTO `inmosoftDB`.`Imagenes` (`id_imagen`, `ruta_imagen`, `descripcion_imagen`, `principal`, `id_propiedad`) 
VALUES 
(1, 'C:\\Users\\josel\\Desktop\\Imagenes\\images1.jpeg', 'Fachada principal de la propiedad.', 1, 1),
(2, 'C:\\Users\\josel\\Desktop\\Imagenes\\images2.jpg', 'Fachada principal de la propiedad.', 0, 1),
(3, 'C:\\Users\\josel\\Desktop\\Imagenes\\images3.jpeg', 'Fachada principal de la propiedad.', 0, 1),
(4, 'C:\\Users\\josel\\Desktop\\Imagenes\\images4.jpg', 'Fachada principal de la propiedad.', 0, 1),
(5, 'C:\\Users\\josel\\Desktop\\Imagenes\\images5.jpeg', 'Fachada principal de la propiedad.', 1, 2),
(6, 'C:\\Users\\josel\\Desktop\\Imagenes\\images6.jpg', 'Fachada principal de la propiedad.', 0, 2),
(7, 'C:\\Users\\josel\\Desktop\\Imagenes\\images7.jpg', 'Fachada principal de la propiedad.', 0, 2),
(8, 'C:\\Users\\josel\\Desktop\\Imagenes\\images8.jpg', 'Fachada principal de la propiedad.', 0, 2),
(9, 'C:\\Users\\josel\\Desktop\\Imagenes\\images9.jpg', 'Fachada principal de la propiedad.', 1, 3),
(10, 'C:\\Users\\josel\\Desktop\\Imagenes\\images10.jpg', 'Fachada principal de la propiedad.', 0, 3),
(11, 'C:\\Users\\josel\\Desktop\\Imagenes\\images11.jpg', 'Fachada principal de la propiedad.', 0, 3),
(12, 'C:\\Users\\josel\\Desktop\\Imagenes\\images12.jpg', 'Fachada principal de la propiedad.', 0, 3),
(13, 'C:\\Users\\josel\\Desktop\\Imagenes\\images13.jpg', 'Fachada principal de la propiedad.', 1, 4),
(14, 'C:\\Users\\josel\\Desktop\\Imagenes\\images14.jpg', 'Fachada principal de la propiedad.', 0, 4),
(15, 'C:\\Users\\josel\\Desktop\\Imagenes\\images15.jpg', 'Fachada principal de la propiedad.', 0, 4),
(16, 'C:\\Users\\josel\\Desktop\\Imagenes\\images16.jpg', 'Fachada principal de la propiedad.', 0, 4),
(17, 'C:\\Users\\josel\\Desktop\\Imagenes\\images17.jpg', 'Fachada principal de la propiedad.', 1, 5),
(18, 'C:\\Users\\josel\\Desktop\\Imagenes\\images18.jpg', 'Fachada principal de la propiedad.', 0, 5),
(19, 'C:\\Users\\josel\\Desktop\\Imagenes\\images19.jpg', 'Fachada principal de la propiedad.', 0, 5),
(20, 'C:\\Users\\josel\\Desktop\\Imagenes\\images20.jpg', 'Fachada principal de la propiedad.', 0, 5),
(21, 'C:\\Users\\josel\\Desktop\\Imagenes\\images21.jpg', 'Fachada principal de la propiedad.', 1, 6),
(22, 'C:\\Users\\josel\\Desktop\\Imagenes\\images22.jpg', 'Fachada principal de la propiedad.', 0, 6),
(23, 'C:\\Users\\josel\\Desktop\\Imagenes\\images23.jpg', 'Fachada principal de la propiedad.', 0, 6),
(24, 'C:\\Users\\josel\\Desktop\\Imagenes\\images24.jpg', 'Fachada principal de la propiedad.', 0, 6);

INSERT INTO `inmosoftDB`.`Contratos` 
(`id_contrato`, `titulo_contrato`, `descripcion_contrato`, `tipo`, `ruta_pdf`, `id_propiedad`) 
VALUES
(1, 'Contrato de Arrendamiento', 'Contrato para el arrendamiento de la propiedad.', 'Arrendamiento', '/pdfs/contrato_arrendamiento1.pdf', 1),
(2, 'Contrato de Compra-Venta', 'Contrato para la compra-venta de la propiedad.', 'Arrendamiento', '/pdfs/contrato_compra_venta1.pdf', 2),
