{{ config(materialized='table') }}

SELECT
    (ROW_NUMBER() OVER (ORDER BY regiao_beneficiario_bolsa, sigla_uf_beneficiario_bolsa, municipio_beneficiario_bolsa) - 1) AS id_localidade_sk,
    regiao_beneficiario_bolsa,
    sigla_uf_beneficiario_bolsa,
    municipio_beneficiario_bolsa

FROM {{ ref('int_prouni_preparados') }}

GROUP BY 
    regiao_beneficiario_bolsa, 
    sigla_uf_beneficiario_bolsa, 
    municipio_beneficiario_bolsa