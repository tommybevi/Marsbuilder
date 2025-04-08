-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mar 09, 2025 alle 16:03
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `citybuilder`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `citta`
--

CREATE TABLE `citta` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `propietario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `citta`
--

INSERT INTO `citta` (`id`, `nome`, `propietario`) VALUES
(39, 'Base Marziana', 48),
(40, 'Base Marziana', 49);

-- --------------------------------------------------------

--
-- Struttura della tabella `edifici`
--

CREATE TABLE `edifici` (
  `id` int(11) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `modello3d` varchar(255) DEFAULT NULL,
  `capacita` int(11) DEFAULT NULL,
  `tempocostruzione` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `edifici`
--

INSERT INTO `edifici` (`id`, `tipo`, `modello3d`, `capacita`, `tempocostruzione`) VALUES
(1, 'Rocks', 'assets/space_bits/gltf/rocks_A.gltf', 0, 0),
(2, 'Rocks', 'assets/space_bits/gltf/rocks_B.gltf', 0, 0),
(3, 'Drill', 'assets/space_bits/gltf/drill_structure.gltf\n', 5, 0),
(4, 'WindTurbine', 'assets/space_bits/gltf/windturbine_tall.gltf\n', 5, 0),
(5, 'Cargo', 'assets/space_bits/gltf/cargo_A_stacked.gltf', 0, 0),
(6, 'Basemodule', 'assets/space_bits/gltf/basemodule_A.gltf', 0, 0),
(9, 'Spacetruk', 'assets/space_bits/gltf/spacetruck.gltf', 0, 0),
(10, 'Solarpanel', 'assets/space_bits/gltf/solarpanel.gltf', 0, 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `edificicitta`
--

CREATE TABLE `edificicitta` (
  `id` int(11) NOT NULL,
  `citta` int(11) DEFAULT NULL,
  `edificio` int(11) DEFAULT NULL,
  `livello` int(11) DEFAULT NULL,
  `posizione` int(11) DEFAULT NULL,
  `qta_prodotta` int(11) DEFAULT NULL,
  `costruzione` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `edificicitta`
--

INSERT INTO `edificicitta` (`id`, `citta`, `edificio`, `livello`, `posizione`, `qta_prodotta`, `costruzione`) VALUES
(1, 39, 3, 1, 11, 0, '2025-02-28 21:00:21'),
(2, 39, 3, 1, 21, 0, '2025-02-28 21:00:57'),
(3, 39, 3, 1, 12, 0, '2025-02-28 21:01:47'),
(4, 39, 3, 1, 22, 0, '2025-02-28 21:03:25'),
(5, 39, 10, 1, 19, 0, '2025-02-28 21:13:51'),
(6, 39, 10, 1, 29, 0, '2025-02-28 21:13:55'),
(7, 39, 3, 1, 31, 0, '2025-02-28 21:15:42'),
(8, 39, 3, 1, 32, 0, '2025-02-28 21:16:39'),
(9, 39, 9, 1, 34, 0, '2025-02-28 21:16:44'),
(10, 39, 5, 1, 71, 0, '2025-02-28 21:16:49'),
(11, 39, 5, 1, 81, 0, '2025-02-28 21:16:52'),
(12, 39, 5, 1, 91, 0, '2025-02-28 21:16:56'),
(13, 39, 5, 1, 41, 0, '2025-02-28 21:17:02'),
(14, 39, 5, 1, 51, 0, '2025-02-28 21:17:06'),
(15, 39, 5, 1, 61, 0, '2025-02-28 21:17:10'),
(16, 39, 4, 1, 18, 0, '2025-02-28 21:17:17'),
(17, 39, 4, 1, 28, 0, '2025-02-28 21:17:22'),
(18, 39, 4, 1, 38, 0, '2025-02-28 21:17:26'),
(19, 39, 4, 1, 48, 0, '2025-02-28 21:17:30'),
(20, 39, 10, 1, 39, 0, '2025-02-28 21:17:32'),
(21, 39, 10, 1, 49, 0, '2025-02-28 21:17:34'),
(22, 39, 2, 1, 54, 0, '2025-02-28 21:17:46'),
(23, 39, 2, 1, 14, 0, '2025-02-28 21:17:50'),
(24, 39, 1, 1, 15, 0, '2025-02-28 21:17:55'),
(25, 39, 1, 1, 16, 0, '2025-02-28 21:17:59'),
(26, 39, 1, 1, 25, 0, '2025-02-28 21:18:08'),
(27, 39, 2, 1, 26, 0, '2025-02-28 21:18:11'),
(28, 39, 2, 1, 76, 0, '2025-02-28 21:18:17'),
(29, 39, 1, 1, 65, 0, '2025-02-28 21:18:22'),
(30, 39, 1, 1, 64, 0, '2025-02-28 21:18:26'),
(31, 39, 2, 1, 79, 0, '2025-02-28 21:18:30'),
(32, 39, 1, 1, 88, 0, '2025-02-28 21:18:35'),
(33, 39, 1, 1, 95, 0, '2025-02-28 21:18:38'),
(34, 39, 1, 1, 83, 0, '2025-02-28 21:18:42'),
(35, 39, 1, 1, 47, 0, '2025-02-28 21:18:46'),
(36, 39, 6, 1, 42, 0, '2025-02-28 21:18:55'),
(37, 39, 10, 1, 59, 0, '2025-02-28 21:21:18'),
(38, 39, 4, 1, 58, 0, '2025-02-28 21:21:27'),
(39, 39, 3, 1, 13, 0, '2025-02-28 21:21:32'),
(40, 39, 3, 1, 23, 0, '2025-03-09 14:18:17'),
(41, 39, 6, 1, 43, 0, '2025-03-09 14:18:22'),
(42, 39, 6, 1, 142, 0, '2025-03-09 14:18:27'),
(43, 39, 6, 1, 242, 0, '2025-03-09 14:18:31'),
(44, 39, 3, 1, 33, 0, '2025-03-09 14:35:20'),
(45, 39, 6, 1, 143, 0, '2025-03-09 14:35:33');

-- --------------------------------------------------------

--
-- Struttura della tabella `edificicostruzione`
--

CREATE TABLE `edificicostruzione` (
  `edificio` int(11) NOT NULL,
  `risorsa` int(11) NOT NULL,
  `qta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `edificicostruzione`
--

INSERT INTO `edificicostruzione` (`edificio`, `risorsa`, `qta`) VALUES
(3, 1, 5),
(3, 3, 10);

-- --------------------------------------------------------

--
-- Struttura della tabella `edificiproduzione`
--

CREATE TABLE `edificiproduzione` (
  `edificio` int(11) NOT NULL,
  `risorsa` int(11) NOT NULL,
  `qta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `edificiproduzione`
--

INSERT INTO `edificiproduzione` (`edificio`, `risorsa`, `qta`) VALUES
(3, 1, 5),
(4, 3, 2),
(10, 3, 5);

-- --------------------------------------------------------

--
-- Struttura della tabella `giocatori`
--

CREATE TABLE `giocatori` (
  `id` int(11) NOT NULL,
  `nickname` varchar(30) DEFAULT NULL,
  `email` varbinary(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `password` varbinary(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `giocatori`
--

INSERT INTO `giocatori` (`id`, `nickname`, `email`, `avatar`, `password`) VALUES
(48, 'Bevi', 0x521688d84d68436f2cd70e718b106789f7d6c6af738077d47a81d05af149b837, '', 0xe8b6891e2fd4361ccd72c2e1a08fe944),
(49, 'tommaso', 0x8a75a46b5e9216c6fe2de5274140ae00, '', 0xe8b6891e2fd4361ccd72c2e1a08fe944);

-- --------------------------------------------------------

--
-- Struttura della tabella `pacchetti`
--

CREATE TABLE `pacchetti` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `prezzo` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `pacchettiacquistati`
--

CREATE TABLE `pacchettiacquistati` (
  `pacchetto` int(11) NOT NULL,
  `giocatore` int(11) NOT NULL,
  `dataAcquisto` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `prezzo` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `risorse`
--

CREATE TABLE `risorse` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) DEFAULT NULL,
  `icona` varchar(255) DEFAULT NULL,
  `rarita` int(11) DEFAULT NULL,
  `descrizione` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `risorse`
--

INSERT INTO `risorse` (`id`, `nome`, `icona`, `rarita`, `descrizione`) VALUES
(1, 'Alluminio', NULL, 1, '...'),
(2, 'Cibo', NULL, 1, '...'),
(3, 'Energia', NULL, 1, '...');

-- --------------------------------------------------------

--
-- Struttura della tabella `risorsecitta`
--

CREATE TABLE `risorsecitta` (
  `citta` int(11) NOT NULL,
  `risorsa` int(11) NOT NULL,
  `qta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `risorsecitta`
--

INSERT INTO `risorsecitta` (`citta`, `risorsa`, `qta`) VALUES
(39, 1, 1405),
(39, 2, 120),
(39, 3, 500),
(40, 1, 100),
(40, 2, 100),
(40, 3, 100);

-- --------------------------------------------------------

--
-- Struttura della tabella `risorsepacchetto`
--

CREATE TABLE `risorsepacchetto` (
  `pacchetto` int(11) NOT NULL,
  `risorsa` int(11) NOT NULL,
  `qta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `citta`
--
ALTER TABLE `citta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `propietario` (`propietario`);

--
-- Indici per le tabelle `edifici`
--
ALTER TABLE `edifici`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `edificicitta`
--
ALTER TABLE `edificicitta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citta` (`citta`),
  ADD KEY `edificio` (`edificio`);

--
-- Indici per le tabelle `edificicostruzione`
--
ALTER TABLE `edificicostruzione`
  ADD PRIMARY KEY (`edificio`,`risorsa`),
  ADD KEY `risorsa` (`risorsa`);

--
-- Indici per le tabelle `edificiproduzione`
--
ALTER TABLE `edificiproduzione`
  ADD PRIMARY KEY (`edificio`,`risorsa`),
  ADD KEY `risorsa` (`risorsa`);

--
-- Indici per le tabelle `giocatori`
--
ALTER TABLE `giocatori`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `pacchetti`
--
ALTER TABLE `pacchetti`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `pacchettiacquistati`
--
ALTER TABLE `pacchettiacquistati`
  ADD PRIMARY KEY (`pacchetto`,`giocatore`),
  ADD KEY `giocatore` (`giocatore`);

--
-- Indici per le tabelle `risorse`
--
ALTER TABLE `risorse`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `risorsecitta`
--
ALTER TABLE `risorsecitta`
  ADD PRIMARY KEY (`citta`,`risorsa`),
  ADD KEY `risorsa` (`risorsa`);

--
-- Indici per le tabelle `risorsepacchetto`
--
ALTER TABLE `risorsepacchetto`
  ADD PRIMARY KEY (`pacchetto`,`risorsa`),
  ADD KEY `risorsa` (`risorsa`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `citta`
--
ALTER TABLE `citta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT per la tabella `edifici`
--
ALTER TABLE `edifici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT per la tabella `edificicitta`
--
ALTER TABLE `edificicitta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT per la tabella `giocatori`
--
ALTER TABLE `giocatori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT per la tabella `pacchetti`
--
ALTER TABLE `pacchetti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `risorse`
--
ALTER TABLE `risorse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `citta`
--
ALTER TABLE `citta`
  ADD CONSTRAINT `citta_ibfk_1` FOREIGN KEY (`propietario`) REFERENCES `giocatori` (`id`);

--
-- Limiti per la tabella `edificicitta`
--
ALTER TABLE `edificicitta`
  ADD CONSTRAINT `edificicitta_ibfk_1` FOREIGN KEY (`citta`) REFERENCES `citta` (`id`),
  ADD CONSTRAINT `edificicitta_ibfk_2` FOREIGN KEY (`edificio`) REFERENCES `edifici` (`id`);

--
-- Limiti per la tabella `edificicostruzione`
--
ALTER TABLE `edificicostruzione`
  ADD CONSTRAINT `edificicostruzione_ibfk_1` FOREIGN KEY (`edificio`) REFERENCES `edifici` (`id`),
  ADD CONSTRAINT `edificicostruzione_ibfk_2` FOREIGN KEY (`risorsa`) REFERENCES `risorse` (`id`);

--
-- Limiti per la tabella `edificiproduzione`
--
ALTER TABLE `edificiproduzione`
  ADD CONSTRAINT `edificiproduzione_ibfk_1` FOREIGN KEY (`edificio`) REFERENCES `edifici` (`id`),
  ADD CONSTRAINT `edificiproduzione_ibfk_2` FOREIGN KEY (`risorsa`) REFERENCES `risorse` (`id`);

--
-- Limiti per la tabella `pacchettiacquistati`
--
ALTER TABLE `pacchettiacquistati`
  ADD CONSTRAINT `pacchettiacquistati_ibfk_1` FOREIGN KEY (`pacchetto`) REFERENCES `pacchetti` (`id`),
  ADD CONSTRAINT `pacchettiacquistati_ibfk_2` FOREIGN KEY (`giocatore`) REFERENCES `giocatori` (`id`);

--
-- Limiti per la tabella `risorsecitta`
--
ALTER TABLE `risorsecitta`
  ADD CONSTRAINT `risorsecitta_ibfk_1` FOREIGN KEY (`citta`) REFERENCES `citta` (`id`),
  ADD CONSTRAINT `risorsecitta_ibfk_2` FOREIGN KEY (`risorsa`) REFERENCES `risorse` (`id`);

--
-- Limiti per la tabella `risorsepacchetto`
--
ALTER TABLE `risorsepacchetto`
  ADD CONSTRAINT `risorsepacchetto_ibfk_1` FOREIGN KEY (`pacchetto`) REFERENCES `pacchetti` (`id`),
  ADD CONSTRAINT `risorsepacchetto_ibfk_2` FOREIGN KEY (`risorsa`) REFERENCES `risorse` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
