-- simulado claude

-- 1) Liste o nome do cliente e o total gasto por ele (quantidade * preço), ordenado do maior para o menor.
SELECT c.cliente, (i.quantidade * pr.preco) AS "total"
FROM CLIENTE c 
JOIN PEDIDO p ON c.id_cliente = p.id_cliente
JOIN ITEM_PEDIDO p ON p.id_pedido = i.id_pedido
JOIN PRODUTO pr ON pr.id_produto = pr.id_produto
ORDER BY (i.quantidade * pr.preco) DESC;

-- 2) Exiba o nome dos clientes que nunca fizeram nenhum pedido. Use NOT EXISTS.
SELECT c.nome 
FROM CLIENTE c 
WHERE NOT EXISTS (SELECT 'X' FROM PEDIDO WHERE id_cliente = c.id_cliente);

-- 3) Exiba o nome e o preço dos produtos, mostrando apenas os que custam mais que a média de preços. Use subconsulta.
SELECT nome, preco
FROM PRODUTO WHERE preco > (SELECT AVG(preco) FROM PRODUTO);

-- 4) Crie uma view vw_funcionario_vendas que mostre o nome do funcionário e o total vendido por ele (quantidade * preço).
CREATE VIEW vw_funcionario_vendas AS
SELECT f.nome, SUM(i.quantidade * pr.preco) AS total
FROM FUNCIONARIO f
JOIN PEDIDO p ON f.id_funcionario = p.id_funcionario
JOIN ITEM_PEDIDO i ON p.id_pedido = i.id_pedido
JOIN PRODUTO pr ON i.id_produto = pr.id_produto
GROUP BY f.nome;

-- 5) Usando a view criada, exiba apenas os funcionários que venderam mais de R$5000 no total.
SELECT nome, total
FROM vw_funcionario_vendas
WHERE total > 5000;

-- 6) Crie uma sequence SEQ_CLIENTE que inicie em 1, incremente de 1 em 1, valor máximo 9999, sem cache.
CREATE SEQUENCE SEQ_CLIENTE
START WITH 1
INCREMENT BY 1
MAXVALUE 9999
NOCACHE;

-- 7) Insira um cliente usando a sequence, com nome 'Paula Souza' e email 'paula@email.com'.
INSERT INTO CLIENTE (id_cliente, nome, email) VALUES (SEQ_CLIENTE.NEXTVAL, 'Paula Souza', 'paula@email.com');

-- 8) Altere a sequence para incrementar de 2 em 2.
ALTER SEQUENCE SEQ_CLIENTE
INCREMENT BY 2;

-- 9) Crie um sinônimo COMPRA para a tabela PEDIDO e faça um SELECT de todos os registros usando ele.
CREATE SYNONYM COMPRA FOR PEDIDO;
SELECT * FROM COMPRA;

-- 10) Crie um índice IDX_PRODUTO para a coluna nome da tabela PRODUTO.
CREATE INDEX ID_PRODUTO ON PRODUTO(nome);

-- 11) Exiba o nome dos funcionários e o nome dos clientes numa lista só, sem repetição.
SELECT nome FROM FUNCIONARIO
UNION
SELECT nome FROM CLIENTE;

-- 12) Exiba o nome dos funcionários e o nome dos clientes numa lista só, com repetição.
SELECT nome FROM FUNCIONARIO
UNION ALL
SELECT nome FROM CLIENTE;

-- 13) Consulte todas as views do seu usuário no dicionário de dados.
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS
WHERE OBJECT_TYPE = 'VIEW';

-- 14) Exclua o sinônimo COMPRA, o índice IDX_PRODUTO e a sequence SEQ_CLIENTE.
DROP SYNONYM COMPRA;
DROP INDEX IDX_PRODUTO;
DROP SEQUENCE SEQ_CLIENTE;