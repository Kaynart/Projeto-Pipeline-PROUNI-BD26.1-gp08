{{ config(materialized='view') }} -- definição da configuração para view


with stg_prouni AS (
    SELECT * FROM {{ ref('stg_prouni_unificados') }} --Pegando o nosso modelo de staging
),


tratamento_nulos AS ( 
    SELECT *
    FROM stg_prouni 
    WHERE ano_concessao_bolsa IS NOT NULL -- como os únicos valores faltantes são linhas nulas completas, não se precisa usar COALESCE, e remove-se toda a linha
), 


tratamento_final AS (
    SELECT
        ano_concessao_bolsa, -- int, nao recebe upper e trim
        codigo_emec_ies_bolsa, -- int, nao recebe upper e trim

        -- UPPER + TRIM pra garantir integridade e uniformidade
        UPPER(TRIM(nome_ies_bolsa)) AS nome_ies_bolsa,
        UPPER(TRIM(tipo_bolsa)) AS tipo_bolsa,
        UPPER(TRIM(modalidade_ensino_bolsa)) AS modalidade_ensino_bolsa,
        UPPER(TRIM(nome_curso_bolsa)) AS nome_curso_bolsa,
        UPPER(TRIM(nome_turno_curso_bolsa)) AS nome_turno_curso_bolsa,
        
        TRIM(cpf_beneficiario_bolsa) AS cpf_beneficiario_bolsa, -- varchar de numeros, nao recebe upper, mas recebe trim

        UPPER(TRIM(sexo_beneficiario_bolsa)) AS sexo_beneficiario_bolsa,
        UPPER(TRIM(raca_beneficiario_bolsa)) AS raca_beneficiario_bolsa,

        dt_nascimento_beneficiario, -- date, nao recebe upper e trim

        UPPER(TRIM(beneficiario_deficiente_fisico)) AS beneficiario_deficiente_fisico,
        
        -- UPPER + TRIM pra garantir integridade e uniformidade
        UPPER(TRIM(regiao_beneficiario_bolsa)) AS regiao_beneficiario_bolsa,
        UPPER(TRIM(sigla_uf_beneficiario_bolsa)) AS sigla_uf_beneficiario_bolsa,
        UPPER(TRIM(municipio_beneficiario_bolsa)) AS municipio_beneficiario_bolsa,
        UPPER(TRIM(semestre_concessao_bolsa)) AS semestre_concessao_bolsa,

        dt_concessao_bolsa -- date, nao recebe upper e trim
        
    FROM tratamento_nulos
)

SELECT * FROM tratamento_final