{{ config(materialized='view') }} -- definição da configuração para view

SELECT
    -- inteiros
    CAST("ANO_CONCESSAO_BOLSA" AS INT)                  AS ano_concessao_bolsa, -- garantia de unificação dos tipos para essa coluna em cada um dos três anos
    CAST("CODIGO_EMEC_IES_BOLSA" AS BIGINT)             AS codigo_emec_ies_bolsa,

    -- varchar
    CAST("NOME_IES_BOLSA" AS VARCHAR)                   AS nome_ies_bolsa,
    CAST("TIPO_BOLSA" AS VARCHAR)                       AS tipo_bolsa,
    CAST("MODALIDADE_ENSINO_BOLSA" AS VARCHAR)          AS modalidade_ensino_bolsa,
    CAST("NOME_CURSO_BOLSA" AS VARCHAR)                 AS nome_curso_bolsa,
    CAST("NOME_TURNO_CURSO_BOLSA" AS VARCHAR)           AS nome_turno_curso_bolsa,
    CAST("CPF_BENEFICIARIO_BOLSA" AS VARCHAR)           AS cpf_beneficiario_bolsa,
    CAST("SEXO_BENEFICIARIO_BOLSA" AS VARCHAR)          AS sexo_beneficiario_bolsa,
    CAST("RACA_BENEFICIARIO_BOLSA" AS VARCHAR)          AS raca_beneficiario_bolsa,

    -- date
    CAST("DT_NASCIMENTO_BENEFICIARIO" AS DATE)          AS dt_nascimento_beneficiario,

    -- varchar
    CAST("BENEFICIARIO_DEFICIENTE_FISICO" AS VARCHAR)   AS beneficiario_deficiente_fisico,
    CAST("REGIAO_BENEFICIARIO_BOLSA" AS VARCHAR)        AS regiao_beneficiario_bolsa,
    CAST("SIGLA_UF_BENEFICIARIO_BOLSA" AS VARCHAR)      AS sigla_uf_beneficiario_bolsa,
    CAST("MUNICIPIO_BENEFICIARIO_BOLSA" AS VARCHAR)     AS municipio_beneficiario_bolsa



from {{ source('dados_brutos_prouni', 'raw_prouni_2017') }}

union all

select
    -- inteiros
    CAST("ANO_CONCESSAO_BOLSA" AS INT)                  AS ano_concessao_bolsa, -- garantia de unificação dos tipos para essa coluna em cada um dos três anos
    CAST("CODIGO_EMEC_IES_BOLSA" AS BIGINT)             AS codigo_emec_ies_bolsa,

    -- varchar
    CAST("NOME_IES_BOLSA" AS VARCHAR)                   AS nome_ies_bolsa,
    CAST("TIPO_BOLSA" AS VARCHAR)                       AS tipo_bolsa,
    CAST("MODALIDADE_ENSINO_BOLSA" AS VARCHAR)          AS modalidade_ensino_bolsa,
    CAST("NOME_CURSO_BOLSA" AS VARCHAR)                 AS nome_curso_bolsa,
    CAST("NOME_TURNO_CURSO_BOLSA" AS VARCHAR)           AS nome_turno_curso_bolsa,
    CAST("CPF_BENEFICIARIO_BOLSA" AS VARCHAR)           AS cpf_beneficiario_bolsa,
    CAST("SEXO_BENEFICIARIO_BOLSA" AS VARCHAR)          AS sexo_beneficiario_bolsa,
    CAST("RACA_BENEFICIARIO_BOLSA" AS VARCHAR)          AS raca_beneficiario_bolsa,

    -- date
    CAST("DT_NASCIMENTO_BENEFICIARIO" AS DATE)          AS dt_nascimento_beneficiario,

    -- varchar
    CAST("BENEFICIARIO_DEFICIENTE_FISICO" AS VARCHAR)   AS beneficiario_deficiente_fisico,
    CAST("REGIAO_BENEFICIARIO_BOLSA" AS VARCHAR)        AS regiao_beneficiario_bolsa,
    CAST("SIGLA_UF_BENEFICIARIO_BOLSA" AS VARCHAR)      AS sigla_uf_beneficiario_bolsa,
    CAST("MUNICIPIO_BENEFICIARIO_BOLSA" AS VARCHAR)     AS municipio_beneficiario_bolsa


from {{ source('dados_brutos_prouni', 'raw_prouni_2018') }}

union all

select
    -- inteiros
    CAST("ANO_CONCESSAO_BOLSA" AS INT)                  AS ano_concessao_bolsa, -- garantia de unificação dos tipos para essa coluna em cada um dos três anos
    CAST("CODIGO_EMEC_IES_BOLSA" AS BIGINT)             AS codigo_emec_ies_bolsa,

    -- varchar
    CAST("NOME_IES_BOLSA" AS VARCHAR)                   AS nome_ies_bolsa,
    CAST("TIPO_BOLSA" AS VARCHAR)                       AS tipo_bolsa,
    CAST("MODALIDADE_ENSINO_BOLSA" AS VARCHAR)          AS modalidade_ensino_bolsa,
    CAST("NOME_CURSO_BOLSA" AS VARCHAR)                 AS nome_curso_bolsa,
    CAST("NOME_TURNO_CURSO_BOLSA" AS VARCHAR)           AS nome_turno_curso_bolsa,
    CAST("CPF_BENEFICIARIO_BOLSA" AS VARCHAR)           AS cpf_beneficiario_bolsa,
    CAST("SEXO_BENEFICIARIO_BOLSA" AS VARCHAR)          AS sexo_beneficiario_bolsa,
    CAST("RACA_BENEFICIARIO_BOLSA" AS VARCHAR)          AS raca_beneficiario_bolsa,

    -- date
    CAST("DT_NASCIMENTO_BENEFICIARIO" AS DATE)          AS dt_nascimento_beneficiario,

    -- varchar
    CAST("BENEFICIARIO_DEFICIENTE_FISICO" AS VARCHAR)   AS beneficiario_deficiente_fisico,
    CAST("REGIAO_BENEFICIARIO_BOLSA" AS VARCHAR)        AS regiao_beneficiario_bolsa,
    CAST("SIGLA_UF_BENEFICIARIO_BOLSA" AS VARCHAR)      AS sigla_uf_beneficiario_bolsa,
    CAST("MUNICIPIO_BENEFICIARIO_BOLSA" AS VARCHAR)     AS municipio_beneficiario_bolsa


from {{ source('dados_brutos_prouni', 'raw_prouni_2019') }}