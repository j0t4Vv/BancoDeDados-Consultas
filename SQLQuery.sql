-- DROP SCHEMA producaobd;

-- Criando o banco de dados PRODUCAOBD.
CREATE DATABASE producaobd;

use producaobd
go

-- Criando a tabela FABRICANTE.
CREATE TABLE  Fabricante (
codfabricante SMALLINT NOT NULL,
nomefabricante VARCHAR(30) NOT NULL,
PRIMARY KEY (codfabricante));

-- Criando a tabela PRODUTO.
CREATE TABLE  Produto (
codproduto INT NOT NULL,
nomeproduto VARCHAR(30) NOT NULL,
codfabricante SMALLINT NOT NULL,
PRIMARY KEY (codproduto),
CONSTRAINT fk_Produto_Fabricante
FOREIGN KEY (codfabricante)
REFERENCES Fabricante (codfabricante));

-- Criando a tabela LOTE.
CREATE TABLE Lote (
numlote INT NOT NULL,
datavalidade DATE NOT NULL,
precounitario DECIMAL(10,2),
quantidade SMALLINT NOT NULL DEFAULT 100,
valorlote DECIMAL(10,2),
codproduto INT NOT NULL,
PRIMARY KEY (numlote),
CONSTRAINT fk_Lote_Produto
FOREIGN KEY (codproduto)
REFERENCES Produto (codproduto));

-- Inserindo registros na tabela FABRICANTE.
INSERT INTO Fabricante VALUES (1, 'Clear');
INSERT INTO Fabricante VALUES (2, 'Rexona');
INSERT INTO Fabricante VALUES (3, 'Jhonson & Jhonson');
INSERT INTO Fabricante VALUES (4, 'Coleston');

-- Inserindo registros na tabela PRODUTO.
INSERT INTO Produto VALUES (10, 'Sabonete em Barra', 2);
INSERT INTO Produto VALUES (11, 'Shampoo Anticaspa', 1);
INSERT INTO Produto VALUES (12, 'Desodorante Aerosol Neutro', 2);
INSERT INTO Produto VALUES (13, 'Sabonete Liquido', 2);
INSERT INTO Produto VALUES (14, 'Protetor Solar 30', 3);
INSERT INTO Produto VALUES (15, 'Shampoo 2 em 1', 2);
INSERT INTO Produto VALUES (16, 'Desodorante Aerosol Morango', 2);
INSERT INTO Produto VALUES (17, 'Shampoo Anticaspa', 2);
INSERT INTO Produto VALUES (18, 'Protetor Solar 60', 3);
INSERT INTO Produto VALUES (19, 'Desodorante Rollon', 1);

-- Inserindo registros na tabela LOTE.

INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, codproduto) VALUES (100, '2028-08-05', 9.90, 500, 18);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, codproduto) VALUES (101, '2027-05-01', 8.47, 500, 10);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (102, '2028-06-02', 11.50, 750, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (103, '2026-02-01', 12.37, 383, DEFAULT, 18);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (104, '2027-01-01', 10.00, 400, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (105, '2026-04-07', 11.50, DEFAULT, DEFAULT, 15);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (106, '2023-06-08', 10.30, 320, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (107, '2024-10-20', 13.90, 456, DEFAULT, 12);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (108, '2026-07-20', 7.53, 750, DEFAULT, 13);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (109, '2025-05-13', 8.00, 720, DEFAULT, 11);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (110, '2027-06-05', 9.50, 860, DEFAULT, 13);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (111, '2028-03-02', 14.50, 990, DEFAULT, 14);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (112, '2028-04-05', 11.40, 430, DEFAULT, 14);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (113, '2025-06-04', 11.30, 200, DEFAULT, 12);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (114, '2027-10-06', 12.76, 380, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (115, '2028-11-06', 8.30, 420, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (116, '2027-10-20', 8.99, 361, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (117, '2024-11-15', 10.09, 713, DEFAULT, 11);

--Consultas

--Questão 1
select *
from Lote 
where year(datavalidade) = '2024'

--Questão 2
select count(*) as Quantidade_Lotes
from Lote
where year(datavalidade) = '2025'

--Questão 3
select count(*) as Lote_Por_Cada_Produto
from Lote l
join Produto p on p.codproduto = l.codproduto

--Questão 4
SELECT 
	codproduto, SUM(precounitario * quantidade) AS Valor_Total_Lotes
FROM 
	Lote
GROUP BY 
	codproduto;

--Questão 5
select *
from Lote
order by datavalidade

--Questão 6
select *
from Lote
where datavalidade between '2024/02/01' and '2026/06/30'
order by datavalidade

--Questão 7
select *
from Lote
where valorlote > (select avg(valorlote) from Lote)

--a
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES
(118, '2029-12-28', 3.78, 1223, DEFAULT, 13);

--Questão 8
update Lote
set precounitario = precounitario * 0.85
where codproduto = 13;

--Questão 9
delete from Produto
where codproduto in (select codproduto from Produto where nomeproduto = 'Shampoo Anticaspa' and codfabricante = 2);
SELECT *
FROM Produto;
--Questão 10
alter table Lote
alter column precounitario decimal(10, 2);

--Questão 11
alter table Lote
add STATUSLOTE varchar(9) default 'Analise';

--Questão 12
update Lote
set STATUSLOTE = 
case numlote
when 107 then 'Recall'
when 113 then 'Liberado'
when 117 then 'Liberado'
when 108 then 'Recall'
when 116 then 'Recall'
when 112 then 'Liberado'
when 109 then 'Liberado'
when 114 then 'Liberado'
end
where numlote IN (107, 113, 117, 108, 116, 112, 109, 114);

--Questão 13
select STATUSLOTE, count(*) as Lotes_Por_Status
from Lote
group by STATUSLOTE;

--Questão 14
select F.nomefabricante, count(P.codproduto) as Produtos_Por_Fabricante
from Fabricante F
left join Produto P on F.codfabricante = P.codfabricante
group by F.codfabricante, F.nomefabricante;