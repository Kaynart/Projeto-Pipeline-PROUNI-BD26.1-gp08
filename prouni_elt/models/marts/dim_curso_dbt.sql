{{ config(materialized='table') }}

-- padronização estilo monitoria:
WITH base AS (
    SELECT * FROM {{ ref('int_prouni_preparados') }}
),

cursos_unicos AS (
    SELECT DISTINCT
        nome_curso_bolsa,
        nome_turno_curso_bolsa,
        modalidade_ensino_bolsa
    FROM base
)

SELECT
    ROW_NUMBER() OVER (ORDER BY nome_curso_bolsa) AS id_curso_sk,
    *
FROM cursos_unicos