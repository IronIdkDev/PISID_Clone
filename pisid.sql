-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 16-Abr-2023 às 12:35
-- Versão do servidor: 10.4.28-MariaDB
-- versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `pisid`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Atribui_Odor` (IN `Sala` INT, IN `IDExperiencia` INT, IN `Odor` VARCHAR(5))   BEGIN

INSERT INTO odoresexperiencia ( Sala, IdExperiencia, CodigoOdor)
VALUES (Sala, IDExperiencia, Odor);


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Atribui_Sub` (IN `NumeroRatos` INT, IN `CodigoSubstancia` VARCHAR(5), IN `IDExperiencia` INT)   BEGIN

INSERT INTO substanciaexperiencia ( NumeroRatos, CodigoSubstancia, IDexperiencia)
VALUES (NumeroRatos, CodigoSubstancia, IDExperiencia);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Criar_Experiencia` (IN `descricao` TEXT, IN `investigador` VARCHAR(50), IN `nratos` INT(11), IN `limitesRatos` INT(11), IN `segSemMovi` INT(11), IN `tempIdeal` DECIMAL(4,2), IN `variacaoMax` DECIMAL(4,2))   BEGIN

DECLARE count INT;

SELECT COUNT(*) INTO count FROM experiencia;

INSERT INTO experiencia (IDexperiência, Descricao, Investigador, DataHora, NumeroRatos,LimiteRatosSala, SegundosSemMovimento, TemperaturaIdeal, VariacaoTemperaturaMaxima, Ativa)
VALUES (count+1, descricao, investigador, current_timestamp() , nratos, limitesRatos,  segSemMovi, tempIdeal, variacaoMax, 1);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Criar_Utilizador` (IN `Nome` VARCHAR(100), IN `Telefone` VARCHAR(12), IN `TipoUtilizador` VARCHAR(3), IN `Email` VARCHAR(100))   BEGIN

INSERT INTO experiencia (NomeUtilizador, TelefoneUtilizador, TipoUtilizador, EmailUtilizador, Ativo,NumeroExperiências)
VALUES (Nome,Telefone,TipoUtilizador,Email,true,0);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Cria_Movimentacao` (IN `SalaEntrada` INT, IN `SalaSaida` INT, IN `IDExperiencia` INT)   BEGIN

DECLARE count INT;
SELECT COUNT(*) INTO count FROM experiencia;


INSERT INTO medicoespassagens (IdMedicao, Hora, SalaEntrada, SalaSaida, IDExperiencia)
    VALUES (count +1,current_timestamp(), SalaEntrada,SalaSaida,IDExperiencia); 

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Cria_Odor` (IN `sala` INT, IN `idexperiencia` INT, IN `codigoOdor` VARCHAR(10))   BEGIN

INSERT INTO odoresexperiencia ( Sala, IdExperiencia, CodigoOdor)
VALUES ( sala, idexperiencia, codigoOdor);



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Cria_Subs` (IN `nRatos` INT, IN `codigoSubs` VARCHAR(5), IN `idExperiencia` INT)   BEGIN

INSERT INTO substanciaexperiencia ( NumeroRatos, CodigoSubstancia, IDexperiencia)
VALUES (nRatos, codigoSubs, idExperiencia);



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EditarDescricaoExperiencia` (IN `IDExperiencia` INT, IN `Descricao` TEXT)   BEGIN

UPDATE experiencia SET Descricao = Descricao WHERE experiencia.IDexperiência = IDExperiencia;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Mostrar_User` (IN `userID` VARCHAR(50))   BEGIN

	SELECT utilizador.NomeUtilizador, utilizador.TelefoneUtilizador, utilizador.TipoUtilizador
	FROM utilizador
	WHERE utilizador.NomeUtilizador = userID or utilizador.TelefoneUtilizador = userID
	or utilizador.TipoUtilizador = userID or utilizador.EmailUtilizador = userID;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Mostra_Alertas` (IN `IDExperiencia` INT)   BEGIN

SELECT alerta.IDExperiência
FROM alerta
WHERE alerta.IDExperiência = IDExperiencia;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Mostra_Experiencia` (IN `userMail` VARCHAR(50))   BEGIN
SELECT experiencia.IDexperiência, experiencia.Descricao, experiencia.DataHora, experiencia.NumeroRatos, experiencia.TemperaturaIdeal
FROM experiencia
WHERE experiencia.Investigador = userMail;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Mostra_Investigadores` (IN `aux` VARCHAR(3))   BEGIN

SELECT NomeUtilizador, TelefoneUtilizador, EmailUtilizador
FROM utilizador
WHERE TipoUtilizador = aux;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Mostra_Medicoes_Temperatura` (IN `IDExperiencia` INT)   BEGIN

SELECT medicoestemperatura.IDExperiência
FROM medicoestemperatura
WHERE medicoestemperatura.IDExperiência = IDExperiencia;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Mostra_Odores` (IN `experienciaID` INT)   BEGIN
SELECT odoresexperiencia.Sala, odoresexperiencia.CodigoOdor
FROM odoresexperiencia
WHERE odoresexperiencia.IdExperiencia = experienciaID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Mostra_Passagem` (IN `IDExperiencia` INT)   BEGIN

SELECT medicoespassagens.IDExperiência
FROM medicoespassagens
WHERE medicoespassagens.IDExperiência = IDExperiencia;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Mostra_Substancias` (IN `experienciaID` INT)   BEGIN
SELECT substanciaexperiencia.CodigoSubstancia, substanciaexperiencia.NumeroRatos
FROM substanciaexperiencia
WHERE substanciaexperiencia.IDexperiência = experienciaID;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Obter_Ultima_Medicao_Movimento` (IN `IDExperiencia` INT)   BEGIN

select *
from medicoespassagens
Where medicoespassagens.IDExperiência = IDExperiencia
ORDER BY id DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Obter_Ultima_Medicao_Temperatura` (IN `IDExperiencia` INT)   select *
from medicoestemperatura 
WHERE medicoestemperatura.IDExperiência = IDExperiencia
ORDER BY medicoestemperatura.IDMedicao 
DESC LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Suspend_User` (IN `userMail` VARCHAR(50))   BEGIN
IF EXISTS (SELECT EmailUtilizador FROM utilizador WHERE Emailutilizador = userMail) THEN
UPDATE utilizador SET Ativo = CASE WHEN Ativo = False THEN True ELSE False END WHERE Emailutilizador = userMail;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Termina_Experiencia` (IN `IDExperiencia` INT)   BEGIN
UPDATE experiencia SET Ativo = False 
WHERE experiencia.IDexperiência = IDExperiencia;


END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `alerta`
--

CREATE TABLE `alerta` (
  `IDAlerta` int(11) NOT NULL,
  `Hora` timestamp NOT NULL DEFAULT current_timestamp(),
  `Sala` int(11) NOT NULL,
  `Sensor` int(11) NOT NULL,
  `Leitura` decimal(4,2) NOT NULL,
  `TipoAlerta` varchar(20) NOT NULL,
  `Mensagem` varchar(100) NOT NULL,
  `horaescrita` timestamp NOT NULL DEFAULT current_timestamp(),
  `IDExperiência` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `alerta`
--

INSERT INTO `alerta` (`IDAlerta`, `Hora`, `Sala`, `Sensor`, `Leitura`, `TipoAlerta`, `Mensagem`, `horaescrita`, `IDExperiência`) VALUES
(1, '2023-03-17 11:50:56', 3, 23, 9.00, 'temp alta', 'tas lixado', '2023-03-17 11:50:56', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `experiencia`
--

CREATE TABLE `experiencia` (
  `IDexperiência` int(11) NOT NULL,
  `Descricao` text DEFAULT NULL,
  `Investigador` varchar(50) NOT NULL,
  `DataHora` timestamp NOT NULL DEFAULT current_timestamp(),
  `NumeroRatos` int(11) NOT NULL,
  `LimiteRatosSala` int(11) NOT NULL,
  `SegundosSemMovimento` int(11) NOT NULL,
  `TemperaturaIdeal` decimal(4,2) NOT NULL,
  `VariacaoTemperaturaMaxima` decimal(4,2) NOT NULL,
  `Ativa` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `experiencia`
--

INSERT INTO `experiencia` (`IDexperiência`, `Descricao`, `Investigador`, `DataHora`, `NumeroRatos`, `LimiteRatosSala`, `SegundosSemMovimento`, `TemperaturaIdeal`, `VariacaoTemperaturaMaxima`, `Ativa`) VALUES
(1, 'gg', 'mmonteiro036@gmail.com', '2023-03-15 14:11:36', 34, 4, 5, 4.00, 4.00, 0),
(2, 'rr', 'mmm@gmail.com', '2023-03-15 18:46:37', 89, 67, 3, 99.00, 2.00, 0),
(3, 'Experiencia teste', 'mmm@gmail.com', '2023-03-17 11:59:28', 34, 0, 67, 23.00, 30.00, 1),
(4, 'Experiencia teste', 'mmm@gmail.com', '2023-03-17 12:07:22', 34, 3, 67, 23.00, 30.00, 1),
(5, 'Experiencia CDSI3.0', 'mmm@gmail.com', '2023-03-17 19:06:53', 78, 8, 45, 89.00, 12.00, 1);

--
-- Acionadores `experiencia`
--
DELIMITER $$
CREATE TRIGGER `contaExperiencia` AFTER INSERT ON `experiencia` FOR EACH ROW BEGIN
  DECLARE experiencias INT;

  SELECT NúmeroExperiências INTO experiencias 
  FROM utilizador
  WHERE EmailUtilizador = NEW.Investigador;

  UPDATE utilizador
  SET NúmeroExperiências = experiencias + 1
  WHERE EmailUtilizador = NEW.Investigador;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `elimina_IDexperiencia` BEFORE DELETE ON `experiencia` FOR EACH ROW BEGIN
  DELETE FROM odoresexperiencia
  WHERE IdExperiencia = OLD.IDexperiência; 
  DELETE FROM substanciaexperiencia
  WHERE IDexperiencia = OLD.IDexperiência;
  DELETE FROM medicoessalas
  WHERE IDExperiencia = OLD.IDExperiência;
  DELETE FROM medicoessalas
  WHERE IDExperiência = Old.IDExperiência;
  DELETE FROM medicoestemperatura
  WHERE IDExperiência = OLD.IDExperiência;
   DELETE FROM alerta
  WHERE IDExperiência = OLD.IDExperiência;
  
  
 
  
  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `verificaUser` BEFORE INSERT ON `experiencia` FOR EACH ROW BEGIN
  DECLARE count INT;
  
  IF NOT EXISTS(SELECT 1 FROM utilizador WHERE utilizador.EmailUtilizador = NEW.Investigador AND utilizador.TipoUtilizador = 'INV' AND utilizador.Ativo = 1 ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O User não pode criar experiências';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicoespassagens`
--

CREATE TABLE `medicoespassagens` (
  `IdMedicao` int(11) NOT NULL,
  `Hora` timestamp NOT NULL DEFAULT current_timestamp(),
  `SalaEntrada` int(11) NOT NULL,
  `SalaSaida` int(11) NOT NULL,
  `IDExperiência` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `medicoespassagens`
--

INSERT INTO `medicoespassagens` (`IdMedicao`, `Hora`, `SalaEntrada`, `SalaSaida`, `IDExperiência`) VALUES
(1, '2023-03-17 20:12:00', 3, 4, 5);

--
-- Acionadores `medicoespassagens`
--
DELIMITER $$
CREATE TRIGGER `passagemRatos` AFTER INSERT ON `medicoespassagens` FOR EACH ROW BEGIN
DECLARE count INT;
DECLARE counter INT;

SET count = (SELECT NumeroRatosFinal FROM medicoessalas WHERE Sala = new.SalaEntrada);
SET counter = (SELECT NumeroRatosFinal FROM medicoessalas WHERE Sala = new.SalaSaida);

UPDATE medicoessalas SET NumeroRatosFinal = count + 1 WHERE Sala = new.SalaEntrada AND IDExperiência = new.IDExperiência;
UPDATE medicoessalas SET NumeroRatosFinal = counter - 1 WHERE Sala = new.SalaSaida AND IDExperiência = new.IDExperiência;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicoessalas`
--

CREATE TABLE `medicoessalas` (
  `IDExperiencia` int(11) NOT NULL,
  `NumeroRatosFinal` int(11) NOT NULL,
  `Sala` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `medicoessalas`
--

INSERT INTO `medicoessalas` (`IDExperiencia`, `NumeroRatosFinal`, `Sala`) VALUES
(3, 33, 1),
(3, 2, 2),
(3, 34, 9),
(5, 1, 3),
(5, 1, 4);

--
-- Acionadores `medicoessalas`
--
DELIMITER $$
CREATE TRIGGER `verificaUpdateRatos` BEFORE UPDATE ON `medicoessalas` FOR EACH ROW BEGIN

DECLARE count INT;
DECLARE id INT;
DECLARE sala int;

SELECT COUNT(*) INTO count FROM alerta;

SET id = new.IDExperiencia;

SET sala = new.Sala;


INSERT INTO alerta (IDAlerta, Hora, Sala, IDExperiência)
VALUES (count +1, current_timestamp(),  sala  ,   id  );  


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicoestemperatura`
--

CREATE TABLE `medicoestemperatura` (
  `IDMedicao` int(11) NOT NULL,
  `Hora` timestamp NULL DEFAULT current_timestamp(),
  `Leitura` decimal(4,2) NOT NULL,
  `Sensor` int(11) NOT NULL,
  `IDExperiência` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `odoresexperiencia`
--

CREATE TABLE `odoresexperiencia` (
  `Sala` int(11) NOT NULL,
  `IdExperiencia` int(11) NOT NULL,
  `CodigoOdor` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `odoresexperiencia`
--

INSERT INTO `odoresexperiencia` (`Sala`, `IdExperiencia`, `CodigoOdor`) VALUES
(3, 1, '67ff'),
(4, 1, '67ff'),
(7, 1, 'rte'),
(9, 1, 'ght');

--
-- Acionadores `odoresexperiencia`
--
DELIMITER $$
CREATE TRIGGER `verificaSalaExperiencia` BEFORE INSERT ON `odoresexperiencia` FOR EACH ROW BEGIN
  IF EXISTS(SELECT 1 FROM odoresexperiencia WHERE odoresexperiencia.Sala = NEW.Sala AND odoresexperiencia.IdExperiencia = NEW.IDExperiencia) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Os valores já existem na tabela';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `substanciaexperiencia`
--

CREATE TABLE `substanciaexperiencia` (
  `NumeroRatos` int(11) NOT NULL,
  `CodigoSubstancia` varchar(5) NOT NULL,
  `IDexperiencia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizador`
--

CREATE TABLE `utilizador` (
  `NomeUtilizador` varchar(100) NOT NULL,
  `TelefoneUtilizador` varchar(12) NOT NULL,
  `TipoUtilizador` varchar(3) NOT NULL,
  `EmailUtilizador` varchar(50) NOT NULL,
  `Ativo` tinyint(1) NOT NULL,
  `NúmeroExperiências` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `utilizador`
--

INSERT INTO `utilizador` (`NomeUtilizador`, `TelefoneUtilizador`, `TipoUtilizador`, `EmailUtilizador`, `Ativo`, `NúmeroExperiências`) VALUES
('Malaquias Lobo', '678342109', 'TEC', 'malaquias@outlook.com', 0, 0),
('Miguelito', '567432111', 'INV', 'mmm@gmail.com', 1, 2),
('MIGUEL', '910349080', 'INV', 'mmonteiro036@gmail.com', 0, 0),
('Paulo', '548999999', 'INV', 'pedroloule@hotmail.com', 1, 0),
('Pedro', '567346111', 'ADM', 'pedrolouro@hotmail.com', 0, 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `alerta`
--
ALTER TABLE `alerta`
  ADD PRIMARY KEY (`IDAlerta`),
  ADD KEY `IDExperiência` (`IDExperiência`);

--
-- Índices para tabela `experiencia`
--
ALTER TABLE `experiencia`
  ADD PRIMARY KEY (`IDexperiência`),
  ADD KEY `Investigador` (`Investigador`);

--
-- Índices para tabela `medicoespassagens`
--
ALTER TABLE `medicoespassagens`
  ADD PRIMARY KEY (`IdMedicao`),
  ADD KEY `IDExperiência` (`IDExperiência`);

--
-- Índices para tabela `medicoessalas`
--
ALTER TABLE `medicoessalas`
  ADD PRIMARY KEY (`IDExperiencia`,`Sala`),
  ADD KEY `Sala` (`Sala`);

--
-- Índices para tabela `medicoestemperatura`
--
ALTER TABLE `medicoestemperatura`
  ADD PRIMARY KEY (`IDMedicao`),
  ADD KEY `IDExperiência` (`IDExperiência`);

--
-- Índices para tabela `odoresexperiencia`
--
ALTER TABLE `odoresexperiencia`
  ADD PRIMARY KEY (`Sala`,`IdExperiencia`),
  ADD KEY `IdExperiencia` (`IdExperiencia`);

--
-- Índices para tabela `substanciaexperiencia`
--
ALTER TABLE `substanciaexperiencia`
  ADD PRIMARY KEY (`CodigoSubstancia`,`IDexperiencia`),
  ADD KEY `IDexperiencia` (`IDexperiencia`);

--
-- Índices para tabela `utilizador`
--
ALTER TABLE `utilizador`
  ADD PRIMARY KEY (`EmailUtilizador`),
  ADD UNIQUE KEY `TelefoneUtilizador` (`TelefoneUtilizador`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alerta`
--
ALTER TABLE `alerta`
  MODIFY `IDAlerta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `experiencia`
--
ALTER TABLE `experiencia`
  MODIFY `IDexperiência` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `medicoespassagens`
--
ALTER TABLE `medicoespassagens`
  MODIFY `IdMedicao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `medicoestemperatura`
--
ALTER TABLE `medicoestemperatura`
  MODIFY `IDMedicao` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `alerta`
--
ALTER TABLE `alerta`
  ADD CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`IDExperiência`) REFERENCES `experiencia` (`IDexperiência`);

--
-- Limitadores para a tabela `experiencia`
--
ALTER TABLE `experiencia`
  ADD CONSTRAINT `experiencia_ibfk_1` FOREIGN KEY (`Investigador`) REFERENCES `utilizador` (`EmailUtilizador`);

--
-- Limitadores para a tabela `medicoespassagens`
--
ALTER TABLE `medicoespassagens`
  ADD CONSTRAINT `medicoespassagens_ibfk_1` FOREIGN KEY (`IDExperiência`) REFERENCES `experiencia` (`IDexperiência`);

--
-- Limitadores para a tabela `medicoessalas`
--
ALTER TABLE `medicoessalas`
  ADD CONSTRAINT `medicoessalas_ibfk_1` FOREIGN KEY (`IDExperiencia`) REFERENCES `experiencia` (`IDexperiência`);

--
-- Limitadores para a tabela `medicoestemperatura`
--
ALTER TABLE `medicoestemperatura`
  ADD CONSTRAINT `medicoestemperatura_ibfk_1` FOREIGN KEY (`IDExperiência`) REFERENCES `experiencia` (`IDexperiência`);

--
-- Limitadores para a tabela `odoresexperiencia`
--
ALTER TABLE `odoresexperiencia`
  ADD CONSTRAINT `odoresexperiencia_ibfk_1` FOREIGN KEY (`IdExperiencia`) REFERENCES `experiencia` (`IDexperiência`);

--
-- Limitadores para a tabela `substanciaexperiencia`
--
ALTER TABLE `substanciaexperiencia`
  ADD CONSTRAINT `substanciaexperiencia_ibfk_1` FOREIGN KEY (`IDexperiencia`) REFERENCES `experiencia` (`IDexperiência`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
