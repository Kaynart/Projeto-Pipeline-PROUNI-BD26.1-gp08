{{ config(materialized='table') }}

WITH base AS (
    SELECT * FROM {{ ref('int_prouni_preparados') }}
),

perfis_com_ranking AS (
    SELECT
        cpf_beneficiario_bolsa,
        sexo_beneficiario_bolsa,
        raca_beneficiario_bolsa,
        dt_nascimento_beneficiario,
        beneficiario_deficiente_fisico,
        ROW_NUMBER() OVER (
            PARTITION BY cpf_beneficiario_bolsa   -- agrupa por CPF
            ORDER BY ano_concessao_bolsa DESC      -- mais recente primeiro
        ) AS rn
    FROM base
    WHERE cpf_beneficiario_bolsa IS NOT NULL
),

perfis_unicos AS (
    SELECT * FROM perfis_com_ranking
    WHERE rn = 1  -- só o mais recente de cada CPF, pra nao duplicar com cpfs iguais
)

SELECT
    ROW_NUMBER() OVER (ORDER BY cpf_beneficiario_bolsa) AS id_beneficiario_sk,
    cpf_beneficiario_bolsa,
    sexo_beneficiario_bolsa,
    raca_beneficiario_bolsa,
    dt_nascimento_beneficiario,
    beneficiario_deficiente_fisico
FROM perfis_unicos