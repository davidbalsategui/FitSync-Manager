/*
    Evitar que las inserciones o modificaciones de reservas
    provoquen que se supere el aforo permitido.
    - Un trigger BEFORE INSERT o el mecanismo acordado.
    - Identificación del horario de la nueva reserva.
    - Cálculo de la ocupación existente.
    - Rechazo de la operación si se supera el límite.
 */