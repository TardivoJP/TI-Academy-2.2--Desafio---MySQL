-- consulta tabela fornecedores
SELECT * from fornecedor;

-- consulta apenas os nomes da tabela fornecedores
SELECT nome FROM fornecedor;

-- consulta de várias tabelas ao mesmo tempo
SELECT oc.id, oc.data, f.nome, f.ie FROM fornecedor as f, ordem_compra as oc;

-- consulta de várias tabelas especificando uma relação entre elas
SELECT oc.id, oc.data, f.nome, f.ie FROM fornecedor as f, ordem_compra as oc
WHERE oc.idFornecedor = f.id;

-- consulta de várias tabelas especificando uma relação entre elas
-- ordenando por uma coluna específica (forma crescente por padrão)
SELECT oc.id, oc.data, f.nome, f.ie FROM fornecedor as f, ordem_compra as oc
WHERE oc.idFornecedor = f.id
ORDER BY f.ie;

-- consulta de várias tabelas especificando uma relação entre elas
-- ordenando por uma coluna específica de forma decrescente
SELECT oc.id, oc.data, f.nome, f.ie FROM fornecedor as f, ordem_compra as oc
WHERE oc.idFornecedor = f.id
ORDER BY f.ie DESC;

-- outro exemplo de consulta em várias tabelas
SELECT ioc.idOrdemCompra, ioc.idMaterial, m.nome
FROM item_ordem_compra AS ioc, material AS m
WHERE ioc.idMaterial = m.id
ORDER BY ioc.idOrdemCompra;

-- -------------------------------------------------------------------------------------
-- 1. Exiba os dados da compra (item_ordem_compra) de todos os materiais cuja
-- quantidade seja maior que 10.
SELECT * FROM item_ordem_compra
WHERE quantidade>10;
-- -------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------
-- 2. Exiba os dados da compra (item_ordem_compra) de todos os materiais cujo
-- valor seja menor que 50.
SELECT * FROM item_ordem_compra
WHERE valor<50;
-- -------------------------------------------------------------------------------------

-- juntando as duas condições dos exercícios temos
SELECT * FROM item_ordem_compra
WHERE quantidade>10 AND valor<50;

-- -------------------------------------------------------------------------------------
-- 3. Exiba os dados da compra (item_ordem_compra) de todos os materiais cuja
-- quantidade seja maior que 100 e o valor seja menor que 50, contendo o nome
-- do material e o nome do fornecedor.
SELECT ioc.idOrdemCompra, ioc.quantidade, ioc.valor, f.nome, m.nome
FROM item_ordem_compra AS ioc, material AS m, fornecedor AS f, ordem_compra AS o
WHERE ioc.idMaterial=m.id AND ioc.idOrdemCompra=o.id AND o.idFornecedor=f.id AND ioc.quantidade>100 AND ioc.valor<50;
-- -------------------------------------------------------------------------------------

-- realizar operações e mostrar na consulta
SELECT *, quantidade*valor AS Subtotal
FROM item_ordem_compra;

-- -------------------------------------------------------------------------------------
-- 4. Exiba o subtotal de cada material vendido, o nome do material e o nome do fornecedor.
SELECT ioc.idOrdemCompra, ioc.quantidade, ioc.valor, f.nome, m.nome, ioc.quantidade*ioc.valor AS Subtotal
FROM item_ordem_compra AS ioc, material AS m, fornecedor AS f, ordem_compra AS o
WHERE ioc.idMaterial=m.id AND ioc.idOrdemCompra=o.id AND o.idFornecedor=f.id;
-- -------------------------------------------------------------------------------------

-- realizar operações e mostrar na consulta
-- neste caso a operação é composta e agrupada pelo id de cada compra
SELECT idOrdemCompra, SUM(quantidade*valor) AS totalCompra
FROM item_ordem_compra
GROUP BY idOrdemCompra;

-- é possível criar condições para a operação realizada
-- porém deve-se utilizar "HAVING" ao invés de "WHERE"
-- pois trata-se de um agrupador "GROUP BY"
SELECT idOrdemCompra, SUM(valor*quantidade) AS totalCompra
FROM item_ordem_compra
GROUP BY idOrdemCompra
HAVING totalCompra>5000;

-- -------------------------------------------------------------------------------------
-- 5. Exiba o nome do fornecedor da ordem de comrpa, a ordem de compra, o total pago
-- pela ordem de compra.
SELECT  f.nome, ioc.idOrdemCompra, SUM(ioc.quantidade*ioc.valor) AS totalCompra
FROM item_ordem_compra AS ioc, fornecedor AS f, ordem_compra AS o
WHERE ioc.idOrdemCompra=o.id AND o.idFornecedor=f.id
GROUP BY idOrdemCompra;
-- -------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------
-- 6. Exiba o nome do fornecedor da ordem de compra, a data da ordem de compra, o total
-- pago pela ordem de compra, num determinado intervalo de datas.

-- é possível estabelecer um intervalo atraves do comando "BETWEEN"
SELECT  f.nome, o.data, SUM(ioc.quantidade*ioc.valor) AS totalCompra
FROM item_ordem_compra AS ioc, fornecedor AS f, ordem_compra AS o
WHERE ioc.idOrdemCompra=o.id AND o.idFornecedor=f.id AND o.data BETWEEN '2022-05-15' AND '2022-05-20'
GROUP BY idOrdemCompra;
-- -------------------------------------------------------------------------------------