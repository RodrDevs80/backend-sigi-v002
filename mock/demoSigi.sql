-- =====================================================
-- SCRIPT DE DATOS DE PRUEBA -
-- =====================================================
USE `NombreDeTuBaseDeDatos`; -- Reemplaza con el nombre de tu base de datos

-- Desactivar temporalmente restricciones para inserciones masivas
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------
-- Tabla: roles
-- -----------------------------------------------------
INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `createdAt`, `updatedAt`) VALUES
(1, 'ADMIN', 'Administrador del sistema', NOW(), NOW()),
(2, 'DOCENTE', 'Docente de la institución', NOW(), NOW()),
(3, 'ESTUDIANTE', 'Alumno regular', NOW(), NOW()),
(4, 'RECTOR', 'Rector de la institución', NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: administrativos
-- -----------------------------------------------------
INSERT INTO `administrativos` (`id`, `nombre`, `apellido`, `email`, `dni`, `contrasenia`, `telefono`, `domicilio`, `id_rol`, `activo`, `createdAt`, `updatedAt`) VALUES
(1, 'María', 'Gómez', 'maria.gomez@instituto.edu', '20123456', '$2b$10$ejemplo1', '351-1111111', 'Calle 1 N° 100', 1, 1, NOW(), NOW()),
(2, 'Carlos', 'Pérez', 'carlos.perez@instituto.edu', '20765432', '$2b$10$ejemplo2', '351-2222222', 'Av. Siempre Viva 742', 2, 1, NOW(), NOW()),
(3, 'Laura', 'Fernández', 'laura.fernandez@instituto.edu', '20876543', '$2b$10$ejemplo3', '351-3333333', 'Calle 3 N° 300', 3, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: usuarios
-- -----------------------------------------------------
INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`, `contrasenia`, `activo`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 'Juan', 'López', 'juan.lopez@correo.com', '$2b$10$hashpass1', 1, 1, NOW(), NOW()),
(2, 'Ana', 'Martínez', 'ana.martinez@correo.com', '$2b$10$hashpass2', 1, 1, NOW(), NOW()),
(3, 'Pedro', 'García', 'pedro.garcia@correo.com', '$2b$10$hashpass3', 1, 1, NOW(), NOW()),
(4, 'Sofía', 'Rodríguez', 'sofia.rodriguez@correo.com', '$2b$10$hashpass4', 1, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: docentes
-- -----------------------------------------------------
INSERT INTO `docentes` (`id`, `nombre`, `apellido`, `email`, `contrasenia`, `dni`, `titulo`, `especialidad`, `domicilio`, `telefono`, `foto`, `id_administrativo`, `activo`, `fecha_de_alta`, `updatedAt`) VALUES
(1, 'Marcelo', 'Díaz', 'marcelo.diaz@instituto.edu', '$2b$10$doc1', '30111222', 'Lic. en Matemáticas', 'Cálculo', 'Calle Falsa 123', '351-5550001', NULL, 2, 1, NOW(), NOW()),
(2, 'Graciela', 'Ruiz', 'graciela.ruiz@instituto.edu', '$2b$10$doc2', '30222333', 'Ing. en Sistemas', 'Programación', 'Av. Corrientes 456', '351-5550002', NULL, 2, 1, NOW(), NOW()),
(3, 'Omar', 'Sosa', 'omar.sosa@instituto.edu', '$2b$10$doc3', '30333444', 'Prof. de Historia', 'Historia Argentina', 'Calle 9 de Julio 789', '351-5550003', NULL, 2, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: carreras
-- -----------------------------------------------------
INSERT INTO `carreras` (`id`, `codigo`, `nombre`, `tipo`, `imagen`, `descripcion`, `dossier`, `activo`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 'TSPW-001', 'Tecnicatura Superior en Programación Web', 'permanente', NULL, 'Carrera de desarrollo web', 'dossier_web.pdf', 1, 1, NOW(), NOW()),
(2, 'TSDS-002', 'Tecnicatura Superior en Data Science', 'a_termino', NULL, 'Carrera de ciencia de datos', 'dossier_ds.pdf', 1, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: planes_estudios
-- -----------------------------------------------------
INSERT INTO `planes_estudios` (`id`, `version`, `fecha_de_aprobacion`, `fecha_de_cierre`, `duracion_en_anios`, `estado`, `id_carrera`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, '2024-v1', '2024-02-01', '2026-12-31', 3, 'VIGENTE', 1, 1, NOW(), NOW()),
(2, '2024-v2', '2024-03-01', '2027-12-31', 3, 'VIGENTE', 2, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: ciclos_lectivos
-- -----------------------------------------------------
INSERT INTO `ciclos_lectivos` (`id`, `anio`, `activo`, `fechaInicio`, `fechaFin`, `id_plan_estudio`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 2025, 1, '2025-03-01', '2025-12-20', 1, 1, NOW(), NOW()),
(2, 2026, 0, '2026-03-01', '2026-12-20', 2, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: cursos
-- -----------------------------------------------------
INSERT INTO `cursos` (`id`, `cupo_estudiantes`, `anio_academico`, `id_ciclo_lectivo`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 30, 1, 1, 1, NOW(), NOW()),
(2, 25, 2, 1, 1, NOW(), NOW()),
(3, 35, 1, 2, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: unidades_curriculares
-- -----------------------------------------------------
INSERT INTO `unidades_curriculares` (`id`, `id_plan_estudio`, `nombre`, `duracion`, `cargaHoraria`, `cuatrimestre`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'Programación I', 'cuatrimestral', 120, 'primero', 1, NOW(), NOW()),
(2, 1, 'Matemática Aplicada', 'cuatrimestral', 90, 'primero', 1, NOW(), NOW()),
(3, 1, 'Base de Datos', 'anual', 160, NULL, 1, NOW(), NOW()),
(4, 2, 'Estadística', 'cuatrimestral', 100, 'segundo', 1, NOW(), NOW()),
(5, 2, 'Machine Learning', 'anual', 200, NULL, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: divisiones
-- -----------------------------------------------------
INSERT INTO `divisiones` (`id`, `id_docente`, `id_curso`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 1, NOW(), NOW()),
(2, 2, 1, 1, NOW(), NOW()),
(3, 3, 2, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: divisiones_x_unidades_curriculares
-- -----------------------------------------------------
INSERT INTO `divisiones_x_unidades_curriculares` (`id`, `id_division`, `id_unidad_curricular`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 1, NOW(), NOW()),
(2, 1, 2, 1, NOW(), NOW()),
(3, 2, 1, 1, NOW(), NOW()),
(4, 3, 4, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: estudiantes
-- -----------------------------------------------------
INSERT INTO `estudiantes` (`id`, `dni`, `nombre`, `apellido`, `email`, `telefono`, `domicilio`, `fecha_de_nacimiento`, `foto`, `trabaja`, `activo`, `id_administrativo`, `id_usuario`, `createdAt`, `updatedAt`) VALUES
(1, '40123456', 'Juan', 'López', 'juan.lopez@correo.com', '351-1110000', 'Calle Estudiante 1', '2000-05-15', NULL, 0, 1, 1, 1, NOW(), NOW()),
(2, '40234567', 'Ana', 'Martínez', 'ana.martinez@correo.com', '351-2220000', 'Calle Estudiante 2', '2001-08-22', NULL, 1, 1, 1, 2, NOW(), NOW()),
(3, '40345678', 'Pedro', 'García', 'pedro.garcia@correo.com', '351-3330000', 'Calle Estudiante 3', '2002-11-30', NULL, 0, 1, 1, 3, NOW(), NOW()),
(4, '40456789', 'Sofía', 'Rodríguez', 'sofia.rodriguez@correo.com', '351-4440000', 'Calle Estudiante 4', '2003-02-10', NULL, 0, 1, 1, 4, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: legajos
-- -----------------------------------------------------
INSERT INTO `legajos` (`id`, `id_estudiante`, `numeroLegajo`, `id_plan_estudio`, `activo`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 10001, 1, 1, 1, NOW(), NOW()),
(2, 2, 10002, 1, 1, 1, NOW(), NOW()),
(3, 3, 10003, 2, 1, 1, NOW(), NOW()),
(4, 4, 10004, 2, 1, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: asistencias
-- -----------------------------------------------------
INSERT INTO `asistencias` (`id`, `id_division_x_unidad_curricular`, `fecha`, `presente`, `id_legajo`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, '2025-04-01', 1, 1, 1, NOW(), NOW()),
(2, 1, '2025-04-01', 0, 2, 1, NOW(), NOW()),
(3, 2, '2025-04-02', 1, 1, 1, NOW(), NOW()),
(4, 3, '2025-04-03', 1, 2, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: cambios_planes_estudios
-- -----------------------------------------------------
INSERT INTO `cambios_planes_estudios` (`id`, `id_legajo`, `id_plan_estudio_origen`, `id_plan_estudio_destino`, `id_usuario_gestor`, `fecha_solicitud`, `fecha_aprobacion`, `plazo_vencimiento`, `estado`, `observaciones`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 2, NULL, '2025-05-01', NULL, NULL, 'PENDIENTE', 'Cambio de plan por motivos laborales', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: movimientos_financieros
-- -----------------------------------------------------
INSERT INTO `movimientos_financieros` (`id`, `id_estudiante`, `tipo`, `concepto`, `monto`, `fecha`, `medio_pago`, `descripcion`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'INGRESO', 'Cuota Mensual Mayo', 5000, '2025-05-10', 'Transferencia', NULL, 1, NOW(), NOW()),
(2, 2, 'EGRESO', 'Devolución material', 1500, '2025-04-28', 'Efectivo', 'Devolución por error de facturación', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: comprobantes_alumnos
-- -----------------------------------------------------
INSERT INTO `comprobantes_alumnos` (`id`, `id_movimiento_financiero`, `url_comprobante`, `concepto`, `fecha_carga`, `estado`, `fecha_confirmacion`, `id_administrativo`) VALUES
(1, 1, 'https://example.com/comprobantes/comp1.pdf', 'Pago Mayo', '2025-05-10', 'NO_VALIDADO', NULL, NULL);

-- -----------------------------------------------------
-- Tabla: correlatividades
-- -----------------------------------------------------
INSERT INTO `correlatividades` (`id`, `id_plan`, `id_unidad_curricular`, `id_unidad_curricular_correlativa`, `condicion`, `createdAt`, `updatedAt`) VALUES
(1, 1, 2, 1, 'PENDIENTE', NOW(), NOW()), -- Matemática requiere Programación I
(2, 2, 4, 5, 'PENDIENTE', NOW(), NOW()); -- Estadística requiere Machine Learning

-- -----------------------------------------------------
-- Tabla: designaciones_docentes
-- -----------------------------------------------------
INSERT INTO `designaciones_docentes` (`id`, `id_docente`, `id_division_x_unidad_curricular`, `id_ciclo_lectivo`, `turno`, `aula`, `horario`, `nroMAB`, `fechaAltaMAB`, `id_administrativo`, `fechaVtoMAB`, `activo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 1, 'Mañana', 'Aula 101', '08:00-10:00', 'MAB001', '2025-03-01', 1, '2026-03-01', 1, NOW(), NOW()),
(2, 2, 2, 1, 'Tarde', 'Aula 202', '14:00-16:00', 'MAB002', '2025-03-01', 1, '2026-03-01', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: tipos_documentos_requeridos
-- -----------------------------------------------------
INSERT INTO `tipos_documentos_requeridos` (`id`, `id_carrera`, `nombre_documento`, `obligatorio`, `es_critico`, `descripcion`, `dias_vigencia`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'DNI', 1, 1, 'Documento Nacional de Identidad', 0, 1, NOW(), NOW()),
(2, 1, 'Título Secundario', 1, 1, 'Título de nivel medio completo', 0, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: documentos_legajos
-- -----------------------------------------------------
INSERT INTO `documentos_legajos` (`id`, `id_legajo`, `id_tipo_documento_requerido`, `id_usuario_carga`, `url_archivo`, `fecha_carga`, `fecha_vencimiento`, `estado`, `id_administrativo`) VALUES
(1, 1, 1, 1, 'https://example.com/docs/dni_1.pdf', '2025-03-15', NULL, 'APROBADO', 1),
(2, 1, 2, 1, 'https://example.com/docs/titulo_1.pdf', '2025-03-15', NULL, 'PENDIENTE', 1);

-- -----------------------------------------------------
-- Tabla: dossiers_institucionales
-- -----------------------------------------------------
INSERT INTO `dossiers_institucionales` (`id`, `id_carrera`, `titulo`, `seccion`, `contenido`, `url_archivo`, `tipo`, `estado`, `fecha_actualizacion`, `id_administrativo`) VALUES
(1, 1, 'Normativa de cursado', 'Reglamento', 'Contenido del reglamento...', NULL, 'NORMATIVA', 1, NOW(), 1),
(2, 2, 'Informe de avance', 'Informes', 'Contenido del informe...', 'https://example.com/informe.pdf', 'INFORME', 0, NOW(), 1);

-- -----------------------------------------------------
-- Tabla: equivalencias_unidades_curriculares
-- -----------------------------------------------------
INSERT INTO `equivalencias_unidades_curriculares` (`id`, `id_plan_estudio_origen`, `id_plan_estudio_destino`, `id_unidad_curricular_origen`, `id_unidad_curricular_destino`, `tipo_equivalencia`, `observaciones`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 2, 1, 4, 'PARCIAL', 'Solo equivalencia parcial de contenidos', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: estudiantes_x_unidades_curriculares
-- -----------------------------------------------------
INSERT INTO `estudiantes_x_unidades_curriculares` (`id`, `id_division_x_unidad_curricular`, `id_legajo`, `fecha_de_inscripcion`, `condicion`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, '2025-03-10', 'regular', 1, NOW(), NOW()),
(2, 2, 1, '2025-03-10', 'promocionado', 1, NOW(), NOW()),
(3, 3, 2, '2025-03-12', 'libre', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: informacion_extra
-- -----------------------------------------------------
INSERT INTO `informacion_extra` (`id`, `titulo`, `icono`, `descripcion`, `id_carrera`, `createdAt`, `updatedAt`) VALUES
(1, 'Horarios de consulta', NULL, 'Lunes a Viernes de 18 a 20 hs.', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: inscripciones_carreras
-- -----------------------------------------------------
INSERT INTO `inscripciones_carreras` (`id`, `cupo`, `fecha_desde`, `fecha_hasta`, `id_plan_estudio`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 50, '2025-01-15', '2025-02-28', 1, 1, NOW(), NOW()),
(2, 40, '2025-06-01', '2025-07-15', 2, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: instancias_evaluativas
-- -----------------------------------------------------
INSERT INTO `instancias_evaluativas` (`id`, `id_division_x_unidad_curricular`, `descripcion`, `fecha`, `tipo`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'Primer Parcial Programación I', '2025-05-15 09:00:00', 'parcial', 1, NOW(), NOW()),
(2, 2, 'Trabajo Práctico Matemática', '2025-06-10 14:00:00', 'trabajo practico', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: legajos_x_instancias_evaluativas
-- -----------------------------------------------------
INSERT INTO `legajos_x_instancias_evaluativas` (`id`, `id_instancia_evaluativa`, `id_legajo`, `nota`, `fecha_registro`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 8, '2025-05-20', 1, NOW(), NOW()),
(2, 1, 2, 6, '2025-05-20', 1, NOW(), NOW()),
(3, 2, 1, 9, '2025-06-15', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: turnos_examenes
-- -----------------------------------------------------
INSERT INTO `turnos_examenes` (`id`, `descripcion`, `fecha_desde`, `fecha_hasta`, `id_ciclo_lectivo`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 'Turno Julio-Agosto 2025', '2025-07-20', '2025-08-10', 1, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: mesas_examenes
-- -----------------------------------------------------
INSERT INTO `mesas_examenes` (`id`, `id_turno_examen`, `id_unidad_curricular`, `fecha`, `hora`, `id_docente_presidente`, `id_docente_vocal1`, `id_docente_vocal2`, `total_inscripto`, `total_aprobados`, `total_desaprobados`, `total_ausentes`, `tipo`, `activo`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, '2025-07-25', '10:00', 1, 2, 3, 2, 0, 0, 0, 'ORDINARIO', 1, 1, NOW(), NOW()),
(2, 1, 3, '2025-07-28', '14:00', 2, 1, 3, 1, 0, 0, 0, 'ORDINARIO', 1, 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: mesas_examenes_x_legajos
-- -----------------------------------------------------
INSERT INTO `mesas_examenes_x_legajos` (`id`, `id_mesa_examen`, `id_legajo`, `condicion`, `fecha_inscripcion`, `nota_oral`, `nota_escrita`, `nota_final`, `fechaUltimaModificacion`, `estaBloqueado`, `resultado`, `id_administrativo`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 'regular', '2025-07-10 09:00:00', 7, 8, 8, '2025-07-25', 0, 'aprobado', 1, NOW(), NOW()),
(2, 1, 2, 'libre', '2025-07-12 10:00:00', 4, 5, 4, '2025-07-25', 0, 'desaprobado', 1, NOW(), NOW());

-- -----------------------------------------------------
-- Tabla: notificaciones
-- -----------------------------------------------------
INSERT INTO `notificaciones` (`id`, `idEstudiante`, `idDocente`, `idAdministrativo`, `titulo`, `mensaje`, `tipo`, `entidadRelacionada`, `entidadId`, `leida`, `fechaCreacion`) VALUES
(1, 1, NULL, 1, 'Inscripción exitosa', 'Te has inscripto correctamente a Programación I', 'INFORMACION', 'estudiantes_x_unidades_curriculares', 1, 0, NOW()),
(2, NULL, 2, NULL, 'Designación docente', 'Ud ha sido designado para la mesa de examen de Julio', 'AVISO', 'mesas_examenes', 1, 0, NOW());

-- -----------------------------------------------------
-- Tabla: preinscriptos
-- -----------------------------------------------------
INSERT INTO `preinscriptos` (`id`, `id_inscripcion`, `id_usuario`, `fechaInscripcion`, `cus`, `isa`, `emmac`, `analitico`, `partida_nacimiento`, `foto`, `estado`, `id_administrativo`, `createdAt`, `updatedAt`, `idEstudiante`, `idCarrera`) VALUES
(1, 1, 3, '2025-02-20', 'CUS123', 'ISA456', NULL, 'analitico.pdf', 'partida.pdf', 'foto.jpg', 'pendiente', 1, NOW(), NOW(), NULL, 1);

-- -----------------------------------------------------
-- Tabla: recuperaciones_contrasenia
-- -----------------------------------------------------
INSERT INTO `recuperaciones_contrasenia` (`id`, `id_usuario`, `fechaExpiracion`, `usado`, `fechaUso`, `id_administrativo`, `id_docente`) VALUES
(1, 1, '2025-12-31 23:59:59', 0, NULL, NULL, NULL);

-- -----------------------------------------------------
-- Tabla: sesiones_usuarios
-- -----------------------------------------------------
INSERT INTO `sesiones_usuarios` (`id`, `id_usuario`, `fechaInicioSesion`, `fechaCierreSesion`, `intentoFallido`, `bloqueado`, `id_administrativo`, `id_docente`) VALUES
(1, 1, NOW(), NULL, 0, 0, NULL, NULL),
(2, 2, NOW(), NULL, 0, 0, NULL, NULL);

-- Reactivar restricciones
SET FOREIGN_KEY_CHECKS = 1;