USE oficina;

INSERT INTO Cliente(nome, cpf) VALUES ('JOAO SILVA', '123.456.789-10');
INSERT INTO Cliente(nome, cpf) VALUES ('MARIA PEREIRA', '987.654.321-10');
INSERT INTO Veiculo(Cliente_idCliente, placa, modelo, marca, ano) VALUES (1, 'ABC-2222', 'GOL BOLA', 'VOLKSWAGEN', 1995);
INSERT INTO Revisao(Veiculo_idVeiculo, descricao, km) VALUES (1, 'REVISAO DOS 100K', 111111);
INSERT INTO Revisao(Veiculo_idVeiculo, descricao, km) VALUES (1, 'REVISAO DOS 200K', 222222);
INSERT INTO Equipe(nome) VALUES ('MCLAREN DA DECADENCIA');
INSERT INTO Equipe(nome) VALUES ('SI FERRARI');
INSERT INTO Mecanico(Equipe_idEquipe, nome, endereço) VALUES (1, 'MECANICO 1', 'ENDERECO 1');
INSERT INTO Mecanico(Equipe_idEquipe, nome, endereço) VALUES (1, 'MECANICO 2', 'ENDERECO 2');
INSERT INTO Mecanico(Equipe_idEquipe, nome, endereço) VALUES (2, 'MECANICO 3', 'ENDERECO 3');
INSERT INTO Mecanico(Equipe_idEquipe, nome, endereço) VALUES (2, 'MECANICO 4', 'ENDERECO 4');
INSERT INTO OrdemServico(Revisao_idRevisao, Equipe_idEquipe, numero, dataEmissao, valorTotal, status, dataConclusao) VALUES (1, 1, 1234, '2005-01-25', 2325.12, 'CONCLUIDO', '2005-01-30');
INSERT INTO OrdemServico(Revisao_idRevisao, Equipe_idEquipe, numero, dataEmissao, valorTotal, status, dataConclusao) VALUES (2, 2, 4321, '2015-01-15', 4459.25, 'CONCLUIDO', '2015-01-22');
INSERT INTO Especialidade(Mecanico_idMecanico, descricao) VALUES (1, 'MOTOR');
INSERT INTO Especialidade(Mecanico_idMecanico, descricao) VALUES (2, 'CAMBIO');
INSERT INTO Especialidade(Mecanico_idMecanico, descricao) VALUES (3, 'ELETRICA');
INSERT INTO Especialidade(Mecanico_idMecanico, descricao) VALUES (4, 'INJECAO ELETRONICA');
INSERT INTO ReferenciaMaoDeObra(descricao, valor) VALUES ('REVISAO MOTOR', 300.00);
INSERT INTO ReferenciaMaoDeObra(descricao, valor) VALUES ('REVISAO CAMBIO', 300.00);
INSERT INTO ReferenciaMaoDeObra(descricao, valor) VALUES ('REVISAO SUSPENSAO', 300.00);
INSERT INTO ReferenciaMaoDeObra(descricao, valor) VALUES ('REVISAO ELETRICA', 300.00);
INSERT INTO ReferenciaMaoDeObra(descricao, valor) VALUES ('REVISAO FREIOS', 300.00);
INSERT INTO ItemOrdemServico(OrdemServico_idOrdemServico, ReferenciaMaoDeObra_idReferenciaMaoDeObra, valorServico) VALUES (1, 1, 350.00);
INSERT INTO ItemOrdemServico(OrdemServico_idOrdemServico, ReferenciaMaoDeObra_idReferenciaMaoDeObra, valorServico) VALUES (1, 3, 400.00);
INSERT INTO ItemOrdemServico(OrdemServico_idOrdemServico, ReferenciaMaoDeObra_idReferenciaMaoDeObra, valorServico) VALUES (1, 4, 450.00);
INSERT INTO ItemOrdemServico(OrdemServico_idOrdemServico, ReferenciaMaoDeObra_idReferenciaMaoDeObra, valorServico) VALUES (1, 5, 550.00);
INSERT INTO Peca(descricao, tipo, tamanho, valor) VALUES ('DESCRICAO 1', 'TIPO 1', 'TAMANHO 1', 100);
INSERT INTO Peca(descricao, tipo, tamanho, valor) VALUES ('DESCRICAO 2', 'TIPO 2', 'TAMANHO 1', 110);
INSERT INTO Peca(descricao, tipo, tamanho, valor) VALUES ('DESCRICAO 3', 'TIPO 3', 'TAMANHO 1', 120);
INSERT INTO Peca(descricao, tipo, tamanho, valor) VALUES ('DESCRICAO 4', 'TIPO 4', 'TAMANHO 1', 130);
INSERT INTO Peca(descricao, tipo, tamanho, valor) VALUES ('DESCRICAO 5', 'TIPO 5', 'TAMANHO 1', 140);
INSERT INTO ItemPeca(ItemOrdemServico_idItemOrdemServico, Peca_idPeca) VALUES (1, 4);
INSERT INTO ItemPeca(ItemOrdemServico_idItemOrdemServico, Peca_idPeca) VALUES (2, 3);
INSERT INTO ItemPeca(ItemOrdemServico_idItemOrdemServico, Peca_idPeca) VALUES (3, 2);
INSERT INTO ItemPeca(ItemOrdemServico_idItemOrdemServico, Peca_idPeca) VALUES (4, 1);
INSERT INTO OrdemServicoHistorico(OrdemServico_idOrdemServico, status, dataHora, mecanicoResponsavel, descricao) VALUES (1, 'ANALISE', '2005-01-26', 'MECANICO 1', 'ANALISE DOS INICIAL');
INSERT INTO OrdemServicoHistorico(OrdemServico_idOrdemServico, status, dataHora, mecanicoResponsavel, descricao) VALUES (1, 'EM ANDAMENTO', '2005-01-27', 'MECANICO 2', 'TROCA DE PEÇAS DESGASTADAS');
INSERT INTO OrdemServicoHistorico(OrdemServico_idOrdemServico, status, dataHora, mecanicoResponsavel, descricao) VALUES (1, 'CHECK', '2005-01-28', 'MECANICO 1', 'CONFERENCIA FINAL');
INSERT INTO OrdemServicoHistorico(OrdemServico_idOrdemServico, status, dataHora, mecanicoResponsavel, descricao) VALUES (1, 'CONCLUIDO', '2005-01-30', 'MECANICO 1', 'CONCLUIDO');

SELECT * FROM Cliente;
SELECT * FROM Veiculo;
SELECT * FROM Revisao;
SELECT * FROM Equipe;
SELECT * FROM Mecanico;
SELECT * FROM OrdemServico;
SELECT * FROM Especialidade;
SELECT * FROM ReferenciaMaoDeObra;
SELECT * FROM ItemOrdemServico;
SELECT * FROM Peca;
SELECT * FROM ItemPeca;
SELECT * FROM OrdemServicoHistorico;

SELECT c.nome
     , c.cpf
     , v.placa
     , v.modelo
     , v.marca
     , v.ano
     , r.descricao
     , r.km
     , o.numero
     , o.valortotal
     , o.status
     , o.dataconclusao
  FROM cliente c
     , veiculo v
     , revisao r
     , ordemservico o
 WHERE c.idcliente = v.Cliente_idCliente
   AND v.idveiculo = r.Veiculo_idVeiculo
   AND r.idrevisao = o.Revisao_idRevisao;
   
SELECT c.nome
     , c.cpf
     , v.placa
     , v.modelo
     , v.marca
     , v.ano
     , count(1) qtdrevisoes
  FROM cliente c
     , veiculo v
     , revisao r
 WHERE c.idcliente = v.Cliente_idCliente
   AND v.idveiculo = r.Veiculo_idVeiculo   
 GROUP BY c.nome
     , c.cpf
     , v.placa
     , v.modelo
     , v.marca
     , v.ano;