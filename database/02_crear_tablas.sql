USE fit_sync_manager; 

-- Tabla socio 

CREATE TABLE SOCIO (
    id_socio INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,

    PRIMARY KEY (id_socio)
);

-- Tabla entrenador 

CREATE TABLE ENTRENADOR (
    id_entrenador INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,

    PRIMARY KEY (id_entrenador)
);

-- Tabla Sala

CREATE TABLE IF NOT EXISTS SALA (
    id_sala INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL,
    ubicacion VARCHAR(100),
    estado ENUM('Disponible', 'No disponible')
        DEFAULT 'Disponible',

    PRIMARY KEY (id_sala),
    CONSTRAINT uq_sala_nombre UNIQUE (nombre),
    CONSTRAINT chk_sala_capacidad CHECK (capacidad > 0)
); 

-- Tabla clase 

CREATE TABLE IF NOT EXISTS CLASE (
    id_clase INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    nivel ENUM('Principiante', 'Intermedio', 'Avanzado'),
    capacidad_maxima INT NOT NULL,
    id_entrenador INT NOT NULL,

    PRIMARY KEY (id_clase),

    CONSTRAINT chk_clase_capacidad
        CHECK (capacidad_maxima > 0),

    CONSTRAINT fk_clase_entrenador
        FOREIGN KEY (id_entrenador)
        REFERENCES ENTRENADOR(id_entrenador)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

-- Tabla horario 

CREATE TABLE IF NOT EXISTS HORARIO (
    id_horario INT AUTO_INCREMENT,
    id_clase INT NOT NULL,
    id_sala INT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,

    PRIMARY KEY (id_horario),

    CONSTRAINT chk_horario_horas
        CHECK (hora_fin > hora_inicio),

    CONSTRAINT fk_horario_clase
        FOREIGN KEY (id_clase)
        REFERENCES CLASE(id_clase)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_horario_sala
        FOREIGN KEY (id_sala)
        REFERENCES SALA(id_sala)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT uq_horario_sala
        UNIQUE (id_sala, fecha, hora_inicio)
); 

-- Tabla membresía 

CREATE TABLE IF NOT EXISTS MEMBRESIA (
    id_membresia INT AUTO_INCREMENT,
    id_socio INT NOT NULL,
    tipo ENUM('Mensual', 'Trimestral', 'Semestral', 'Anual')
        NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado ENUM('Activa', 'Caducada', 'Cancelada')
        DEFAULT 'Activa',

    PRIMARY KEY (id_membresia),

    CONSTRAINT chk_membresia_precio
        CHECK (precio >= 0),

    CONSTRAINT chk_membresia_fechas
        CHECK (fecha_fin >= fecha_inicio),

    CONSTRAINT fk_membresia_socio
        FOREIGN KEY (id_socio)
        REFERENCES SOCIO(id_socio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

-- Tabla reserva

CREATE TABLE IF NOT EXISTS RESERVA (
    id_reserva INT AUTO_INCREMENT,
    id_socio INT NOT NULL,
    id_horario INT NOT NULL,
    fecha_reserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('Confirmada', 'Cancelada', 'Pendiente')
        DEFAULT 'Pendiente',

    PRIMARY KEY (id_reserva),

    CONSTRAINT uq_reserva_socio_horario
        UNIQUE (id_socio, id_horario),

    CONSTRAINT fk_reserva_socio
        FOREIGN KEY (id_socio)
        REFERENCES SOCIO(id_socio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_reserva_horario
        FOREIGN KEY (id_horario)
        REFERENCES HORARIO(id_horario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

-- Tabla pago 

CREATE TABLE IF NOT EXISTS PAGO (
    id_pago INT AUTO_INCREMENT,
    id_socio INT NOT NULL,
    id_membresia INT NOT NULL,
    fecha_pago DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    importe DECIMAL(10,2) NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia')
        NOT NULL,
    estado ENUM('Pendiente', 'Pagado', 'Rechazado')
        DEFAULT 'Pendiente',

    PRIMARY KEY (id_pago),

    CONSTRAINT chk_pago_importe
        CHECK (importe > 0),

    CONSTRAINT fk_pago_socio
        FOREIGN KEY (id_socio)
        REFERENCES SOCIO(id_socio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_pago_membresia
        FOREIGN KEY (id_membresia)
        REFERENCES MEMBRESIA(id_membresia)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

-- Tabla incidencia 

CREATE TABLE IF NOT EXISTS INCIDENCIA (
    id_incidencia INT AUTO_INCREMENT,
    id_socio INT,
    id_entrenador INT,
    id_sala INT,
    fecha_incidencia DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT NOT NULL,
    prioridad ENUM('Baja', 'Media', 'Alta')
        DEFAULT 'Media',
    estado ENUM('Abierta', 'En proceso', 'Resuelta')
        DEFAULT 'Abierta',

    PRIMARY KEY (id_incidencia),

    CONSTRAINT fk_incidencia_socio
        FOREIGN KEY (id_socio)
        REFERENCES SOCIO(id_socio)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT fk_incidencia_entrenador
        FOREIGN KEY (id_entrenador)
        REFERENCES ENTRENADOR(id_entrenador)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT fk_incidencia_sala
        FOREIGN KEY (id_sala)
        REFERENCES SALA(id_sala)
        ON UPDATE CASCADE
        ON DELETE SET NULL
); 