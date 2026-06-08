-- Análise da Distribuição Geográfica e Desigualdade Regional de Bolsas
WITH fato AS (
    SELECT * FROM public.fato_prouni_dbt
),
dim_localidade AS (
    SELECT * FROM public.dim_localidade_dbt
)

SELECT 
    l.regiao_beneficiario_bolsa AS regiao,
    l.sigla_uf_beneficiario_bolsa AS estado,
    COUNT(*) AS total_bolsas,
    ROUND(COUNT() * 100.0 / SUM(COUNT()) OVER(), 2) AS percentual_nacional
FROM fato f
INNER JOIN dim_localidade l 
    ON f.id_localidade_sk = l.id_localidade_sk
GROUP BY l.regiao_beneficiario_bolsa, l.sigla_uf_beneficiario_bolsa
ORDER BY total_bolsas DESC;