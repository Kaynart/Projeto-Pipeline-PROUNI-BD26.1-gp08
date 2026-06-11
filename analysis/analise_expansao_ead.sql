-- Análise da Evolução de Bolsas: Presencial vs. Ensino à Distância (EaD)
WITH fato AS (
    SELECT * FROM public.fato_prouni_dbt
),
dim_curso AS (
    SELECT * FROM public.dim_curso_dbt
)

SELECT 
    f.ano_concessao_bolsa AS ano,
    c.modalidade_ensino_bolsa AS modalidade,
    COUNT(*) AS total_bolsas,
    -- Mostra a distribuição percentual dentro de cada ano:
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY f.ano_concessao_bolsa), 2) AS percentual_no_ano
FROM fato f
INNER JOIN dim_curso c 
    ON f.id_curso_sk = c.id_curso_sk
GROUP BY f.ano_concessao_bolsa, c.modalidade_ensino_bolsa
ORDER BY ano ASC, total_bolsas DESC;
