# dados-vacinas
Repositório para manter dados sumarizados do SI-PNI Covid-19

## Descrição dos arquivos

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
|  6 | 50-59 anos | 40-49 anos |
|  7 | 60-69 anos | 50-59 anos |
|  8 | 70-79 anos | 60-69 anos |
|  9 | 80-89 anos | 70-79 anos |
| 10 |   90+ anos | 80-89 anos |
| 11 |            | 90+ anos |

## Arquivos de saída

Na pasta principal (main), existem cinco arquivos de saída.
- doses_cobertura_proporcao_mes.csv
- doses_cobertura_proporcao_semana.csv
- doses_cobertura_proporcao_mes_ordem.csv
- doses_cobertura_proporcao_semana_ordem.csv
- doses_ordem_uf.csv

Enquanto os arquivos 'doses_cobertura_proporcao_mes.csv' e 'doses_cobertura_proporcao_semana.csv' se baseiam na classificação de doses de acordo com os dados informados pelo SI-PNI, os arquivos 'doses_cobertura_proporcao_mes_ordem.csv' e 'doses_cobertura_proporcao_semana_ordem.csv' classificam as doses de acordo com a **ordem de aplicação** em um mesmo registro de um indivíduo.

**doses_cobertura_proporcao_mes.csv**

| campo | descrição | tipo |
|------|-----------|------|
| month | primeiro dia do mês após a data de aplicação da dose | Date, formato YYYY-MM-DD |
| agegroup | faixa etária (considerando a divisão ag_child) | int de 1 a 11 |
| dose | população com determinada classificação de dose (ler mais abaixo) | factor, levels: D, D1, D2, D2f, R, D1cum, D2cum, Dcum, Rcum |
| n | tamanho da população com certa classificação de dose| int  |
| UF | sigla da Unidade Federativa | factor |

**doses_cobertura_proporcao_semana.csv**

| campo | descrição | tipo |
|------|-----------|------|
| week | último dia da semana epidemiológica da data de aplicação da dose | Date, formato YYYY-MM-DD |
| agegroup | faixa etária (considerando a divisão ag_child) | int de 1 a 11 |
| dose | população com determinada classificação de dose (ler mais abaixo) | factor, levels: D, D1, D2, D2f, R, D1cum, D2cum, Dcum, Rcum |
| n | tamanho da população com certa classificação de dose| int  |
| UF | sigla da Unidade Federativa | factor |

Para as classificações na coluna dose, utiliza-se os seguintes códigos:

| Dose | Descrição | Cálculo |
|------|-----------|------|
| D1 | variação do No de individuos somente com D1 | Soma de novas D1 registradas, subtração de indivíduos que passaram de D1 para D2 |
| D2 | variação do No de individuos com D2+ | Soma de indivíduos que passaram de D1 para D2 ou D |
| D2f | variação do No de individuos com D2+ sem registro de D1 | Soma de registros de D2 sem registro de D1 |
| R | variação do No de individuos com R* | Soma de registros de R* |
| D | variação do No de individuos com primeira dose com Janssen (D+) | soma de registros de primeira dose D (vacina da marca Janssen) |
| D1cum | total acumulado de individuos com somente D1 no tempo t | D1 - D2 |
| D2cum | total acumulado de individuos com D2+ no tempo t e sem dose de reforço | D2 + D2f - R |
| Rcum | total acumulado de individuos com R no tempo t | R |
| Dcum | total acumulado de individuos com somente D+ no tempo t | D |

- D2+: Indivíduos com ao menos a segunda dose (D2), podendo ter recebido outras doses posteriormente. 
- D+: Indivíduos com primeira dose de Janssen (D), podendo ter recebido outras doses posteriormente.
- R*: Indivíduos com dose R na terceira posição, e D1 presente no registro.  
&emsp;&ensp;Indivíduos com dose R na segunda posição, e D1 ausente no registro.  
&emsp;&ensp;Indivíduos com dose D (Janssen) na terceira posição, D1 presente no registro, D2 não é Janssen.  
&emsp;&ensp;Indivíduos com dose D (Janssen) na segunda posição, D1 ausente no registro, D2 não é Janssen.  
    
Observações:
- Esta classificação leva em consideração tanto a classificação de dose (ver **tratamento de dados**) a partir dos dados informados pelo SI-PNI, quanto a ordem da data de aplicação de cada dose para um mesmo registro (ID). No processamento, os dados de cada estado são avaliados separadamente. Desta forma, eventuais registros de indivíduos que tomaram alguma das doses em estados diferentes poderão ser considerados dois registros distintos.
- Quando a segunda dose aplicada (de acordo com a ordem) é "D", da marca Janssen, porém a primeira dose é de outra marca, considera-se que o indivíduo passa para D2
- Para o cálculo da cobertura de doses por estado por mês e semana epidemiológica (arquivos **doses_cobertura_proporcao_mes.csv** e **doses_cobertura_proporcao_semana.csv**), são filtrados os registros de indivíduos que receberam D2 no mesmo dia ou antes de D1.
- Os arquivos **doses_por_estado.csv** e **doses_serie_temporal.csv** são arquivos para contagem de doses, porém obsoletos.

**doses_cobertura_proporcao_mes_ordem.csv**

| campo | descrição | tipo |
|------|-----------|------|
| month | primeiro dia do mês após a data de aplicação da dose | Date, formato YYYY-MM-DD |
| agegroup | faixa etária (considerando a divisão ag_child) | int de 1 a 11 |
| dose | dose de acordo com a ordem de aplicação (ler mais abaixo) | factor, levels: D1, D2, D3, D4, D5, D1cum, D2cum, D3cum, D4cum, D5cum |
| n | tamanho da população com certa classificação de dose| int  |
| first_dose | vacina utilizada na primeira dose (se Janssen ou outra marca) | factor, levels: "Janssen", "Other"  |
| UF | sigla da Unidade Federativa | factor |

**doses_cobertura_proporcao_semana_ordem.csv**

| campo | descrição | tipo |
|------|-----------|------|
| week | último dia da semana epidemiológica da data de aplicação da dose | Date, formato YYYY-MM-DD |
| agegroup | faixa etária (considerando a divisão ag_child) | int de 1 a 11 |
| dose | dose de acordo com a ordem de aplicação (ler mais abaixo) | factor, levels: D1, D2, D3, D4, D5, D1cum, D2cum, D3cum, D4cum, D5cum |
| n | tamanho da população com certa classificação de dose| int  |
| first_dose | vacina utilizada na primeira dose (se Janssen ou outra marca) | factor, levels: "Janssen", "Other"  |
| UF | sigla da Unidade Federativa | factor |

Esta classificação das doses leva em consideração a ordem das datas de aplicações de doses em um mesmo registro, e ignora a classificação de doses de acordo com os dados fornecidos pelo SI-PNI.

| Dose | Descrição | Cálculo |
|------|-----------|------|
| D1 | variação do No de individuos com somente uma dose | Soma de novas D1 registradas, subtração de indivíduos que passaram de D1 para D2 |
| D2 | variação do No de individuos com duas doses | Soma de novas D2 registradas, subtração de indivíduos que passaram de D2 para D3 |
| D3 | variação do No de individuos com três doses | Soma de novas D3 registradas, subtração de indivíduos que passaram de D3 para D4 |
| D4 | variação do No de individuos com quatro doses | Soma de novas D4 registradas, subtração de indivíduos que passaram de D4 para D5 |
| D5 | variação do No de individuos com cinco doses | Soma de novas D5 registradas |
| D1cum | total acumulado de individuos com somente uma dose (D1) no tempo t | D1 - D2 |
| D2cum | total acumulado de individuos com somente duas doses (D2) no tempo t | D2 - D3 |
| D3cum | total acumulado de individuos com somente três doses (D3) no tempo t | D3 - D4 |
| D4cum | total acumulado de individuos com somente quatro doses (D4) no tempo t | D4 - D5 |
| D5cum | total acumulado de individuos com somente cinco doses (D5) no tempo t | D5 |

## Tratamento dos dados

Para classificação dos tipos de doses a partir dos dados brutos do SI-PNI, utiliza-se o seguinte dicionário, na seguinte ordem:

| Regex | Classificação | Exemplo |
|------|------|------|
| Reforço| R | "Dose Reforço", "1º Reforço"|
| 1 | D1 | "1ª Dose", "1ª Dose Revacinação" |
| 2 | D2 | "2ª Dose", "2ª Dose Revacinação" |
| 3 | 3 | "3ª Dose", "3ª Dose Revacinação" |
| 4 | 4 | "4ª Dose" |
| 5 | 5 | "5ª Dose" |
| ^Dose$ | D | "Dose" |
| Adicional | DA | "Dose Adicional" |
| Única | D | "Única" |
| Inicial | D | "Dose Inicial" |
| *Outras combinações* | NA | "Revacinação", "Tratamento com uma dose" |

São automaticamente excluídos os seguintes casos:
- Registros com data de aplicação anterior a 17-jan-2021 e posterior à data de extração do banco
- Pacientes com data de nascimento anterior a 01-jan-1900
- Registros de indivíduos (ID) com mais de 5 doses
- Registros com mais de um mesmo tipo de dose por ID
- Registros de indivíduos (ID) com mais de uma dose na mesma data de aplicação


