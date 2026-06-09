{{ config(materialized='table') }}

WITH base AS (
    SELECT * FROM {{ ref('int_prouni_preparados') }}
),

datas_unicas AS (
    SELECT DISTINCT
        dt_concessao_bolsa,
        semestre_concessao_bolsa
        
        -- Extract para obter dia, mês, ano e semestre a partir da data de concessão da bolsa
        EXTRACT(DAY FROM dt_concessao_bolsa) AS dia,
        EXTRACT(MONTH FROM dt_concessao_bolsa) AS mes,
        EXTRACT(YEAR FROM dt_concessao_bolsa) AS ano,
    FROM base
    WHERE dt_concessao_bolsa IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER (ORDER BY dt_concessao_bolsa) AS id_temporal_sk,
    *
FROM datas_unicas