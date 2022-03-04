# dados-vacinas
Repositório para manter dados sumarizados do SI-PNI Covid-19

Na pasta doses_estados, os arquivos são separados por estado, e cada um tem os seguintes campos:

|campo | descrição | tipo |
|------|-----------|------|
|vacina | fabricante da vacina | char: um de "AZ" "Coronavac" "Janssen" "Pfizer" |
|agegroup | faixa etária, representando a faixa etária para uma das duas possíveis divisões (ag_10 ou ag_child) | int de 1 a 11 |
|data | data de vacinação | data no formato YYYY-MM-DD|
|doses | qual dose do esquema vacinal - primeira, segunda, primeira dose com Janssen, reforço, e adicional | char: um de "D1" "D2" "D" "R" "DA"|
|ag_10 | número de vacinas aplicadas para divisão etária de 10 em 10 anos | int |
|ag_child | número de vacinas aplicadas para divisão etária considerando faixas especiais para crianças | int |

Para ag_10, os códigos se traduzem:

| código | ag_10 | ag_child |
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

