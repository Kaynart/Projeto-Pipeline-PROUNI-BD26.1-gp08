{{ config(materialized='table') }}

SELECT
    (ROW_NUMBER() OVER (ORDER BY codigo_emec_ies_bolsa, nome_ies_bolsa) - 1) AS id_ies_sk,
    codigo_emec_ies_bolsa,
    nome_ies_bolsa

FROM {{ ref('int_prouni_preparados') }}

GROUP BY 
    codigo_emec_ies_bolsa, 
    nome_ies_bolsa