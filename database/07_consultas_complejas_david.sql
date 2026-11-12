USE fitsyncmanager;

-- Consulta 1: resumen económico de cada socio (nombre del socio, número de pagos realizados, pagos completados y pendientes) 

SELECT
    s.id_socio,
    s.nombre,
    s.apellidos,
    s.email,
    COALESCE(p.numero_pagos, 0) AS numero_pagos,
    COALESCE(p.total_pagado, 0) AS total_pagado,
    COALESCE(p.total_pendiente, 0) AS total_pendiente

FROM SOCIO s

LEFT JOIN (
    SELECT
        id_socio,
        COUNT(*) AS numero_pagos,

        SUM(
            CASE
                WHEN estado = 'Pagado' THEN importe
                ELSE 0
            END
        ) AS total_pagado,

        SUM(
            CASE
                WHEN estado = 'Pendiente' THEN importe
                ELSE 0
            END
        ) AS total_pendiente

    FROM PAGO
    GROUP BY id_socio

) p ON s.id_socio = p.id_socio

ORDER BY total_pagado DESC;

-- Consulta 2: descripción de las clases programadas (nombre, entrenador responsable, sala, fecha y horario, plazas ocupadas, capacidad máxima y porcentaje de ocupación)

SELECT
    c.nombre AS nombre_clase,
    CONCAT(e.nombre, ' ', e.apellidos) AS entrenador,
    sa.nombre AS sala,
    h.fecha,
    h.hora_inicio,
    h.hora_fin,

    COUNT(
        DISTINCT CASE
            WHEN r.estado = 'Confirmada'
            THEN r.id_reserva
        END
    ) AS plazas_ocupadas,

    c.capacidad_maxima,

    ROUND(
        COUNT(
            DISTINCT CASE
                WHEN r.estado = 'Confirmada'
                THEN r.id_reserva
            END
        ) * 100.0 / c.capacidad_maxima,
        2
    ) AS porcentaje_ocupacion

FROM HORARIO h

INNER JOIN CLASE c
    ON h.id_clase = c.id_clase

INNER JOIN ENTRENADOR e
    ON c.id_entrenador = e.id_entrenador

INNER JOIN SALA sa
    ON h.id_sala = sa.id_sala

LEFT JOIN RESERVA r
    ON h.id_horario = r.id_horario

GROUP BY
    h.id_horario,
    c.nombre,
    e.nombre,
    e.apellidos,
    sa.nombre,
    h.fecha,
    h.hora_inicio,
    h.hora_fin,
    c.capacidad_maxima

ORDER BY porcentaje_ocupacion DESC;

-- Consulta 3: rendimiento de los entrenadores (nombre, número de clases diferentes, número de horarios programados, número de reservas confirmadas y porcentaje medio de ocupación)

WITH ocupacion_horario AS (

    SELECT
        h.id_horario,
        c.id_clase,
        c.id_entrenador,
        c.capacidad_maxima,

        COUNT(
            DISTINCT CASE
                WHEN r.estado = 'Confirmada'
                THEN r.id_reserva
            END
        ) AS reservas_confirmadas

    FROM HORARIO h

    INNER JOIN CLASE c
        ON h.id_clase = c.id_clase

    LEFT JOIN RESERVA r
        ON h.id_horario = r.id_horario

    GROUP BY
        h.id_horario,
        c.id_clase,
        c.id_entrenador,
        c.capacidad_maxima
)

SELECT
    e.id_entrenador,
    e.nombre,
    e.apellidos,

    COUNT(DISTINCT oh.id_clase) AS numero_clases,

    COUNT(oh.id_horario) AS horarios_programados,

    COALESCE(
        SUM(oh.reservas_confirmadas), 0
    ) AS reservas_confirmadas,

    COALESCE(
        ROUND(
            SUM(oh.reservas_confirmadas) * 100.0 /
            NULLIF(SUM(oh.capacidad_maxima), 0),
            2
        ),
        0
    ) AS porcentaje_ocupacion

FROM ENTRENADOR e

LEFT JOIN ocupacion_horario oh
    ON e.id_entrenador = oh.id_entrenador

GROUP BY
    e.id_entrenador,
    e.nombre,
    e.apellidos

HAVING COUNT(oh.id_horario) > 0

ORDER BY porcentaje_ocupacion DESC;

-- Consulta 4: membresías caducadas y próximas a ello (socio, tipo de membresía, fecha inicio, estado de la membresía, importe total pagado y número de pagos pendientes) 

SELECT
    s.id_socio,
    s.nombre,
    s.apellidos,

    m.id_membresia,
    m.tipo,
    m.fecha_inicio,
    m.fecha_fin,
    m.estado,

    CASE
        WHEN m.fecha_fin < CURRENT_DATE
            THEN 'Caducada'
        ELSE 'Proxima a caducar'
    END AS situacion_membresia,

    COALESCE(p.total_pagado, 0) AS total_pagado,

    COALESCE(p.pagos_pendientes, 0) AS pagos_pendientes

FROM MEMBRESIA m

INNER JOIN SOCIO s
    ON m.id_socio = s.id_socio

LEFT JOIN (

    SELECT
        id_membresia,

        SUM(
            CASE
                WHEN estado = 'Pagado' THEN importe
                ELSE 0
            END
        ) AS total_pagado,

        SUM(
            CASE
                WHEN estado = 'Pendiente' THEN 1
                ELSE 0
            END
        ) AS pagos_pendientes

    FROM PAGO

    GROUP BY id_membresia

) p ON m.id_membresia = p.id_membresia

WHERE m.fecha_fin <= DATE_ADD(
    CURRENT_DATE,
    INTERVAL 30 DAY
)

ORDER BY m.fecha_fin ASC;

-- Consulta 5: análisis de utilización de salas (sala, número de horarios programados, número de reservas confirmadas, capacidad total disponible, porcentaje de utilización)

WITH resumen_horarios AS (

    SELECT
        h.id_horario,
        h.id_sala,
        c.capacidad_maxima,

        COUNT(
            DISTINCT CASE
                WHEN r.estado = 'Confirmada'
                THEN r.id_reserva
            END
        ) AS reservas_confirmadas

    FROM HORARIO h

    INNER JOIN CLASE c
        ON h.id_clase = c.id_clase

    LEFT JOIN RESERVA r
        ON h.id_horario = r.id_horario

    GROUP BY
        h.id_horario,
        h.id_sala,
        c.capacidad_maxima
)

SELECT
    sa.id_sala,
    sa.nombre AS nombre_sala,

    COUNT(rh.id_horario) AS horarios_programados,

    COALESCE(
        SUM(rh.reservas_confirmadas), 0
    ) AS reservas_confirmadas,

    COALESCE(
        SUM(rh.capacidad_maxima), 0
    ) AS capacidad_total,

    COALESCE(
        ROUND(
            SUM(rh.reservas_confirmadas) * 100.0 /
            NULLIF(SUM(rh.capacidad_maxima), 0),
            2
        ),
        0
    ) AS porcentaje_utilizacion

FROM SALA sa

LEFT JOIN resumen_horarios rh
    ON sa.id_sala = rh.id_sala

GROUP BY
    sa.id_sala,
    sa.nombre

ORDER BY porcentaje_utilizacion DESC;

