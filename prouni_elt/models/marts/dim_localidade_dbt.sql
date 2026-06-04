{{ config(materialized='table') }}

-- padronização estilo monitoria:
WITH base AS (
    SELECT * FROM {{ ref('int_prouni_preparados') }}
),

locais_unicos AS (
    SELECT DISTINCT
        municipio_beneficiario_bolsa,
        sigla_uf_beneficiario_bolsa,
        regiao_beneficiario_bolsa
    FROM base
)

SELECT
    ROW_NUMBER() OVER (ORDER BY municipio_beneficiario_bolsa) AS id_localidade_sk,
    *
FROM locais_unicos