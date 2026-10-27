# FitSync Manager 🏋️

**Sistema de gestión integral de gimnasios mediante una base de datos relacional.**

## 1. Descripción del problema

FitSync Manager es un sistema de gestión integral diseñado para administrar la información y las actividades de un gimnasio o centro deportivo. La base de datos permitirá centralizar la información relacionada con los socios, entrenadores personales, clases dirigidas, reservas, pagos, membresías, salas y horarios.

El sistema pretende facilitar la organización de las actividades del gimnasio y mantener la información almacenada de forma ordenada, estructurada, coherente y segura.

La base de datos deberá garantizar la integridad y consistencia de los datos, evitar duplicidades innecesarias, mantener la integridad referencial entre las entidades y proteger la información mediante mecanismos de seguridad y control de acceso.

## 2. Objetivo general

El objetivo principal del proyecto es diseñar una base de datos relacional que permita gestionar de forma organizada, segura y eficiente la actividad de un gimnasio, garantizando la integridad de la información y facilitando las consultas relacionadas con los socios, entrenadores, clases, reservas, membresías, pagos, salas y horarios.

Asimismo, se busca facilitar la administración diaria del gimnasio mediante una estructura de datos centralizada que permita mantener la información actualizada, reducir posibles errores y evitar duplicidades.

La base de datos deberá permitir registrar y consultar la información de manera sencilla, así como controlar aspectos importantes como:

- La disponibilidad de plazas en las clases.
- Las reservas realizadas por los socios.
- La vigencia de las membresías.
- El estado de los pagos.
- La asignación de entrenadores y salas.

De este modo, FitSync Manager contribuirá a mejorar la organización interna del gimnasio y a garantizar una gestión más fiable y coherente de sus recursos.

## 3. Usuarios y funciones del sistema

El sistema contempla cuatro tipos de usuarios, cada uno con diferentes responsabilidades y permisos.

| Usuario | Funciones principales |
|---|---|
| **Administrador** | Gestiona socios y entrenadores, crea y modifica clases, consulta estadísticas y gestiona pagos. |
| **Recepcionista** | Registra socios, gestiona reservas, consulta clases y registra pagos. |
| **Entrenador personal** | Consulta sus clases, los socios inscritos y las salas disponibles. |
| **Socio** | Consulta las clases disponibles, realiza y cancela reservas y consulta sus pagos y membresía. |

## 4. Requisitos de funcionamiento

La base de datos deberá cumplir los siguientes requisitos funcionales y de integridad:

- [ ] Registrar socios mediante un DNI único.
- [ ] Garantizar que el correo electrónico de cada socio sea único.
- [ ] Impedir el alta de personas menores de 16 años.
- [ ] Permitir el registro de entrenadores personales.
- [ ] Permitir la creación de clases dirigidas.
- [ ] Asignar entrenadores a las clases.
- [ ] Controlar el aforo máximo de las clases.
- [ ] Permitir que los socios realicen y cancelen reservas.
- [ ] Impedir reservas duplicadas.
- [ ] Registrar los pagos de los socios.
- [ ] Gestionar las membresías.

## 5. Consultas mínimas del sistema

La base de datos deberá permitir realizar, como mínimo, las siguientes consultas:

1. Listado de socios registrados.
2. Búsqueda de un socio mediante su DNI.
3. Consulta de socios activos.
4. Listado de entrenadores.
5. Consulta de clases.
6. Consulta de horarios y salas.
7. Consulta general de reservas.
8. Consulta de las reservas de un socio.
9. Consulta de la ocupación de las clases.
10. Consulta de membresías.
11. Consulta de los pagos de un socio.
12. Consulta de ingresos por periodo.

### 5.1. Consultas de socios y entrenadores

Permiten consultar los socios registrados, localizar a una persona mediante su DNI, identificar los socios activos y obtener los datos de los entrenadores.

### 5.2. Consultas de clases, horarios y salas

Permiten consultar las clases junto con el entrenador responsable, así como conocer sus horarios, fechas y salas asignadas.

### 5.3. Consultas de reservas

Permiten obtener el listado general de reservas y consultar las reservas asociadas a un socio concreto.

### 5.4. Consulta de ocupación de clases

Permite calcular el número de reservas confirmadas para cada clase y determinar las plazas restantes a partir del aforo máximo establecido.

### 5.5. Consultas de membresías y pagos

Permiten consultar las membresías vinculadas a los socios y recuperar el historial de pagos de un socio determinado, incluyendo:

- Fecha del pago.
- Importe.
- Método de pago.
- Estado del pago.
- Tipo de membresía asociado.

### 5.6. Consulta de ingresos por periodo

Permite analizar los pagos registrados durante un intervalo de fechas. Se contabiliza el número de pagos y se calcula el importe total de los pagos cuyo estado sea **«pagado»**, agrupando los resultados por día.

## 6. Integridad y consistencia de los datos

El diseño de la base de datos deberá aplicar mecanismos que garanticen la calidad y coherencia de la información almacenada.

Entre ellos se incluyen:

- **Claves primarias (PK):** identifican de forma única cada registro.
- **Claves foráneas (FK):** garantizan la integridad referencial entre las entidades.
- **Restricciones de unicidad:** evitan duplicidades en atributos como el DNI y el correo electrónico.
- **Validaciones de datos:** permiten aplicar reglas como la edad mínima de los socios.
- **Control de reservas:** evita reservas duplicadas y permite respetar el aforo máximo de las clases.
- **Control de acceso:** limita las operaciones que puede realizar cada tipo de usuario según sus responsabilidades.

Estos mecanismos contribuirán a mantener una base de datos fiable, consistente y segura.

## 7. Tecnologías y herramientas

El proyecto está orientado al uso de las siguientes tecnologías y herramientas:

- **MySQL:** sistema gestor de bases de datos relacionales.
- **MySQL Workbench:** herramienta para diseñar el modelo de datos, ejecutar consultas SQL y administrar la base de datos.
- **GitHub:** repositorio para almacenar los scripts SQL, la documentación y las versiones del proyecto.

La organización del repositorio permitirá compartir los cambios, mantener un historial de modificaciones y facilitar el trabajo colaborativo entre los integrantes del grupo.

## 8. Alcance del proyecto

FitSync Manager busca proporcionar una estructura de datos centralizada para gestionar los principales procesos de un gimnasio: registro de socios, asignación de entrenadores, organización de clases, gestión de reservas, control de membresías y seguimiento de pagos.

El proyecto se centra en el diseño y la implementación de una base de datos relacional que permita almacenar, mantener y consultar esta información de forma eficiente, coherente y segura.

---

*FitSync Manager — Gestión organizada, eficiente y fiable de la actividad de un gimnasio.*
