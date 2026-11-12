USE fitsyncmanager;

-- Consultar horarios por fecha
CREATE INDEX idx_horario_fecha
ON HORARIO(fecha);

-- Consultar reservas por horario y estado
CREATE INDEX idx_reserva_horario_estado
ON RESERVA(id_horario, estado);

-- Consultar reservas de un socio por fecha
CREATE INDEX idx_reserva_socio_fecha
ON RESERVA(id_socio, fecha_reserva);

-- Consultar pagos por estado y fecha
CREATE INDEX idx_pago_estado_fecha
ON PAGO(estado, fecha_pago);

-- Consultar membresias proximas a caducar
CREATE INDEX idx_membresia_fecha_fin
ON MEMBRESIA(fecha_fin);

-- Consultar incidencias por estado y prioridad
CREATE INDEX idx_incidencia_estado_prioridad
ON INCIDENCIA(estado, prioridad);
