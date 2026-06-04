{{ config(materialized='table') }}

SELECT
    (ROW_NUMBER() OVER (ORDER BY nome_curso_bolsa, nome_turno_curso_bolsa, modalidade_ensino_bolsa) - 1) AS id_curso_sk,
    nome_curso_bolsa,
    nome_turno_curso_bolsa,
    modalidade_ensino_bolsa

FROM {{ ref('int_prouni_preparados') }}

GROUP BY 
    nome_curso_bolsa, 
    nome_turno_curso_bolsa, 
    modalidade_ensino_bolsa