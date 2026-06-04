{{ config(materialized='table') }} 

-- padronização estilo monitoria:
WITH base AS (
    SELECT * FROM {{ ref('int_prouni_preparados') }}
),

perfis_unicos AS (
    SELECT DISTINCT
        cpf_beneficiario_bolsa,
        sexo_beneficiario_bolsa,
        raca_beneficiario_bolsa,
        dt_nascimento_beneficiario,
        beneficiario_deficiente_fisico
    FROM base
)

SELECT
    ROW_NUMBER() OVER (ORDER BY cpf_beneficiario_bolsa) AS id_beneficiario_sk,
    *
FROM perfis_unicos