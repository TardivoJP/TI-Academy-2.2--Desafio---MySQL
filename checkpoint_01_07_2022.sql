USE turmax;
SELECT * FROM material;
SELECT * FROM item_ordem_compra;

-- -------------------------------------------------------------------------------------
-- listar o nome de cada material e o valor médio desse material
SELECT m.nome, AVG(ioc.valor) AS media
FROM item_ordem_compra AS ioc, material AS m
WHERE ioc.idMaterial = m.id
GROUP BY m.nome;
-- -------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------
-- listar o nome de cada material e o valor médio desse material
-- entre os dias 10/05/2022 e 13/05/2022
SELECT m.nome, AVG(ioc.valor) AS media
FROM item_ordem_compra AS ioc, material AS m, ordem_compra AS o
WHERE ioc.idMaterial = m.id AND o.id=ioc.idOrdemCompra AND o.data BETWEEN '2022-05-10' AND '2022-05-13'
GROUP BY m.nome;
-- -------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------
-- qual o produto que tem mais saída nas ordens de compra
-- (que apareceu em mais pedidos)
SELECT m.nome, COUNT(ioc.idMaterial) AS maisVendido
FROM item_ordem_compra AS ioc, material AS m
WHERE ioc.idMaterial = m.id
GROUP BY m.nome
ORDER BY maisVendido DESC;
-- -------------------------------------------------------------------------------------


-- CRUD(insert, select, update, delete)

-- update
UPDATE material SET nome='Prego' WHERE id=2;

-- delete
DELETE FROM item_ordem_compra WHERE idOrdemCompra=5 AND idMaterial=11;