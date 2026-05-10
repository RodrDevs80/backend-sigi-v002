# SIGI - Backend

API RESTful para la gestión integral de una institución educativa: administrativos, docentes, estudiantes, carreras, planes de estudio, mesas de examen, asistencias y mucho más.

Desarrollada con **Node.js + TypeScript**, **Express 5**, **Sequelize (MySQL)** y buenas prácticas como validación con **Zod**, hasheo de contraseñas con **bcrypt**, control de errores centralizado y arquitectura por capas.

---

## Tecnologías principales

| Tecnología               | Propósito                                                                      |
| ------------------------ | ------------------------------------------------------------------------------ |
| **Node.js + TypeScript** | Entorno de ejecución y tipado estático para mayor robustez.                    |
| **Express 5**            | Framework web para definir rutas y middlewares.                                |
| **Sequelize**            | ORM que facilita la interacción con MySQL (modelos, relaciones, validaciones). |
| **MySQL2**               | Driver para conectar Sequelize con MySQL.                                      |
| **Zod**                  | Validación de datos de entrada (DTOs) con esquemas declarativos.               |
| **bcrypt**               | Hashing de contraseñas antes de almacenarlas.                                  |
| **Morgan**               | Logging de peticiones HTTP en desarrollo.                                      |
| **CORS**                 | Habilita peticiones desde dominios externos.                                   |
| **dotenv**               | Manejo de variables de entorno.                                                |
| **tsx**                  | Ejecución en caliente durante desarrollo (`tsx watch`).                        |

---

## Requisitos previos

- **Node.js** 18 o superior.
- **MySQL** Server (local o remoto).
- **Git** (opcional, para clonar el repositorio).

---

## Instalación y configuración

1. **Clonar el repositorio e instalar dependencias**:
   ```bash
   git clone <repo-url>
   cd backend-sigi
   npm install
   Configurar variables de entorno:
   Crear un archivo .env en la raíz del proyecto con el siguiente contenido (ajustá los valores a tu entorno):
   ```

env
PORT=4000
DB_NAME=sigi_db
DB_USER_M=root
DB_PASSWORD=tu_contraseña
DB_HOST=localhost
DB_DIALECT_M=mysql
Explicación:

PORT: puerto en el que se ejecutará el servidor.

DB_NAME: nombre de la base de datos MySQL (se recomienda crearla antes de arrancar, aunque Sequelize puede crearla según la configuración).

DB_USER_M, DB_PASSWORD: credenciales de MySQL.

DB_HOST: dirección del servidor MySQL.

DB_DIALECT_M: dialecto de Sequelize (debe ser mysql).

Crear la base de datos (opcional, pero recomendado):

sql
CREATE DATABASE IF NOT EXISTS sigi_db;
Puesta en marcha
Modo desarrollo (con recarga automática)
bash
npm run dev
Esto ejecuta tsx --watch src/index.ts, reiniciando el servidor ante cualquier cambio.

Compilación y ejecución en producción
bash
npm run build # compila TypeScript a ./dist
npm start # ejecuta el código compilado
Creación de las tablas
El proyecto utiliza Sequelize para definir los modelos y sincronizarlos con la base de datos.
En el archivo src/index.ts, al iniciar la aplicación se ejecuta:

ts
await sequelize.sync({ force: false });
force: false (por defecto): crea las tablas si no existen, pero no modifica las existentes ni borra datos. Es seguro usarlo en desarrollo.

force: true: elimina todas las tablas y las vuelve a crear cada vez que se inicia el servidor. Nunca debe usarse en producción, solo para pruebas iniciales.

El orden de creación de las tablas lo maneja Sequelize gracias a las relaciones definidas en src/modules/index.ts. Allí se importan todos los modelos y se establecen las asociaciones (belongsTo, hasMany, etc.).

Nota importante: los modelos están configurados para que Sequelize gestione la creación de las tablas. Si ya tenés una base de datos existente creada por otro método (por ejemplo, un script SQL de forward engineering de MySQL Workbench), podés usar force: false y Sequelize no tocará esas tablas, pero sí intentará sincronizar las asociaciones si se lo permitís.

Carga de datos de prueba
Se incluye un script SQL con datos de ejemplo en mock/demoSigi.sql. Este script:

Desactiva temporalmente las restricciones de clave foránea para permitir inserciones en cualquier orden.

Inserta registros en todas las tablas (roles, administrativos, usuarios, docentes, estudiantes, carreras, planes de estudio, ciclos lectivos, cursos, divisiones, unidades curriculares, asistencias, mesas de examen, etc.) con datos coherentes y referencias válidas.

Reactiva las restricciones al finalizar.

Instrucciones para cargar los datos de prueba:

Asegurate de que la base de datos sigi_db exista (o usá el nombre configurado en tu .env).

Ejecutá el script con tu cliente MySQL favorito. Por ejemplo, desde MySQL Workbench:

Abrí el archivo mock/demoSigi.sql.

Reemplazá USE 'NombreDeTuBaseDeDatos'; por USE sigi_db; (o el nombre real de tu BD).

Ejecutá todo el script.

O desde línea de comandos:

bash
mysql -u root -p sigi_db < mock/demoSigi.sql
De esta manera, tendrás datos precargados para probar los endpoints de la API inmediatamente.

Estructura del proyecto
plaintext
src/
├── config/database/ # Configuración de Sequelize
│ ├── conexion.ts # Instancia de Sequelize
│ └── configDataBase.ts # Carga de credenciales desde .env
├── core/ # Componentes reutilizables
│ ├── constants/
│ │ └── http.status.ts # Constantes de códigos HTTP
│ ├── enums/
│ │ └── role.enum.ts # Enum de roles de usuario
│ └── middlewares/
│ ├── error-handler.middleware.ts # Manejo centralizado de errores
│ ├── validate-jwt.middleware.ts # Simulacro de JWT (ver abajo)
│ └── validate-role.middleware.ts # Verificación de roles
├── helpers/
│ ├── parsePagination.ts # Helper para parámetros de paginación
│ └── respondZodError.ts # Helper para responder errores de Zod
├── modules/ # Módulo por entidad
│ ├── administrativos/
│ ├── asistencias/
│ ├── carreras/
│ ├── ... (más de 25 módulos)
│ └── index.ts # Agrupa modelos y define relaciones
└── index.ts # Punto de entrada (configura Express, sincroniza DB)
Cada módulo sigue una arquitectura de capas:

routes: define los endpoints y aplica middlewares (autenticación, roles).

controller: extrae y valida los datos de la request, llama al servicio y envía la respuesta.

service: contiene la lógica de negocio y el acceso a la base de datos (usando Sequelize).

dto (Zod): esquemas de validación para los datos de entrada (creación/actualización).

model (Sequelize): definición de la tabla, columnas, tipos, validaciones y hooks.

Funcionalidades principales
API RESTful completa (más de 25 recursos)
Todos los endpoints soportan operaciones CRUD y, en la mayoría de los casos, incluyen listados paginados. Algunos ejemplos:

Administrativos – gestión de personal administrativo (con encriptación de contraseñas).

Docentes – alta, baja, modificación de docentes (también con bcrypt).

Estudiantes – registro de alumnos, asociación con usuarios y legajos.

Carreras y Planes de estudio – administración de ofertas académicas.

Ciclos lectivos – definición de años académicos y su vigencia.

Cursos, Divisiones – organización de comisiones y cursos.

Unidades curriculares – materias o asignaturas de cada plan.

Correlatividades – definición de requisitos entre unidades curriculares.

Asistencias – registro de presencia/ausencia de alumnos.

Mesas de examen – configuración y administración de exámenes finales.

Notas e instancias evaluativas – carga de calificaciones.

Preinscripciones e inscripciones – proceso de admisión.

Notificaciones – envío y consulta de avisos.

Sesiones de usuario y recuperación de contraseñas – módulos de seguridad.

Roles – manejo de perfiles (ADMIN, DOCENTE, ESTUDIANTE, RECTOR).

Validación de datos con Zod
Todos los endpoints de creación y actualización utilizan DTOs (Data Transfer Objects) validados con Zod, lo que asegura que solo datos correctos lleguen a la base de datos.

Paginación uniforme
Los endpoints GET de lista soportan page y limit como query params, devolviendo una respuesta estandarizada:

json
{
"status": "success",
"data": [...],
"meta": {
"total": 42,
"page": 2,
"limit": 10,
"totalPages": 5
}
}
Manejo centralizado de errores
El middleware errorHandler (al final de la cadena de Express) captura cualquier error y devuelve respuestas adecuadas:

Errores de negocio (AppError)

Errores de validación de Sequelize (ValidationError, UniqueConstraintError, ForeignKeyConstraintError)

Errores de Zod

Errores genéricos del servidor (500)

Esto permite que los controladores simplemente lancen next(err) y se desentiendan del formateo de errores.

Seguridad de contraseñas
Los modelos Administrativo, Docente y Usuario utilizan hooks de Sequelize (beforeCreate, beforeUpdate) para hashear las contraseñas automáticamente con bcrypt (10 rondas de salt).

Las contraseñas nunca se devuelven en las respuestas de la API (atributo excluido en las consultas).

Autenticación y autorización (parcial)
Actualmente los middlewares de JWT y roles están simulados con fines de desarrollo:

validateJwt: exige un header Authorization (cualquier valor) y simula un usuario autenticado con rol ADMIN.

validateRole(...roles): verifica que el rol del usuario simulado esté entre los permitidos.

Sin el header Authorization las rutas protegidas devuelven 401.
Con cualquier valor en ese header, se asume que sos un usuario ADMIN con acceso total.

Esto está pensado para facilitar las pruebas en Postman/Insomnia sin necesidad de un sistema JWT real, pero no debe usarse en producción.

Endpoints de la API
Base URL: http://localhost:4000/api/v1

A continuación se listan los recursos principales. Todos siguen un patrón REST estándar.

Recurso Rutas principales Middleware Descripción
Administrativos /administrativos JWT (+ ADMIN en POST/PUT/DELETE) CRUD de personal administrativo
Roles /roles JWT (+ ADMIN en escritura) Gestión de roles de usuario
Docentes /docentes JWT (+ ADMIN en escritura) CRUD de docentes
Estudiantes /estudiantes JWT (+ ADMIN en escritura) Registro y modificación de alumnos
Carreras /carreras JWT (+ ADMIN) Oferta académica
Planes de estudio /planes-estudios JWT (+ ADMIN) Versiones de planes
Ciclos lectivos /ciclos-lectivos JWT (+ ADMIN) Años académicos
Cursos /cursos JWT (+ ADMIN) Comisiones por año
Divisiones /divisiones JWT (+ ADMIN) Agrupamiento de cursos
Unidades curriculares /unidades-curriculares JWT (+ ADMIN) Materias/asignaturas
Correlatividades /correlatividades JWT (+ ADMIN) Requisitos entre materias
Asistencias /asistencias JWT (+ ADMIN) Registro de presente/ausente
Designaciones docentes /designaciones-docentes JWT (+ ADMIN) Asignación de docentes a cursos
Mesas de examen /mesas-examenes JWT (+ ADMIN) Exámenes finales
Inscripciones a mesas /mesas-examenes-x-legajos JWT (+ ADMIN) Legajos inscriptos en mesas
Instancias evaluativas /instancias-evaluativas JWT (+ ADMIN) Parciales, TP, finales
Notas / Legajos evaluativos /legajos-x-instancias-evaluativas JWT (+ ADMIN) Carga de notas
Movimientos financieros /movimientos-financieros JWT (+ ADMIN) Ingresos/egresos
Preinscripciones /preinscriptos JWT (+ ADMIN) Solicitudes de ingreso
Notificaciones /notificaciones JWT (+ ADMIN) Mensajes del sistema
Documentos de legajos /documentos-legajos JWT (+ ADMIN) Archivos requeridos
Tipos de documentos /tipos-documentos-requeridos JWT (+ ADMIN) Configuración de requisitos
Equivalencias /equivalencias JWT (+ ADMIN) Equivalencias entre planes
Sesiones de usuario /sesiones-usuarios JWT (+ ADMIN) Control de sesiones
Recuperación de contraseña /recuperaciones-contrasenia JWT (+ ADMIN) Tokens de recuperación
Usuarios /usuarios JWT (+ ADMIN) Credenciales del sistema
Además, hay un endpoint de health check: GET /health.

Funcionalidades pendientes / mejoras futuras
Aunque el sistema es funcional y tiene una base sólida, varios aspectos están planificados para futuras iteraciones:

🔐 Autenticación real con JWT
Actualmente es un simulacro. Se debe implementar un sistema de login que genere y verifique tokens JWT reales, incluyendo refresco de tokens y cierre de sesión.

📦 Migraciones de base de datos (Sequelize CLI)
Hoy se usa sequelize.sync() para crear/modificar tablas, lo cual es práctico pero poco seguro para producción. Se migrará a un sistema de migraciones con Sequelize CLI para versionar los cambios de esquema.

🧪 Pruebas unitarias y de integración
El proyecto carece de tests automatizados. Se añadirán tests con Jest o Mocha para servicios y controladores.

📚 Documentación de API con Swagger/OpenAPI
Sería ideal integrar Swagger para documentar cada endpoint de forma interactiva.

🛡️ Roles y permisos más granulares
El enum Role actual es básico. Se podría ampliar a un sistema de permisos más detallado, por ejemplo, diferenciando entre directivos, preceptores, etc.

📊 Módulo de reportes
Funcionalidades como historial académico, estadísticas de asistencia, reportes financieros no están implementadas.

📧 Notificaciones reales (email, push)
Actualmente la entidad notificaciones es un registro en base de datos. Se podría extender para enviar correos electrónicos o notificaciones push.

🔍 Filtros avanzados y búsquedas
Algunos endpoints ya permiten filtrar (ej. carreras por nombre), pero se planea añadir filtros por múltiples campos, fechas, etc.

Notas finales
Este proyecto fue diseñado como una base sólida y didáctica para un sistema de gestión educativa. Cumple con buenas prácticas de arquitectura de software, separación de responsabilidades y manejo de errores.

Advertencia sobre producción:

No usar force: true ni el middleware JWT simulado en un entorno real.

Implementar migraciones, JWT real y desactivar logs detallados de Morgan en producción.

Si tenés dudas sobre cómo extender el sistema, revisá el archivo src/modules/index.ts para entender cómo se agregan nuevos modelos y relaciones, y src/index.ts para ver cómo se registran las rutas.
