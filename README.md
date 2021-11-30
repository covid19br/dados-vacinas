# dados-vacinas
Repositório para manter dados sumarizados do SI-PNI Covid-19

Os arquivos são separados por estado, e cada um tem os seguintes campos:

|campo | descrição | tipo |
|------|-----------|------|
|vacina | fabricante da vacina | char: um de "AZ" "Coronavac" "Janssen" "Pfizer" |
|agegroup | faixa etária, de 10 em 10 anos | int de 1 a 9, com 1 significando a faixa de 0-10 anos, e 9 a de 80+ |
|data | data de vacinação | data no formato YYYY-MM-DD|
|doses | qual dose do esquema vacinal - primeira, segunda, única, ou reforço/adicional | char: um de "D1" "D2" "DU" "R" |
|n | número de vacinas aplicadas | int |
