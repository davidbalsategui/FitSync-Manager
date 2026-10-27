/*
    Impedir que se inserten o actualicen pagos con importes
    que incumplan las reglas del proyecto.
    - Un trigger BEFORE INSERT y, si es necesario,
      otro BEFORE UPDATE.
    - Comprobación del importe.
    - Rechazo de valores negativos o inválidos.
 */