{{ config(materialized='table') }} -- definição da configuração para table

WITH df AS (
    SELECT * FROM {{ ref('int_prouni_preparados') }}
),
d_beneficiario AS (
    SELECT * FROM {{ ref('dim_beneficiario_dbt') }}
),
d_localidade AS (
    SELECT * FROM {{ ref('dim_localidade_dbt') }}
),
d_ies AS (
    SELECT * FROM {{ ref('dim_ies_dbt') }}
),
d_curso AS (
    SELECT * FROM {{ ref('dim_curso_dbt') }}
)

SELECT
    b.id_beneficiario_sk,
    l.id_localidade_sk,
    i.id_ies_sk,
    c.id_curso_sk,
    df.ano_concessao_bolsa,
    df.tipo_bolsa
FROM df

-- Junta Beneficiário
LEFT JOIN d_beneficiario b
    ON TRIM(df.cpf_beneficiario_bolsa) = TRIM(b.cpf_beneficiario_bolsa)

-- Junta Localidade
LEFT JOIN d_localidade l
    ON  TRIM(df.municipio_beneficiario_bolsa) = TRIM(l.municipio_beneficiario_bolsa)
    AND TRIM(df.sigla_uf_beneficiario_bolsa)  = TRIM(l.sigla_uf_beneficiario_bolsa)

-- Junta Ies
LEFT JOIN d_ies i
    ON df.codigo_emec_ies_bolsa = i.codigo_emec_ies_bolsa

-- Junta Curso
LEFT JOIN d_curso c
    ON  TRIM(df.nome_curso_bolsa)        = TRIM(c.nome_curso_bolsa)
    AND TRIM(df.modalidade_ensino_bolsa) = TRIM(c.modalidade_ensino_bolsa)