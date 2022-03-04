# dados-vacinas
Repositório para manter dados sumarizados do SI-PNI Covid-19

Na pasta doses_estados, os arquivos são separados por estado, e cada um tem os seguintes campos:

| campo | descrição | tipo |
|------|-----------|------|
|vacina | fabricante da vacina | char: um de "AZ" "Coronavac" "Janssen" "Pfizer" |
|agegroup | faixa etária, representando a faixa etária para uma das duas possíveis divisões (ag_10 ou ag_child) | int de 1 a 11 |
|data | data de vacinação | Date, formato YYYY-MM-DD|
|doses | qual dose do esquema vacinal - primeira, segunda, primeira dose com Janssen, reforço, e adicional | char: um de "D1" "D2" "D" "R" "DA"|
|ag_10 | número de vacinas aplicadas para divisão etária de 10 em 10 anos | int |
|ag_child | número de vacinas aplicadas para divisão etária considerando faixas especiais para crianças | int |

Observação: o antigo código "DU" (Dose Única) para a vacina Janssen foi atualizado para "D", representando somente "D", quando a Janssen é a primeira vacina a ser aplicada.

Os códigos das faixas etárias se traduzem:

| código | ag_10 | ag_child |
|------|-----------|------|
|  1 |   0-9 anos | 0-4 anos |
|  2 | 10-19 anos | 5-11 anos |
|  3 | 20-29 anos | 12-17 anos |
|  4 | 30-39 anos | 18-29 anos |
|  5 | 40-49 anos | 30-39 anos |
|  6 | 50-59 anos | 40-41 anos |
|  7 | 60-69 anos | 50-51 anos |
|  8 | 70-79 anos | 60-61 anos |
|  9 | 80-89 anos | 70-71 anos |
| 10 |   90+ anos | 80-81 anos |
| 11 |            | 90+ anos |

Na pasta principal (main), existem quatro arquivos de saída.

**doses_cobertura_proporcao_mes.csv**

| campo | descrição | tipo |
|------|-----------|------|
| month | primeiro dia do mês após a data de aplicação da dose | Date, formato YYYY-MM-DD |
| agegroup | faixa etária (considerando a divisão ag_child) | int de 1 a 11 |
| dose | população com determinada classificação de dose (ler mais abaixo) | factor, levels: D, D1, D2, D2f, D1cum, D2cum, Dcum |
| n | tamanho da população com certa classificação de dose| int  |
| UF | sigla da Unidade Federativa | factor |

**doses_cobertura_proporcao_semana.csv**

| campo | descrição | tipo |
|------|-----------|------|
| week | último dia da semana epidemiológica da data de aplicação da dose | Date, formato YYYY-MM-DD |
| agegroup | faixa etária (considerando a divisão ag_child) | int de 1 a 11 |
| dose | população com determinada classificação de dose (ler mais abaixo) | factor, levels: D, D1, D2, D2f, D1cum, D2cum, Dcum |
| n | tamanho da população com certa classificação de dose| int  |
| UF | sigla da Unidade Federativa | factor |

Para as classificações na coluna dose, utiliza-se os seguintes códigos:

| Dose | Descrição | Cálculo |
|------|-----------|------|
| D1 | variação do No de individuos somente com D1 | Soma de novas D1 registradas, subtração de indivíduos que passaram de D1 para D2 |
| D2 | variação do No de individuos com D2 | Soma de indivíduos que passaram de D1 para D2 |
| D2f | variação do No de individuos | Soma de registros de D2 sem registro de D1 |
| D | variação do No de individuos somente com D| soma de registros de primeira dose com vacina da marca Janssen |
| D1cum | total de individuos com somente D1 no tempo t | D1 - D2 |
| D2cum | total de individuos com D2 no tempo t | D2 + D2f |
| Dcum | total de individuos com somente D no tempo t | D |

Observação: os arquivos **doses_por_estado.csv** e **doses_serie_temporal.csv** são arquivos para contagem de doses, porém obsoletos.
