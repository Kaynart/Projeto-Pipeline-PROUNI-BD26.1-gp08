{{ config(materialized='table') }}

-- padronização estilo monitoria:
WITH base AS (
    SELECT * FROM {{ ref('int_prouni_preparados') }}
),

datas_unicas AS (
    SELECT
        dt_concessao_bolsa,
        semestre_concessao_bolsa
    FROM base
    WHERE dt_concessao_bolsa IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER (ORDER BY dt_concessao_bolsa) AS id_temporal_sk,
     -- O extract é utilizado para extrair partes específicas de uma data, como ano, mês ou dia.
    EXTRACT(DAY FROM dt_concessao_bolsa) AS dia,
    EXTRACT(MONTH FROM dt_concessao_bolsa) AS mes,
    EXTRACT(YEAR FROM dt_concessao_bolsa) AS ano,
    *
FROM datas_unicas