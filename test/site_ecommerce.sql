-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  lun. 11 mai 2020 à 21:47
-- Version du serveur :  10.4.10-MariaDB
-- Version de PHP :  7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `site_ecommerce`
--

-- --------------------------------------------------------
CREATE DATABASE IF NOT EXISTS site_ecommerce;

USE site_ecommerce;
--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `name`, `slug`) VALUES
(5, 'Ordinateurs', 'ordinateurs'),
(6, 'Cartes graphique', 'cartes-graphique'),
(7, 'Processeurs', 'processeurs'),
(8, 'Souris', 'souris'),
(9, 'Claviers', 'claviers');

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` varchar(900) NOT NULL,
  `price` text NOT NULL,
  `category` varchar(255) NOT NULL,
  `weight` varchar(255) NOT NULL,
  `shipping` varchar(255) NOT NULL,
  `final_price` varchar(255) NOT NULL,
  `stock` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`ID`, `title`, `slug`, `description`, `price`, `category`, `weight`, `shipping`, `final_price`, `stock`) VALUES
(47, 'MSI GeForce RTX 2080 SUPER GAMING X TRIO', 'msi-geforce-rtx-2080-super-gaming-x-trio', '-Mémoire : 8 Go.\r\n-Type de mémoire de l\'adaptateur graphique: GDDR6.\r\n-Mémoire Bus: 256 bit. \r\n-Résolution maximale: 7680 x 4320 pixels.\r\n-Version DirectX: 12.0.\r\n-Version OpenGL: 4.5. \r\n-Type d\'interface: PCI Express x16 3.0. \r\n-Type de refroidissement: Actif.', '935', 'Cartes graphique', '0', '0', '1122', '60'),
(48, 'Zotac gaming GeForce RTX 2080 TI', 'zotac-gaming-geforce-rtx-2080-ti', '-11264 MB mémoire.\r\n-GDDR6', '1800', 'Cartes graphique', '0', '0', '2160', '40'),
(49, 'Processeur Intel Core i7 9700K', 'processeur-intel-core-i7-9700k', 'Processeur Intel Core i7 9700K (BX80684I79700K) - Socket 1151 - 8 coeurs, 8 threads - Frequence de base 3,60 GHz (Turbo 4,90 GHz) - TDP 95W', '650', 'Processeurs', '0', '0', '780', '150'),
(50, 'Souris gaming Logitech G Pro Wireless', 'souris-gaming-logitech-g-pro-wireless', 'Souris logitech gaming sans fil.', '110', 'Souris', '0', '0', '132', '450'),
(51, 'Clavier Gaming Razer Ornata Chroma Noir', 'clavier-gaming-razer-ornata-chroma-noir', 'Type : Azerty, Technologie de méca-membrane Razer, Touches à mi-hauteur, Rétroéclairage Razer Chroma, Repose-poignet ergonomique, Touches entièrement programmables, Activation simultanée de 10 touches,', '130', 'Claviers', '0', '0', '156', '800'),
(52, 'PC Asus ROG Strix GL10CS-FR322T', 'pc-asus-rog-strix-gl10cs-fr322t', 'Intel Core i5 8 Go RAM 512 Go SSD\r\nCarte graphique\r\nnVidia GeForce GTX 1660', '899', 'Ordinateurs', '0', '0', '1078.8', '15');

-- --------------------------------------------------------

--
-- Structure de la table `products_transactions`
--

DROP TABLE IF EXISTS `products_transactions`;
CREATE TABLE IF NOT EXISTS `products_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country` varchar(25) NOT NULL,
  `date` varchar(255) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `currency_code` varchar(5) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(2, 'LearnPHPaz', 'learnphpaz@gmail.com', '1212'),
(5, 'TITIFDP', 'encule@Styven.com', 'Lucastropbg'),
(6, 'Xubeo', 'lucastourneaux26@gmail.com', 'Motdepasse');

-- --------------------------------------------------------

--
-- Structure de la table `weights`
--

DROP TABLE IF EXISTS `weights`;
CREATE TABLE IF NOT EXISTS `weights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `weights`
--

INSERT INTO `weights` (`id`, `name`, `price`) VALUES
(1, 0, 0),
(2, 100, 100),
(3, 200, 200),
(4, 300, 300),
(5, 400, 400);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
