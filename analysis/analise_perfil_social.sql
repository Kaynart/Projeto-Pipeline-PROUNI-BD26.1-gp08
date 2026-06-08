-- Análise do Perfil Social dos Beneficiários (Gênero e Raça)
WITH fato AS (    
    SELECT * FROM public.fato_prouni_dbt
),
dim_beneficiario AS (
    SELECT * FROM public.dim_beneficiario_dbt
)

SELECT 
    b.sexo_beneficiario_bolsa AS genero,
    b.raca_beneficiario_bolsa AS raca,
    COUNT(*) AS total_bolsas,
    ROUND(COUNT() * 100.0 / SUM(COUNT()) OVER(), 2) AS percentual_do_total
FROM fato f
INNER JOIN dim_beneficiario b 
    ON f.id_beneficiario_sk = b.id_beneficiario_sk
GROUP BY b.sexo_beneficiario_bolsa, b.raca_beneficiario_bolsa
ORDER BY total_bolsas DESC;