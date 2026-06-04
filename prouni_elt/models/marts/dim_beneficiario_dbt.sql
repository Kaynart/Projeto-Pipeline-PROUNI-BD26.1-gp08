{{ config(materialized='table') }}

SELECT
    (ROW_NUMBER() OVER (ORDER BY cpf_beneficiario_bolsa, sexo_beneficiario_bolsa) - 1) AS id_beneficiario_sk,
    cpf_beneficiario_bolsa,
    sexo_beneficiario_bolsa,
    raca_beneficiario_bolsa,
    dt_nascimento_beneficiario,
    beneficiario_deficiente_fisico

FROM {{ ref('int_prouni_preparados') }}

GROUP BY 
    cpf_beneficiario_bolsa, 
    sexo_beneficiario_bolsa, 
    raca_beneficiario_bolsa, 
    dt_nascimento_beneficiario, 
    beneficiario_deficiente_fisico