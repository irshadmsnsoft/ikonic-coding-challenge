-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ikonic_coding_challenge
CREATE DATABASE IF NOT EXISTS `ikonic_coding_challenge` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ikonic_coding_challenge`;

-- Dumping structure for table ikonic_coding_challenge.connections
CREATE TABLE IF NOT EXISTS `connections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `request_from` bigint unsigned NOT NULL,
  `request_to` bigint unsigned NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `connections_request_from_foreign` (`request_from`),
  KEY `connections_request_to_foreign` (`request_to`),
  CONSTRAINT `connections_request_from_foreign` FOREIGN KEY (`request_from`) REFERENCES `users` (`id`),
  CONSTRAINT `connections_request_to_foreign` FOREIGN KEY (`request_to`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ikonic_coding_challenge.connections: ~11 rows (approximately)
INSERT INTO `connections` (`id`, `request_from`, `request_to`, `status`, `created_at`, `updated_at`) VALUES
	(3, 5, 1, 'accepted', '2023-12-17 07:38:55', '2023-12-17 08:56:45'),
	(5, 1, 8, 'accepted', '2023-12-17 09:46:48', '2023-12-17 09:46:48'),
	(10, 1, 2, 'accepted', '2023-12-17 11:06:44', '2023-12-17 11:06:44'),
	(11, 1, 6, 'pending', '2023-12-17 11:09:08', '2023-12-17 11:09:08'),
	(12, 8, 2, 'accepted', '2023-12-17 11:14:47', '2023-12-17 11:17:47'),
	(13, 5, 2, 'accepted', '2023-12-17 11:17:03', '2023-12-17 11:17:03'),
	(14, 4, 1, 'pending', '2023-12-17 13:50:00', '2023-12-17 13:50:00'),
	(15, 1, 3, 'pending', '2023-12-17 23:53:21', '2023-12-17 23:53:21'),
	(16, 15, 1, 'pending', '2023-12-17 23:53:23', '2023-12-17 23:53:23'),
	(17, 1, 7, 'pending', '2023-12-17 23:53:24', '2023-12-17 23:53:24'),
	(18, 11, 1, 'accepted', '2023-12-17 23:57:04', '2023-12-17 23:58:18');

-- Dumping structure for table ikonic_coding_challenge.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ikonic_coding_challenge.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table ikonic_coding_challenge.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ikonic_coding_challenge.migrations: ~6 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
	(4, '2019_08_19_000000_create_failed_jobs_table', 1),
	(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(6, '2023_12_17_114128_create_connections_table', 2);

-- Dumping structure for table ikonic_coding_challenge.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ikonic_coding_challenge.password_resets: ~0 rows (approximately)

-- Dumping structure for table ikonic_coding_challenge.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ikonic_coding_challenge.personal_access_tokens: ~0 rows (approximately)

-- Dumping structure for table ikonic_coding_challenge.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ikonic_coding_challenge.users: ~19 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'user', 'user@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(2, 'user1', 'user1@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(3, 'user2', 'user2@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(4, 'user3', 'user3@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(5, 'user4', 'user4@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(6, 'user5', 'user5@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(7, 'user6', 'user6@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(8, 'user7', 'user7@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(9, 'user8', 'user8@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(10, 'user9', 'user9@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(11, 'user10', 'user10@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(12, 'user11', 'user11@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(13, 'user12', 'user12@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(14, 'user13', 'user13@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(15, 'user14', 'user14@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(16, 'user15', 'user15@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(17, 'user16', 'user16@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(18, 'user17', 'user17@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(19, 'user18', 'user18@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51'),
	(20, 'user19', 'user19@gmail.com', NULL, '$2y$10$/n8Ho0WHiOhU1OBax8vsse19Y2FqzbtmbG5BNmsJGvCGk18.1fU3y', NULL, NULL, NULL, NULL, '2023-12-17 01:59:51', '2023-12-17 01:59:51');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
