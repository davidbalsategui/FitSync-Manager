/*
    Impedir que se registren socios menores de 16 años
    cuando la regla se implemente mediante trigger.
    - Un trigger BEFORE INSERT sobre SOCIO.
    - Cálculo de la edad usando fecha_nacimiento.
    - Rechazo del registro cuando la edad sea inferior
      a 16 años.
    - Tratamiento de fechas inválidas o nulas, según
      las reglas del proyecto.
 */