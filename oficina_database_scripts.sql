
-- -----------------------------------------------------
-- Database oficina
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  PRIMARY KEY (idCliente),
  UNIQUE INDEX cpf_UNIQUE (cpf ASC) VISIBLE)
;

-- -----------------------------------------------------
-- Table Veiculo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Veiculo (
  idVeiculo INT NOT NULL AUTO_INCREMENT,
  Cliente_idCliente INT NOT NULL,
  placa VARCHAR(45) NOT NULL,
  modelo VARCHAR(45) NOT NULL,
  marca VARCHAR(45) NOT NULL,
  ano INT NOT NULL,
  PRIMARY KEY (idVeiculo, Cliente_idCliente),
  INDEX fk_Veiculo_Cliente_idx (Cliente_idCliente ASC) VISIBLE,
  CONSTRAINT fk_Veiculo_Cliente
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente))
;

-- -----------------------------------------------------
-- Table Revisao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Revisao (
  idRevisao INT NOT NULL AUTO_INCREMENT,
  Veiculo_idVeiculo INT NOT NULL,
  descricao VARCHAR(45) NOT NULL,
  km INT NOT NULL,
  PRIMARY KEY (idRevisao, Veiculo_idVeiculo),
  INDEX fk_Revisao_Veiculo1_idx (Veiculo_idVeiculo ASC) VISIBLE,
  CONSTRAINT fk_Revisao_Veiculo1
    FOREIGN KEY (Veiculo_idVeiculo)
    REFERENCES Veiculo (idVeiculo))
;

-- -----------------------------------------------------
-- Table Equipe
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Equipe (
  idEquipe INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEquipe))
;

-- -----------------------------------------------------
-- Table Mecanico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Mecanico (
  idMecanico INT NOT NULL AUTO_INCREMENT,
  Equipe_idEquipe INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  endereço VARCHAR(45) NULL,
  PRIMARY KEY (idMecanico, Equipe_idEquipe),
  INDEX fk_Mecanico_Equipe1_idx (Equipe_idEquipe ASC) VISIBLE,
  CONSTRAINT fk_Mecanico_Equipe1
    FOREIGN KEY (Equipe_idEquipe)
    REFERENCES Equipe (idEquipe))
;

-- -----------------------------------------------------
-- Table OrdemServico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OrdemServico (
  idOrdemServico INT NOT NULL AUTO_INCREMENT,
  Revisao_idRevisao INT NOT NULL,
  Equipe_idEquipe INT NOT NULL,
  numero INT NOT NULL,
  dataEmissao DATETIME NOT NULL,
  valorTotal DECIMAL(12,2) NOT NULL DEFAULT 0,
  status VARCHAR(45) NOT NULL,
  dataConclusao DATETIME NULL,
  PRIMARY KEY (idOrdemServico, Revisao_idRevisao, Equipe_idEquipe),
  INDEX fk_OrdemServico_Revisao1_idx (Revisao_idRevisao ASC) VISIBLE,
  INDEX fk_OrdemServico_Equipe1_idx (Equipe_idEquipe ASC) VISIBLE,
  CONSTRAINT fk_OrdemServico_Revisao1
    FOREIGN KEY (Revisao_idRevisao)
    REFERENCES Revisao (idRevisao),
  CONSTRAINT fk_OrdemServico_Equipe1
    FOREIGN KEY (Equipe_idEquipe)
    REFERENCES Equipe (idEquipe))
;

-- -----------------------------------------------------
-- Table Especialidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Especialidade (
  idEspecialidade INT NOT NULL AUTO_INCREMENT,
  Mecanico_idMecanico INT NOT NULL,
  descricao VARCHAR(45) NULL,
  PRIMARY KEY (idEspecialidade, Mecanico_idMecanico),
  INDEX fk_Especialidade_Mecanico1_idx (Mecanico_idMecanico ASC) VISIBLE,
  CONSTRAINT fk_Especialidade_Mecanico1
    FOREIGN KEY (Mecanico_idMecanico)
    REFERENCES Mecanico (idMecanico))
;

-- -----------------------------------------------------
-- Table ReferenciaMaoDeObra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ReferenciaMaoDeObra (
  idReferenciaMaoDeObra INT NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(45) NOT NULL,
  valor DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (idReferenciaMaoDeObra))
;

-- -----------------------------------------------------
-- Table ItemOrdemServico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ItemOrdemServico (
  idItemOrdemServico INT NOT NULL AUTO_INCREMENT,
  OrdemServico_idOrdemServico INT NOT NULL,
  ReferenciaMaoDeObra_idReferenciaMaoDeObra INT NOT NULL,
  valorServico DECIMAL(12,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (idItemOrdemServico, OrdemServico_idOrdemServico, ReferenciaMaoDeObra_idReferenciaMaoDeObra),
  INDEX fk_ItemOrdemServico_OrdemServico1_idx (OrdemServico_idOrdemServico ASC) VISIBLE,
  INDEX fk_ItemOrdemServico_ReferenciaMaoDeObra1_idx (ReferenciaMaoDeObra_idReferenciaMaoDeObra ASC) VISIBLE,
  CONSTRAINT fk_ItemOrdemServico_OrdemServico1
    FOREIGN KEY (OrdemServico_idOrdemServico)
    REFERENCES OrdemServico (idOrdemServico),
  CONSTRAINT fk_ItemOrdemServico_ReferenciaMaoDeObra1
    FOREIGN KEY (ReferenciaMaoDeObra_idReferenciaMaoDeObra)
    REFERENCES ReferenciaMaoDeObra (idReferenciaMaoDeObra))
;

-- -----------------------------------------------------
-- Table Peca
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Peca (
  idPeca INT NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(45) NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  tamanho VARCHAR(45) NULL,
  valor VARCHAR(45) NOT NULL DEFAULT 0,
  PRIMARY KEY (idPeca))
;

-- -----------------------------------------------------
-- Table ItemPeca
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ItemPeca (
  idItemPeca INT NOT NULL AUTO_INCREMENT,
  ItemOrdemServico_idItemOrdemServico INT NOT NULL,
  Peca_idPeca INT NOT NULL,
  PRIMARY KEY (idItemPeca, ItemOrdemServico_idItemOrdemServico, Peca_idPeca),
  INDEX fk_ItemPeca_ItemOrdemServico1_idx (ItemOrdemServico_idItemOrdemServico ASC) VISIBLE,
  INDEX fk_ItemPeca_Peca1_idx (Peca_idPeca ASC) VISIBLE,
  CONSTRAINT fk_ItemPeca_ItemOrdemServico1
    FOREIGN KEY (ItemOrdemServico_idItemOrdemServico)
    REFERENCES ItemOrdemServico (idItemOrdemServico),
  CONSTRAINT fk_ItemPeca_Peca1
    FOREIGN KEY (Peca_idPeca)
    REFERENCES Peca (idPeca))
;

-- -----------------------------------------------------
-- Table OrdemServicoHistorico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OrdemServicoHistorico (
  idOrdemServicoHistorico INT NOT NULL AUTO_INCREMENT,
  OrdemServico_idOrdemServico INT NOT NULL,
  status VARCHAR(45) NOT NULL,
  dataHora DATETIME NOT NULL,
  mecanicoResponsavel VARCHAR(45) NOT NULL,
  descricao VARCHAR(45) NOT NULL,
  PRIMARY KEY (idOrdemServicoHistorico, OrdemServico_idOrdemServico),
  INDEX fk_OrdemServicoHistorico_OrdemServico1_idx (OrdemServico_idOrdemServico ASC) VISIBLE,
  CONSTRAINT fk_OrdemServicoHistorico_OrdemServico1
    FOREIGN KEY (OrdemServico_idOrdemServico)
    REFERENCES OrdemServico (idOrdemServico))
;
