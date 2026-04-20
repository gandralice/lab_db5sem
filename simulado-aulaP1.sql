-- O banco de dados usado tem as tabelas: CLIENTE, PEDIDO, ITEM_PEDIDO, PRODUTO, FUNCIONARIO

--1) Liste o nome do cliente, a data do pedido e o nome do produto comprado.
SELECT c.nome, p.data, pr.nome 
FROM CLIENTE c 
JOIN PEDIDO p ON c.id_cliente = p.id_cliente 
JOIN ITEM_PEDIDO i ON p.id_pedido = i.id_pedido 
JOIN PRODUTO pr ON i.id_produto = pr.id_produto;

-- 2) A gerência quer saber quais clientes que ainda não compraram nada.
SELECT nome
FROM CLIENTE
WHERE id_cliente NOT IN (SELECT id_cliente FROM PEDIDO); 

-- 3) A gerência quer saber quais clientes compraram produtos.
SELECT c.nome 
FROM CLIENTE c 
JOIN PEDIDO p ON c.id_cliente = p.id_cliente;

-- 4) Exiba o nome dos funcionários que possuem salário acima da média geral.
SELECT nome 
FROM FUNCIONARIO 
WHERE salario > (SELECT AVG(salario) FROM FUNCIONARIO);

-- 5) Crie uma sequência SEQ_PEDIDO para gerar automaticamente o código dos pedidos, que inicie em 1000 com incremento 1 e sem valores na memória cache.
CREATE SEQUENCE SEQ_PEDIDO START WITH 1000 INCREMENT BY 1 NOCACHE;

-- 6) Utilizando a sequência SEQ_PEDIDO, cadastrar um pedido para o cliente com id = 1 e com a data atual.
INSERT INTO PEDIDO (id_pedido, data, id_cliente, id_funcionario) VALUES (SEQ_PEDIDO.NEXTVAL, SYSDATE, 1, 2);

-- 7) Alterar a sequência SEQ_PEDIDO para que o incremento passe a ser de 15 em 15 com valor máximo de 3000.
ALTER SEQUENCE SEQ_PEDIDO INCREMENT BY 15 MAXVALUE 3000 NOCACHE;

-- 8) Mostre os itens comprados no pedido 100, exibindo produto, quantidade e valor total.
SELECT pr.nome, i.quantidade, (pr.preco*i.quantidade) AS "valor total" FROM PRODUTO pr JOIN ITEM_PEDIDO i ON pr.id_produto = i.id_produto WHERE i.id_pedido = 100;

-- 9) Com subconsulta, liste o nome dos clientes que têm pedido emitido.
SELECT nome FROM CLIENTE WHERE id_cliente IN(SELECT id_cliente FROM PEDIDO);

-- 10) Com subconsulta, liste o nome dos clientes que não têm pedido emitido.
SELECT nome FROM CLIENTE WHERE id_cliente NOT IN(SELECT id_cliente FROM PEDIDO);

-- 11) Criar um índice IDX_CLIENTE para a coluna nome_cliente na tabela CLIENTE.
CREATE INDEX IDX_CLIENTE ON CLIENTE(nome);

-- 12) Criar um sinônimo chamado COLABORADOR para a tabela FUNCIONARIO.
CREATE SYNONYM COLABORADOR FOR FUNCIONARIO;

-- 13) Consultar todas as sequências criadas no usuário logado.
SELECT * FROM USER_SEQUENCES;

-- 14) Consultar todos os sinônimos existentes no banco de dados.
SELECT * FROM ALL_SYNONYMS;

-- 15) Consultar todos os índices no dicionário de dados.
SELECT * FROM USER_INDEXES;

-- 16) Consultar todas as views existentes no dicionário de dados.
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS
WHERE OBJECT_TYPE = 'VIEW';

-- 17) Excluir o índice IDX_CLIENTE.
DROP INDEX IDX_CLIENTE;

-- 18) Excluir a sequência SEQ_PEDIDO.
DROP SEQUENCE SEQ_PEDIDO;

-- 19) Excluir o sinônimo COLABORADOR.
DROP SYNONYM COLABORADOR; 

-- 20) Com operadores de conjunto, exibir o nome dos funcionários e o nome dos clientes sem repetição de nomes.
SELECT nome FROM FUNCIONARIO UNION SELECT nome FROM CLIENTE;  

-- 21) Com operadores de conjunto, exibir o nome dos funcionários e o nome dos clientes com repetição de nomes.
SELECT nome FROM FUNCIONARIO UNION ALL SELECT nome FROM CLIENTE; 

-- 22) Com subconsulta, exiba o nome e o preço dos produtos mais caros que a média de preços.
SELECT nome, preco FROM PRODUTO WHERE preco > (SELECT AVG(preco) FROM PRODUTO); 

-- 23) Liste o nome dos funcionários e com a função SUM, multiplique o preço pela quantidade.
SELECT f.nome, SUM(pr.preco * i.quantidade) AS "total"
FROM FUNCIONARIO f
JOIN PEDIDO p ON f.id_funcionario = p.id_funcionario
JOIN ITEM_PEDIDO i ON p.id_pedido = i.id_pedido
JOIN PRODUTO pr ON i.id_produto = pr.id_produto
GROUP BY f.nome;

-- 24) Liste o nome dos funcionários e com a função SUM, multiplique o preço pela quantidade. Somente exibir os que realizaram pedidos acima de R$3000 no total.
SELECT f.nome, SUM(pr.preco * i.quantidade) AS "total"
FROM FUNCIONARIO f
JOIN PEDIDO p ON f.id_funcionario = p.id_funcionario
JOIN ITEM_PEDIDO i ON p.id_pedido = i.id_pedido
JOIN PRODUTO pr ON i.id_produto = pr.id_produto
GROUP BY f.nome
HAVING SUM(pr.preco * i.quantidade) > 3000;

-- 25) Crie uma view vw_clientes_compras que mostre cliente, produto e valor total gasto (quantidade * preço).
CREATE VIEW vw_clientes_compras AS
SELECT c.nome AS nome_cliente, pr.nome AS nome_produto, (i.quantidade * pr.preco) AS valor_total
FROM CLIENTE c
JOIN PEDIDO p ON c.id_cliente = p.id_cliente
JOIN ITEM_PEDIDO i ON p.id_pedido = i.id_pedido
JOIN PRODUTO pr ON i.id_produto = pr.id_produto;

-- 26) Utilizando a view vw_clientes_compras, exibir o nome e o valor total gasto, ordenado pelo nome do cliente.
SELECT nome_cliente, valor_total
FROM vw_clientes_compras
ORDER BY nome_cliente;

-- 27) Utilizando a view vw_clientes_compras, exibir o nome e o valor total gasto somente quando o valor total for maior ou igual a 2000.
SELECT nome_cliente, valor_total
FROM vw_clientes_compras
WHERE valor_total >= 2000;