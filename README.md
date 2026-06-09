# 🎓 Data Warehouse e Pipeline de Dados: Análise Histórica de Concessão de Bolsas ProUni (2017-2019)

> **Projeto da Disciplina CIN0137 - Banco de Dados 26.1 - Centro de Informática UFPE**

Este repositório centraliza o desenvolvimento de um ecossistema de dados projetado para consolidar, higienizar e analisar o histórico de concessão de bolsas do Programa Universidade para Todos (PROUNI). 

O projeto explora o contraste prático entre duas arquiteturas de Engenharia de Dados: o **ETL Tradicional** baseado em scripts imperativos (Python/Pandas) e o **ELT Moderno** declarativo (dbt/SQL), promovendo a construção de um **Data Warehouse em Esquema Estrela (Star Schema)** voltado para Business Intelligence (BI).

---

## 👥 Equipe 08
| **Nome Integrante** | **login CIn** |
| :--- | :---: |
| Caio de Oliveira Daltro Gouté | ***codg*** |
| Felipe Almeida Albuquerque de Holanda | ***faah*** |
| Guilherme Galindo Zloccowick | ***ggz*** |
| Jonas Manoel Barbosa de Lima | ***jmbl2*** |
| Kaynan Roberth Torres Silva | ***krts*** |
| Maria Clara Pereira Goncalves | ***mcpg*** |

---


## 🎯 O Cenário e os Desafios dos Dados

O principal objetivo do projeto foi unificar anos de dados públicos fragmentados para viabilizar uma análise histórica consistente sobre o perfil dos beneficiários e das instituições de ensino superior (IES).

* **Fonte:** Base pública de dados abertos do Ministério da Educação (MEC) [https://dadosabertos.mec.gov.br/prouni].
* **Dados Brutos:** Arquivos CSV anuais (2017, 2018 e 2019) contendo o registro individualizado de cada bolsa.
* **Desafios de Data Quality:**
  * **Inconsistência de Tipagem:** Colunas essenciais (como `ano_concessao_bolsa`) mudavam de tipo primitivo de um ano para o outro.
  * **Registros Corrompidos:** O arquivo de 2019 apresentava linhas fantasmas compostas inteiramente por valores nulos.
  * **Complexidade de Sintaxe:** A fonte bruta trazia cabeçalhos em caixa alta, o que exigiria o uso exaustivo de aspas duplas no PostgreSQL se não normalizados.

---

## 🏗️ Arquitetura da Solução

Para fins comparativos e de aprendizado, estruturamos a solução através de duas esteiras distintas:

### 1. Abordagem ETL (Python Driven)
  * **Extração (E):** Leitura automatizada dos CSVs locais ou via API.
  * **Transformação (T):** Limpeza inicial, padronização de nomenclatura de colunas para caixa baixa e conversão forçada de tipos em memória usando **Pandas**.
  * **Carga (L):** Inserção das tabelas pré-processadas no PostgreSQL.

### 2. Abordagem ELT (Modern Data Stack)
  * **Extração & Carga (EL):** O Python é usado para carregar os dados brutos (`raw`) diretamente no banco de dados.
  * **Transformação (T):** O **dbt (data build tool)** orquestra transformações complexas dentro do PostgreSQL usando SQL modular, dividido em camadas:
      * **Staging (`stg_`):** Unificação dos três anos via `UNION ALL`, normalização dos nomes das colunas para caixa baixa (evitando o uso de aspas em SQL) e aplicação de `CAST` para unificar os tipos das colunas.
      * **Intermediate (`int_`):** Limpeza pesada e de maior densidade, responsável pela eliminação de linhas 100% nulas de 2019 e aplicação conjunta de `UPPER()` e `TRIM()` para garantir a integridade do texto.
      * **Marts:** Criação das Tabelas Fato e Dimensão finais — Esquema Estrela.
---

## 🖼️ Diagrama de Representação

<img width="1711" height="705" alt="Image" src="https://github.com/user-attachments/assets/b77eacac-83fd-4a1d-b1db-a7c18416f3c5" />

---

## 📐 Arquitetura do Star Schema

Ao final do pipeline, os dados limpos são organizados em um modelo dimensional para facilitar as análises:

| Tabela | Tipo | Descrição |
| :--- | :--- | :--- |
| **`fct_prouni`** | **Fato** | Registro de cada bolsa concedida. Contém a métrica de contagem (`quantidade_bolsas`), o contexto temporal/tipo e as chaves estrangeiras (Surrogate Keys) que conectam às dimensões. |
| **`dim_beneficiario`** | Dimensão | Perfil demográfico dos estudantes (Sexo, Raça, Idade, CPF mascarado e indicador de deficiência física). |
| **`dim_ies`** | Dimensão | Dados das Instituições de Ensino Superior (Código EMEC e Nome normalizado da IES). |
| **`dim_curso`** | Dimensão | Detalhes das vagas (Nome do Curso, Turno e Modalidade de Ensino). |
| **`dim_localidade`** | Dimensão | Hierarquia geográfica do beneficiário (Município, UF e Região). |
| **`dim_temporal`** | Dimensão | Dados representativos de tempo da concessão de bolsa (Ano, Mês e Dia de Concessão e Semestre). |

---

## 🛠️ Ferramentas Utilizadas

* **Python 3.x**: Scripts para carga/manipulação inicial de dados.
  * **PostgreSQL**: Sistema de Gerenciamento de Banco de Dados (SGBD) atuando como nosso Data Warehouse.
  * **dbt Core**: Orquestração, linhagem, testes e transformações SQL.
  * **SQLAlchemy & Psycopg2**: Conectores de banco de dados.
  * **Git/GitHub**: Controle de versionamento e trabalho colaborativo da equipe.
  * **Discord**: Comunicação controlada e direta entre os integrantes do time de desenvolvimento.

---

## 📂 Organização do Repositório

```
.
├── analysis/                       # Scripts SQL com as análises finais (Insights)
├── notebooks/                      # Scripts de ETL e carga inicial executados pelos colegas
│   ├── data/                       # Arquivos CSV brutos usados de fato, com dados sintéticos
|   ├── data_original/              # Arquivos CSV inicialmente recebidos
│   ├── ETL.ipynb                   # Pipeline 1: ETL completo em Python
│   └── ELT.ipynb                   # Pipeline 2: Carga bruta para o dbt
├──  prouni_elt/                    # Projeto dbt (Pipeline ELT)
│   ├── models/
│   │   ├── staging/                # unificação dos dados brutos
│   │   └── marts/                  # Modelos finais (Dimensões e Fato com Surrogate Keys)
|   |   |   ├── int_prouni...       # Limpeza densa intermediária: UPPER, TRIM, Nulos
│   │   │   ├── dim_...             # Tabelas Dimensão
│   │   │   └── fato_prouni...      # Tabela Fato
│   └── dbt_project.yml
├── .gitignore                      # Segurança para versionamento   
└── README.md                       # Instruções e documentação
```

-----

## 🚀 Como Executar o Projeto

### Pré-requisitos

1.  Instale Python e PostgreSQL.
2.  Clone este repositório.
3.  Instale as dependências: `pip install pandas sqlalchemy psycopg2-binary dbt-postgres`.

### Passo 1: Carga Inicial (EL)

Execute o notebook `notebooks/ELT.ipynb`. Isso lerá os CSVs da pasta `data/` e criará as tabelas `raw_prouni_201X` no seu banco de dados.

### Passo 2: Configuração do dbt

1.  Configure seu arquivo `profiles.yml` (geralmente em `~/.dbt/`) com as credenciais do seu PostgreSQL local.
2.  No terminal, navegue até a pasta do projeto dbt:
    ```bash
    cd prouni_elt
    ```
3.  Teste a conexão:
    ```bash
    dbt debug
    ```

### Passo 3: Execução das Transformações

Ainda no terminal, execute o comando para construir o Data Warehouse:

```bash
dbt run
```

*Isso criará todas as views de staging e as tabelas Fato e Dimensão finais.*

-----
## 📊 Resultados e Insights

A modelagem dimensional permitiu responder a perguntas complexas de negócio com alta performance e sem duplicidade de registros:

1. **Análise Demográfica:** Mapeamento do perfil socioeconômico dos beneficiários (gênero, raça e incidência de PCD) cruzado com o tipo de bolsa (integral ou parcial).
2. **Mapeamento Institucional:** Análise da expansão da modalidade Ensino à Distância (EAD) pelo PROUNI ao longo dos anos.
3. **Análise Social:** Identificação dos perfis sociais predominantes no programa governamental no triênio trabalhado.
   
> **Nota sobre a Qualidade dos Dados:** Durante a fase de construção da tabela Intermediate, o pipeline eliminou com sucesso um lote de registros corrompidos nativos do ano de 2019, que continham linhas inteiramente nulas, blindando as métricas da tabela Fato contra distorções. Além disso, também foram aplicados dados sintéticos para ampliação e detalhamento da análise temporal. 
