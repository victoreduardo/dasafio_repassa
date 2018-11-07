# Desafio desenvolvedor Full Stack Repassa

Essa é um desafio da entrevista de desenvolvedor Full Stack Repassa. Você pode dar "fork" nesse projeto, porém,
pedidos de "Pull Request" serão ignorados.

## Requisitos

Crie um aplicativo da Web que permita que os funcionários enviem feedback para a análise de desempenho de cada um.

*Soluções parcialmente implementadas são aceitas.* Não é obrigatório enviar a solução completa de todos os requisitos, mas o que for enviado necessáriamente precisa estar funcionando.

## Ambiente Admin
* Adicionar/Remover/Atualizar/Ver Empregados
* Adicionar/Remover/Atualizar/Ver Avaliações de Desempenho
* Atribuir funcionários para participarem da revisão de desempenho de outro funcionário

## Ambiente Funcionário
* Lista de revisões de desempenho que precisam de feedback
* Enviar feedback

## Escopo do Desafio
* Descrever da arquitetura e tecnologias utilizadas
* API Backend
  * Implementação de pelo menos três chamadas de API;
  * No Repassa, utilizamos a linguagem Ruby e o framework Rails servidor (com o Postgres para o banco de dados), mas sinta-se livre para usar outra tecnologia se preferir.
* Aplicativo Web (frontend)
  * Implementação de 2-5 páginas da web usando uma estrutura moderna da web (por exemplo, React, Angular ou VueJS) que fala com o lado do servidor;
  * Layout das telas utilizando CSS ou Framework CSS é livre;
  * Isso deve se integrar à sua API, mas é bom usar respostas estáticas para algumas delas.
* Documente todas as escolhas feitas;
* Soluções completas não são necessárias, mas o que você enviar precisa ser executado.

## Como completar este desafio
* Crie a aplicação e codifique como definido acima com o melhor do seu conhecimento/habilidades;
* Coloque comentários no seu código para explicar alguma ação, quando apropriado. Deixe seu código o mais legível possível;
* *Bonus 1*: Escrever testes, pelo menos da API backend (pelo menos de modelos ou controller se houver);
* Você pode enviar o resultado por email compactado no formato: fullstack_[NOME].zip

## O que estamos procurando com esse teste?
* Entender como você faz escolhas com um número limitado de requerimentos;
* Tecnologia e arquitetura escolhidos;
* Identificar seus pontos fortes;
* Este não é um teste eliminatório, porém, poderá servir como material para uma próxima etapa no processo de contratação.

## Bonus 2 (Resposta opcional):

Considerando o seguinte cenário:

1- A cada venda realizada através de uma loja virtual, será enviado pelo portal, através de uma requisição RESTFul (POST), um evento para um novo sistema que deverá ser construido, este evento conterá o id do usuário e valor total do pedido.

2- Como usuário interno desejo ter um relatório onde poderei analisar dados consolidados sobre esses eventos. São eles: Quantidade de vendas e soma total das vendas. 

3- Após o desenvolvimento de uma arquitetura convencional, isto é, cada requisição pega uma conexão com o pool de conexões com banco de dados (Postgres) e grava 1 registro. O servidor que foi disponibilizado suportou 1000 requisições por minuto. 

4- Entretanto, atualmente a loja faz 1500 vendas por minuto. 

Diante da arquitetura convencional descrita no cenário acima, como você melhoraria ou desenharia uma arquitetura para suportar as 1500 requisições por minuto (sem a necessidade de aumentar a infra-estrutura de servidores)?

