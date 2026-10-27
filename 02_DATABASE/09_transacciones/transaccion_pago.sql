/*
    Proteger las operaciones necesarias para registrar
    una reserva sin dejar datos inconsistentes.
    - Inicio de transacción.
    - Comprobación del horario y la disponibilidad.
    - Inserción de la reserva.
    - Confirmación con COMMIT.
    - Reversión con ROLLBACK cuando proceda.
 */