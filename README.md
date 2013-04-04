# EliteApp

## Official Calendar

* Acompanhamento de performance acadêmica
  * Algoritmo e interface de Processamento de cartões-resposta (utilizando o modelo atual) (02MAR)
    * Usuários devem poder fazer upload de cartões e extrair as respostas assinaladas pelo aluno
    * Usuários devem poder fazer correções no processamento, sendo assim verificadores do processo
    * O cadastro de toda a estrutura pedagógica se faz necessário para a escalabilidade do processo
  * Geração automatica de resultados e lista de presença (22MAR)
    * O Sistema deve comparar as respostas assinaladas pelo aluno com a resposta certa, gerando assim uma nota final para o aluno
    * O Sistema deve compilar todas as notas (finais e parciais) dos alunos de um determinado Produto e montar uma lista de classificação
    * O Sistema deve aceitar notas calculadas de maneira mais complexa (peso para provas, nota mínima por prova, critérios de desempate)
    * O Sistema deve gerar todos os documentos acessórios para a realização de um simulado (lista de presença)
  * Confecção de um cartão-resposta personalizado e ajuste do algoritmo para processamento (12ABR)
    * O Novo cartão-resposta deve possuir forma que facilite a sua impressão na unidade
    * O Novo cartão-resposta deve possuir um layout que minimize os erros de leitura
    * O Novo cartão-resposta deve permitir ao sistema identificar automaticamente qual aluno realizou qual prova
    * O Novo cartão-resposta deve reduzir o número de erros acionáveis(de processamento do cartão, de marcação de código, etc) para no máximo 1% do total de cartões
  * EliteSim para Alunos e Coordenadores (31MAI)
    * Os alunos poderão acessar as informações de notas de 5 maneiras diferentes: Lista, Histograma de Acertos, Estatisticas de Resposta, Evolução no tempo e Boletim de Desempenho
    * os coordenadores poderão, além de simular o acesso de qualquer aluno de sua unidade, 
* Acompanhamento do Horario/Faltas (26ABR)
  * O usuário poderá verificar/alterar o horário, temporariamente e definitivamente
  * O usuário poderá lançar faltas (e suas substituiçoes), bem como aulas extras
  * O professor terá acesso a suas faltas separadas por mês de competência
  * Os professores poderão visualizar e alterar seus dados cadastrais (foto, telefone, endereço)
* Processamento de Pesquisas  (Depende da data da GDP #1 e pesquisa de satisfação #1)
  * Gerar pesquisas personalizadas para cada turma (PDF's)
  * Processar o resultado das pesquisas e gerar um output analítico


## Urgent

* Create staging environment and deploy daily


## Later...

* Card processing
  * Changing a student's class its student_exams will remain on the old class
  * Fix card_processing destroy link
  * Unmark card_processing as repeated after destruction
  * Create student_exam views
  * Add dpi validation to card upload

* Create feedback button!

* Improvements
  * Add subject to exam form - update task
  * Datatables ajax
  * Review back buttons
  * Translate

* Calendar
  * fix select date
  * create campus calendar
  * create/update/destroy actions for periods
  * create holidays and breaks table

* Schedule
  * Update db changes from schema.mwb to schema.rb
  * Create migration script for sample files



