# Relatório do Mini-Projeto 1, Língua Natural

## Grupo 3

* Filipe Ligeiro Silva, 95574
* Tiago Pereira Martins, 95678

**Nota:** ambos os alunos participaram por igual no projeto, tendo-o feito em
conjunto e participado na discussão das questões de design que se encontram
abaixo descritas.

## Decisões tomadas no design da solução

* acceptor pesos
* juntar transdutores

### 1. Transdutor *acceptor*

Este transdutor é utilizado na geração dos transdutores:

* *mmm2mm*
* *pt2en* (e, por extensão, *en2pt*)

Este aceita números de 0 a 9, o caractere '/', e os meses em formato MMM, tanto
em Inglês como em Português. Isto faz com que os transdutores *pt2en* e *en2pt*,
quando fornecidos com meses em Inglês e Português , respetivamente, aceitem os
mesmos, retornando o "input" fornecido sem alteração.

Para o *acceptor* funcionar sem interferir na operação dos transdutores
anteriores a este (como é o caso dos dois transdutores de tradução), tiveram que
ser utilizados pesos, para denotar um peso menor associado à simples cópia de
símbolos *versus* tradução de meses.

Esta decisão de colocar os meses no *acceptor* faz com que o transdutor
*mix2text* se torne bastante mais fácil de gerar (visto que a operação de
tradução funciona independentemente da língua usada).

### 2. Geração de transdutores

Por forma a diminuir ao mínimo a escrita de novos transdutores, muitos destes
foram gerados a partir de transdutores anteriores (como se pode verificar no
script *run.sh*, onde os comandos de geração estão explícitos).
