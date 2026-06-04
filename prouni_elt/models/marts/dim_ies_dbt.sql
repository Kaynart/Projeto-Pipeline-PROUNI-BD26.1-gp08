{{ config(materialized='table') }}

-- padronização estilo monitoria:
WITH base AS (
    SELECT * FROM {{ ref('int_prouni_preparados') }}
),

ies_unicas AS (
    SELECT DISTINCT
        codigo_emec_ies_bolsa,
        nome_ies_bolsa
    FROM base
)

SELECT
    ROW_NUMBER() OVER (ORDER BY nome_ies_bolsa) AS id_ies_sk,
    *
FROM ies_unicas