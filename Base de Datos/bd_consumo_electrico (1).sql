-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-12-2024 a las 21:23:04
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_consumo_electrico`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lectura_medidor`
--

CREATE TABLE `lectura_medidor` (
  `ID` int(11) NOT NULL,
  `MedidorID` int(11) NOT NULL,
  `FechaHora` timestamp NOT NULL DEFAULT current_timestamp(),
  `Corriente_rms` float DEFAULT NULL,
  `Voltaje_rms` float DEFAULT NULL,
  `Potencia_activa` float DEFAULT NULL,
  `Potencia_aparente` float DEFAULT NULL,
  `Energia` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lectura_medidor`
--

INSERT INTO `lectura_medidor` (`ID`, `MedidorID`, `FechaHora`, `Corriente_rms`, `Voltaje_rms`, `Potencia_activa`, `Potencia_aparente`, `Energia`) VALUES
(1, 1, '2023-11-15 16:00:00', 4.5, 220, 990, 1000, 15),
(2, 1, '2023-11-16 16:00:00', 4.2, 219.8, 924.6, 940, 30),
(3, 1, '2023-11-17 16:00:00', 4.8, 220.3, 1054.6, 1070, 45),
(4, 1, '2023-11-18 16:00:00', 5, 220.1, 1100.5, 1120, 60),
(5, 2, '2023-11-15 17:00:00', 3.5, 220.1, 770.35, 780, 10.5),
(6, 2, '2023-11-16 17:00:00', 3.8, 220.4, 837.52, 850, 25.8),
(7, 2, '2023-11-17 17:00:00', 3.7, 220.2, 814.74, 820, 38.4),
(8, 2, '2023-11-18 17:00:00', 3.9, 220.5, 859.95, 870, 50),
(9, 3, '2023-11-15 16:00:00', 8.2, 220, 1804, 1850, 50),
(10, 3, '2023-11-16 16:00:00', 8.5, 220.5, 1879.25, 1920, 105),
(11, 3, '2023-11-17 16:00:00', 8.4, 220.3, 1852.92, 1900, 155),
(12, 3, '2023-11-18 16:00:00', 8.7, 220.8, 1920.96, 1970, 210),
(13, 4, '2023-11-15 15:00:00', 12.5, 220, 2750, 2800, 100),
(14, 4, '2023-11-16 15:00:00', 12.8, 220.2, 2824.56, 2900, 300),
(15, 4, '2023-11-17 15:00:00', 12.7, 220.1, 2801.27, 2850, 520),
(16, 4, '2023-11-18 15:00:00', 13, 220.5, 2867.25, 2950, 750),
(17, 5, '2023-11-15 14:00:00', 6.5, 220, 1430, 1450, 80),
(18, 5, '2023-11-16 14:00:00', 7, 220.3, 1542.1, 1570, 200),
(19, 5, '2023-11-17 14:00:00', 6.8, 220.2, 1497.36, 1520, 340),
(20, 5, '2023-11-18 14:00:00', 7.2, 220.5, 1586.6, 1620, 450),
(21, 6, '2024-11-24 22:13:58', 0.921434, 220, 172.308, 202.715, 0.0478634),
(22, 6, '2024-11-24 22:14:09', 0.915511, 220, 171.201, 201.412, 0.0475557),
(23, 6, '2024-11-24 22:14:19', 0.902446, 220, 168.757, 198.538, 0.0468771),
(24, 6, '2024-11-24 22:14:29', 1.24157, 220, 232.174, 273.146, 0.0644928),
(25, 6, '2024-11-24 22:14:40', 1.25146, 220, 234.022, 275.32, 0.0650062),
(26, 6, '2024-11-24 22:14:51', 1.24956, 220, 233.668, 274.903, 0.0649078),
(27, 6, '2024-11-24 22:15:01', 1.25621, 220, 234.912, 276.367, 0.0652533),
(28, 6, '2024-11-24 22:15:11', 0.824648, 220, 154.209, 181.423, 0.0428359),
(29, 6, '2024-11-24 22:15:22', 0.812286, 220, 151.898, 178.703, 0.0421938),
(30, 6, '2024-11-24 23:27:21', 0.779187, 220, 145.708, 171.421, 0.0404744),
(31, 6, '2024-11-24 23:28:04', 1.11881, 220, 209.218, 246.139, 0.0581162),
(32, 6, '2024-11-24 23:28:16', 0.774082, 220, 144.753, 170.298, 0.0402093),
(33, 6, '2024-11-24 23:28:53', 1.27051, 220, 237.585, 279.512, 0.0659959),
(34, 6, '2024-11-24 23:29:12', 0.939272, 220, 175.644, 206.64, 0.04879),
(35, 6, '2024-11-24 23:35:07', 1.02318, 220, 191.335, 225.099, 0.0531485),
(36, 6, '2024-11-24 23:37:30', 1.06868, 220, 199.843, 235.109, 0.0555119),
(37, 6, '2024-11-24 23:37:41', 1.14492, 220, 214.1, 251.882, 0.0594722),
(38, 6, '2024-11-24 23:37:51', 1.08369, 220, 202.65, 238.412, 0.0562917),
(39, 6, '2024-11-24 23:38:02', 1.23701, 220, 231.321, 272.142, 0.0642557),
(40, 6, '2024-11-24 23:38:12', 1.26436, 220, 236.436, 278.159, 0.0656765),
(41, 6, '2024-11-24 23:38:23', 1.19783, 220, 223.995, 263.523, 0.0622207),
(42, 6, '2024-11-24 23:38:33', 1.2442, 220, 232.666, 273.725, 0.0646295),
(43, 6, '2024-11-24 23:38:44', 0.972607, 220, 181.878, 213.974, 0.0505215),
(44, 6, '2024-11-24 23:38:54', 0.990367, 220, 185.199, 217.881, 0.0514441),
(45, 6, '2024-11-24 23:39:20', 0.897869, 220, 167.902, 197.531, 0.0466393),
(46, 6, '2024-11-24 23:39:31', 1.11667, 220, 208.817, 245.667, 0.0580048),
(47, 6, '2024-11-24 23:39:41', 1.15682, 220, 216.325, 254.5, 0.0600904),
(48, 6, '2024-11-24 23:39:52', 1.10452, 220, 206.546, 242.995, 0.0573738),
(49, 6, '2024-11-24 23:40:02', 0.967092, 220, 180.846, 212.76, 0.050235),
(50, 6, '2024-11-24 23:40:13', 0.994867, 220, 186.04, 218.871, 0.0516778),
(51, 6, '2024-11-24 23:40:23', 0.988955, 220, 184.935, 217.57, 0.0513707),
(52, 6, '2024-11-24 23:40:34', 0.969076, 220, 181.217, 213.197, 0.0503381),
(53, 6, '2024-11-24 23:40:44', 1.18146, 220, 220.933, 259.922, 0.0613704),
(54, 6, '2024-11-24 23:40:54', 1.17005, 220, 218.798, 257.41, 0.0607773),
(55, 6, '2024-11-24 23:41:05', 1.13537, 220, 212.315, 249.782, 0.0589763),
(56, 6, '2024-11-24 23:45:09', 0.811028, 220, 151.662, 178.426, 0.0421284),
(57, 6, '2024-11-24 23:45:20', 0.881039, 220, 164.754, 193.829, 0.0457651),
(58, 6, '2024-11-24 23:45:32', 1.26529, 220, 236.609, 278.364, 0.0657248),
(59, 6, '2024-11-24 23:45:44', 1.06213, 220, 198.618, 233.669, 0.0551718),
(60, 6, '2024-11-24 23:45:56', 0.99798, 220, 186.622, 219.556, 0.0518395),
(61, 6, '2024-11-24 23:46:07', 1.01419, 220, 189.653, 223.122, 0.0526815),
(62, 6, '2024-11-24 23:46:19', 1.05476, 220, 197.241, 232.048, 0.0547892),
(63, 6, '2024-11-24 23:46:32', 1.01188, 220, 189.222, 222.614, 0.0525616),
(64, 6, '2024-11-24 23:46:44', 0.97745, 220, 182.783, 215.039, 0.0507731),
(65, 6, '2024-11-24 23:46:56', 1.00072, 220, 187.135, 220.159, 0.0519821),
(66, 6, '2024-11-24 23:47:07', 1.00561, 220, 188.049, 221.235, 0.052236),
(67, 6, '2024-11-24 23:47:19', 0.987025, 220, 184.574, 217.145, 0.0512705),
(68, 6, '2024-11-24 23:47:31', 1.02476, 220, 191.629, 225.446, 0.0532303),
(69, 6, '2024-11-24 23:47:42', 1.02012, 220, 190.763, 224.427, 0.0529898),
(70, 6, '2024-11-24 23:47:54', 1.05789, 220, 197.824, 232.735, 0.0549512),
(71, 6, '2024-11-24 23:48:06', 1.22716, 220, 229.478, 269.975, 0.063744),
(72, 6, '2024-11-24 23:48:18', 1.03517, 220, 193.578, 227.738, 0.0537716),
(73, 6, '2024-11-24 23:48:29', 1.08549, 220, 202.987, 238.808, 0.0563852),
(74, 6, '2024-11-24 23:48:41', 0.998455, 220, 186.711, 219.66, 0.0518642),
(75, 6, '2024-11-24 23:48:53', 1.02863, 220, 192.354, 226.298, 0.0534316),
(76, 6, '2024-11-24 23:49:04', 1.24277, 220, 232.397, 273.408, 0.0645548),
(77, 6, '2024-11-24 23:49:16', 1.1649, 220, 217.835, 256.277, 0.0605099),
(78, 6, '2024-11-24 23:49:28', 1.17195, 220, 219.154, 257.828, 0.0608761),
(79, 6, '2024-11-24 23:49:39', 1.07013, 220, 200.114, 235.428, 0.0555872),
(80, 6, '2024-11-24 23:49:51', 1.04119, 220, 194.702, 229.061, 0.0540839),
(81, 6, '2024-11-24 23:50:03', 1.03945, 220, 194.377, 228.679, 0.0539936),
(82, 6, '2024-11-24 23:50:14', 1.08099, 220, 202.146, 237.818, 0.0561515),
(83, 6, '2024-11-24 23:50:26', 1.04777, 220, 195.933, 230.509, 0.0544258),
(84, 6, '2024-11-24 23:50:38', 1.04585, 220, 195.574, 230.087, 0.0543261),
(85, 6, '2024-11-24 23:50:49', 1.05194, 220, 196.712, 231.426, 0.0546422),
(86, 6, '2024-11-24 23:51:01', 1.04721, 220, 195.829, 230.387, 0.0543969),
(87, 6, '2024-11-24 23:51:13', 1.01035, 220, 188.936, 222.277, 0.0524821),
(88, 6, '2024-11-24 23:51:24', 1.0573, 220, 197.714, 232.605, 0.0549207),
(89, 6, '2024-11-24 23:51:47', 1.06849, 220, 199.807, 235.067, 0.0555019),
(90, 6, '2024-11-24 23:52:01', 1.04528, 220, 195.468, 229.962, 0.0542966),
(91, 6, '2024-11-24 23:52:13', 1.08458, 220, 202.817, 238.608, 0.056338),
(92, 6, '2024-11-24 23:52:26', 1.07655, 220, 201.315, 236.841, 0.0559207),
(93, 6, '2024-11-24 23:52:38', 1.05934, 220, 198.096, 233.055, 0.0550268),
(94, 6, '2024-11-24 23:52:50', 1.056, 220, 197.471, 232.319, 0.0548531),
(95, 6, '2024-11-24 23:53:03', 1.03474, 220, 193.496, 227.642, 0.0537489),
(96, 6, '2024-11-24 23:53:16', 1.04932, 220, 196.222, 230.85, 0.0545062),
(97, 6, '2024-11-24 23:53:28', 1.09685, 220, 205.111, 241.307, 0.0569751),
(98, 6, '2024-11-24 23:53:40', 1.04865, 220, 196.097, 230.703, 0.0544714),
(99, 6, '2024-11-24 23:53:52', 1.02041, 220, 190.817, 224.491, 0.0530048),
(100, 6, '2024-11-24 23:54:04', 1.0718, 220, 200.427, 235.797, 0.0556742),
(101, 6, '2024-11-24 23:54:16', 1.03694, 220, 193.908, 228.127, 0.0538634),
(102, 6, '2024-11-24 23:54:28', 1.04065, 220, 194.601, 228.942, 0.0540558),
(103, 6, '2024-11-24 23:54:40', 1.06338, 220, 198.852, 233.943, 0.0552366),
(104, 6, '2024-11-24 23:54:51', 1.06467, 220, 199.094, 234.229, 0.055304),
(105, 6, '2024-11-24 23:55:03', 1.06451, 220, 199.064, 234.193, 0.0552955),
(106, 6, '2024-11-24 23:55:15', 1.05098, 220, 196.533, 231.215, 0.0545924),
(107, 6, '2024-11-24 23:55:26', 1.05065, 220, 196.472, 231.143, 0.0545755),
(108, 6, '2024-11-24 23:55:38', 1.02972, 220, 192.557, 226.538, 0.0534882),
(109, 6, '2024-11-24 23:55:50', 1.13004, 220, 211.317, 248.609, 0.0586992),
(110, 6, '2024-11-24 23:56:01', 1.21045, 220, 226.355, 266.3, 0.0628763),
(111, 6, '2024-11-24 23:56:13', 1.06476, 220, 199.11, 234.247, 0.0553084),
(112, 6, '2024-11-24 23:56:25', 1.05485, 220, 197.256, 232.066, 0.0547935),
(113, 6, '2024-11-24 23:56:37', 1.0604, 220, 198.294, 233.287, 0.0550818),
(114, 6, '2024-11-24 23:56:49', 1.02981, 220, 192.575, 226.559, 0.0534931),
(115, 6, '2024-11-24 23:57:01', 1.05576, 220, 197.427, 232.267, 0.0548409),
(116, 6, '2024-11-24 23:57:12', 1.10988, 220, 207.548, 244.174, 0.0576523),
(117, 6, '2024-11-24 23:57:24', 1.03582, 220, 193.698, 227.88, 0.0538049),
(118, 6, '2024-11-24 23:57:36', 1.08159, 220, 202.257, 237.949, 0.0561825),
(119, 6, '2024-11-24 23:57:47', 1.07729, 220, 201.454, 237.005, 0.0559595),
(120, 6, '2024-11-24 23:57:59', 1.07096, 220, 200.27, 235.612, 0.0556306),
(121, 6, '2024-11-24 23:58:11', 1.07111, 220, 200.297, 235.644, 0.0556381),
(122, 6, '2024-11-24 23:58:23', 1.06846, 220, 199.803, 235.062, 0.0555007),
(123, 6, '2024-11-24 23:58:35', 1.05406, 220, 197.11, 231.894, 0.0547528),
(124, 6, '2024-11-24 23:58:47', 1.07689, 220, 201.378, 236.915, 0.0559383),
(125, 6, '2024-11-24 23:58:59', 1.01319, 220, 189.467, 222.902, 0.0526297),
(126, 6, '2024-11-24 23:59:11', 1.04009, 220, 194.497, 228.82, 0.0540269),
(127, 6, '2024-11-24 23:59:25', 1.08222, 220, 202.375, 238.089, 0.0562153),
(128, 6, '2024-11-24 23:59:37', 1.09442, 220, 204.657, 240.773, 0.0568491),
(129, 6, '2024-11-24 23:59:49', 1.05383, 220, 197.065, 231.842, 0.0547404),
(130, 6, '2024-11-25 00:00:01', 1.06874, 220, 199.854, 235.122, 0.0555149),
(131, 6, '2024-11-25 00:00:13', 1.07385, 220, 200.81, 236.247, 0.0557805),
(132, 6, '2024-11-25 00:00:24', 1.26462, 220, 236.483, 278.215, 0.0656897),
(133, 6, '2024-11-25 00:00:36', 1.0765, 220, 201.305, 236.829, 0.055918),
(134, 6, '2024-11-25 00:00:48', 1.0681, 220, 199.735, 234.982, 0.0554819),
(135, 6, '2024-11-25 00:01:00', 1.2478, 220, 233.338, 274.515, 0.0648161),
(136, 6, '2024-11-25 00:01:11', 1.04589, 220, 195.582, 230.096, 0.0543283),
(137, 6, '2024-11-25 00:01:23', 1.05645, 220, 197.555, 232.418, 0.0548764),
(138, 6, '2024-11-25 00:01:35', 1.0539, 220, 197.079, 231.857, 0.054744),
(139, 6, '2024-11-25 00:01:46', 1.0543, 220, 197.153, 231.945, 0.0547648),
(140, 6, '2024-11-25 00:01:58', 1.07893, 220, 201.76, 237.364, 0.0560443),
(141, 6, '2024-11-25 00:02:10', 1.05761, 220, 197.773, 232.675, 0.0549371),
(142, 6, '2024-11-25 00:02:21', 1.07506, 220, 201.036, 236.512, 0.0558432),
(143, 6, '2024-11-25 00:02:33', 1.03302, 220, 193.175, 227.265, 0.0536598),
(144, 6, '2024-11-25 00:02:45', 1.07072, 220, 200.225, 235.559, 0.055618),
(145, 6, '2024-11-25 00:02:57', 0.99705, 220, 186.448, 219.351, 0.0517912),
(146, 6, '2024-11-25 00:03:08', 1.03479, 220, 193.507, 227.655, 0.0537518),
(147, 6, '2024-11-25 00:03:20', 1.01925, 220, 190.6, 224.236, 0.0529445),
(148, 6, '2024-11-25 00:03:32', 1.049, 220, 196.163, 230.78, 0.0544898),
(149, 6, '2024-11-25 00:03:43', 1.03543, 220, 193.626, 227.795, 0.053785),
(150, 6, '2024-11-25 00:03:55', 1.01788, 220, 190.344, 223.934, 0.0528732),
(151, 6, '2024-11-25 00:04:07', 1.01981, 220, 190.705, 224.359, 0.0529736),
(152, 6, '2024-11-25 00:04:19', 1.02184, 220, 191.084, 224.804, 0.0530788),
(153, 6, '2024-11-25 00:04:32', 1.06289, 220, 198.76, 233.836, 0.0552112),
(154, 6, '2024-11-25 00:04:45', 1.07798, 220, 201.582, 237.155, 0.055995),
(155, 6, '2024-11-25 00:04:59', 1.04038, 220, 194.551, 228.884, 0.054042),
(156, 6, '2024-11-25 00:05:12', 1.18383, 220, 221.377, 260.443, 0.0614935),
(157, 6, '2024-11-25 00:05:25', 1.02666, 220, 191.986, 225.865, 0.0533294),
(158, 6, '2024-11-25 00:05:38', 1.04921, 220, 196.202, 230.826, 0.0545005),
(159, 6, '2024-11-25 00:05:50', 1.03036, 220, 192.678, 226.68, 0.0535216),
(160, 6, '2024-11-25 00:06:03', 1.02531, 220, 191.732, 225.567, 0.053259),
(161, 6, '2024-11-25 00:06:16', 1.00116, 220, 187.216, 220.254, 0.0520045),
(162, 6, '2024-11-25 00:06:28', 1.02791, 220, 192.219, 226.141, 0.0533943),
(163, 6, '2024-11-25 00:06:40', 1.13917, 220, 213.025, 250.617, 0.0591735),
(164, 6, '2024-11-25 00:06:52', 1.03184, 220, 192.953, 227.004, 0.0535982),
(165, 6, '2024-11-25 00:07:04', 1.09329, 220, 204.446, 240.525, 0.0567906),
(166, 6, '2024-11-25 00:07:19', 1.0988, 220, 205.475, 241.735, 0.0570763),
(167, 6, '2024-11-25 00:07:30', 1.10685, 220, 206.982, 243.508, 0.0574949),
(168, 6, '2024-11-25 00:07:42', 1.12729, 220, 210.803, 248.003, 0.0585564),
(169, 6, '2024-11-25 00:07:54', 1.10989, 220, 207.549, 244.175, 0.0576524),
(170, 6, '2024-11-25 00:08:05', 1.07383, 220, 200.807, 236.243, 0.0557796),
(171, 6, '2024-11-25 00:08:17', 1.13753, 220, 212.719, 250.258, 0.0590886),
(172, 6, '2024-11-25 00:08:29', 1.15589, 220, 216.151, 254.295, 0.060042),
(173, 6, '2024-11-25 00:08:40', 1.11014, 220, 207.596, 244.231, 0.0576656),
(174, 6, '2024-11-25 00:08:52', 2.17459, 220, 406.648, 478.41, 0.112958),
(175, 6, '2024-11-25 00:09:04', 2.15526, 220, 403.034, 474.158, 0.111954),
(176, 6, '2024-11-25 00:09:16', 2.09123, 220, 391.06, 460.071, 0.108628),
(177, 6, '2024-11-25 00:09:27', 2.09571, 220, 391.897, 461.055, 0.10886),
(178, 6, '2024-11-25 00:09:39', 2.07192, 220, 387.449, 455.823, 0.107625),
(179, 6, '2024-11-25 00:09:51', 2.09411, 220, 391.598, 460.703, 0.108777),
(180, 6, '2024-11-25 00:10:02', 2.04843, 220, 383.056, 450.655, 0.106404),
(181, 6, '2024-11-25 00:10:14', 2.03239, 220, 380.056, 447.125, 0.105571),
(182, 6, '2024-11-25 00:10:26', 2.04107, 220, 381.681, 449.036, 0.106022),
(183, 6, '2024-11-25 00:10:37', 2.05026, 220, 383.399, 451.057, 0.1065),
(184, 6, '2024-11-25 00:10:49', 2.04206, 220, 381.866, 449.254, 0.106074),
(185, 6, '2024-11-25 00:11:01', 2.05241, 220, 383.801, 451.53, 0.106611),
(186, 6, '2024-11-25 00:11:12', 2.04195, 220, 381.845, 449.23, 0.106068),
(187, 6, '2024-11-25 00:11:24', 2.04147, 220, 381.755, 449.124, 0.106043),
(188, 6, '2024-11-25 00:11:36', 2.00541, 220, 375.012, 441.19, 0.10417),
(189, 6, '2024-11-25 00:11:47', 1.97658, 220, 369.621, 434.848, 0.102673),
(190, 6, '2024-11-25 00:11:59', 2.00442, 220, 374.827, 440.973, 0.104119),
(191, 6, '2024-11-25 00:12:11', 1.99691, 220, 373.422, 439.32, 0.103728),
(192, 6, '2024-11-25 00:12:22', 1.94033, 220, 362.842, 426.873, 0.10079),
(193, 6, '2024-11-25 00:12:34', 1.97628, 220, 369.565, 434.782, 0.102657),
(194, 6, '2024-11-25 00:12:46', 1.9934, 220, 372.765, 438.547, 0.103546),
(195, 6, '2024-11-25 00:12:58', 1.94557, 220, 363.822, 428.026, 0.101062),
(196, 6, '2024-11-25 00:13:09', 2.00524, 220, 374.98, 441.153, 0.104161),
(197, 6, '2024-11-25 00:13:21', 1.97276, 220, 368.905, 434.007, 0.102474),
(198, 6, '2024-11-25 00:13:33', 1.97089, 220, 368.556, 433.595, 0.102377),
(199, 6, '2024-11-25 00:13:44', 1.94765, 220, 364.211, 428.484, 0.10117),
(200, 6, '2024-11-25 00:13:56', 1.92607, 220, 360.174, 423.735, 0.100048),
(201, 6, '2024-11-25 00:14:08', 1.96043, 220, 366.599, 431.293, 0.101833),
(202, 6, '2024-11-25 00:14:20', 1.94408, 220, 363.542, 427.697, 0.100984),
(203, 6, '2024-11-25 00:14:31', 1.96741, 220, 367.906, 432.83, 0.102196),
(204, 6, '2024-11-25 00:14:43', 1.90631, 220, 356.48, 419.389, 0.0990223),
(205, 6, '2024-11-25 00:14:55', 1.93361, 220, 361.585, 425.394, 0.10044),
(206, 6, '2024-11-25 00:15:06', 1.93883, 220, 362.562, 426.543, 0.100712),
(207, 6, '2024-11-25 00:15:18', 1.96314, 220, 367.107, 431.89, 0.101974),
(208, 6, '2024-11-25 00:15:30', 1.93782, 220, 362.372, 426.32, 0.100659),
(209, 6, '2024-11-25 00:15:42', 1.89896, 220, 355.105, 417.771, 0.0986404),
(210, 6, '2024-11-25 00:15:53', 1.96409, 220, 367.285, 432.1, 0.102024),
(211, 6, '2024-11-25 00:16:05', 1.95176, 220, 364.979, 429.387, 0.101383),
(212, 6, '2024-11-25 00:44:07', 2.32412, 220, 434.611, 511.307, 0.120725),
(213, 6, '2024-11-25 00:44:18', 1.97928, 220, 370.125, 435.441, 0.102812),
(214, 6, '2024-11-25 00:44:30', 1.89223, 220, 353.848, 416.291, 0.098291),
(215, 6, '2024-11-25 00:44:42', 1.92586, 220, 360.136, 423.689, 0.100038),
(216, 6, '2024-11-25 00:44:54', 1.81105, 220, 338.666, 398.43, 0.0940738),
(217, 6, '2024-11-25 00:45:05', 1.84487, 220, 344.991, 405.872, 0.0958309),
(218, 6, '2024-11-25 00:45:17', 1.91518, 220, 358.138, 421.339, 0.0994828),
(219, 6, '2024-11-25 00:45:29', 2.14933, 220, 401.925, 472.853, 0.111646),
(220, 6, '2024-11-25 00:45:40', 2.12034, 220, 396.504, 466.475, 0.11014),
(221, 6, '2024-11-25 00:45:52', 1.70619, 220, 319.057, 375.362, 0.088627),
(222, 6, '2024-11-25 00:46:04', 1.37941, 220, 257.95, 303.471, 0.0716529),
(223, 6, '2024-11-25 00:46:15', 1.34254, 220, 251.054, 295.358, 0.0697373),
(224, 6, '2024-11-25 00:46:27', 1.79183, 220, 335.072, 394.202, 0.0930755),
(225, 6, '2024-11-25 00:46:39', 1.25722, 220, 235.1, 276.589, 0.0653057),
(226, 6, '2024-11-25 00:46:51', 1.28842, 220, 240.934, 283.452, 0.0669261),
(227, 6, '2024-11-29 17:42:23', 0.294151, 220, 55.0062, 64.7132, 0.0152795),
(228, 6, '2024-11-29 17:42:34', 0.29238, 220, 54.675, 64.3235, 0.0151875),
(229, 6, '2024-11-29 17:42:45', 14.0904, 220, 2634.91, 3099.89, 0.731919),
(230, 6, '2024-11-29 17:42:56', 14.1034, 220, 2637.34, 3102.75, 0.732594),
(231, 6, '2024-11-29 17:43:07', 13.9936, 220, 2616.81, 3078.6, 0.726892),
(232, 6, '2024-11-29 17:43:18', 0.418494, 220, 78.2584, 92.0687, 0.0217384),
(233, 6, '2024-11-29 17:43:29', 0.366504, 220, 68.5363, 80.631, 0.0190379),
(234, 6, '2024-11-29 17:43:40', 0.324597, 220, 60.6996, 71.4113, 0.016861),
(235, 6, '2024-11-29 17:43:51', 0.28394, 220, 53.0967, 62.4667, 0.0147491),
(236, 6, '2024-11-29 17:44:02', 0.244794, 220, 45.7766, 53.8548, 0.0127157),
(237, 6, '2024-11-29 17:44:13', 0.175604, 220, 32.8379, 38.6328, 0.00912163),
(238, 6, '2024-11-29 17:44:23', 0.188386, 220, 35.2282, 41.4449, 0.00978561),
(239, 6, '2024-11-29 17:44:34', 0.17521, 220, 32.7643, 38.5462, 0.0091012),
(240, 6, '2024-11-29 17:44:45', 0.169108, 220, 31.6233, 37.2038, 0.00878424),
(241, 6, '2024-11-29 17:44:56', 0.181839, 220, 34.0038, 40.0045, 0.00944551),
(242, 6, '2024-11-29 18:05:34', 0.543521, 220, 101.638, 119.575, 0.0282329),
(243, 6, '2024-11-29 18:05:45', 1.61987, 220, 302.915, 356.371, 0.0841432),
(244, 6, '2024-11-29 18:05:55', 1.35273, 220, 252.96, 297.599, 0.0702665),
(245, 6, '2024-11-29 18:06:06', 1.21725, 220, 227.626, 267.795, 0.0632294),
(246, 6, '2024-11-29 18:06:16', 1.22367, 220, 228.826, 269.207, 0.0635628),
(247, 6, '2024-11-29 18:06:27', 1.17922, 220, 220.514, 259.428, 0.0612538),
(248, 6, '2024-11-29 18:06:37', 1.46095, 220, 273.198, 321.41, 0.0758884),
(249, 6, '2024-11-29 18:06:48', 1.29446, 220, 242.064, 284.782, 0.0672401),
(250, 6, '2024-11-29 18:06:59', 14.5443, 220, 2719.79, 3199.75, 0.755498),
(251, 6, '2024-11-29 18:07:09', 14.5009, 220, 2711.67, 3190.2, 0.753242),
(252, 6, '2024-11-29 18:07:20', 14.6341, 220, 2736.57, 3219.49, 0.760158),
(253, 6, '2024-11-29 18:07:30', 0.503604, 220, 94.1739, 110.793, 0.0261594),
(254, 13, '2024-12-09 19:00:31', 1.04305, 220, 195.051, 229.471, 0.0541808),
(255, 13, '2024-12-09 19:00:41', 1.07207, 220, 200.477, 235.856, 0.0556882),
(256, 13, '2024-12-09 19:00:51', 1.12652, 220, 210.66, 247.835, 0.0585166),
(257, 13, '2024-12-09 19:01:01', 1.09642, 220, 205.03, 241.212, 0.0569529),
(258, 14, '2024-12-09 19:29:00', 0.63615, 220, 118.96, 139.953, 0.0330445),
(259, 14, '2024-12-09 19:29:09', 0.646872, 220, 120.965, 142.312, 0.0336014),
(260, 14, '2024-12-09 19:29:20', 0.665365, 220, 124.423, 146.38, 0.034562),
(261, 14, '2024-12-09 19:29:29', 0.690256, 220, 129.078, 151.856, 0.035855),
(262, 14, '2024-12-09 19:29:41', 14.3268, 220, 2679.11, 3151.9, 0.744198),
(263, 14, '2024-12-09 19:29:49', 14.2976, 220, 2673.65, 3145.47, 0.742681),
(264, 14, '2024-12-09 19:30:00', 14.3065, 220, 2675.32, 3147.43, 0.743144),
(265, 14, '2024-12-09 19:30:10', 14.289, 220, 2672.04, 3143.58, 0.742233),
(266, 14, '2024-12-09 19:30:20', 1.66086, 220, 310.581, 365.389, 0.0862724),
(267, 14, '2024-12-09 19:30:30', 1.65757, 220, 309.966, 364.666, 0.0861017),
(268, 14, '2024-12-09 19:30:40', 1.66561, 220, 311.469, 366.434, 0.0865191),
(269, 14, '2024-12-09 19:30:50', 1.67628, 220, 313.465, 368.782, 0.0870736),
(270, 14, '2024-12-09 19:30:59', 14.2785, 220, 2670.07, 3141.26, 0.741687),
(271, 14, '2024-12-09 19:31:10', 1.67456, 220, 313.143, 368.404, 0.0869842),
(272, 14, '2024-12-09 19:31:19', 1.68272, 220, 314.669, 370.199, 0.0874082),
(273, 14, '2024-12-09 19:31:30', 1.67616, 220, 313.442, 368.755, 0.0870672),
(274, 14, '2024-12-09 19:31:40', 1.67431, 220, 313.097, 368.349, 0.0869714),
(275, 14, '2024-12-09 19:31:50', 1.64109, 220, 306.884, 361.04, 0.0852457),
(276, 14, '2024-12-09 19:31:59', 1.6563, 220, 309.729, 364.387, 0.0860358);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medidor`
--

CREATE TABLE `medidor` (
  `ID` int(11) NOT NULL,
  `UsuarioID` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Tipo` varchar(50) NOT NULL,
  `FechaRegistro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medidor`
--

INSERT INTO `medidor` (`ID`, `UsuarioID`, `Nombre`, `Tipo`, `FechaRegistro`) VALUES
(1, 1, 'Medidor Principal Casa', 'Residencial', '2023-01-10 20:00:00'),
(2, 2, 'Medidor Sotano', 'Residencial', '2023-02-10 21:30:00'),
(3, 3, 'Medidor Oficina', 'Comercial', '2023-03-10 22:15:00'),
(4, 4, 'Medidor Bodega', 'Industrial', '2023-04-10 23:00:00'),
(5, 5, 'Medidor Taller', 'Comercial', '2023-05-11 00:45:00'),
(6, 6, 'casa2', 'dada', '2024-11-24 21:46:07'),
(7, 6, 'Casa4', 'Manolo', '2024-11-28 20:54:15'),
(8, 6, 'casa8', 'noo', '2024-11-29 16:44:45'),
(9, 6, 'Polo', 'Casa', '2024-11-29 17:13:40'),
(13, 11, 'Agora', 'Analogico', '2024-12-09 18:52:17'),
(14, 44, 'Cocian', 'Dijital', '2024-12-09 19:27:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Direccion` varchar(255) DEFAULT NULL,
  `Telefono` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `FechaRegistro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID`, `Nombre`, `Direccion`, `Telefono`, `Email`, `Password`, `FechaRegistro`) VALUES
(1, 'Juan Pérez', 'Av. Principal 123', '5551234567', 'juan.perez@gmail.com', 'hola', '2023-01-01 16:00:00'),
(2, 'Ana López', 'Calle Secundaria 45', '5557654321', 'ana.lopez@gmail.com', '', '2023-02-01 17:30:00'),
(3, 'Carlos Ruiz', 'Av. Reforma 10', '5559876543', 'carlos.ruiz@gmail.com', '', '2023-03-01 18:15:00'),
(4, 'Lucía Gómez', 'Calle Estrella 78', '5556543210', 'lucia.gomez@gmail.com', '', '2023-04-01 19:00:00'),
(5, 'María Torres', 'Av. Sur 456', '5553456789', 'maria.torres@gmail.com', '', '2023-05-01 20:45:00'),
(6, 'rene', 'fwefe', '2324', 'rene@gmail.com', 'rene123', '2024-11-24 21:15:45'),
(7, 'rene', 'fef', '2323', 'dwd', '', '2024-11-24 21:19:09'),
(8, 'Ronald', 'Calle 1', '123457', 'rere', '', '2024-11-24 21:20:26'),
(10, 'rene', 'fefe', '4343', 'sdw', '', '2024-11-24 21:22:58'),
(11, 'Valdir', 'Alto Seguencoma', '7857483', 'valdir.flores@gmail.com', 'val123', '2024-11-24 21:23:36'),
(12, 'Rene', 'ec', '2323', 'fsf', '', '2024-11-24 21:26:06'),
(13, 'rENE', 'FW', '244', 'fe', '', '2024-11-24 21:29:48'),
(14, 'Ronald', 'dwe', '24', 'cd', '', '2024-11-24 21:33:55'),
(15, 'ewew', 'ffef', '23', 'fw', '', '2024-11-24 21:34:26'),
(16, 'Ronek', 'ded', '23', 'dw', '', '2024-11-24 21:36:10'),
(17, 'eref', 'fef', '32', 'f', '', '2024-11-24 21:40:57'),
(18, 'wfw', '4234', 'fef', 'f2', '', '2024-11-24 21:43:02'),
(21, 'DAIRA', 'Satelite', '324324', 'di@as', '', '2024-11-27 20:02:55'),
(23, 'DAIRA', 'Satelite', '43243', 'rene@rene', '', '2024-11-27 20:16:37'),
(39, 'rene', 'q', '5555555', 'ffff@fff', NULL, '2024-12-09 03:33:12'),
(40, 'a', 'q', '99999999', 'dfa@rerr', NULL, '2024-12-09 03:35:41'),
(42, 'Aston Martin', 'La Paz Bolivia Perez', '79988', 'qwdq@wdwd', '3213213', '2024-12-09 04:05:32'),
(43, 'Aston Martin', 'La Paz Bolivia Perez', '99999999', 'ron@ron', 'gggggg', '2024-12-09 18:58:46'),
(44, 'Daira', 'Satelite', '8965774', 'daira.arce@gmail.com', '12345', '2024-12-09 19:26:20');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `lectura_medidor`
--
ALTER TABLE `lectura_medidor`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `MedidorID` (`MedidorID`);

--
-- Indices de la tabla `medidor`
--
ALTER TABLE `medidor`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UsuarioID` (`UsuarioID`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `lectura_medidor`
--
ALTER TABLE `lectura_medidor`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=277;

--
-- AUTO_INCREMENT de la tabla `medidor`
--
ALTER TABLE `medidor`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `lectura_medidor`
--
ALTER TABLE `lectura_medidor`
  ADD CONSTRAINT `lectura_medidor_ibfk_1` FOREIGN KEY (`MedidorID`) REFERENCES `medidor` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `medidor`
--
ALTER TABLE `medidor`
  ADD CONSTRAINT `medidor_ibfk_1` FOREIGN KEY (`UsuarioID`) REFERENCES `usuario` (`ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
