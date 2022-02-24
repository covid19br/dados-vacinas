# dados-vacinas
Repositório para manter dados sumarizados do SI-PNI Covid-19

Os arquivos são separados por estado, e cada um tem os seguintes campos:

|campo | descrição | tipo |
|------|-----------|------|
|vacina | fabricante da vacina | char: um de "AZ" "Coronavac" "Janssen" "Pfizer" |
|agegroup | faixa etária, de 10 em 10 anos | int de 1 a 11, com 1 significando a faixa de 0-4, 2 significando 5-11, 3 significando 12-17, 4 significando 18-29, e para 4,5,6,7,8,9, 10, bins de 10 em 10 anos, e 11 a de 90+ |
|data | data de vacinação | data no formato YYYY-MM-DD|
|doses | qual dose do esquema vacinal - primeira, segunda, única, ou reforço/adicional | char: um de "D1" "D2" "DU" "R" |
|n | número de vacinas aplicadas | int |
