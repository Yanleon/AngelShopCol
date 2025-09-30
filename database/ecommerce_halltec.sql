# ************************************************************
# Sequel Ace SQL dump
# Version 20087
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 8.0.37)
# Database: ecommerce_halltec_bd
# Generation Time: 2025-03-07 20:42:00 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table addresses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `addresses`;

CREATE TABLE `addresses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `address_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_address_id` int unsigned DEFAULT NULL,
  `customer_id` int unsigned DEFAULT NULL COMMENT 'null if guest checkout',
  `cart_id` int unsigned DEFAULT NULL COMMENT 'only for cart_addresses',
  `order_id` int unsigned DEFAULT NULL COMMENT 'only for order_addresses',
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vat_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_address` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'only for customer_addresses',
  `use_for_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_customer_id_foreign` (`customer_id`),
  KEY `addresses_cart_id_foreign` (`cart_id`),
  KEY `addresses_order_id_foreign` (`order_id`),
  KEY `addresses_parent_address_id_foreign` (`parent_address_id`),
  CONSTRAINT `addresses_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addresses_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addresses_parent_address_id_foreign` FOREIGN KEY (`parent_address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `addresses_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table admin_password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_password_resets`;

CREATE TABLE `admin_password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `admin_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table admins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_token` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `role_id` int unsigned NOT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`),
  UNIQUE KEY `admins_api_token_unique` (`api_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;

INSERT INTO `admins` (`id`, `name`, `email`, `password`, `api_token`, `status`, `role_id`, `image`, `remember_token`, `created_at`, `updated_at`)
VALUES
	(1,'Admin Admin','admin@gmail.com','$2y$10$HNutFQF86nYYvBXjpQ4wtenV74pzqMDpkznvIx6xnIW6SAyMaWGQm','8b4xvVaHk61Sb0nt4Q7nJMIyd7KqfpcfEnrNuw8jAjl5yAP4t08aFqLMyndrXKtSwPVEvxki7I2pNYoE',1,1,'admins/1/jjop8fFNhpArgqyEG9SvJqUmTUniOrb31jRGlo2G.png',NULL,'2024-09-25 10:19:36','2024-10-16 11:14:54');

/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table attribute_families
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attribute_families`;

CREATE TABLE `attribute_families` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `is_user_defined` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `attribute_families` WRITE;
/*!40000 ALTER TABLE `attribute_families` DISABLE KEYS */;

INSERT INTO `attribute_families` (`id`, `code`, `name`, `status`, `is_user_defined`)
VALUES
	(1,'default','Predeterminado',0,1);

/*!40000 ALTER TABLE `attribute_families` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table attribute_group_mappings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attribute_group_mappings`;

CREATE TABLE `attribute_group_mappings` (
  `attribute_id` int unsigned NOT NULL,
  `attribute_group_id` int unsigned NOT NULL,
  `position` int DEFAULT NULL,
  PRIMARY KEY (`attribute_id`,`attribute_group_id`),
  KEY `attribute_group_mappings_attribute_group_id_foreign` (`attribute_group_id`),
  CONSTRAINT `attribute_group_mappings_attribute_group_id_foreign` FOREIGN KEY (`attribute_group_id`) REFERENCES `attribute_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attribute_group_mappings_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `attribute_group_mappings` WRITE;
/*!40000 ALTER TABLE `attribute_group_mappings` DISABLE KEYS */;

INSERT INTO `attribute_group_mappings` (`attribute_id`, `attribute_group_id`, `position`)
VALUES
	(1,1,1),
	(2,1,3),
	(3,1,4),
	(4,1,5),
	(5,6,1),
	(6,6,2),
	(7,6,3),
	(8,6,4),
	(9,2,1),
	(10,2,2),
	(11,4,1),
	(12,4,2),
	(13,4,3),
	(14,4,4),
	(15,4,5),
	(16,3,1),
	(17,3,2),
	(18,3,3),
	(19,5,1),
	(20,5,2),
	(21,5,3),
	(22,5,4),
	(23,1,6),
	(24,1,7),
	(25,1,8),
	(26,6,5),
	(27,1,2),
	(28,7,1);

/*!40000 ALTER TABLE `attribute_group_mappings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table attribute_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attribute_groups`;

CREATE TABLE `attribute_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute_family_id` int unsigned NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `column` int NOT NULL DEFAULT '1',
  `position` int NOT NULL,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_groups_attribute_family_id_name_unique` (`attribute_family_id`,`name`),
  CONSTRAINT `attribute_groups_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `attribute_groups` WRITE;
/*!40000 ALTER TABLE `attribute_groups` DISABLE KEYS */;

INSERT INTO `attribute_groups` (`id`, `code`, `attribute_family_id`, `name`, `column`, `position`, `is_user_defined`)
VALUES
	(1,'general',1,'General',1,1,0),
	(2,'description',1,'Descripción',1,2,0),
	(3,'meta_description',1,'Meta Descripción',1,3,0),
	(4,'price',1,'Precio',2,1,0),
	(5,'shipping',1,'Envío',2,2,0),
	(6,'settings',1,'Configuraciones',2,3,0),
	(7,'inventories',1,'Inventarios',2,4,0);

/*!40000 ALTER TABLE `attribute_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table attribute_option_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attribute_option_translations`;

CREATE TABLE `attribute_option_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `attribute_option_id` int unsigned NOT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_option_translations_attribute_option_id_locale_unique` (`attribute_option_id`,`locale`),
  CONSTRAINT `attribute_option_translations_attribute_option_id_foreign` FOREIGN KEY (`attribute_option_id`) REFERENCES `attribute_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `attribute_option_translations` WRITE;
/*!40000 ALTER TABLE `attribute_option_translations` DISABLE KEYS */;

INSERT INTO `attribute_option_translations` (`id`, `attribute_option_id`, `locale`, `label`)
VALUES
	(1,1,'es','Rojo'),
	(2,2,'es','Verde'),
	(3,3,'es','Amarillo'),
	(4,4,'es','Negro'),
	(5,5,'es','Blanco'),
	(6,6,'es','S'),
	(7,7,'es','M'),
	(8,8,'es','L'),
	(9,9,'es','XL');

/*!40000 ALTER TABLE `attribute_option_translations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table attribute_options
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attribute_options`;

CREATE TABLE `attribute_options` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` int unsigned NOT NULL,
  `admin_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `swatch_value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_options_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `attribute_options_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `attribute_options` WRITE;
/*!40000 ALTER TABLE `attribute_options` DISABLE KEYS */;

INSERT INTO `attribute_options` (`id`, `attribute_id`, `admin_name`, `sort_order`, `swatch_value`)
VALUES
	(1,23,'Rojo',1,NULL),
	(2,23,'Verde',2,NULL),
	(3,23,'Amarillo',3,NULL),
	(4,23,'Negro',4,NULL),
	(5,23,'Blanco',5,NULL),
	(6,24,'S',1,NULL),
	(7,24,'M',2,NULL),
	(8,24,'L',3,NULL),
	(9,24,'XL',4,NULL);

/*!40000 ALTER TABLE `attribute_options` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table attribute_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attribute_translations`;

CREATE TABLE `attribute_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` int unsigned NOT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_translations_attribute_id_locale_unique` (`attribute_id`,`locale`),
  CONSTRAINT `attribute_translations_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `attribute_translations` WRITE;
/*!40000 ALTER TABLE `attribute_translations` DISABLE KEYS */;

INSERT INTO `attribute_translations` (`id`, `attribute_id`, `locale`, `name`)
VALUES
	(1,1,'es','SKU'),
	(2,2,'es','Nombre'),
	(3,3,'es','Clave de URL'),
	(4,4,'es','Categoría de Impuestos'),
	(5,5,'es','Nuevo'),
	(6,6,'es','Destacado'),
	(7,7,'es','Visible Individualmente'),
	(8,8,'es','Estado'),
	(9,9,'es','Descripción Corta'),
	(10,10,'es','Descripción'),
	(11,11,'es','Precio'),
	(12,12,'es','Costo'),
	(13,13,'es','Precio Especial'),
	(14,14,'es','Precio Especial Desde'),
	(15,15,'es','Precio Especial Hasta'),
	(16,16,'es','Meta Título'),
	(17,17,'es','Meta Palabras Clave'),
	(18,18,'es','Meta Descripción'),
	(19,19,'es','Longitud'),
	(20,20,'es','Ancho'),
	(21,21,'es','Altura'),
	(22,22,'es','Peso'),
	(23,23,'es','Color'),
	(24,24,'es','Tamaño'),
	(25,25,'es','Marca'),
	(26,26,'es','Compra de Invitado'),
	(27,27,'es','Número de Producto'),
	(28,28,'es','Gestionar Stock');

/*!40000 ALTER TABLE `attribute_translations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table attributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attributes`;

CREATE TABLE `attributes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `swatch_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validation` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `regex` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `is_unique` tinyint(1) NOT NULL DEFAULT '0',
  `is_filterable` tinyint(1) NOT NULL DEFAULT '0',
  `is_comparable` tinyint(1) NOT NULL DEFAULT '0',
  `is_configurable` tinyint(1) NOT NULL DEFAULT '0',
  `is_user_defined` tinyint(1) NOT NULL DEFAULT '1',
  `is_visible_on_front` tinyint(1) NOT NULL DEFAULT '0',
  `value_per_locale` tinyint(1) NOT NULL DEFAULT '0',
  `value_per_channel` tinyint(1) NOT NULL DEFAULT '0',
  `default_value` int DEFAULT NULL,
  `enable_wysiwyg` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attributes_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;

INSERT INTO `attributes` (`id`, `code`, `admin_name`, `type`, `swatch_type`, `validation`, `regex`, `position`, `is_required`, `is_unique`, `is_filterable`, `is_comparable`, `is_configurable`, `is_user_defined`, `is_visible_on_front`, `value_per_locale`, `value_per_channel`, `default_value`, `enable_wysiwyg`, `created_at`, `updated_at`)
VALUES
	(1,'sku','SKU','text',NULL,NULL,NULL,1,1,1,0,0,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(2,'name','Nombre','text',NULL,NULL,NULL,3,1,0,0,1,0,0,0,1,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(3,'url_key','Clave de URL','text',NULL,NULL,NULL,4,1,1,0,0,0,0,0,1,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(4,'tax_category_id','Categoría de Impuestos','select',NULL,NULL,NULL,5,0,0,0,0,0,0,0,0,1,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(5,'new','Nuevo','boolean',NULL,NULL,NULL,6,0,0,0,0,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(6,'featured','Destacado','boolean',NULL,NULL,NULL,7,0,0,0,0,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(7,'visible_individually','Visible Individualmente','boolean',NULL,NULL,NULL,9,1,0,0,0,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(8,'status','Estado','boolean',NULL,NULL,NULL,10,1,0,0,0,0,0,0,0,1,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(9,'short_description','Descripción Corta','textarea',NULL,NULL,NULL,11,1,0,0,0,0,0,0,1,0,NULL,1,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(10,'description','Descripción','textarea',NULL,NULL,NULL,12,1,0,0,1,0,0,0,1,0,NULL,1,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(11,'price','Precio','price',NULL,'decimal',NULL,13,1,0,1,1,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(12,'cost','Costo','price',NULL,'decimal',NULL,14,0,0,0,0,0,1,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(13,'special_price','Precio Especial','price',NULL,'decimal',NULL,15,0,0,0,0,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(14,'special_price_from','Precio Especial Desde','date',NULL,NULL,NULL,16,0,0,0,0,0,0,0,0,1,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(15,'special_price_to','Precio Especial Hasta','date',NULL,NULL,NULL,17,0,0,0,0,0,0,0,0,1,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(16,'meta_title','Meta Título','textarea',NULL,NULL,NULL,18,0,0,0,0,0,0,0,1,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(17,'meta_keywords','Meta Palabras Clave','textarea',NULL,NULL,NULL,20,0,0,0,0,0,0,0,1,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(18,'meta_description','Meta Descripción','textarea',NULL,NULL,NULL,21,0,0,0,0,0,1,0,1,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(19,'length','Longitud','text',NULL,'decimal',NULL,22,0,0,0,0,0,1,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(20,'width','Ancho','text',NULL,'decimal',NULL,23,0,0,0,0,0,1,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(21,'height','Altura','text',NULL,'decimal',NULL,24,0,0,0,0,0,1,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(22,'weight','Peso','text',NULL,'decimal',NULL,25,1,0,0,0,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(23,'color','Color','select',NULL,NULL,NULL,26,0,0,1,0,1,1,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(24,'size','Tamaño','select',NULL,NULL,NULL,27,0,0,1,0,1,1,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(25,'brand','Marca','select',NULL,NULL,NULL,28,0,0,1,0,0,1,1,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(26,'guest_checkout','Compra de Invitado','boolean',NULL,NULL,NULL,8,1,0,0,0,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(27,'product_number','Número de Producto','text',NULL,NULL,NULL,2,0,1,0,0,0,0,0,0,0,NULL,0,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(28,'manage_stock','Gestionar Stock','boolean',NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,1,1,0,'2024-09-25 10:19:36','2024-09-25 10:19:36');

/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cart
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_gift` tinyint(1) NOT NULL DEFAULT '0',
  `items_count` int DEFAULT NULL,
  `items_qty` decimal(12,4) DEFAULT NULL,
  `exchange_rate` decimal(12,4) DEFAULT NULL,
  `global_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cart_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` decimal(12,4) DEFAULT '0.0000',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000',
  `sub_total` decimal(12,4) DEFAULT '0.0000',
  `base_sub_total` decimal(12,4) DEFAULT '0.0000',
  `tax_total` decimal(12,4) DEFAULT '0.0000',
  `base_tax_total` decimal(12,4) DEFAULT '0.0000',
  `discount_amount` decimal(12,4) DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `checkout_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_guest` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `applied_cart_rule_ids` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` int unsigned DEFAULT NULL,
  `channel_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_customer_id_foreign` (`customer_id`),
  KEY `cart_channel_id_foreign` (`channel_id`),
  CONSTRAINT `cart_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_item_inventories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_item_inventories`;

CREATE TABLE `cart_item_inventories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `qty` int unsigned NOT NULL DEFAULT '0',
  `inventory_source_id` int unsigned DEFAULT NULL,
  `cart_item_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_items`;

CREATE TABLE `cart_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL DEFAULT '0',
  `sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total_weight` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total_weight` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `price` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `custom_price` decimal(12,4) DEFAULT NULL,
  `total` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `tax_percent` decimal(12,4) DEFAULT '0.0000',
  `tax_amount` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000',
  `discount_percent` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `applied_tax_rate` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned NOT NULL,
  `cart_id` int unsigned NOT NULL,
  `tax_category_id` int unsigned DEFAULT NULL,
  `applied_cart_rule_ids` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_parent_id_foreign` (`parent_id`),
  KEY `cart_items_product_id_foreign` (`product_id`),
  KEY `cart_items_cart_id_foreign` (`cart_id`),
  KEY `cart_items_tax_category_id_foreign` (`tax_category_id`),
  CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `cart_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_tax_category_id_foreign` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_categories` (`id`),
  CONSTRAINT `cart_items_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_payment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_payment`;

CREATE TABLE `cart_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cart_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_payment_cart_id_foreign` (`cart_id`),
  CONSTRAINT `cart_payment_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_rule_channels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_rule_channels`;

CREATE TABLE `cart_rule_channels` (
  `cart_rule_id` int unsigned NOT NULL,
  `channel_id` int unsigned NOT NULL,
  PRIMARY KEY (`cart_rule_id`,`channel_id`),
  KEY `cart_rule_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `cart_rule_channels_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_rule_coupon_usage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_rule_coupon_usage`;

CREATE TABLE `cart_rule_coupon_usage` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `times_used` int NOT NULL DEFAULT '0',
  `cart_rule_coupon_id` int unsigned NOT NULL,
  `customer_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_coupon_usage_cart_rule_coupon_id_foreign` (`cart_rule_coupon_id`),
  KEY `cart_rule_coupon_usage_customer_id_foreign` (`customer_id`),
  CONSTRAINT `cart_rule_coupon_usage_cart_rule_coupon_id_foreign` FOREIGN KEY (`cart_rule_coupon_id`) REFERENCES `cart_rule_coupons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_coupon_usage_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_rule_coupons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_rule_coupons`;

CREATE TABLE `cart_rule_coupons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usage_limit` int unsigned NOT NULL DEFAULT '0',
  `usage_per_customer` int unsigned NOT NULL DEFAULT '0',
  `times_used` int unsigned NOT NULL DEFAULT '0',
  `type` int unsigned NOT NULL DEFAULT '0',
  `is_primary` tinyint(1) NOT NULL DEFAULT '0',
  `expired_at` date DEFAULT NULL,
  `cart_rule_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_coupons_cart_rule_id_foreign` (`cart_rule_id`),
  CONSTRAINT `cart_rule_coupons_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_rule_customer_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_rule_customer_groups`;

CREATE TABLE `cart_rule_customer_groups` (
  `cart_rule_id` int unsigned NOT NULL,
  `customer_group_id` int unsigned NOT NULL,
  PRIMARY KEY (`cart_rule_id`,`customer_group_id`),
  KEY `cart_rule_customer_groups_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `cart_rule_customer_groups_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_customer_groups_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_rule_customers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_rule_customers`;

CREATE TABLE `cart_rule_customers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `times_used` bigint unsigned NOT NULL DEFAULT '0',
  `customer_id` int unsigned NOT NULL,
  `cart_rule_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_customers_cart_rule_id_foreign` (`cart_rule_id`),
  KEY `cart_rule_customers_customer_id_foreign` (`customer_id`),
  CONSTRAINT `cart_rule_customers_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_customers_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_rule_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_rule_translations`;

CREATE TABLE `cart_rule_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cart_rule_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cart_rule_translations_cart_rule_id_locale_unique` (`cart_rule_id`,`locale`),
  CONSTRAINT `cart_rule_translations_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_rules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_rules`;

CREATE TABLE `cart_rules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `starts_from` datetime DEFAULT NULL,
  `ends_till` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `coupon_type` int NOT NULL DEFAULT '1',
  `use_auto_generation` tinyint(1) NOT NULL DEFAULT '0',
  `usage_per_customer` int NOT NULL DEFAULT '0',
  `uses_per_coupon` int NOT NULL DEFAULT '0',
  `times_used` int unsigned NOT NULL DEFAULT '0',
  `condition_type` tinyint(1) NOT NULL DEFAULT '1',
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `end_other_rules` tinyint(1) NOT NULL DEFAULT '0',
  `uses_attribute_conditions` tinyint(1) NOT NULL DEFAULT '0',
  `action_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `discount_quantity` int NOT NULL DEFAULT '1',
  `discount_step` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `apply_to_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `free_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `cart_rules_chk_1` CHECK (json_valid(`conditions`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cart_shipping_rates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cart_shipping_rates`;

CREATE TABLE `cart_shipping_rates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `carrier` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `carrier_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double DEFAULT '0',
  `base_price` double DEFAULT '0',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `tax_percent` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `applied_tax_rate` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_calculate_tax` tinyint(1) NOT NULL DEFAULT '1',
  `cart_address_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cart_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_shipping_rates_cart_id_foreign` (`cart_id`),
  CONSTRAINT `cart_shipping_rates_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table catalog_rule_channels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_rule_channels`;

CREATE TABLE `catalog_rule_channels` (
  `catalog_rule_id` int unsigned NOT NULL,
  `channel_id` int unsigned NOT NULL,
  PRIMARY KEY (`catalog_rule_id`,`channel_id`),
  KEY `catalog_rule_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `catalog_rule_channels_catalog_rule_id_foreign` FOREIGN KEY (`catalog_rule_id`) REFERENCES `catalog_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table catalog_rule_customer_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_rule_customer_groups`;

CREATE TABLE `catalog_rule_customer_groups` (
  `catalog_rule_id` int unsigned NOT NULL,
  `customer_group_id` int unsigned NOT NULL,
  PRIMARY KEY (`catalog_rule_id`,`customer_group_id`),
  KEY `catalog_rule_customer_groups_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `catalog_rule_customer_groups_catalog_rule_id_foreign` FOREIGN KEY (`catalog_rule_id`) REFERENCES `catalog_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_customer_groups_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table catalog_rule_product_prices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_rule_product_prices`;

CREATE TABLE `catalog_rule_product_prices` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `rule_date` date NOT NULL,
  `starts_from` datetime DEFAULT NULL,
  `ends_till` datetime DEFAULT NULL,
  `product_id` int unsigned NOT NULL,
  `customer_group_id` int unsigned NOT NULL,
  `catalog_rule_id` int unsigned NOT NULL,
  `channel_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalog_rule_product_prices_product_id_foreign` (`product_id`),
  KEY `catalog_rule_product_prices_customer_group_id_foreign` (`customer_group_id`),
  KEY `catalog_rule_product_prices_catalog_rule_id_foreign` (`catalog_rule_id`),
  KEY `catalog_rule_product_prices_channel_id_foreign` (`channel_id`),
  CONSTRAINT `catalog_rule_product_prices_catalog_rule_id_foreign` FOREIGN KEY (`catalog_rule_id`) REFERENCES `catalog_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_product_prices_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_product_prices_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_product_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table catalog_rule_products
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_rule_products`;

CREATE TABLE `catalog_rule_products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `starts_from` datetime DEFAULT NULL,
  `ends_till` datetime DEFAULT NULL,
  `end_other_rules` tinyint(1) NOT NULL DEFAULT '0',
  `action_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `product_id` int unsigned NOT NULL,
  `customer_group_id` int unsigned NOT NULL,
  `catalog_rule_id` int unsigned NOT NULL,
  `channel_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalog_rule_products_product_id_foreign` (`product_id`),
  KEY `catalog_rule_products_customer_group_id_foreign` (`customer_group_id`),
  KEY `catalog_rule_products_catalog_rule_id_foreign` (`catalog_rule_id`),
  KEY `catalog_rule_products_channel_id_foreign` (`channel_id`),
  CONSTRAINT `catalog_rule_products_catalog_rule_id_foreign` FOREIGN KEY (`catalog_rule_id`) REFERENCES `catalog_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_products_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_products_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table catalog_rules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_rules`;

CREATE TABLE `catalog_rules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `starts_from` date DEFAULT NULL,
  `ends_till` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `condition_type` tinyint(1) NOT NULL DEFAULT '1',
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `end_other_rules` tinyint(1) NOT NULL DEFAULT '0',
  `action_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `catalog_rules_chk_1` CHECK (json_valid(`conditions`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `position` int NOT NULL DEFAULT '0',
  `logo_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `display_mode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'products_and_description',
  `_lft` int unsigned NOT NULL DEFAULT '0',
  `_rgt` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `banner_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`),
  CONSTRAINT `categories_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `position`, `logo_path`, `status`, `display_mode`, `_lft`, `_rgt`, `parent_id`, `additional`, `banner_path`, `created_at`, `updated_at`)
VALUES
	(1,5,NULL,1,'products_and_description',1,34,NULL,NULL,NULL,'2024-09-25 10:19:36','2024-09-26 11:23:02'),
	(3,5,'category/3/p3WavcuICiOwPVXFM0RKup84QOEKwd5AHv4Jjryz.webp',1,'products_and_description',14,15,1,NULL,NULL,'2024-09-26 11:03:27','2024-10-07 09:06:40'),
	(4,5,'category/4/xbwKkqtFcjcUqTPjYxIoEdxslwY1Oej9PPrKpRWV.webp',1,'products_and_description',16,17,1,NULL,NULL,'2024-09-26 11:25:17','2024-10-07 09:05:28'),
	(5,5,'category/5/XW1mHUx2E9itXFJGZ4ww4aGMOer7XFGPrOX8xEzB.webp',1,'products_and_description',18,19,1,NULL,NULL,'2024-09-26 11:27:09','2024-10-07 09:04:30'),
	(6,5,'category/6/Rz6OcUnawBBWQCuWdWX4HbSIgdR8WHORpjm294Kg.webp',1,'products_and_description',20,21,1,NULL,NULL,'2024-09-26 11:31:09','2024-10-07 09:03:29'),
	(7,5,'category/7/sRsGGew7XnPbmp9feLRPpNsGojcxZz1CYA00uFvh.webp',1,'products_and_description',22,23,1,NULL,NULL,'2024-09-26 11:34:21','2024-10-07 09:07:22'),
	(8,5,'category/8/Bvvgd6gE5Q1ACiFlDHVp8YCqt785MJneig3eauKL.webp',1,'products_and_description',24,25,1,NULL,NULL,'2024-09-26 11:41:33','2024-10-07 09:01:48'),
	(9,5,'category/9/0JQ7h3ELYdwI7iBCr7MqkysEmxiTflEA0D5zdlnq.webp',1,'products_and_description',26,27,1,NULL,NULL,'2024-09-26 11:45:16','2024-10-07 09:00:48'),
	(10,5,'category/10/sazmtSQC3XzKrimZ3Jv1265r00KZmvZJcigXs2zp.webp',1,'products_and_description',28,33,1,NULL,NULL,'2024-09-26 14:56:40','2024-10-07 08:59:20'),
	(12,1,NULL,1,'products_and_description',29,32,10,NULL,NULL,'2024-11-26 16:29:37','2024-11-26 16:29:55'),
	(13,1,NULL,1,'products_and_description',30,31,12,NULL,NULL,'2024-11-26 16:30:35','2024-11-26 16:30:35');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table category_filterable_attributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `category_filterable_attributes`;

CREATE TABLE `category_filterable_attributes` (
  `category_id` int unsigned NOT NULL,
  `attribute_id` int unsigned NOT NULL,
  KEY `category_filterable_attributes_category_id_foreign` (`category_id`),
  KEY `category_filterable_attributes_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `category_filterable_attributes_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_filterable_attributes_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `category_filterable_attributes` WRITE;
/*!40000 ALTER TABLE `category_filterable_attributes` DISABLE KEYS */;

INSERT INTO `category_filterable_attributes` (`category_id`, `attribute_id`)
VALUES
	(3,11),
	(3,23),
	(3,24),
	(3,25),
	(1,11),
	(1,23),
	(1,24),
	(1,25),
	(4,11),
	(4,23),
	(4,24),
	(4,25),
	(5,11),
	(5,23),
	(5,24),
	(5,25),
	(6,11),
	(6,23),
	(6,24),
	(6,25),
	(7,11),
	(7,23),
	(7,24),
	(7,25),
	(8,11),
	(8,23),
	(8,24),
	(8,25),
	(9,11),
	(9,23),
	(9,24),
	(9,25),
	(10,11),
	(10,23),
	(10,24),
	(10,25),
	(12,11),
	(12,23),
	(12,24),
	(12,25),
	(13,11);

/*!40000 ALTER TABLE `category_filterable_attributes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table category_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `category_translations`;

CREATE TABLE `category_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url_path` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_id` int unsigned DEFAULT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_translations_category_id_slug_locale_unique` (`category_id`,`slug`,`locale`),
  KEY `category_translations_locale_id_foreign` (`locale_id`),
  CONSTRAINT `category_translations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_translations_locale_id_foreign` FOREIGN KEY (`locale_id`) REFERENCES `locales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `category_translations` WRITE;
/*!40000 ALTER TABLE `category_translations` DISABLE KEYS */;

INSERT INTO `category_translations` (`id`, `category_id`, `name`, `slug`, `url_path`, `description`, `meta_title`, `meta_description`, `meta_keywords`, `locale_id`, `locale`)
VALUES
	(1,1,'Raíz','root','','<p>Descripci&oacute;n de la Categor&iacute;a Ra&iacute;z</p>','','','',NULL,'es'),
	(3,3,'UNILEVER','unilever','','<p>UNILEVER</p>','UNILEVER','UNILEVER','UNILEVER',1,'es'),
	(4,4,'NATURA','natura','','<p>NATURA</p>','NATURA','NATURA','NATURA',1,'es'),
	(5,5,'LBEL','lbel','','<p>LBEL</p>','LBEL','LBEL','LBEL',1,'es'),
	(6,6,'NEUTROGENA','neutrogena','','<p>NEUTROGENA</p>','NEUTROGENA','NEUTROGENA','louis vuitton',1,'es'),
	(7,7,'NIVEA','nivea','','<p>NIVEA</p>','NIVEA','NIVEA','NIVEA',1,'es'),
	(8,8,'WELLA','WELLA','','<p>WELLA</p>','WELLA','WELLA','WELLA',1,'es'),
	(9,9,'DIOR','dior','','<p>DIOR</p>','DIOR','DIOR','DIOR',1,'es'),
	(10,10,'LOREAL','loreal','','<p>LOREAL</p>','LOREAL','LOREAL','LOREAL',1,'es'),
	(12,12,'Loreal 2','loreal-2','','<p>prueba</p>','','','',1,'es'),
	(13,13,'loreal 3','loreal-3','','<p>prueba</p>','','','',1,'es');

/*!40000 ALTER TABLE `category_translations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table channel_currencies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `channel_currencies`;

CREATE TABLE `channel_currencies` (
  `channel_id` int unsigned NOT NULL,
  `currency_id` int unsigned NOT NULL,
  PRIMARY KEY (`channel_id`,`currency_id`),
  KEY `channel_currencies_currency_id_foreign` (`currency_id`),
  CONSTRAINT `channel_currencies_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_currencies_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `channel_currencies` WRITE;
/*!40000 ALTER TABLE `channel_currencies` DISABLE KEYS */;

INSERT INTO `channel_currencies` (`channel_id`, `currency_id`)
VALUES
	(1,1);

/*!40000 ALTER TABLE `channel_currencies` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table channel_inventory_sources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `channel_inventory_sources`;

CREATE TABLE `channel_inventory_sources` (
  `channel_id` int unsigned NOT NULL,
  `inventory_source_id` int unsigned NOT NULL,
  UNIQUE KEY `channel_inventory_sources_channel_id_inventory_source_id_unique` (`channel_id`,`inventory_source_id`),
  KEY `channel_inventory_sources_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `channel_inventory_sources_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_inventory_sources_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `channel_inventory_sources` WRITE;
/*!40000 ALTER TABLE `channel_inventory_sources` DISABLE KEYS */;

INSERT INTO `channel_inventory_sources` (`channel_id`, `inventory_source_id`)
VALUES
	(1,1);

/*!40000 ALTER TABLE `channel_inventory_sources` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table channel_locales
# ------------------------------------------------------------

DROP TABLE IF EXISTS `channel_locales`;

CREATE TABLE `channel_locales` (
  `channel_id` int unsigned NOT NULL,
  `locale_id` int unsigned NOT NULL,
  PRIMARY KEY (`channel_id`,`locale_id`),
  KEY `channel_locales_locale_id_foreign` (`locale_id`),
  CONSTRAINT `channel_locales_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_locales_locale_id_foreign` FOREIGN KEY (`locale_id`) REFERENCES `locales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `channel_locales` WRITE;
/*!40000 ALTER TABLE `channel_locales` DISABLE KEYS */;

INSERT INTO `channel_locales` (`channel_id`, `locale_id`)
VALUES
	(1,1);

/*!40000 ALTER TABLE `channel_locales` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table channel_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `channel_translations`;

CREATE TABLE `channel_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int unsigned NOT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `maintenance_mode_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `home_seo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `channel_translations_channel_id_locale_unique` (`channel_id`,`locale`),
  KEY `channel_translations_locale_index` (`locale`),
  CONSTRAINT `channel_translations_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_translations_chk_1` CHECK (json_valid(`home_seo`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `channel_translations` WRITE;
/*!40000 ALTER TABLE `channel_translations` DISABLE KEYS */;

INSERT INTO `channel_translations` (`id`, `channel_id`, `locale`, `name`, `description`, `maintenance_mode_text`, `home_seo`, `created_at`, `updated_at`)
VALUES
	(1,1,'es','Predeterminado',NULL,'',X'7B226D6574615F7469746C65223A225469656E64612064652044656D6F7374726163695C75303066336E222C226D6574615F6465736372697074696F6E223A224465736372697063695C75303066336E206465204D657461206465206C61205469656E64612064652044656D6F7374726163695C75303066336E222C226D6574615F6B6579776F726473223A2250616C616272617320436C617665206465204D657461206465206C61205469656E64612064652044656D6F7374726163695C75303066336E227D',NULL,'2024-09-25 14:37:25');

/*!40000 ALTER TABLE `channel_translations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table channels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `channels`;

CREATE TABLE `channels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timezone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hostname` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `home_seo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `is_maintenance_on` tinyint(1) NOT NULL DEFAULT '0',
  `allowed_ips` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `root_category_id` int unsigned DEFAULT NULL,
  `default_locale_id` int unsigned NOT NULL,
  `base_currency_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channels_root_category_id_foreign` (`root_category_id`),
  KEY `channels_default_locale_id_foreign` (`default_locale_id`),
  KEY `channels_base_currency_id_foreign` (`base_currency_id`),
  CONSTRAINT `channels_base_currency_id_foreign` FOREIGN KEY (`base_currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `channels_default_locale_id_foreign` FOREIGN KEY (`default_locale_id`) REFERENCES `locales` (`id`),
  CONSTRAINT `channels_root_category_id_foreign` FOREIGN KEY (`root_category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `channels_chk_1` CHECK (json_valid(`home_seo`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `channels` WRITE;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;

INSERT INTO `channels` (`id`, `code`, `timezone`, `theme`, `hostname`, `logo`, `favicon`, `home_seo`, `is_maintenance_on`, `allowed_ips`, `root_category_id`, `default_locale_id`, `base_currency_id`, `created_at`, `updated_at`)
VALUES
	(1,'default',NULL,'default','https://bellezaysalud.hallpos.com.co','channel/1/Ys58i9uIn0rpXMQ74OHilLWlniZDJvtIfMc4CBit.jpg','channel/1/VQ3SUwilmPMI8EoLKivct0787nazz2l5NSlbUvvl.png',NULL,0,'',1,1,1,'2024-09-25 10:19:36','2025-03-04 12:26:51');

/*!40000 ALTER TABLE `channels` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cms_page_channels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_page_channels`;

CREATE TABLE `cms_page_channels` (
  `cms_page_id` int unsigned NOT NULL,
  `channel_id` int unsigned NOT NULL,
  UNIQUE KEY `cms_page_channels_cms_page_id_channel_id_unique` (`cms_page_id`,`channel_id`),
  KEY `cms_page_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `cms_page_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_page_channels_cms_page_id_foreign` FOREIGN KEY (`cms_page_id`) REFERENCES `cms_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table cms_page_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_page_translations`;

CREATE TABLE `cms_page_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `page_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `html_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cms_page_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_page_translations_cms_page_id_url_key_locale_unique` (`cms_page_id`,`url_key`,`locale`),
  CONSTRAINT `cms_page_translations_cms_page_id_foreign` FOREIGN KEY (`cms_page_id`) REFERENCES `cms_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `cms_page_translations` WRITE;
/*!40000 ALTER TABLE `cms_page_translations` DISABLE KEYS */;

INSERT INTO `cms_page_translations` (`id`, `page_title`, `url_key`, `html_content`, `meta_title`, `meta_description`, `meta_keywords`, `locale`, `cms_page_id`)
VALUES
	(1,'Acerca de Nosotros','about-us','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Acerca de Nosotros</div></div>','about us','','aboutus','es',1),
	(2,'Política de Retorno','return-policy','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Política de Retorno</div></div>','return policy','','return, policy','es',2),
	(3,'Política de Devolución','refund-policy','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Política de Devolución</div></div>','Refund policy','','refund, policy','es',3),
	(4,'Términos y Condiciones','terms-conditions','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Términos y Condiciones</div></div>','Terms & Conditions','','term, conditions','es',4),
	(5,'Términos de Uso','terms-of-use','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Términos de Uso</div></div>','Terms of use','','term, use','es',5),
	(6,'Servicio al Cliente','customer-service','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Servicio al Cliente</div></div>','Customer Service','','customer, service','es',7),
	(7,'Novedades','whats-new','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Novedades</div></div>','What\'s New','','new','es',8),
	(8,'Política de Pago','payment-policy','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Política de Pago</div></div>','Payment Policy','','payment, policy','es',9),
	(9,'Política de Envío','shipping-policy','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Política de Envío</div></div>','Shipping Policy','','shipping, policy','es',10),
	(10,'Política de Privacidad','privacy-policy','<div class=\"static-container\"><div class=\"mb-5\">Contenido de la Página Política de Privacidad</div></div>','Privacy Policy','','privacy, policy','es',11);

/*!40000 ALTER TABLE `cms_page_translations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cms_pages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_pages`;

CREATE TABLE `cms_pages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `layout` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `cms_pages` WRITE;
/*!40000 ALTER TABLE `cms_pages` DISABLE KEYS */;

INSERT INTO `cms_pages` (`id`, `layout`, `created_at`, `updated_at`)
VALUES
	(1,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(2,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(3,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(4,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(5,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(6,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(7,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(8,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(9,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(10,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(11,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36');

/*!40000 ALTER TABLE `cms_pages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table compare_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `compare_items`;

CREATE TABLE `compare_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `customer_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compare_items_product_id_foreign` (`product_id`),
  KEY `compare_items_customer_id_foreign` (`customer_id`),
  CONSTRAINT `compare_items_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compare_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table core_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_config`;

CREATE TABLE `core_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `core_config` WRITE;
/*!40000 ALTER TABLE `core_config` DISABLE KEYS */;

INSERT INTO `core_config` (`id`, `code`, `value`, `channel_code`, `locale_code`, `created_at`, `updated_at`)
VALUES
	(1,'sales.checkout.shopping_cart.allow_guest_checkout','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(2,'emails.general.notifications.emails.general.notifications.verification','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(3,'emails.general.notifications.emails.general.notifications.registration','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(4,'emails.general.notifications.emails.general.notifications.customer','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(5,'emails.general.notifications.emails.general.notifications.new_order','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(6,'emails.general.notifications.emails.general.notifications.new_admin','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(7,'emails.general.notifications.emails.general.notifications.new_invoice','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(8,'emails.general.notifications.emails.general.notifications.new_refund','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(9,'emails.general.notifications.emails.general.notifications.new_shipment','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(10,'emails.general.notifications.emails.general.notifications.new_inventory_source','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(11,'emails.general.notifications.emails.general.notifications.cancel_order','1',NULL,NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(12,'customer.settings.social_login.enable_facebook','0','default',NULL,'2024-09-25 10:19:36','2024-10-02 23:43:01'),
	(13,'customer.settings.social_login.enable_twitter','0','default',NULL,'2024-09-25 10:19:36','2024-10-02 23:43:01'),
	(14,'customer.settings.social_login.enable_google','0','default',NULL,'2024-09-25 10:19:36','2024-10-02 23:43:01'),
	(15,'customer.settings.social_login.enable_linkedin','1','default',NULL,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(16,'customer.settings.social_login.enable_github','0','default',NULL,'2024-09-25 10:19:36','2024-10-02 23:43:01'),
	(19,'sales.payment_methods.paypal_smart_button.description','PayPal','default','es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(20,'sales.payment_methods.paypal_smart_button.active','0','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(21,'sales.payment_methods.paypal_smart_button.sandbox','0','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(22,'sales.payment_methods.epayco.title','Epayco',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(23,'sales.payment_methods.epayco.name_store','Fashion pago en linea',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(24,'sales.payment_methods.epayco.url_response','https://outlet.hallpos2.com.co/epayco/standard/success',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:24:04'),
	(25,'sales.payment_methods.epayco.url_confirmation','https://outlet.hallpos2.com.co/epayco/standard/ipn',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:24:04'),
	(26,'sales.payment_methods.epayco.description','Epayco',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(27,'sales.payment_methods.epayco.cust_id_client','1491654',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(28,'sales.payment_methods.epayco.p_key','',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(29,'sales.payment_methods.epayco.public_key','',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(30,'sales.payment_methods.epayco.active','1',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(31,'sales.payment_methods.epayco.testing_mode','1',NULL,'es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(32,'sales.payment_methods.cashondelivery.description','Cash On Delivery','default','es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(33,'sales.payment_methods.cashondelivery.instructions','','default','es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(34,'sales.payment_methods.cashondelivery.generate_invoice','0','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(35,'sales.payment_methods.cashondelivery.invoice_status','paid','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(36,'sales.payment_methods.cashondelivery.active','0','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(37,'sales.payment_methods.cashondelivery.sort','1',NULL,NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(38,'sales.payment_methods.moneytransfer.description','Money Transfer','default','es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(39,'sales.payment_methods.moneytransfer.generate_invoice','0','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(40,'sales.payment_methods.moneytransfer.mailing_address','','default','es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(41,'sales.payment_methods.moneytransfer.active','0','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(42,'sales.payment_methods.moneytransfer.sort','2',NULL,NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(43,'sales.payment_methods.paypal_standard.description','PayPal Standard','default','es','2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(44,'sales.payment_methods.paypal_standard.active','0','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(45,'sales.payment_methods.paypal_standard.sandbox','0','default',NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(46,'sales.payment_methods.paypal_standard.sort','3',NULL,NULL,'2024-10-02 17:12:28','2024-10-02 17:12:28'),
	(47,'sales.carriers.free.title','Free Shipping','default','es','2024-10-02 17:12:39','2024-10-02 17:12:39'),
	(48,'sales.carriers.free.description','Free Shipping','default','es','2024-10-02 17:12:39','2024-10-02 17:12:39'),
	(49,'sales.carriers.free.active','1','default',NULL,'2024-10-02 17:12:39','2024-10-02 17:12:39'),
	(50,'sales.carriers.flatrate.description','Flat Rate Shipping','default','es','2024-10-02 17:12:39','2024-10-02 17:12:39'),
	(51,'sales.carriers.flatrate.type','per_unit','default',NULL,'2024-10-02 17:12:39','2024-10-02 17:12:39'),
	(52,'sales.carriers.flatrate.active','0','default',NULL,'2024-10-02 17:12:39','2024-10-02 17:12:39'),
	(53,'customer.settings.wishlist.wishlist_option','1',NULL,NULL,'2024-10-02 23:43:01','2024-10-02 23:43:01'),
	(54,'customer.settings.login_options.redirected_to_page','home',NULL,NULL,'2024-10-02 23:43:01','2024-10-02 23:43:01'),
	(55,'customer.settings.create_new_account_options.default_group','guest',NULL,NULL,'2024-10-02 23:43:01','2024-10-02 23:43:01'),
	(56,'customer.settings.create_new_account_options.news_letter','1',NULL,NULL,'2024-10-02 23:43:01','2024-10-02 23:43:01'),
	(57,'customer.settings.newsletter.subscription','0',NULL,NULL,'2024-10-02 23:43:01','2024-10-02 23:43:01'),
	(58,'customer.settings.email.verification','0',NULL,NULL,'2024-10-02 23:43:01','2024-10-02 23:43:01'),
	(59,'customer.settings.social_login.enable_linkedin-openid','0','default',NULL,'2024-10-02 23:43:01','2024-10-02 23:43:01'),
	(60,'general.design.admin_logo.logo_image','configuration/4ZvUtNEv6PYd0dmKhcUowvJAWKdkP3OnYgBeJPNn.png',NULL,NULL,'2024-10-16 11:14:38','2024-10-16 11:14:38'),
	(61,'catalog.products.settings.compare_option','1',NULL,NULL,'2024-11-26 16:31:47','2024-11-26 16:31:47'),
	(62,'catalog.products.settings.image_search','1',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(63,'catalog.products.search.engine','database',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(64,'catalog.products.search.admin_mode','database',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(65,'catalog.products.search.storefront_mode','database',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(66,'catalog.products.search.min_query_length','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(67,'catalog.products.search.max_query_length','1000',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(68,'catalog.products.product_view_page.no_of_related_products','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(69,'catalog.products.product_view_page.no_of_up_sells_products','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(70,'catalog.products.cart_view_page.no_of_cross_sells_products','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(71,'catalog.products.storefront.products_per_page','','default',NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(72,'catalog.products.storefront.sort_by','name-asc','default',NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(73,'catalog.products.storefront.buy_now_button_display','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(74,'catalog.products.cache_small_image.width','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(75,'catalog.products.cache_small_image.height','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(76,'catalog.products.cache_medium_image.width','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(77,'catalog.products.cache_medium_image.height','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(78,'catalog.products.cache_large_image.width','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(79,'catalog.products.cache_large_image.height','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(80,'catalog.products.review.guest_review','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(81,'catalog.products.review.customer_review','1',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(82,'catalog.products.review.summary','review_counts',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(83,'catalog.products.attribute.image_attribute_upload_size','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(84,'catalog.products.attribute.file_attribute_upload_size','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(85,'catalog.products.social_share.enabled','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(86,'catalog.products.social_share.facebook','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(87,'catalog.products.social_share.twitter','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(88,'catalog.products.social_share.pinterest','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(89,'catalog.products.social_share.whatsapp','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(90,'catalog.products.social_share.linkedin','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(91,'catalog.products.social_share.email','0',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(92,'catalog.products.social_share.share_message','',NULL,NULL,'2024-11-26 16:31:48','2024-11-26 16:31:48'),
	(93,'sales.shipping.origin.country','CO','default','es','2024-11-27 08:56:36','2024-11-27 08:56:36'),
	(94,'sales.shipping.origin.state','Santander','default','es','2024-11-27 08:56:36','2024-11-27 08:56:36'),
	(95,'sales.shipping.origin.city','68679-SAN GIL','default','es','2024-11-27 08:56:36','2024-11-27 08:56:36'),
	(96,'sales.shipping.origin.address','calle 11 8-84, HALLTEC SAS','default','es','2024-11-27 08:56:36','2024-11-27 08:56:36'),
	(97,'sales.shipping.origin.zipcode','684031','default','es','2024-11-27 08:56:36','2024-11-27 08:56:36'),
	(98,'sales.shipping.origin.store_name','','default','es','2024-11-27 08:56:36','2024-11-27 08:56:36'),
	(99,'sales.shipping.origin.vat_number','','default',NULL,'2024-11-27 08:56:36','2024-11-27 08:56:36'),
	(100,'sales.shipping.origin.contact','','default',NULL,'2024-11-27 08:56:36','2024-11-27 08:56:36'),
	(101,'sales.shipping.origin.bank_details','','default','es','2024-11-27 08:56:36','2024-11-27 08:56:36');

/*!40000 ALTER TABLE `core_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table countries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;

INSERT INTO `countries` (`id`, `code`, `name`)
VALUES
	(1,'AF','Afghanistan'),
	(2,'AX','Åland Islands'),
	(3,'AL','Albania'),
	(4,'DZ','Algeria'),
	(5,'AS','American Samoa'),
	(6,'AD','Andorra'),
	(7,'AO','Angola'),
	(8,'AI','Anguilla'),
	(9,'AQ','Antarctica'),
	(10,'AG','Antigua & Barbuda'),
	(11,'AR','Argentina'),
	(12,'AM','Armenia'),
	(13,'AW','Aruba'),
	(14,'AC','Ascension Island'),
	(15,'AU','Australia'),
	(16,'AT','Austria'),
	(17,'AZ','Azerbaijan'),
	(18,'BS','Bahamas'),
	(19,'BH','Bahrain'),
	(20,'BD','Bangladesh'),
	(21,'BB','Barbados'),
	(22,'BY','Belarus'),
	(23,'BE','Belgium'),
	(24,'BZ','Belize'),
	(25,'BJ','Benin'),
	(26,'BM','Bermuda'),
	(27,'BT','Bhutan'),
	(28,'BO','Bolivia'),
	(29,'BA','Bosnia & Herzegovina'),
	(30,'BW','Botswana'),
	(31,'BR','Brazil'),
	(32,'IO','British Indian Ocean Territory'),
	(33,'VG','British Virgin Islands'),
	(34,'BN','Brunei'),
	(35,'BG','Bulgaria'),
	(36,'BF','Burkina Faso'),
	(37,'BI','Burundi'),
	(38,'KH','Cambodia'),
	(39,'CM','Cameroon'),
	(40,'CA','Canada'),
	(41,'IC','Canary Islands'),
	(42,'CV','Cape Verde'),
	(43,'BQ','Caribbean Netherlands'),
	(44,'KY','Cayman Islands'),
	(45,'CF','Central African Republic'),
	(46,'EA','Ceuta & Melilla'),
	(47,'TD','Chad'),
	(48,'CL','Chile'),
	(49,'CN','China'),
	(50,'CX','Christmas Island'),
	(51,'CC','Cocos (Keeling) Islands'),
	(52,'CO','Colombia'),
	(53,'KM','Comoros'),
	(54,'CG','Congo - Brazzaville'),
	(55,'CD','Congo - Kinshasa'),
	(56,'CK','Cook Islands'),
	(57,'CR','Costa Rica'),
	(58,'CI','Côte d’Ivoire'),
	(59,'HR','Croatia'),
	(60,'CU','Cuba'),
	(61,'CW','Curaçao'),
	(62,'CY','Cyprus'),
	(63,'CZ','Czechia'),
	(64,'DK','Denmark'),
	(65,'DG','Diego Garcia'),
	(66,'DJ','Djibouti'),
	(67,'DM','Dominica'),
	(68,'DO','Dominican Republic'),
	(69,'EC','Ecuador'),
	(70,'EG','Egypt'),
	(71,'SV','El Salvador'),
	(72,'GQ','Equatorial Guinea'),
	(73,'ER','Eritrea'),
	(74,'EE','Estonia'),
	(75,'ET','Ethiopia'),
	(76,'EZ','Eurozone'),
	(77,'FK','Falkland Islands'),
	(78,'FO','Faroe Islands'),
	(79,'FJ','Fiji'),
	(80,'FI','Finland'),
	(81,'FR','France'),
	(82,'GF','French Guiana'),
	(83,'PF','French Polynesia'),
	(84,'TF','French Southern Territories'),
	(85,'GA','Gabon'),
	(86,'GM','Gambia'),
	(87,'GE','Georgia'),
	(88,'DE','Germany'),
	(89,'GH','Ghana'),
	(90,'GI','Gibraltar'),
	(91,'GR','Greece'),
	(92,'GL','Greenland'),
	(93,'GD','Grenada'),
	(94,'GP','Guadeloupe'),
	(95,'GU','Guam'),
	(96,'GT','Guatemala'),
	(97,'GG','Guernsey'),
	(98,'GN','Guinea'),
	(99,'GW','Guinea-Bissau'),
	(100,'GY','Guyana'),
	(101,'HT','Haiti'),
	(102,'HN','Honduras'),
	(103,'HK','Hong Kong SAR China'),
	(104,'HU','Hungary'),
	(105,'IS','Iceland'),
	(106,'IN','India'),
	(107,'ID','Indonesia'),
	(108,'IR','Iran'),
	(109,'IQ','Iraq'),
	(110,'IE','Ireland'),
	(111,'IM','Isle of Man'),
	(112,'IL','Israel'),
	(113,'IT','Italy'),
	(114,'JM','Jamaica'),
	(115,'JP','Japan'),
	(116,'JE','Jersey'),
	(117,'JO','Jordan'),
	(118,'KZ','Kazakhstan'),
	(119,'KE','Kenya'),
	(120,'KI','Kiribati'),
	(121,'XK','Kosovo'),
	(122,'KW','Kuwait'),
	(123,'KG','Kyrgyzstan'),
	(124,'LA','Laos'),
	(125,'LV','Latvia'),
	(126,'LB','Lebanon'),
	(127,'LS','Lesotho'),
	(128,'LR','Liberia'),
	(129,'LY','Libya'),
	(130,'LI','Liechtenstein'),
	(131,'LT','Lithuania'),
	(132,'LU','Luxembourg'),
	(133,'MO','Macau SAR China'),
	(134,'MK','Macedonia'),
	(135,'MG','Madagascar'),
	(136,'MW','Malawi'),
	(137,'MY','Malaysia'),
	(138,'MV','Maldives'),
	(139,'ML','Mali'),
	(140,'MT','Malta'),
	(141,'MH','Marshall Islands'),
	(142,'MQ','Martinique'),
	(143,'MR','Mauritania'),
	(144,'MU','Mauritius'),
	(145,'YT','Mayotte'),
	(146,'MX','Mexico'),
	(147,'FM','Micronesia'),
	(148,'MD','Moldova'),
	(149,'MC','Monaco'),
	(150,'MN','Mongolia'),
	(151,'ME','Montenegro'),
	(152,'MS','Montserrat'),
	(153,'MA','Morocco'),
	(154,'MZ','Mozambique'),
	(155,'MM','Myanmar (Burma)'),
	(156,'NA','Namibia'),
	(157,'NR','Nauru'),
	(158,'NP','Nepal'),
	(159,'NL','Netherlands'),
	(160,'NC','New Caledonia'),
	(161,'NZ','New Zealand'),
	(162,'NI','Nicaragua'),
	(163,'NE','Niger'),
	(164,'NG','Nigeria'),
	(165,'NU','Niue'),
	(166,'NF','Norfolk Island'),
	(167,'KP','North Korea'),
	(168,'MP','Northern Mariana Islands'),
	(169,'NO','Norway'),
	(170,'OM','Oman'),
	(171,'PK','Pakistan'),
	(172,'PW','Palau'),
	(173,'PS','Palestinian Territories'),
	(174,'PA','Panama'),
	(175,'PG','Papua New Guinea'),
	(176,'PY','Paraguay'),
	(177,'PE','Peru'),
	(178,'PH','Philippines'),
	(179,'PN','Pitcairn Islands'),
	(180,'PL','Poland'),
	(181,'PT','Portugal'),
	(182,'PR','Puerto Rico'),
	(183,'QA','Qatar'),
	(184,'RE','Réunion'),
	(185,'RO','Romania'),
	(186,'RU','Russia'),
	(187,'RW','Rwanda'),
	(188,'WS','Samoa'),
	(189,'SM','San Marino'),
	(190,'ST','São Tomé & Príncipe'),
	(191,'SA','Saudi Arabia'),
	(192,'SN','Senegal'),
	(193,'RS','Serbia'),
	(194,'SC','Seychelles'),
	(195,'SL','Sierra Leone'),
	(196,'SG','Singapore'),
	(197,'SX','Sint Maarten'),
	(198,'SK','Slovakia'),
	(199,'SI','Slovenia'),
	(200,'SB','Solomon Islands'),
	(201,'SO','Somalia'),
	(202,'ZA','South Africa'),
	(203,'GS','South Georgia & South Sandwich Islands'),
	(204,'KR','South Korea'),
	(205,'SS','South Sudan'),
	(206,'ES','Spain'),
	(207,'LK','Sri Lanka'),
	(208,'BL','St. Barthélemy'),
	(209,'SH','St. Helena'),
	(210,'KN','St. Kitts & Nevis'),
	(211,'LC','St. Lucia'),
	(212,'MF','St. Martin'),
	(213,'PM','St. Pierre & Miquelon'),
	(214,'VC','St. Vincent & Grenadines'),
	(215,'SD','Sudan'),
	(216,'SR','Suriname'),
	(217,'SJ','Svalbard & Jan Mayen'),
	(218,'SZ','Swaziland'),
	(219,'SE','Sweden'),
	(220,'CH','Switzerland'),
	(221,'SY','Syria'),
	(222,'TW','Taiwan'),
	(223,'TJ','Tajikistan'),
	(224,'TZ','Tanzania'),
	(225,'TH','Thailand'),
	(226,'TL','Timor-Leste'),
	(227,'TG','Togo'),
	(228,'TK','Tokelau'),
	(229,'TO','Tonga'),
	(230,'TT','Trinidad & Tobago'),
	(231,'TA','Tristan da Cunha'),
	(232,'TN','Tunisia'),
	(233,'TR','Turkey'),
	(234,'TM','Turkmenistan'),
	(235,'TC','Turks & Caicos Islands'),
	(236,'TV','Tuvalu'),
	(237,'UM','U.S. Outlying Islands'),
	(238,'VI','U.S. Virgin Islands'),
	(239,'UG','Uganda'),
	(240,'UA','Ukraine'),
	(241,'AE','United Arab Emirates'),
	(242,'GB','United Kingdom'),
	(243,'UN','United Nations'),
	(244,'US','United States'),
	(245,'UY','Uruguay'),
	(246,'UZ','Uzbekistan'),
	(247,'VU','Vanuatu'),
	(248,'VA','Vatican City'),
	(249,'VE','Venezuela'),
	(250,'VN','Vietnam'),
	(251,'WF','Wallis & Futuna'),
	(252,'EH','Western Sahara'),
	(253,'YE','Yemen'),
	(254,'ZM','Zambia'),
	(255,'ZW','Zimbabwe');

/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table country_state_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `country_state_translations`;

CREATE TABLE `country_state_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `country_state_id` int unsigned NOT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `country_state_translations_country_state_id_foreign` (`country_state_id`),
  CONSTRAINT `country_state_translations_country_state_id_foreign` FOREIGN KEY (`country_state_id`) REFERENCES `country_states` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table country_states
# ------------------------------------------------------------

DROP TABLE IF EXISTS `country_states`;

CREATE TABLE `country_states` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int unsigned DEFAULT NULL,
  `country_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_states_country_id_foreign` (`country_id`),
  CONSTRAINT `country_states_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `country_states` WRITE;
/*!40000 ALTER TABLE `country_states` DISABLE KEYS */;

INSERT INTO `country_states` (`id`, `country_id`, `country_code`, `code`, `default_name`)
VALUES
	(1,244,'US','AL','Alabama'),
	(2,244,'US','AK','Alaska'),
	(3,244,'US','AS','American Samoa'),
	(4,244,'US','AZ','Arizona'),
	(5,244,'US','AR','Arkansas'),
	(6,244,'US','AE','Armed Forces Africa'),
	(7,244,'US','AA','Armed Forces Americas'),
	(8,244,'US','AE','Armed Forces Canada'),
	(9,244,'US','AE','Armed Forces Europe'),
	(10,244,'US','AE','Armed Forces Middle East'),
	(11,244,'US','AP','Armed Forces Pacific'),
	(12,244,'US','CA','California'),
	(13,244,'US','CO','Colorado'),
	(14,244,'US','CT','Connecticut'),
	(15,244,'US','DE','Delaware'),
	(16,244,'US','DC','District of Columbia'),
	(17,244,'US','FM','Federated States Of Micronesia'),
	(18,244,'US','FL','Florida'),
	(19,244,'US','GA','Georgia'),
	(20,244,'US','GU','Guam'),
	(21,244,'US','HI','Hawaii'),
	(22,244,'US','ID','Idaho'),
	(23,244,'US','IL','Illinois'),
	(24,244,'US','IN','Indiana'),
	(25,244,'US','IA','Iowa'),
	(26,244,'US','KS','Kansas'),
	(27,244,'US','KY','Kentucky'),
	(28,244,'US','LA','Louisiana'),
	(29,244,'US','ME','Maine'),
	(30,244,'US','MH','Marshall Islands'),
	(31,244,'US','MD','Maryland'),
	(32,244,'US','MA','Massachusetts'),
	(33,244,'US','MI','Michigan'),
	(34,244,'US','MN','Minnesota'),
	(35,244,'US','MS','Mississippi'),
	(36,244,'US','MO','Missouri'),
	(37,244,'US','MT','Montana'),
	(38,244,'US','NE','Nebraska'),
	(39,244,'US','NV','Nevada'),
	(40,244,'US','NH','New Hampshire'),
	(41,244,'US','NJ','New Jersey'),
	(42,244,'US','NM','New Mexico'),
	(43,244,'US','NY','New York'),
	(44,244,'US','NC','North Carolina'),
	(45,244,'US','ND','North Dakota'),
	(46,244,'US','MP','Northern Mariana Islands'),
	(47,244,'US','OH','Ohio'),
	(48,244,'US','OK','Oklahoma'),
	(49,244,'US','OR','Oregon'),
	(50,244,'US','PW','Palau'),
	(51,244,'US','PA','Pennsylvania'),
	(52,244,'US','PR','Puerto Rico'),
	(53,244,'US','RI','Rhode Island'),
	(54,244,'US','SC','South Carolina'),
	(55,244,'US','SD','South Dakota'),
	(56,244,'US','TN','Tennessee'),
	(57,244,'US','TX','Texas'),
	(58,244,'US','UT','Utah'),
	(59,244,'US','VT','Vermont'),
	(60,244,'US','VI','Virgin Islands'),
	(61,244,'US','VA','Virginia'),
	(62,244,'US','WA','Washington'),
	(63,244,'US','WV','West Virginia'),
	(64,244,'US','WI','Wisconsin'),
	(65,244,'US','WY','Wyoming'),
	(66,40,'CA','AB','Alberta'),
	(67,40,'CA','BC','British Columbia'),
	(68,40,'CA','MB','Manitoba'),
	(69,40,'CA','NL','Newfoundland and Labrador'),
	(70,40,'CA','NB','New Brunswick'),
	(71,40,'CA','NS','Nova Scotia'),
	(72,40,'CA','NT','Northwest Territories'),
	(73,40,'CA','NU','Nunavut'),
	(74,40,'CA','ON','Ontario'),
	(75,40,'CA','PE','Prince Edward Island'),
	(76,40,'CA','QC','Quebec'),
	(77,40,'CA','SK','Saskatchewan'),
	(78,40,'CA','YT','Yukon Territory'),
	(79,88,'DE','NDS','Niedersachsen'),
	(80,88,'DE','BAW','Baden-Württemberg'),
	(81,88,'DE','BAY','Bayern'),
	(82,88,'DE','BER','Berlin'),
	(83,88,'DE','BRG','Brandenburg'),
	(84,88,'DE','BRE','Bremen'),
	(85,88,'DE','HAM','Hamburg'),
	(86,88,'DE','HES','Hessen'),
	(87,88,'DE','MEC','Mecklenburg-Vorpommern'),
	(88,88,'DE','NRW','Nordrhein-Westfalen'),
	(89,88,'DE','RHE','Rheinland-Pfalz'),
	(90,88,'DE','SAR','Saarland'),
	(91,88,'DE','SAS','Sachsen'),
	(92,88,'DE','SAC','Sachsen-Anhalt'),
	(93,88,'DE','SCN','Schleswig-Holstein'),
	(94,88,'DE','THE','Thüringen'),
	(95,16,'AT','WI','Wien'),
	(96,16,'AT','NO','Niederösterreich'),
	(97,16,'AT','OO','Oberösterreich'),
	(98,16,'AT','SB','Salzburg'),
	(99,16,'AT','KN','Kärnten'),
	(100,16,'AT','ST','Steiermark'),
	(101,16,'AT','TI','Tirol'),
	(102,16,'AT','BL','Burgenland'),
	(103,16,'AT','VB','Vorarlberg'),
	(104,220,'CH','AG','Aargau'),
	(105,220,'CH','AI','Appenzell Innerrhoden'),
	(106,220,'CH','AR','Appenzell Ausserrhoden'),
	(107,220,'CH','BE','Bern'),
	(108,220,'CH','BL','Basel-Landschaft'),
	(109,220,'CH','BS','Basel-Stadt'),
	(110,220,'CH','FR','Freiburg'),
	(111,220,'CH','GE','Genf'),
	(112,220,'CH','GL','Glarus'),
	(113,220,'CH','GR','Graubünden'),
	(114,220,'CH','JU','Jura'),
	(115,220,'CH','LU','Luzern'),
	(116,220,'CH','NE','Neuenburg'),
	(117,220,'CH','NW','Nidwalden'),
	(118,220,'CH','OW','Obwalden'),
	(119,220,'CH','SG','St. Gallen'),
	(120,220,'CH','SH','Schaffhausen'),
	(121,220,'CH','SO','Solothurn'),
	(122,220,'CH','SZ','Schwyz'),
	(123,220,'CH','TG','Thurgau'),
	(124,220,'CH','TI','Tessin'),
	(125,220,'CH','UR','Uri'),
	(126,220,'CH','VD','Waadt'),
	(127,220,'CH','VS','Wallis'),
	(128,220,'CH','ZG','Zug'),
	(129,220,'CH','ZH','Zürich'),
	(130,206,'ES','A Coruсa','A Coruña'),
	(131,206,'ES','Alava','Alava'),
	(132,206,'ES','Albacete','Albacete'),
	(133,206,'ES','Alicante','Alicante'),
	(134,206,'ES','Almeria','Almeria'),
	(135,206,'ES','Asturias','Asturias'),
	(136,206,'ES','Avila','Avila'),
	(137,206,'ES','Badajoz','Badajoz'),
	(138,206,'ES','Baleares','Baleares'),
	(139,206,'ES','Barcelona','Barcelona'),
	(140,206,'ES','Burgos','Burgos'),
	(141,206,'ES','Caceres','Caceres'),
	(142,206,'ES','Cadiz','Cadiz'),
	(143,206,'ES','Cantabria','Cantabria'),
	(144,206,'ES','Castellon','Castellon'),
	(145,206,'ES','Ceuta','Ceuta'),
	(146,206,'ES','Ciudad Real','Ciudad Real'),
	(147,206,'ES','Cordoba','Cordoba'),
	(148,206,'ES','Cuenca','Cuenca'),
	(149,206,'ES','Girona','Girona'),
	(150,206,'ES','Granada','Granada'),
	(151,206,'ES','Guadalajara','Guadalajara'),
	(152,206,'ES','Guipuzcoa','Guipuzcoa'),
	(153,206,'ES','Huelva','Huelva'),
	(154,206,'ES','Huesca','Huesca'),
	(155,206,'ES','Jaen','Jaen'),
	(156,206,'ES','La Rioja','La Rioja'),
	(157,206,'ES','Las Palmas','Las Palmas'),
	(158,206,'ES','Leon','Leon'),
	(159,206,'ES','Lleida','Lleida'),
	(160,206,'ES','Lugo','Lugo'),
	(161,206,'ES','Madrid','Madrid'),
	(162,206,'ES','Malaga','Malaga'),
	(163,206,'ES','Melilla','Melilla'),
	(164,206,'ES','Murcia','Murcia'),
	(165,206,'ES','Navarra','Navarra'),
	(166,206,'ES','Ourense','Ourense'),
	(167,206,'ES','Palencia','Palencia'),
	(168,206,'ES','Pontevedra','Pontevedra'),
	(169,206,'ES','Salamanca','Salamanca'),
	(170,206,'ES','Santa Cruz de Tenerife','Santa Cruz de Tenerife'),
	(171,206,'ES','Segovia','Segovia'),
	(172,206,'ES','Sevilla','Sevilla'),
	(173,206,'ES','Soria','Soria'),
	(174,206,'ES','Tarragona','Tarragona'),
	(175,206,'ES','Teruel','Teruel'),
	(176,206,'ES','Toledo','Toledo'),
	(177,206,'ES','Valencia','Valencia'),
	(178,206,'ES','Valladolid','Valladolid'),
	(179,206,'ES','Vizcaya','Vizcaya'),
	(180,206,'ES','Zamora','Zamora'),
	(181,206,'ES','Zaragoza','Zaragoza'),
	(182,81,'FR','1','Ain'),
	(183,81,'FR','2','Aisne'),
	(184,81,'FR','3','Allier'),
	(185,81,'FR','4','Alpes-de-Haute-Provence'),
	(186,81,'FR','5','Hautes-Alpes'),
	(187,81,'FR','6','Alpes-Maritimes'),
	(188,81,'FR','7','Ardèche'),
	(189,81,'FR','8','Ardennes'),
	(190,81,'FR','9','Ariège'),
	(191,81,'FR','10','Aube'),
	(192,81,'FR','11','Aude'),
	(193,81,'FR','12','Aveyron'),
	(194,81,'FR','13','Bouches-du-Rhône'),
	(195,81,'FR','14','Calvados'),
	(196,81,'FR','15','Cantal'),
	(197,81,'FR','16','Charente'),
	(198,81,'FR','17','Charente-Maritime'),
	(199,81,'FR','18','Cher'),
	(200,81,'FR','19','Corrèze'),
	(201,81,'FR','2A','Corse-du-Sud'),
	(202,81,'FR','2B','Haute-Corse'),
	(203,81,'FR','21','Côte-d\'Or'),
	(204,81,'FR','22','Côtes-d\'Armor'),
	(205,81,'FR','23','Creuse'),
	(206,81,'FR','24','Dordogne'),
	(207,81,'FR','25','Doubs'),
	(208,81,'FR','26','Drôme'),
	(209,81,'FR','27','Eure'),
	(210,81,'FR','28','Eure-et-Loir'),
	(211,81,'FR','29','Finistère'),
	(212,81,'FR','30','Gard'),
	(213,81,'FR','31','Haute-Garonne'),
	(214,81,'FR','32','Gers'),
	(215,81,'FR','33','Gironde'),
	(216,81,'FR','34','Hérault'),
	(217,81,'FR','35','Ille-et-Vilaine'),
	(218,81,'FR','36','Indre'),
	(219,81,'FR','37','Indre-et-Loire'),
	(220,81,'FR','38','Isère'),
	(221,81,'FR','39','Jura'),
	(222,81,'FR','40','Landes'),
	(223,81,'FR','41','Loir-et-Cher'),
	(224,81,'FR','42','Loire'),
	(225,81,'FR','43','Haute-Loire'),
	(226,81,'FR','44','Loire-Atlantique'),
	(227,81,'FR','45','Loiret'),
	(228,81,'FR','46','Lot'),
	(229,81,'FR','47','Lot-et-Garonne'),
	(230,81,'FR','48','Lozère'),
	(231,81,'FR','49','Maine-et-Loire'),
	(232,81,'FR','50','Manche'),
	(233,81,'FR','51','Marne'),
	(234,81,'FR','52','Haute-Marne'),
	(235,81,'FR','53','Mayenne'),
	(236,81,'FR','54','Meurthe-et-Moselle'),
	(237,81,'FR','55','Meuse'),
	(238,81,'FR','56','Morbihan'),
	(239,81,'FR','57','Moselle'),
	(240,81,'FR','58','Nièvre'),
	(241,81,'FR','59','Nord'),
	(242,81,'FR','60','Oise'),
	(243,81,'FR','61','Orne'),
	(244,81,'FR','62','Pas-de-Calais'),
	(245,81,'FR','63','Puy-de-Dôme'),
	(246,81,'FR','64','Pyrénées-Atlantiques'),
	(247,81,'FR','65','Hautes-Pyrénées'),
	(248,81,'FR','66','Pyrénées-Orientales'),
	(249,81,'FR','67','Bas-Rhin'),
	(250,81,'FR','68','Haut-Rhin'),
	(251,81,'FR','69','Rhône'),
	(252,81,'FR','70','Haute-Saône'),
	(253,81,'FR','71','Saône-et-Loire'),
	(254,81,'FR','72','Sarthe'),
	(255,81,'FR','73','Savoie'),
	(256,81,'FR','74','Haute-Savoie'),
	(257,81,'FR','75','Paris'),
	(258,81,'FR','76','Seine-Maritime'),
	(259,81,'FR','77','Seine-et-Marne'),
	(260,81,'FR','78','Yvelines'),
	(261,81,'FR','79','Deux-Sèvres'),
	(262,81,'FR','80','Somme'),
	(263,81,'FR','81','Tarn'),
	(264,81,'FR','82','Tarn-et-Garonne'),
	(265,81,'FR','83','Var'),
	(266,81,'FR','84','Vaucluse'),
	(267,81,'FR','85','Vendée'),
	(268,81,'FR','86','Vienne'),
	(269,81,'FR','87','Haute-Vienne'),
	(270,81,'FR','88','Vosges'),
	(271,81,'FR','89','Yonne'),
	(272,81,'FR','90','Territoire-de-Belfort'),
	(273,81,'FR','91','Essonne'),
	(274,81,'FR','92','Hauts-de-Seine'),
	(275,81,'FR','93','Seine-Saint-Denis'),
	(276,81,'FR','94','Val-de-Marne'),
	(277,81,'FR','95','Val-d\'Oise'),
	(278,185,'RO','AB','Alba'),
	(279,185,'RO','AR','Arad'),
	(280,185,'RO','AG','Argeş'),
	(281,185,'RO','BC','Bacău'),
	(282,185,'RO','BH','Bihor'),
	(283,185,'RO','BN','Bistriţa-Năsăud'),
	(284,185,'RO','BT','Botoşani'),
	(285,185,'RO','BV','Braşov'),
	(286,185,'RO','BR','Brăila'),
	(287,185,'RO','B','Bucureşti'),
	(288,185,'RO','BZ','Buzău'),
	(289,185,'RO','CS','Caraş-Severin'),
	(290,185,'RO','CL','Călăraşi'),
	(291,185,'RO','CJ','Cluj'),
	(292,185,'RO','CT','Constanţa'),
	(293,185,'RO','CV','Covasna'),
	(294,185,'RO','DB','Dâmboviţa'),
	(295,185,'RO','DJ','Dolj'),
	(296,185,'RO','GL','Galaţi'),
	(297,185,'RO','GR','Giurgiu'),
	(298,185,'RO','GJ','Gorj'),
	(299,185,'RO','HR','Harghita'),
	(300,185,'RO','HD','Hunedoara'),
	(301,185,'RO','IL','Ialomiţa'),
	(302,185,'RO','IS','Iaşi'),
	(303,185,'RO','IF','Ilfov'),
	(304,185,'RO','MM','Maramureş'),
	(305,185,'RO','MH','Mehedinţi'),
	(306,185,'RO','MS','Mureş'),
	(307,185,'RO','NT','Neamţ'),
	(308,185,'RO','OT','Olt'),
	(309,185,'RO','PH','Prahova'),
	(310,185,'RO','SM','Satu-Mare'),
	(311,185,'RO','SJ','Sălaj'),
	(312,185,'RO','SB','Sibiu'),
	(313,185,'RO','SV','Suceava'),
	(314,185,'RO','TR','Teleorman'),
	(315,185,'RO','TM','Timiş'),
	(316,185,'RO','TL','Tulcea'),
	(317,185,'RO','VS','Vaslui'),
	(318,185,'RO','VL','Vâlcea'),
	(319,185,'RO','VN','Vrancea'),
	(320,80,'FI','Lappi','Lappi'),
	(321,80,'FI','Pohjois-Pohjanmaa','Pohjois-Pohjanmaa'),
	(322,80,'FI','Kainuu','Kainuu'),
	(323,80,'FI','Pohjois-Karjala','Pohjois-Karjala'),
	(324,80,'FI','Pohjois-Savo','Pohjois-Savo'),
	(325,80,'FI','Etelä-Savo','Etelä-Savo'),
	(326,80,'FI','Etelä-Pohjanmaa','Etelä-Pohjanmaa'),
	(327,80,'FI','Pohjanmaa','Pohjanmaa'),
	(328,80,'FI','Pirkanmaa','Pirkanmaa'),
	(329,80,'FI','Satakunta','Satakunta'),
	(330,80,'FI','Keski-Pohjanmaa','Keski-Pohjanmaa'),
	(331,80,'FI','Keski-Suomi','Keski-Suomi'),
	(332,80,'FI','Varsinais-Suomi','Varsinais-Suomi'),
	(333,80,'FI','Etelä-Karjala','Etelä-Karjala'),
	(334,80,'FI','Päijät-Häme','Päijät-Häme'),
	(335,80,'FI','Kanta-Häme','Kanta-Häme'),
	(336,80,'FI','Uusimaa','Uusimaa'),
	(337,80,'FI','Itä-Uusimaa','Itä-Uusimaa'),
	(338,80,'FI','Kymenlaakso','Kymenlaakso'),
	(339,80,'FI','Ahvenanmaa','Ahvenanmaa'),
	(340,74,'EE','EE-37','Harjumaa'),
	(341,74,'EE','EE-39','Hiiumaa'),
	(342,74,'EE','EE-44','Ida-Virumaa'),
	(343,74,'EE','EE-49','Jõgevamaa'),
	(344,74,'EE','EE-51','Järvamaa'),
	(345,74,'EE','EE-57','Läänemaa'),
	(346,74,'EE','EE-59','Lääne-Virumaa'),
	(347,74,'EE','EE-65','Põlvamaa'),
	(348,74,'EE','EE-67','Pärnumaa'),
	(349,74,'EE','EE-70','Raplamaa'),
	(350,74,'EE','EE-74','Saaremaa'),
	(351,74,'EE','EE-78','Tartumaa'),
	(352,74,'EE','EE-82','Valgamaa'),
	(353,74,'EE','EE-84','Viljandimaa'),
	(354,74,'EE','EE-86','Võrumaa'),
	(355,125,'LV','LV-DGV','Daugavpils'),
	(356,125,'LV','LV-JEL','Jelgava'),
	(357,125,'LV','Jēkabpils','Jēkabpils'),
	(358,125,'LV','LV-JUR','Jūrmala'),
	(359,125,'LV','LV-LPX','Liepāja'),
	(360,125,'LV','LV-LE','Liepājas novads'),
	(361,125,'LV','LV-REZ','Rēzekne'),
	(362,125,'LV','LV-RIX','Rīga'),
	(363,125,'LV','LV-RI','Rīgas novads'),
	(364,125,'LV','Valmiera','Valmiera'),
	(365,125,'LV','LV-VEN','Ventspils'),
	(366,125,'LV','Aglonas novads','Aglonas novads'),
	(367,125,'LV','LV-AI','Aizkraukles novads'),
	(368,125,'LV','Aizputes novads','Aizputes novads'),
	(369,125,'LV','Aknīstes novads','Aknīstes novads'),
	(370,125,'LV','Alojas novads','Alojas novads'),
	(371,125,'LV','Alsungas novads','Alsungas novads'),
	(372,125,'LV','LV-AL','Alūksnes novads'),
	(373,125,'LV','Amatas novads','Amatas novads'),
	(374,125,'LV','Apes novads','Apes novads'),
	(375,125,'LV','Auces novads','Auces novads'),
	(376,125,'LV','Babītes novads','Babītes novads'),
	(377,125,'LV','Baldones novads','Baldones novads'),
	(378,125,'LV','Baltinavas novads','Baltinavas novads'),
	(379,125,'LV','LV-BL','Balvu novads'),
	(380,125,'LV','LV-BU','Bauskas novads'),
	(381,125,'LV','Beverīnas novads','Beverīnas novads'),
	(382,125,'LV','Brocēnu novads','Brocēnu novads'),
	(383,125,'LV','Burtnieku novads','Burtnieku novads'),
	(384,125,'LV','Carnikavas novads','Carnikavas novads'),
	(385,125,'LV','Cesvaines novads','Cesvaines novads'),
	(386,125,'LV','Ciblas novads','Ciblas novads'),
	(387,125,'LV','LV-CE','Cēsu novads'),
	(388,125,'LV','Dagdas novads','Dagdas novads'),
	(389,125,'LV','LV-DA','Daugavpils novads'),
	(390,125,'LV','LV-DO','Dobeles novads'),
	(391,125,'LV','Dundagas novads','Dundagas novads'),
	(392,125,'LV','Durbes novads','Durbes novads'),
	(393,125,'LV','Engures novads','Engures novads'),
	(394,125,'LV','Garkalnes novads','Garkalnes novads'),
	(395,125,'LV','Grobiņas novads','Grobiņas novads'),
	(396,125,'LV','LV-GU','Gulbenes novads'),
	(397,125,'LV','Iecavas novads','Iecavas novads'),
	(398,125,'LV','Ikšķiles novads','Ikšķiles novads'),
	(399,125,'LV','Ilūkstes novads','Ilūkstes novads'),
	(400,125,'LV','Inčukalna novads','Inčukalna novads'),
	(401,125,'LV','Jaunjelgavas novads','Jaunjelgavas novads'),
	(402,125,'LV','Jaunpiebalgas novads','Jaunpiebalgas novads'),
	(403,125,'LV','Jaunpils novads','Jaunpils novads'),
	(404,125,'LV','LV-JL','Jelgavas novads'),
	(405,125,'LV','LV-JK','Jēkabpils novads'),
	(406,125,'LV','Kandavas novads','Kandavas novads'),
	(407,125,'LV','Kokneses novads','Kokneses novads'),
	(408,125,'LV','Krimuldas novads','Krimuldas novads'),
	(409,125,'LV','Krustpils novads','Krustpils novads'),
	(410,125,'LV','LV-KR','Krāslavas novads'),
	(411,125,'LV','LV-KU','Kuldīgas novads'),
	(412,125,'LV','Kārsavas novads','Kārsavas novads'),
	(413,125,'LV','Lielvārdes novads','Lielvārdes novads'),
	(414,125,'LV','LV-LM','Limbažu novads'),
	(415,125,'LV','Lubānas novads','Lubānas novads'),
	(416,125,'LV','LV-LU','Ludzas novads'),
	(417,125,'LV','Līgatnes novads','Līgatnes novads'),
	(418,125,'LV','Līvānu novads','Līvānu novads'),
	(419,125,'LV','LV-MA','Madonas novads'),
	(420,125,'LV','Mazsalacas novads','Mazsalacas novads'),
	(421,125,'LV','Mālpils novads','Mālpils novads'),
	(422,125,'LV','Mārupes novads','Mārupes novads'),
	(423,125,'LV','Naukšēnu novads','Naukšēnu novads'),
	(424,125,'LV','Neretas novads','Neretas novads'),
	(425,125,'LV','Nīcas novads','Nīcas novads'),
	(426,125,'LV','LV-OG','Ogres novads'),
	(427,125,'LV','Olaines novads','Olaines novads'),
	(428,125,'LV','Ozolnieku novads','Ozolnieku novads'),
	(429,125,'LV','LV-PR','Preiļu novads'),
	(430,125,'LV','Priekules novads','Priekules novads'),
	(431,125,'LV','Priekuļu novads','Priekuļu novads'),
	(432,125,'LV','Pārgaujas novads','Pārgaujas novads'),
	(433,125,'LV','Pāvilostas novads','Pāvilostas novads'),
	(434,125,'LV','Pļaviņu novads','Pļaviņu novads'),
	(435,125,'LV','Raunas novads','Raunas novads'),
	(436,125,'LV','Riebiņu novads','Riebiņu novads'),
	(437,125,'LV','Rojas novads','Rojas novads'),
	(438,125,'LV','Ropažu novads','Ropažu novads'),
	(439,125,'LV','Rucavas novads','Rucavas novads'),
	(440,125,'LV','Rugāju novads','Rugāju novads'),
	(441,125,'LV','Rundāles novads','Rundāles novads'),
	(442,125,'LV','LV-RE','Rēzeknes novads'),
	(443,125,'LV','Rūjienas novads','Rūjienas novads'),
	(444,125,'LV','Salacgrīvas novads','Salacgrīvas novads'),
	(445,125,'LV','Salas novads','Salas novads'),
	(446,125,'LV','Salaspils novads','Salaspils novads'),
	(447,125,'LV','LV-SA','Saldus novads'),
	(448,125,'LV','Saulkrastu novads','Saulkrastu novads'),
	(449,125,'LV','Siguldas novads','Siguldas novads'),
	(450,125,'LV','Skrundas novads','Skrundas novads'),
	(451,125,'LV','Skrīveru novads','Skrīveru novads'),
	(452,125,'LV','Smiltenes novads','Smiltenes novads'),
	(453,125,'LV','Stopiņu novads','Stopiņu novads'),
	(454,125,'LV','Strenču novads','Strenču novads'),
	(455,125,'LV','Sējas novads','Sējas novads'),
	(456,125,'LV','LV-TA','Talsu novads'),
	(457,125,'LV','LV-TU','Tukuma novads'),
	(458,125,'LV','Tērvetes novads','Tērvetes novads'),
	(459,125,'LV','Vaiņodes novads','Vaiņodes novads'),
	(460,125,'LV','LV-VK','Valkas novads'),
	(461,125,'LV','LV-VM','Valmieras novads'),
	(462,125,'LV','Varakļānu novads','Varakļānu novads'),
	(463,125,'LV','Vecpiebalgas novads','Vecpiebalgas novads'),
	(464,125,'LV','Vecumnieku novads','Vecumnieku novads'),
	(465,125,'LV','LV-VE','Ventspils novads'),
	(466,125,'LV','Viesītes novads','Viesītes novads'),
	(467,125,'LV','Viļakas novads','Viļakas novads'),
	(468,125,'LV','Viļānu novads','Viļānu novads'),
	(469,125,'LV','Vārkavas novads','Vārkavas novads'),
	(470,125,'LV','Zilupes novads','Zilupes novads'),
	(471,125,'LV','Ādažu novads','Ādažu novads'),
	(472,125,'LV','Ērgļu novads','Ērgļu novads'),
	(473,125,'LV','Ķeguma novads','Ķeguma novads'),
	(474,125,'LV','Ķekavas novads','Ķekavas novads'),
	(475,131,'LT','LT-AL','Alytaus Apskritis'),
	(476,131,'LT','LT-KU','Kauno Apskritis'),
	(477,131,'LT','LT-KL','Klaipėdos Apskritis'),
	(478,131,'LT','LT-MR','Marijampolės Apskritis'),
	(479,131,'LT','LT-PN','Panevėžio Apskritis'),
	(480,131,'LT','LT-SA','Šiaulių Apskritis'),
	(481,131,'LT','LT-TA','Tauragės Apskritis'),
	(482,131,'LT','LT-TE','Telšių Apskritis'),
	(483,131,'LT','LT-UT','Utenos Apskritis'),
	(484,131,'LT','LT-VL','Vilniaus Apskritis'),
	(485,31,'BR','AC','Acre'),
	(486,31,'BR','AL','Alagoas'),
	(487,31,'BR','AP','Amapá'),
	(488,31,'BR','AM','Amazonas'),
	(489,31,'BR','BA','Bahia'),
	(490,31,'BR','CE','Ceará'),
	(491,31,'BR','ES','Espírito Santo'),
	(492,31,'BR','GO','Goiás'),
	(493,31,'BR','MA','Maranhão'),
	(494,31,'BR','MT','Mato Grosso'),
	(495,31,'BR','MS','Mato Grosso do Sul'),
	(496,31,'BR','MG','Minas Gerais'),
	(497,31,'BR','PA','Pará'),
	(498,31,'BR','PB','Paraíba'),
	(499,31,'BR','PR','Paraná'),
	(500,31,'BR','PE','Pernambuco'),
	(501,31,'BR','PI','Piauí'),
	(502,31,'BR','RJ','Rio de Janeiro'),
	(503,31,'BR','RN','Rio Grande do Norte'),
	(504,31,'BR','RS','Rio Grande do Sul'),
	(505,31,'BR','RO','Rondônia'),
	(506,31,'BR','RR','Roraima'),
	(507,31,'BR','SC','Santa Catarina'),
	(508,31,'BR','SP','São Paulo'),
	(509,31,'BR','SE','Sergipe'),
	(510,31,'BR','TO','Tocantins'),
	(511,31,'BR','DF','Distrito Federal'),
	(512,59,'HR','HR-01','Zagrebačka županija'),
	(513,59,'HR','HR-02','Krapinsko-zagorska županija'),
	(514,59,'HR','HR-03','Sisačko-moslavačka županija'),
	(515,59,'HR','HR-04','Karlovačka županija'),
	(516,59,'HR','HR-05','Varaždinska županija'),
	(517,59,'HR','HR-06','Koprivničko-križevačka županija'),
	(518,59,'HR','HR-07','Bjelovarsko-bilogorska županija'),
	(519,59,'HR','HR-08','Primorsko-goranska županija'),
	(520,59,'HR','HR-09','Ličko-senjska županija'),
	(521,59,'HR','HR-10','Virovitičko-podravska županija'),
	(522,59,'HR','HR-11','Požeško-slavonska županija'),
	(523,59,'HR','HR-12','Brodsko-posavska županija'),
	(524,59,'HR','HR-13','Zadarska županija'),
	(525,59,'HR','HR-14','Osječko-baranjska županija'),
	(526,59,'HR','HR-15','Šibensko-kninska županija'),
	(527,59,'HR','HR-16','Vukovarsko-srijemska županija'),
	(528,59,'HR','HR-17','Splitsko-dalmatinska županija'),
	(529,59,'HR','HR-18','Istarska županija'),
	(530,59,'HR','HR-19','Dubrovačko-neretvanska županija'),
	(531,59,'HR','HR-20','Međimurska županija'),
	(532,59,'HR','HR-21','Grad Zagreb'),
	(533,106,'IN','AN','Andaman and Nicobar Islands'),
	(534,106,'IN','AP','Andhra Pradesh'),
	(535,106,'IN','AR','Arunachal Pradesh'),
	(536,106,'IN','AS','Assam'),
	(537,106,'IN','BR','Bihar'),
	(538,106,'IN','CH','Chandigarh'),
	(539,106,'IN','CT','Chhattisgarh'),
	(540,106,'IN','DN','Dadra and Nagar Haveli'),
	(541,106,'IN','DD','Daman and Diu'),
	(542,106,'IN','DL','Delhi'),
	(543,106,'IN','GA','Goa'),
	(544,106,'IN','GJ','Gujarat'),
	(545,106,'IN','HR','Haryana'),
	(546,106,'IN','HP','Himachal Pradesh'),
	(547,106,'IN','JK','Jammu and Kashmir'),
	(548,106,'IN','JH','Jharkhand'),
	(549,106,'IN','KA','Karnataka'),
	(550,106,'IN','KL','Kerala'),
	(551,106,'IN','LD','Lakshadweep'),
	(552,106,'IN','MP','Madhya Pradesh'),
	(553,106,'IN','MH','Maharashtra'),
	(554,106,'IN','MN','Manipur'),
	(555,106,'IN','ML','Meghalaya'),
	(556,106,'IN','MZ','Mizoram'),
	(557,106,'IN','NL','Nagaland'),
	(558,106,'IN','OR','Odisha'),
	(559,106,'IN','PY','Puducherry'),
	(560,106,'IN','PB','Punjab'),
	(561,106,'IN','RJ','Rajasthan'),
	(562,106,'IN','SK','Sikkim'),
	(563,106,'IN','TN','Tamil Nadu'),
	(564,106,'IN','TG','Telangana'),
	(565,106,'IN','TR','Tripura'),
	(566,106,'IN','UP','Uttar Pradesh'),
	(567,106,'IN','UT','Uttarakhand'),
	(568,106,'IN','WB','West Bengal'),
	(569,176,'PY','PY-16','Alto Paraguay'),
	(570,176,'PY','PY-10','Alto Paraná'),
	(571,176,'PY','PY-13','Amambay'),
	(572,176,'PY','PY-ASU','Asunción'),
	(573,176,'PY','PY-19','Boquerón'),
	(574,176,'PY','PY-5','Caaguazú'),
	(575,176,'PY','PY-6','Caazapá'),
	(576,176,'PY','PY-14','Canindeyú'),
	(577,176,'PY','PY-11','Central'),
	(578,176,'PY','PY-1','Concepción'),
	(579,176,'PY','PY-3','Cordillera'),
	(580,176,'PY','PY-4','Guairá'),
	(581,176,'PY','PY-7','Itapúa'),
	(582,176,'PY','PY-8','Misiones'),
	(583,176,'PY','PY-9','Paraguarí'),
	(584,176,'PY','PY-15','Presidente Hayes'),
	(585,176,'PY','PY-2','San Pedro'),
	(586,176,'PY','PY-12','Ñeembucú');

/*!40000 ALTER TABLE `country_states` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table country_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `country_translations`;

CREATE TABLE `country_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int unsigned NOT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `country_translations_country_id_foreign` (`country_id`),
  CONSTRAINT `country_translations_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table currencies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `currencies`;

CREATE TABLE `currencies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimal` int unsigned NOT NULL DEFAULT '2',
  `group_separator` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ',',
  `decimal_separator` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '.',
  `currency_position` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;

INSERT INTO `currencies` (`id`, `code`, `name`, `symbol`, `decimal`, `group_separator`, `decimal_separator`, `currency_position`, `created_at`, `updated_at`)
VALUES
	(1,'COP','Peso Colombiano','$',2,',','.',NULL,NULL,NULL);

/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table currency_exchange_rates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `currency_exchange_rates`;

CREATE TABLE `currency_exchange_rates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `rate` decimal(24,12) NOT NULL,
  `target_currency` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currency_exchange_rates_target_currency_unique` (`target_currency`),
  CONSTRAINT `currency_exchange_rates_target_currency_foreign` FOREIGN KEY (`target_currency`) REFERENCES `currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table customer_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_groups`;

CREATE TABLE `customer_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_groups_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `customer_groups` WRITE;
/*!40000 ALTER TABLE `customer_groups` DISABLE KEYS */;

INSERT INTO `customer_groups` (`id`, `code`, `name`, `is_user_defined`, `created_at`, `updated_at`)
VALUES
	(1,'guest','Invitado',0,NULL,NULL),
	(2,'general','General',0,NULL,NULL),
	(3,'wholesale','Mayorista',0,NULL,NULL);

/*!40000 ALTER TABLE `customer_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table customer_notes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_notes`;

CREATE TABLE `customer_notes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int unsigned DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_notified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_notes_customer_id_foreign` (`customer_id`),
  CONSTRAINT `customer_notes_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table customer_password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_password_resets`;

CREATE TABLE `customer_password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `customer_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table customer_social_accounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_social_accounts`;

CREATE TABLE `customer_social_accounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int unsigned NOT NULL,
  `provider_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_social_accounts_provider_id_unique` (`provider_id`),
  KEY `customer_social_accounts_customer_id_foreign` (`customer_id`),
  CONSTRAINT `customer_social_accounts_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table customers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_token` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_group_id` int unsigned DEFAULT NULL,
  `channel_id` int unsigned DEFAULT NULL,
  `subscribed_to_news_letter` tinyint(1) NOT NULL DEFAULT '0',
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `is_suspended` tinyint unsigned NOT NULL DEFAULT '0',
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_email_unique` (`email`),
  UNIQUE KEY `customers_phone_unique` (`phone`),
  UNIQUE KEY `customers_api_token_unique` (`api_token`),
  KEY `customers_customer_group_id_foreign` (`customer_group_id`),
  KEY `customers_channel_id_foreign` (`channel_id`),
  CONSTRAINT `customers_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `customers_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;

INSERT INTO `customers` (`id`, `first_name`, `last_name`, `gender`, `date_of_birth`, `email`, `phone`, `image`, `status`, `password`, `api_token`, `customer_group_id`, `channel_id`, `subscribed_to_news_letter`, `is_verified`, `is_suspended`, `token`, `remember_token`, `created_at`, `updated_at`)
VALUES
	(2,'Oscar Manuel','Aguillon Silva','Male',NULL,'aguillonsilva@gmail.com','3108593676','customer/2/C1EUgPw6yKfDbyNO7GVvesdlZDrFCYyxqxGVNgnF.jpg',1,'$2y$10$ivCGXjcC/OLmFRuXQVVXV.RUVMEec17oKkq5V6gUv97GYBW4kWclG','yG2tPd4A2JydXaym6efT2hiIoH1EEqW1Hap2uWQj7NZ06xKkypNvSlqIX9PnPE7AflerJ1fgxEtRNUQZ',1,1,0,1,0,'7cdd243be66872285dc057f2099827b8',NULL,'2024-10-02 17:10:16','2024-10-03 09:26:06');

/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table datagrid_saved_filters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `datagrid_saved_filters`;

CREATE TABLE `datagrid_saved_filters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `src` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datagrid_saved_filters_user_id_name_src_unique` (`user_id`,`name`,`src`),
  CONSTRAINT `datagrid_saved_filters_chk_1` CHECK (json_valid(`applied`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table downloadable_link_purchased
# ------------------------------------------------------------

DROP TABLE IF EXISTS `downloadable_link_purchased`;

CREATE TABLE `downloadable_link_purchased` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `download_bought` int NOT NULL DEFAULT '0',
  `download_used` int NOT NULL DEFAULT '0',
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` int unsigned NOT NULL,
  `order_id` int unsigned NOT NULL,
  `order_item_id` int unsigned NOT NULL,
  `download_canceled` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `downloadable_link_purchased_customer_id_foreign` (`customer_id`),
  KEY `downloadable_link_purchased_order_id_foreign` (`order_id`),
  KEY `downloadable_link_purchased_order_item_id_foreign` (`order_item_id`),
  CONSTRAINT `downloadable_link_purchased_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `downloadable_link_purchased_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `downloadable_link_purchased_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table failed_jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table import_batches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `import_batches`;

CREATE TABLE `import_batches` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `import_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `import_batches_import_id_foreign` (`import_id`),
  CONSTRAINT `import_batches_import_id_foreign` FOREIGN KEY (`import_id`) REFERENCES `imports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `import_batches_chk_1` CHECK (json_valid(`data`)),
  CONSTRAINT `import_batches_chk_2` CHECK (json_valid(`summary`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table imports
# ------------------------------------------------------------

DROP TABLE IF EXISTS `imports`;

CREATE TABLE `imports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `process_in_queue` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `validation_strategy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `allowed_errors` int NOT NULL DEFAULT '0',
  `processed_rows_count` int NOT NULL DEFAULT '0',
  `invalid_rows_count` int NOT NULL DEFAULT '0',
  `errors_count` int NOT NULL DEFAULT '0',
  `errors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `field_separator` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `images_directory_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_file_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `imports_chk_1` CHECK (json_valid(`errors`)),
  CONSTRAINT `imports_chk_2` CHECK (json_valid(`summary`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table inventory_sources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `inventory_sources`;

CREATE TABLE `inventory_sources` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `contact_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_fax` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `street` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `postcode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` int NOT NULL DEFAULT '0',
  `latitude` decimal(10,5) DEFAULT NULL,
  `longitude` decimal(10,5) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventory_sources_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `inventory_sources` WRITE;
/*!40000 ALTER TABLE `inventory_sources` DISABLE KEYS */;

INSERT INTO `inventory_sources` (`id`, `code`, `name`, `description`, `contact_name`, `contact_email`, `contact_number`, `contact_fax`, `country`, `state`, `city`, `street`, `postcode`, `priority`, `latitude`, `longitude`, `status`, `created_at`, `updated_at`)
VALUES
	(1,'default','Predeterminado','','Predeterminado','warehouse@example.com','1234567899','','CO','cundinamarca','Bogota','12th Street','48127',0,0.00000,0.00000,1,NULL,'2024-11-27 08:59:09');

/*!40000 ALTER TABLE `inventory_sources` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table invoice_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `invoice_items`;

CREATE TABLE `invoice_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int unsigned DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `tax_amount` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000',
  `discount_percent` decimal(12,4) DEFAULT '0.0000',
  `discount_amount` decimal(12,4) DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `product_id` int unsigned DEFAULT NULL,
  `product_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_item_id` int unsigned DEFAULT NULL,
  `invoice_id` int unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_items_invoice_id_foreign` (`invoice_id`),
  KEY `invoice_items_parent_id_foreign` (`parent_id`),
  CONSTRAINT `invoice_items_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `invoice_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_items_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table invoices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `invoices`;

CREATE TABLE `invoices` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT '0',
  `total_qty` int DEFAULT NULL,
  `base_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total` decimal(12,4) DEFAULT '0.0000',
  `base_sub_total` decimal(12,4) DEFAULT '0.0000',
  `grand_total` decimal(12,4) DEFAULT '0.0000',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000',
  `shipping_amount` decimal(12,4) DEFAULT '0.0000',
  `base_shipping_amount` decimal(12,4) DEFAULT '0.0000',
  `tax_amount` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000',
  `discount_amount` decimal(12,4) DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `order_id` int unsigned DEFAULT NULL,
  `transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reminders` int NOT NULL DEFAULT '0',
  `next_reminder_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_order_id_foreign` (`order_id`),
  CONSTRAINT `invoices_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table job_batches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_batches`;

CREATE TABLE `job_batches` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table locales
# ------------------------------------------------------------

DROP TABLE IF EXISTS `locales`;

CREATE TABLE `locales` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direction` enum('ltr','rtl') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ltr',
  `logo_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `locales_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `locales` WRITE;
/*!40000 ALTER TABLE `locales` DISABLE KEYS */;

INSERT INTO `locales` (`id`, `code`, `name`, `direction`, `logo_path`, `created_at`, `updated_at`)
VALUES
	(1,'es','Español','ltr','locales/irnur9e7Ut8WeUzBfaDrpcwIlqHCyKPg588bYub0.png',NULL,NULL);

/*!40000 ALTER TABLE `locales` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table marketing_campaigns
# ------------------------------------------------------------

DROP TABLE IF EXISTS `marketing_campaigns`;

CREATE TABLE `marketing_campaigns` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_to` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `spooling` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_id` int unsigned DEFAULT NULL,
  `customer_group_id` int unsigned DEFAULT NULL,
  `marketing_template_id` int unsigned DEFAULT NULL,
  `marketing_event_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `marketing_campaigns_channel_id_foreign` (`channel_id`),
  KEY `marketing_campaigns_customer_group_id_foreign` (`customer_group_id`),
  KEY `marketing_campaigns_marketing_template_id_foreign` (`marketing_template_id`),
  KEY `marketing_campaigns_marketing_event_id_foreign` (`marketing_event_id`),
  CONSTRAINT `marketing_campaigns_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `marketing_campaigns_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `marketing_campaigns_marketing_event_id_foreign` FOREIGN KEY (`marketing_event_id`) REFERENCES `marketing_events` (`id`) ON DELETE SET NULL,
  CONSTRAINT `marketing_campaigns_marketing_template_id_foreign` FOREIGN KEY (`marketing_template_id`) REFERENCES `marketing_templates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table marketing_events
# ------------------------------------------------------------

DROP TABLE IF EXISTS `marketing_events`;

CREATE TABLE `marketing_events` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `marketing_events` WRITE;
/*!40000 ALTER TABLE `marketing_events` DISABLE KEYS */;

INSERT INTO `marketing_events` (`id`, `name`, `description`, `date`, `created_at`, `updated_at`)
VALUES
	(1,'Birthday','Birthday',NULL,NULL,NULL);

/*!40000 ALTER TABLE `marketing_events` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table marketing_templates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `marketing_templates`;

CREATE TABLE `marketing_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `migration`, `batch`)
VALUES
	(1,'2014_10_12_000000_create_users_table',1),
	(2,'2014_10_12_100000_create_admin_password_resets_table',1),
	(3,'2014_10_12_100000_create_password_resets_table',1),
	(4,'2018_06_12_111907_create_admins_table',1),
	(5,'2018_06_13_055341_create_roles_table',1),
	(6,'2018_07_05_130148_create_attributes_table',1),
	(7,'2018_07_05_132854_create_attribute_translations_table',1),
	(8,'2018_07_05_135150_create_attribute_families_table',1),
	(9,'2018_07_05_135152_create_attribute_groups_table',1),
	(10,'2018_07_05_140832_create_attribute_options_table',1),
	(11,'2018_07_05_140856_create_attribute_option_translations_table',1),
	(12,'2018_07_05_142820_create_categories_table',1),
	(13,'2018_07_10_055143_create_locales_table',1),
	(14,'2018_07_20_054426_create_countries_table',1),
	(15,'2018_07_20_054502_create_currencies_table',1),
	(16,'2018_07_20_054542_create_currency_exchange_rates_table',1),
	(17,'2018_07_20_064849_create_channels_table',1),
	(18,'2018_07_21_142836_create_category_translations_table',1),
	(19,'2018_07_23_110040_create_inventory_sources_table',1),
	(20,'2018_07_24_082635_create_customer_groups_table',1),
	(21,'2018_07_24_082930_create_customers_table',1),
	(22,'2018_07_27_065727_create_products_table',1),
	(23,'2018_07_27_070011_create_product_attribute_values_table',1),
	(24,'2018_07_27_092623_create_product_reviews_table',1),
	(25,'2018_07_27_113941_create_product_images_table',1),
	(26,'2018_07_27_113956_create_product_inventories_table',1),
	(27,'2018_08_30_064755_create_tax_categories_table',1),
	(28,'2018_08_30_065042_create_tax_rates_table',1),
	(29,'2018_08_30_065840_create_tax_mappings_table',1),
	(30,'2018_09_05_150444_create_cart_table',1),
	(31,'2018_09_05_150915_create_cart_items_table',1),
	(32,'2018_09_11_064045_customer_password_resets',1),
	(33,'2018_09_19_093453_create_cart_payment',1),
	(34,'2018_09_19_093508_create_cart_shipping_rates_table',1),
	(35,'2018_09_20_060658_create_core_config_table',1),
	(36,'2018_09_27_113154_create_orders_table',1),
	(37,'2018_09_27_113207_create_order_items_table',1),
	(38,'2018_09_27_115022_create_shipments_table',1),
	(39,'2018_09_27_115029_create_shipment_items_table',1),
	(40,'2018_09_27_115135_create_invoices_table',1),
	(41,'2018_09_27_115144_create_invoice_items_table',1),
	(42,'2018_10_01_095504_create_order_payment_table',1),
	(43,'2018_10_03_025230_create_wishlist_table',1),
	(44,'2018_10_12_101803_create_country_translations_table',1),
	(45,'2018_10_12_101913_create_country_states_table',1),
	(46,'2018_10_12_101923_create_country_state_translations_table',1),
	(47,'2018_11_16_173504_create_subscribers_list_table',1),
	(48,'2018_11_21_144411_create_cart_item_inventories_table',1),
	(49,'2018_12_06_185202_create_product_flat_table',1),
	(50,'2018_12_24_123812_create_channel_inventory_sources_table',1),
	(51,'2018_12_26_165327_create_product_ordered_inventories_table',1),
	(52,'2019_05_13_024321_create_cart_rules_table',1),
	(53,'2019_05_13_024322_create_cart_rule_channels_table',1),
	(54,'2019_05_13_024323_create_cart_rule_customer_groups_table',1),
	(55,'2019_05_13_024324_create_cart_rule_translations_table',1),
	(56,'2019_05_13_024325_create_cart_rule_customers_table',1),
	(57,'2019_05_13_024326_create_cart_rule_coupons_table',1),
	(58,'2019_05_13_024327_create_cart_rule_coupon_usage_table',1),
	(59,'2019_06_17_180258_create_product_downloadable_samples_table',1),
	(60,'2019_06_17_180314_create_product_downloadable_sample_translations_table',1),
	(61,'2019_06_17_180325_create_product_downloadable_links_table',1),
	(62,'2019_06_17_180346_create_product_downloadable_link_translations_table',1),
	(63,'2019_06_21_202249_create_downloadable_link_purchased_table',1),
	(64,'2019_07_30_153530_create_cms_pages_table',1),
	(65,'2019_07_31_143339_create_category_filterable_attributes_table',1),
	(66,'2019_08_02_105320_create_product_grouped_products_table',1),
	(67,'2019_08_20_170510_create_product_bundle_options_table',1),
	(68,'2019_08_20_170520_create_product_bundle_option_translations_table',1),
	(69,'2019_08_20_170528_create_product_bundle_option_products_table',1),
	(70,'2019_09_11_184511_create_refunds_table',1),
	(71,'2019_09_11_184519_create_refund_items_table',1),
	(72,'2019_12_03_184613_create_catalog_rules_table',1),
	(73,'2019_12_03_184651_create_catalog_rule_channels_table',1),
	(74,'2019_12_03_184732_create_catalog_rule_customer_groups_table',1),
	(75,'2019_12_06_101110_create_catalog_rule_products_table',1),
	(76,'2019_12_06_110507_create_catalog_rule_product_prices_table',1),
	(77,'2019_12_14_000001_create_personal_access_tokens_table',1),
	(78,'2020_01_14_191854_create_cms_page_translations_table',1),
	(79,'2020_01_15_130209_create_cms_page_channels_table',1),
	(80,'2020_04_16_185147_add_table_addresses',1),
	(81,'2020_05_06_171638_create_order_comments_table',1),
	(82,'2020_05_21_171500_create_product_customer_group_prices_table',1),
	(83,'2020_06_25_162154_create_customer_social_accounts_table',1),
	(84,'2020_11_19_112228_create_product_videos_table',1),
	(85,'2020_11_26_141455_create_marketing_templates_table',1),
	(86,'2020_11_26_150534_create_marketing_events_table',1),
	(87,'2020_11_26_150644_create_marketing_campaigns_table',1),
	(88,'2020_12_21_000200_create_channel_translations_table',1),
	(89,'2020_12_27_121950_create_jobs_table',1),
	(90,'2021_03_11_212124_create_order_transactions_table',1),
	(91,'2021_04_07_132010_create_product_review_images_table',1),
	(92,'2021_12_15_104544_notifications',1),
	(93,'2022_03_15_160510_create_failed_jobs_table',1),
	(94,'2022_04_01_094622_create_sitemaps_table',1),
	(95,'2022_10_03_144232_create_product_price_indices_table',1),
	(96,'2022_10_04_144444_create_job_batches_table',1),
	(97,'2022_10_08_134150_create_product_inventory_indices_table',1),
	(98,'2023_05_26_213105_create_wishlist_items_table',1),
	(99,'2023_05_26_213120_create_compare_items_table',1),
	(100,'2023_06_27_163529_rename_product_review_images_to_product_review_attachments',1),
	(101,'2023_07_06_140013_add_logo_path_column_to_locales',1),
	(102,'2023_07_10_184256_create_theme_customizations_table',1),
	(103,'2023_07_12_181722_remove_home_page_and_footer_content_column_from_channel_translations_table',1),
	(104,'2023_07_20_185324_add_column_column_in_attribute_groups_table',1),
	(105,'2023_07_25_145943_add_regex_column_in_attributes_table',1),
	(106,'2023_07_25_165945_drop_notes_column_from_customers_table',1),
	(107,'2023_07_25_171058_create_customer_notes_table',1),
	(108,'2023_07_31_125232_rename_image_and_category_banner_columns_from_categories_table',1),
	(109,'2023_09_15_170053_create_theme_customization_translations_table',1),
	(110,'2023_09_20_102031_add_default_value_column_in_attributes_table',1),
	(111,'2023_09_20_102635_add_inventories_group_in_attribute_groups_table',1),
	(112,'2023_09_26_155709_add_columns_to_currencies',1),
	(113,'2023_10_05_163612_create_visits_table',1),
	(114,'2023_10_12_090446_add_tax_category_id_column_in_order_items_table',1),
	(115,'2023_11_08_054614_add_code_column_in_attribute_groups_table',1),
	(116,'2023_11_08_140116_create_search_terms_table',1),
	(117,'2023_11_09_162805_create_url_rewrites_table',1),
	(118,'2023_11_17_150401_create_search_synonyms_table',1),
	(119,'2023_12_11_054614_add_channel_id_column_in_product_price_indices_table',1),
	(120,'2024_01_11_154640_create_imports_table',1),
	(121,'2024_01_11_154741_create_import_batches_table',1),
	(122,'2024_01_19_170350_add_unique_id_column_in_product_attribute_values_table',1),
	(123,'2024_01_19_170350_add_unique_id_column_in_product_customer_group_prices_table',1),
	(124,'2024_01_22_170814_add_unique_index_in_mapping_tables',1),
	(125,'2024_02_26_153000_add_columns_to_addresses_table',1),
	(126,'2024_03_07_193421_rename_address1_column_in_addresses_table',1),
	(127,'2024_04_16_144400_add_cart_id_column_in_cart_shipping_rates_table',1),
	(128,'2024_04_19_102939_add_incl_tax_columns_in_orders_table',1),
	(129,'2024_04_19_135405_add_incl_tax_columns_in_cart_items_table',1),
	(130,'2024_04_19_144641_add_incl_tax_columns_in_order_items_table',1),
	(131,'2024_04_23_133154_add_incl_tax_columns_in_cart_table',1),
	(132,'2024_04_23_150945_add_incl_tax_columns_in_cart_shipping_rates_table',1),
	(133,'2024_04_24_102939_add_incl_tax_columns_in_invoices_table',1),
	(134,'2024_04_24_102939_add_incl_tax_columns_in_refunds_table',1),
	(135,'2024_04_24_144641_add_incl_tax_columns_in_invoice_items_table',1),
	(136,'2024_04_24_144641_add_incl_tax_columns_in_refund_items_table',1),
	(137,'2024_04_24_144641_add_incl_tax_columns_in_shipment_items_table',1),
	(138,'2024_05_10_152848_create_saved_filters_table',1),
	(139,'2024_06_03_174128_create_product_channels_table',1),
	(140,'2024_06_04_130527_add_channel_id_column_in_customers_table',1),
	(141,'2024_06_04_134403_add_channel_id_column_in_visits_table',1),
	(142,'2024_06_13_184426_add_theme_column_into_theme_customizations_table',1);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `order_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_order_id_foreign` (`order_id`),
  CONSTRAINT `notifications_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table order_comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order_comments`;

CREATE TABLE `order_comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int unsigned DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_notified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_comments_order_id_foreign` (`order_id`),
  CONSTRAINT `order_comments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table order_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order_items`;

CREATE TABLE `order_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` decimal(12,4) DEFAULT '0.0000',
  `total_weight` decimal(12,4) DEFAULT '0.0000',
  `qty_ordered` int DEFAULT '0',
  `qty_shipped` int DEFAULT '0',
  `qty_invoiced` int DEFAULT '0',
  `qty_canceled` int DEFAULT '0',
  `qty_refunded` int DEFAULT '0',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `amount_refunded` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_amount_refunded` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `discount_percent` decimal(12,4) DEFAULT '0.0000',
  `discount_amount` decimal(12,4) DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000',
  `discount_refunded` decimal(12,4) DEFAULT '0.0000',
  `base_discount_refunded` decimal(12,4) DEFAULT '0.0000',
  `tax_percent` decimal(12,4) DEFAULT '0.0000',
  `tax_amount` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000',
  `tax_amount_invoiced` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount_invoiced` decimal(12,4) DEFAULT '0.0000',
  `tax_amount_refunded` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount_refunded` decimal(12,4) DEFAULT '0.0000',
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `product_id` int unsigned DEFAULT NULL,
  `product_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` int unsigned DEFAULT NULL,
  `tax_category_id` int unsigned DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_parent_id_foreign` (`parent_id`),
  KEY `order_items_tax_category_id_foreign` (`tax_category_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_tax_category_id_foreign` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_categories` (`id`),
  CONSTRAINT `order_items_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table order_payment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order_payment`;

CREATE TABLE `order_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int unsigned DEFAULT NULL,
  `method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_payment_order_id_foreign` (`order_id`),
  CONSTRAINT `order_payment_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_payment_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table order_transactions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order_transactions`;

CREATE TABLE `order_transactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(12,4) DEFAULT '0.0000',
  `payment_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `invoice_id` int unsigned NOT NULL,
  `order_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_transactions_order_id_foreign` (`order_id`),
  CONSTRAINT `order_transactions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_transactions_chk_1` CHECK (json_valid(`data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_guest` tinyint(1) DEFAULT NULL,
  `customer_email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_gift` tinyint(1) NOT NULL DEFAULT '0',
  `total_item_count` int DEFAULT NULL,
  `total_qty_ordered` int DEFAULT NULL,
  `base_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` decimal(12,4) DEFAULT '0.0000',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000',
  `grand_total_invoiced` decimal(12,4) DEFAULT '0.0000',
  `base_grand_total_invoiced` decimal(12,4) DEFAULT '0.0000',
  `grand_total_refunded` decimal(12,4) DEFAULT '0.0000',
  `base_grand_total_refunded` decimal(12,4) DEFAULT '0.0000',
  `sub_total` decimal(12,4) DEFAULT '0.0000',
  `base_sub_total` decimal(12,4) DEFAULT '0.0000',
  `sub_total_invoiced` decimal(12,4) DEFAULT '0.0000',
  `base_sub_total_invoiced` decimal(12,4) DEFAULT '0.0000',
  `sub_total_refunded` decimal(12,4) DEFAULT '0.0000',
  `base_sub_total_refunded` decimal(12,4) DEFAULT '0.0000',
  `discount_percent` decimal(12,4) DEFAULT '0.0000',
  `discount_amount` decimal(12,4) DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000',
  `discount_refunded` decimal(12,4) DEFAULT '0.0000',
  `base_discount_refunded` decimal(12,4) DEFAULT '0.0000',
  `tax_amount` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000',
  `tax_amount_invoiced` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount_invoiced` decimal(12,4) DEFAULT '0.0000',
  `tax_amount_refunded` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount_refunded` decimal(12,4) DEFAULT '0.0000',
  `shipping_amount` decimal(12,4) DEFAULT '0.0000',
  `base_shipping_amount` decimal(12,4) DEFAULT '0.0000',
  `shipping_invoiced` decimal(12,4) DEFAULT '0.0000',
  `base_shipping_invoiced` decimal(12,4) DEFAULT '0.0000',
  `shipping_refunded` decimal(12,4) DEFAULT '0.0000',
  `base_shipping_refunded` decimal(12,4) DEFAULT '0.0000',
  `shipping_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `shipping_tax_refunded` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_tax_refunded` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `customer_id` int unsigned DEFAULT NULL,
  `customer_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_id` int unsigned DEFAULT NULL,
  `channel_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cart_id` int DEFAULT NULL,
  `applied_cart_rule_ids` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_increment_id_unique` (`increment_id`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_channel_id_foreign` (`channel_id`),
  CONSTRAINT `orders_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table personal_access_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_attribute_values
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_attribute_values`;

CREATE TABLE `product_attribute_values` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `boolean_value` tinyint(1) DEFAULT NULL,
  `integer_value` int DEFAULT NULL,
  `float_value` decimal(12,4) DEFAULT NULL,
  `datetime_value` datetime DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `json_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `product_id` int unsigned NOT NULL,
  `attribute_id` int unsigned NOT NULL,
  `unique_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chanel_locale_attribute_value_index_unique` (`channel`,`locale`,`attribute_id`,`product_id`),
  UNIQUE KEY `product_attribute_values_unique_id_unique` (`unique_id`),
  KEY `product_attribute_values_product_id_foreign` (`product_id`),
  KEY `product_attribute_values_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `product_attribute_values_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_attribute_values_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_attribute_values_chk_1` CHECK (json_valid(`json_value`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_attribute_values` WRITE;
/*!40000 ALTER TABLE `product_attribute_values` DISABLE KEYS */;

INSERT INTO `product_attribute_values` (`id`, `locale`, `channel`, `text_value`, `boolean_value`, `integer_value`, `float_value`, `datetime_value`, `date_value`, `json_value`, `product_id`, `attribute_id`, `unique_id`)
VALUES
	(274,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,26,5,'26|5'),
	(275,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,26,6,'26|6'),
	(276,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,26,7,'26|7'),
	(277,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,26,8,'default|26|8'),
	(278,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,26,26,'26|26'),
	(279,'es',NULL,'<p>Gel Antibacterial</p>',NULL,NULL,NULL,NULL,NULL,NULL,26,9,'es|26|9'),
	(280,'es',NULL,'<p>Gel Antibacterial</p>',NULL,NULL,NULL,NULL,NULL,NULL,26,10,'es|26|10'),
	(281,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,26,19,'26|19'),
	(282,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,26,20,'26|20'),
	(283,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,26,21,'26|21'),
	(284,NULL,NULL,'1000',NULL,NULL,NULL,NULL,NULL,NULL,26,22,'26|22'),
	(285,NULL,NULL,'Gel1',NULL,NULL,NULL,NULL,NULL,NULL,26,1,'26|1'),
	(286,'es',NULL,'Gel Antibacterial',NULL,NULL,NULL,NULL,NULL,NULL,26,2,'es|26|2'),
	(287,'es',NULL,'gel-antibacterial',NULL,NULL,NULL,NULL,NULL,NULL,26,3,'es|26|3'),
	(288,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,26,23,'26|23'),
	(289,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL,NULL,26,24,'26|24'),
	(290,NULL,NULL,'0002',NULL,NULL,NULL,NULL,NULL,NULL,26,27,'26|27'),
	(291,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,26,28,'default|26|28'),
	(292,'es',NULL,'Gel Antibacterial',NULL,NULL,NULL,NULL,NULL,NULL,26,16,'es|26|16'),
	(293,'es',NULL,'Gel Antibacterial',NULL,NULL,NULL,NULL,NULL,NULL,26,17,'es|26|17'),
	(294,'es',NULL,'Gel Antibacterial',NULL,NULL,NULL,NULL,NULL,NULL,26,18,'es|26|18'),
	(295,NULL,NULL,NULL,NULL,NULL,50.0000,NULL,NULL,NULL,26,11,'26|11'),
	(296,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,26,12,'26|12'),
	(297,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,26,13,'26|13'),
	(298,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,26,14,'default|26|14'),
	(299,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,26,15,'default|26|15'),
	(300,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,27,5,'27|5'),
	(301,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,27,6,'27|6'),
	(302,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,27,7,'27|7'),
	(303,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,27,8,'default|27|8'),
	(304,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,27,26,'27|26'),
	(305,'es',NULL,'<p>Crema Humectante</p>',NULL,NULL,NULL,NULL,NULL,NULL,27,9,'es|27|9'),
	(306,'es',NULL,'<p>Crema Humectante</p>',NULL,NULL,NULL,NULL,NULL,NULL,27,10,'es|27|10'),
	(307,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,27,19,'27|19'),
	(308,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,27,20,'27|20'),
	(309,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,27,21,'27|21'),
	(310,NULL,NULL,'10',NULL,NULL,NULL,NULL,NULL,NULL,27,22,'27|22'),
	(311,NULL,NULL,'Crema2',NULL,NULL,NULL,NULL,NULL,NULL,27,1,'27|1'),
	(312,'es',NULL,'Crema Humectante',NULL,NULL,NULL,NULL,NULL,NULL,27,2,'es|27|2'),
	(313,'es',NULL,'crema-humectante',NULL,NULL,NULL,NULL,NULL,NULL,27,3,'es|27|3'),
	(314,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,27,23,'27|23'),
	(315,NULL,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,27,24,'27|24'),
	(316,NULL,NULL,'0003',NULL,NULL,NULL,NULL,NULL,NULL,27,27,'27|27'),
	(317,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,27,28,'default|27|28'),
	(318,'es',NULL,'Crema Humectante',NULL,NULL,NULL,NULL,NULL,NULL,27,16,'es|27|16'),
	(319,'es',NULL,'Crema Humectante',NULL,NULL,NULL,NULL,NULL,NULL,27,17,'es|27|17'),
	(320,'es',NULL,'Crema Humectante',NULL,NULL,NULL,NULL,NULL,NULL,27,18,'es|27|18'),
	(321,NULL,NULL,NULL,NULL,NULL,60.0000,NULL,NULL,NULL,27,11,'27|11'),
	(322,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,27,12,'27|12'),
	(323,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,27,13,'27|13'),
	(324,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,27,14,'default|27|14'),
	(325,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,27,15,'default|27|15'),
	(326,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,28,5,'28|5'),
	(327,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,28,6,'28|6'),
	(328,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,28,7,'28|7'),
	(329,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,28,8,'default|28|8'),
	(330,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,28,26,'28|26'),
	(331,'es',NULL,'<p>Desodorante Hombre</p>',NULL,NULL,NULL,NULL,NULL,NULL,28,9,'es|28|9'),
	(332,'es',NULL,'<p>Desodorante Hombre</p>',NULL,NULL,NULL,NULL,NULL,NULL,28,10,'es|28|10'),
	(333,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,28,19,'28|19'),
	(334,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,28,20,'28|20'),
	(335,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,28,21,'28|21'),
	(336,NULL,NULL,'10',NULL,NULL,NULL,NULL,NULL,NULL,28,22,'28|22'),
	(337,NULL,NULL,'Desoderante1',NULL,NULL,NULL,NULL,NULL,NULL,28,1,'28|1'),
	(338,'es',NULL,'Desodorante Hombre',NULL,NULL,NULL,NULL,NULL,NULL,28,2,'es|28|2'),
	(339,'es',NULL,'desodorante-hombre',NULL,NULL,NULL,NULL,NULL,NULL,28,3,'es|28|3'),
	(340,NULL,NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,28,23,'28|23'),
	(341,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL,NULL,28,24,'28|24'),
	(342,NULL,NULL,'0004',NULL,NULL,NULL,NULL,NULL,NULL,28,27,'28|27'),
	(343,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,28,28,'default|28|28'),
	(344,'es',NULL,'Desodorante Hombre',NULL,NULL,NULL,NULL,NULL,NULL,28,16,'es|28|16'),
	(345,'es',NULL,'Desodorante Hombre',NULL,NULL,NULL,NULL,NULL,NULL,28,17,'es|28|17'),
	(346,'es',NULL,'Desodorante Hombre',NULL,NULL,NULL,NULL,NULL,NULL,28,18,'es|28|18'),
	(347,NULL,NULL,NULL,NULL,NULL,25.0000,NULL,NULL,NULL,28,11,'28|11'),
	(348,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,28,12,'28|12'),
	(349,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,28,13,'28|13'),
	(350,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,28,14,'default|28|14'),
	(351,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,28,15,'default|28|15'),
	(352,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,29,5,'29|5'),
	(353,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,29,6,'29|6'),
	(354,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,29,7,'29|7'),
	(355,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,29,8,'default|29|8'),
	(356,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,29,26,'29|26'),
	(357,'es',NULL,'<p>Talco Para Pies</p>',NULL,NULL,NULL,NULL,NULL,NULL,29,9,'es|29|9'),
	(358,'es',NULL,'<p>Talco Para Pies</p>',NULL,NULL,NULL,NULL,NULL,NULL,29,10,'es|29|10'),
	(359,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,29,19,'29|19'),
	(360,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,29,20,'29|20'),
	(361,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,29,21,'29|21'),
	(362,NULL,NULL,'10',NULL,NULL,NULL,NULL,NULL,NULL,29,22,'29|22'),
	(363,NULL,NULL,'Talcos1',NULL,NULL,NULL,NULL,NULL,NULL,29,1,'29|1'),
	(364,'es',NULL,'Talco Para Pies',NULL,NULL,NULL,NULL,NULL,NULL,29,2,'es|29|2'),
	(365,'es',NULL,'talco-para-pies',NULL,NULL,NULL,NULL,NULL,NULL,29,3,'es|29|3'),
	(366,NULL,NULL,'0005',NULL,NULL,NULL,NULL,NULL,NULL,29,27,'29|27'),
	(367,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,29,28,'default|29|28'),
	(368,'es',NULL,'Talco Para Pies',NULL,NULL,NULL,NULL,NULL,NULL,29,16,'es|29|16'),
	(369,'es',NULL,'Talco Para Pies',NULL,NULL,NULL,NULL,NULL,NULL,29,17,'es|29|17'),
	(370,'es',NULL,'Talco Para Pies',NULL,NULL,NULL,NULL,NULL,NULL,29,18,'es|29|18'),
	(371,NULL,NULL,NULL,NULL,NULL,30.0000,NULL,NULL,NULL,29,11,'29|11'),
	(372,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,29,12,'29|12'),
	(373,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,29,13,'29|13'),
	(374,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,29,14,'default|29|14'),
	(375,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,29,15,'default|29|15'),
	(376,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,30,5,'30|5'),
	(377,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,30,6,'30|6'),
	(378,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,30,7,'30|7'),
	(379,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,30,8,'default|30|8'),
	(380,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,30,26,'30|26'),
	(381,'es',NULL,'<p>Kit de Cremas</p>',NULL,NULL,NULL,NULL,NULL,NULL,30,9,'es|30|9'),
	(382,'es',NULL,'<p>Kit de Cremas</p>',NULL,NULL,NULL,NULL,NULL,NULL,30,10,'es|30|10'),
	(383,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,30,19,'30|19'),
	(384,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,30,20,'30|20'),
	(385,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,30,21,'30|21'),
	(386,NULL,NULL,'10',NULL,NULL,NULL,NULL,NULL,NULL,30,22,'30|22'),
	(387,NULL,NULL,'Crema1',NULL,NULL,NULL,NULL,NULL,NULL,30,1,'30|1'),
	(388,'es',NULL,'Kit de Cremas',NULL,NULL,NULL,NULL,NULL,NULL,30,2,'es|30|2'),
	(389,'es',NULL,'kit-de-cremas',NULL,NULL,NULL,NULL,NULL,NULL,30,3,'es|30|3'),
	(390,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL,NULL,30,24,'30|24'),
	(391,NULL,NULL,'0006',NULL,NULL,NULL,NULL,NULL,NULL,30,27,'30|27'),
	(392,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,30,28,'default|30|28'),
	(393,'es',NULL,'Kit de Cremas',NULL,NULL,NULL,NULL,NULL,NULL,30,16,'es|30|16'),
	(394,'es',NULL,'Kit de Cremas',NULL,NULL,NULL,NULL,NULL,NULL,30,17,'es|30|17'),
	(395,'es',NULL,'Kit de Cremas',NULL,NULL,NULL,NULL,NULL,NULL,30,18,'es|30|18'),
	(396,NULL,NULL,NULL,NULL,NULL,70.0000,NULL,NULL,NULL,30,11,'30|11'),
	(397,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,30,12,'30|12'),
	(398,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,30,13,'30|13'),
	(399,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,30,14,'default|30|14'),
	(400,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,30,15,'default|30|15'),
	(401,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,31,5,'31|5'),
	(402,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,31,6,'31|6'),
	(403,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,31,7,'31|7'),
	(404,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,31,8,'default|31|8'),
	(405,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,31,26,'31|26'),
	(406,'es',NULL,'<p>Shampoo Oleil</p>',NULL,NULL,NULL,NULL,NULL,NULL,31,9,'es|31|9'),
	(407,'es',NULL,'<p>Shampoo Oleil</p>',NULL,NULL,NULL,NULL,NULL,NULL,31,10,'es|31|10'),
	(408,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,31,19,'31|19'),
	(409,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,31,20,'31|20'),
	(410,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,31,21,'31|21'),
	(411,NULL,NULL,'10',NULL,NULL,NULL,NULL,NULL,NULL,31,22,'31|22'),
	(412,NULL,NULL,'Shampoo1',NULL,NULL,NULL,NULL,NULL,NULL,31,1,'31|1'),
	(413,'es',NULL,'Shampoo Oleil',NULL,NULL,NULL,NULL,NULL,NULL,31,2,'es|31|2'),
	(414,'es',NULL,'shampoo-oleil',NULL,NULL,NULL,NULL,NULL,NULL,31,3,'es|31|3'),
	(415,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL,NULL,31,24,'31|24'),
	(416,NULL,NULL,'0007',NULL,NULL,NULL,NULL,NULL,NULL,31,27,'31|27'),
	(417,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,31,28,'default|31|28'),
	(418,'es',NULL,'Shampoo Oleil',NULL,NULL,NULL,NULL,NULL,NULL,31,16,'es|31|16'),
	(419,'es',NULL,'Shampoo Oleil',NULL,NULL,NULL,NULL,NULL,NULL,31,17,'es|31|17'),
	(420,'es',NULL,'Shampoo Oleil',NULL,NULL,NULL,NULL,NULL,NULL,31,18,'es|31|18'),
	(421,NULL,NULL,NULL,NULL,NULL,40.0000,NULL,NULL,NULL,31,11,'31|11'),
	(422,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,31,12,'31|12'),
	(423,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,31,13,'31|13'),
	(424,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,31,14,'default|31|14'),
	(425,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,31,15,'default|31|15'),
	(458,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,33,5,'33|5'),
	(459,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,33,6,'33|6'),
	(460,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,33,7,'33|7'),
	(461,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,33,8,'default|33|8'),
	(462,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,33,26,'33|26'),
	(463,'es',NULL,'<p>Loci&oacute;n de Rosas</p>',NULL,NULL,NULL,NULL,NULL,NULL,33,9,'es|33|9'),
	(464,'es',NULL,'<p>Loci&oacute;n de Rosas</p>',NULL,NULL,NULL,NULL,NULL,NULL,33,10,'es|33|10'),
	(465,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,33,19,'33|19'),
	(466,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,33,20,'33|20'),
	(467,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,33,21,'33|21'),
	(468,NULL,NULL,'10',NULL,NULL,NULL,NULL,NULL,NULL,33,22,'33|22'),
	(469,NULL,NULL,'temporary-sku-7e2205',NULL,NULL,NULL,NULL,NULL,NULL,33,1,'33|1'),
	(470,'es',NULL,'Loción de Rosas',NULL,NULL,NULL,NULL,NULL,NULL,33,2,'es|33|2'),
	(471,'es',NULL,'locion-de-rosas',NULL,NULL,NULL,NULL,NULL,NULL,33,3,'es|33|3'),
	(472,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL,NULL,33,24,'33|24'),
	(473,NULL,NULL,'copia-de-0007',NULL,NULL,NULL,NULL,NULL,NULL,33,27,'33|27'),
	(474,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,33,28,'default|33|28'),
	(475,'es',NULL,'Loción de Rosas',NULL,NULL,NULL,NULL,NULL,NULL,33,16,'es|33|16'),
	(476,'es',NULL,'Loción de Rosas',NULL,NULL,NULL,NULL,NULL,NULL,33,17,'es|33|17'),
	(477,'es',NULL,'Loción de Rosas',NULL,NULL,NULL,NULL,NULL,NULL,33,18,'es|33|18'),
	(478,NULL,NULL,NULL,NULL,NULL,70.0000,NULL,NULL,NULL,33,11,'33|11'),
	(479,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,33,12,'33|12'),
	(480,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,33,13,'33|13'),
	(481,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,33,14,'default|33|14'),
	(482,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,33,15,'default|33|15'),
	(533,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,36,5,'36|5'),
	(534,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,36,6,'36|6'),
	(535,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,36,7,'36|7'),
	(536,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,36,8,'default|36|8'),
	(537,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,36,26,'36|26'),
	(538,'es',NULL,'<p>Crema Rostro</p>',NULL,NULL,NULL,NULL,NULL,NULL,36,9,'es|36|9'),
	(539,'es',NULL,'<p>Crema Rostro</p>',NULL,NULL,NULL,NULL,NULL,NULL,36,10,'es|36|10'),
	(540,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,36,19,'36|19'),
	(541,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,36,20,'36|20'),
	(542,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,36,21,'36|21'),
	(543,NULL,NULL,'10',NULL,NULL,NULL,NULL,NULL,NULL,36,22,'36|22'),
	(544,NULL,NULL,'Crema3',NULL,NULL,NULL,NULL,NULL,NULL,36,1,'36|1'),
	(545,'es',NULL,'Crema Rostro',NULL,NULL,NULL,NULL,NULL,NULL,36,2,'es|36|2'),
	(546,'es',NULL,'crema-rostro',NULL,NULL,NULL,NULL,NULL,NULL,36,3,'es|36|3'),
	(547,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL,NULL,36,24,'36|24'),
	(548,NULL,NULL,'Crema Rostro',NULL,NULL,NULL,NULL,NULL,NULL,36,27,'36|27'),
	(549,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,36,28,'default|36|28'),
	(550,'es',NULL,'Crema Rostro',NULL,NULL,NULL,NULL,NULL,NULL,36,16,'es|36|16'),
	(551,'es',NULL,'Crema Rostro',NULL,NULL,NULL,NULL,NULL,NULL,36,17,'es|36|17'),
	(552,'es',NULL,'Crema Rostro',NULL,NULL,NULL,NULL,NULL,NULL,36,18,'es|36|18'),
	(553,NULL,NULL,NULL,NULL,NULL,25.0000,NULL,NULL,NULL,36,11,'36|11'),
	(554,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36,12,'36|12'),
	(555,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36,13,'36|13'),
	(556,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,36,14,'default|36|14'),
	(557,NULL,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,36,15,'default|36|15');

/*!40000 ALTER TABLE `product_attribute_values` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_bundle_option_products
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_bundle_option_products`;

CREATE TABLE `product_bundle_option_products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `product_bundle_option_id` int unsigned NOT NULL,
  `qty` int NOT NULL DEFAULT '0',
  `is_user_defined` tinyint(1) NOT NULL DEFAULT '1',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bundle_option_products_product_id_bundle_option_id_unique` (`product_id`,`product_bundle_option_id`),
  KEY `product_bundle_option_products_product_bundle_option_id_foreign` (`product_bundle_option_id`),
  CONSTRAINT `product_bundle_option_products_product_bundle_option_id_foreign` FOREIGN KEY (`product_bundle_option_id`) REFERENCES `product_bundle_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_bundle_option_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_bundle_option_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_bundle_option_translations`;

CREATE TABLE `product_bundle_option_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_bundle_option_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_bundle_option_translations_option_id_locale_unique` (`product_bundle_option_id`,`locale`),
  UNIQUE KEY `bundle_option_translations_locale_label_bundle_option_id_unique` (`locale`,`label`,`product_bundle_option_id`),
  CONSTRAINT `product_bundle_option_translations_option_id_foreign` FOREIGN KEY (`product_bundle_option_id`) REFERENCES `product_bundle_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_bundle_options
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_bundle_options`;

CREATE TABLE `product_bundle_options` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_bundle_options_product_id_foreign` (`product_id`),
  CONSTRAINT `product_bundle_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_categories`;

CREATE TABLE `product_categories` (
  `product_id` int unsigned NOT NULL,
  `category_id` int unsigned NOT NULL,
  UNIQUE KEY `product_categories_product_id_category_id_unique` (`product_id`,`category_id`),
  KEY `product_categories_category_id_foreign` (`category_id`),
  CONSTRAINT `product_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_categories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;

INSERT INTO `product_categories` (`product_id`, `category_id`)
VALUES
	(36,3),
	(33,4),
	(31,5),
	(30,6),
	(29,7),
	(28,8),
	(27,9),
	(26,10);

/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_channels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_channels`;

CREATE TABLE `product_channels` (
  `product_id` int unsigned NOT NULL,
  `channel_id` int unsigned NOT NULL,
  UNIQUE KEY `product_channels_product_id_channel_id_unique` (`product_id`,`channel_id`),
  KEY `product_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `product_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_channels_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_channels` WRITE;
/*!40000 ALTER TABLE `product_channels` DISABLE KEYS */;

INSERT INTO `product_channels` (`product_id`, `channel_id`)
VALUES
	(26,1),
	(27,1),
	(28,1),
	(29,1),
	(30,1),
	(31,1),
	(32,1),
	(33,1),
	(36,1);

/*!40000 ALTER TABLE `product_channels` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_cross_sells
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_cross_sells`;

CREATE TABLE `product_cross_sells` (
  `parent_id` int unsigned NOT NULL,
  `child_id` int unsigned NOT NULL,
  UNIQUE KEY `product_cross_sells_parent_id_child_id_unique` (`parent_id`,`child_id`),
  KEY `product_cross_sells_child_id_foreign` (`child_id`),
  CONSTRAINT `product_cross_sells_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_cross_sells_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_customer_group_prices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_customer_group_prices`;

CREATE TABLE `product_customer_group_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `qty` int NOT NULL DEFAULT '0',
  `value_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `product_id` int unsigned NOT NULL,
  `customer_group_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `unique_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_customer_group_prices_unique_id_unique` (`unique_id`),
  KEY `product_customer_group_prices_product_id_foreign` (`product_id`),
  KEY `product_customer_group_prices_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `product_customer_group_prices_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_customer_group_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_downloadable_link_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_downloadable_link_translations`;

CREATE TABLE `product_downloadable_link_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_downloadable_link_id` int unsigned NOT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `link_translations_link_id_foreign` (`product_downloadable_link_id`),
  CONSTRAINT `link_translations_link_id_foreign` FOREIGN KEY (`product_downloadable_link_id`) REFERENCES `product_downloadable_links` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_downloadable_links
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_downloadable_links`;

CREATE TABLE `product_downloadable_links` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `sample_url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sample_file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sample_file_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sample_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `downloads` int NOT NULL DEFAULT '0',
  `sort_order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_downloadable_links_product_id_foreign` (`product_id`),
  CONSTRAINT `product_downloadable_links_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_downloadable_sample_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_downloadable_sample_translations`;

CREATE TABLE `product_downloadable_sample_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_downloadable_sample_id` int unsigned NOT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `sample_translations_sample_id_foreign` (`product_downloadable_sample_id`),
  CONSTRAINT `sample_translations_sample_id_foreign` FOREIGN KEY (`product_downloadable_sample_id`) REFERENCES `product_downloadable_samples` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_downloadable_samples
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_downloadable_samples`;

CREATE TABLE `product_downloadable_samples` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_downloadable_samples_product_id_foreign` (`product_id`),
  CONSTRAINT `product_downloadable_samples_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_flat
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_flat`;

CREATE TABLE `product_flat` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `url_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new` tinyint(1) DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `meta_title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `price` decimal(12,4) DEFAULT NULL,
  `special_price` decimal(12,4) DEFAULT NULL,
  `special_price_from` date DEFAULT NULL,
  `special_price_to` date DEFAULT NULL,
  `weight` decimal(12,4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute_family_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `visible_individually` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_flat_unique_index` (`product_id`,`channel`,`locale`),
  KEY `product_flat_attribute_family_id_foreign` (`attribute_family_id`),
  KEY `product_flat_parent_id_foreign` (`parent_id`),
  CONSTRAINT `product_flat_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`),
  CONSTRAINT `product_flat_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `product_flat` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_flat_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_flat` WRITE;
/*!40000 ALTER TABLE `product_flat` DISABLE KEYS */;

INSERT INTO `product_flat` (`id`, `sku`, `type`, `product_number`, `name`, `short_description`, `description`, `url_key`, `new`, `featured`, `status`, `meta_title`, `meta_keywords`, `meta_description`, `price`, `special_price`, `special_price_from`, `special_price_to`, `weight`, `created_at`, `locale`, `channel`, `attribute_family_id`, `product_id`, `updated_at`, `parent_id`, `visible_individually`)
VALUES
	(26,'Gel1','simple','0002','Gel Antibacterial','<p>Gel Antibacterial</p>','<p>Gel Antibacterial</p>','gel-antibacterial',1,1,1,'Gel Antibacterial','Gel Antibacterial','Gel Antibacterial',50.0000,NULL,NULL,NULL,1000.0000,'2024-09-25 16:47:08','es','default',1,26,'2024-10-07 11:59:24',NULL,1),
	(27,'Crema2','simple','0003','Crema Humectante','<p>Crema Humectante</p>','<p>Crema Humectante</p>','crema-humectante',1,1,1,'Crema Humectante','Crema Humectante','Crema Humectante',60.0000,NULL,NULL,NULL,10.0000,'2024-09-25 17:05:11','es','default',1,27,'2024-10-07 11:59:13',NULL,1),
	(28,'Desoderante1','simple','0004','Desodorante Hombre','<p>Desodorante Hombre</p>','<p>Desodorante Hombre</p>','desodorante-hombre',1,1,1,'Desodorante Hombre','Desodorante Hombre','Desodorante Hombre',25.0000,NULL,NULL,NULL,10.0000,'2024-09-25 17:09:23','es','default',1,28,'2024-10-07 11:58:55',NULL,1),
	(29,'Talcos1','simple','0005','Talco Para Pies','<p>Talco Para Pies</p>','<p>Talco Para Pies</p>','talco-para-pies',1,1,1,'Talco Para Pies','Talco Para Pies','Talco Para Pies',30.0000,NULL,NULL,NULL,10.0000,'2024-09-25 17:20:16','es','default',1,29,'2024-11-28 15:37:47',NULL,1),
	(30,'Crema1','simple','0006','Kit de Cremas','<p>Kit de Cremas</p>','<p>Kit de Cremas</p>','kit-de-cremas',1,1,1,'Kit de Cremas','Kit de Cremas','Kit de Cremas',70.0000,NULL,NULL,NULL,10.0000,'2024-09-25 17:34:03','es','default',1,30,'2024-10-07 11:58:26',NULL,1),
	(31,'Shampoo1','simple','0007','Shampoo Oleil','<p>Shampoo Oleil</p>','<p>Shampoo Oleil</p>','shampoo-oleil',1,1,1,'Shampoo Oleil','Shampoo Oleil','Shampoo Oleil',40.0000,NULL,NULL,NULL,10.0000,'2024-09-25 17:38:07','es','default',1,31,'2024-10-07 11:58:13',NULL,1),
	(32,'PKP','simple',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-09-26 11:00:36','es','default',1,32,'2024-09-26 11:00:36',NULL,NULL),
	(33,'temporary-sku-7e2205','simple','copia-de-0007','Loción de Rosas','<p>Loci&oacute;n de Rosas</p>','<p>Loci&oacute;n de Rosas</p>','locion-de-rosas',1,1,1,'Loción de Rosas','Loción de Rosas','Loción de Rosas',70.0000,NULL,NULL,NULL,10.0000,'2024-10-04 10:51:59','es','default',1,33,'2024-10-07 11:57:58',NULL,1),
	(36,'Crema3','simple','Crema Rostro','Crema Rostro','<p>Crema Rostro</p>','<p>Crema Rostro</p>','crema-rostro',1,1,1,'Crema Rostro','Crema Rostro','Crema Rostro',25.0000,NULL,NULL,NULL,10.0000,'2024-10-04 14:39:08','es','default',1,36,'2024-11-26 17:28:32',NULL,1);

/*!40000 ALTER TABLE `product_flat` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_grouped_products
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_grouped_products`;

CREATE TABLE `product_grouped_products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `associated_product_id` int unsigned NOT NULL,
  `qty` int NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_grouped_products_product_id_associated_product_id_unique` (`product_id`,`associated_product_id`),
  KEY `product_grouped_products_associated_product_id_foreign` (`associated_product_id`),
  CONSTRAINT `product_grouped_products_associated_product_id_foreign` FOREIGN KEY (`associated_product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_grouped_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_images`;

CREATE TABLE `product_images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int unsigned NOT NULL,
  `position` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_images_product_id_foreign` (`product_id`),
  CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;

INSERT INTO `product_images` (`id`, `type`, `path`, `product_id`, `position`)
VALUES
	(14,'images','product/33/Hb16s1VaJGtlLXNrgw4bm2wsHZqYWz6eKz5m6RqA.webp',33,1),
	(15,'images','product/31/uirWlv3voANadjY0a74XxfRnQkJBpUaWozCzN9dc.webp',31,1),
	(16,'images','product/30/VKLk70uulr7PvWWt7PZyayFWNlHqLnPtSvf1h7rr.webp',30,1),
	(17,'images','product/29/JsJMcjwJvcym3IFCLV8y4CayDkMQwwzFu1K6mwOO.webp',29,1),
	(18,'images','product/28/PdrnXAQjzK2wlNLFs9eHpijLtMId3KoWpWWgTmfW.webp',28,1),
	(20,'images','product/27/Xcd60GKddprLI8aXnwG50m5yqNUY1r40RDHnaEzK.webp',27,1),
	(24,'images','product/36/gjIBuh8rf0RIc1QnlbS1qWaW9HOZpojifdTu2u4T.webp',36,1),
	(25,'images','product/26/1Ev2JCM42w6JpEdvZyLpDi2ZLkMj1PapekGL0iKR.webp',26,1);

/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_inventories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_inventories`;

CREATE TABLE `product_inventories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `qty` int NOT NULL DEFAULT '0',
  `product_id` int unsigned NOT NULL,
  `vendor_id` int NOT NULL DEFAULT '0',
  `inventory_source_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_source_vendor_index_unique` (`product_id`,`inventory_source_id`,`vendor_id`),
  KEY `product_inventories_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `product_inventories_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_inventories` WRITE;
/*!40000 ALTER TABLE `product_inventories` DISABLE KEYS */;

INSERT INTO `product_inventories` (`id`, `qty`, `product_id`, `vendor_id`, `inventory_source_id`)
VALUES
	(4,1000,26,0,1),
	(5,1000,27,0,1),
	(6,1000,28,0,1),
	(7,999,29,0,1),
	(8,1000,30,0,1),
	(9,1000,31,0,1),
	(10,1000,33,0,1),
	(13,1000,36,0,1);

/*!40000 ALTER TABLE `product_inventories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_inventory_indices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_inventory_indices`;

CREATE TABLE `product_inventory_indices` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `qty` int NOT NULL DEFAULT '0',
  `product_id` int unsigned NOT NULL,
  `channel_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_inventory_indices_product_id_channel_id_unique` (`product_id`,`channel_id`),
  KEY `product_inventory_indices_channel_id_foreign` (`channel_id`),
  CONSTRAINT `product_inventory_indices_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_inventory_indices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_inventory_indices` WRITE;
/*!40000 ALTER TABLE `product_inventory_indices` DISABLE KEYS */;

INSERT INTO `product_inventory_indices` (`id`, `qty`, `product_id`, `channel_id`, `created_at`, `updated_at`)
VALUES
	(6,1000,26,1,NULL,'2024-10-02 17:50:40'),
	(7,990,27,1,NULL,'2025-03-03 16:51:27'),
	(8,1000,28,1,NULL,'2024-10-02 17:51:19'),
	(9,1190,29,1,NULL,'2024-11-27 13:24:36'),
	(10,997,30,1,NULL,'2025-03-03 16:50:51'),
	(11,998,31,1,NULL,'2024-10-02 17:50:54'),
	(12,999,33,1,NULL,'2025-03-03 16:50:51'),
	(14,1000,36,1,NULL,NULL);

/*!40000 ALTER TABLE `product_inventory_indices` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_ordered_inventories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_ordered_inventories`;

CREATE TABLE `product_ordered_inventories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `qty` int NOT NULL DEFAULT '0',
  `product_id` int unsigned NOT NULL,
  `channel_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_ordered_inventories_product_id_channel_id_unique` (`product_id`,`channel_id`),
  KEY `product_ordered_inventories_channel_id_foreign` (`channel_id`),
  CONSTRAINT `product_ordered_inventories_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_ordered_inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_ordered_inventories` WRITE;
/*!40000 ALTER TABLE `product_ordered_inventories` DISABLE KEYS */;

INSERT INTO `product_ordered_inventories` (`id`, `qty`, `product_id`, `channel_id`)
VALUES
	(1,10,27,1),
	(2,7,29,1),
	(3,2,31,1),
	(4,3,30,1),
	(7,1,33,1);

/*!40000 ALTER TABLE `product_ordered_inventories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_price_indices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_price_indices`;

CREATE TABLE `product_price_indices` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `customer_group_id` int unsigned DEFAULT NULL,
  `channel_id` int unsigned NOT NULL DEFAULT '1',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `regular_min_price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `regular_max_price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `price_indices_product_id_customer_group_id_channel_id_unique` (`product_id`,`customer_group_id`,`channel_id`),
  KEY `product_price_indices_channel_id_foreign` (`channel_id`),
  KEY `product_price_indices_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `product_price_indices_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_price_indices_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_price_indices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_price_indices` WRITE;
/*!40000 ALTER TABLE `product_price_indices` DISABLE KEYS */;

INSERT INTO `product_price_indices` (`id`, `product_id`, `customer_group_id`, `channel_id`, `min_price`, `regular_min_price`, `max_price`, `regular_max_price`, `created_at`, `updated_at`)
VALUES
	(16,26,1,1,50.0000,50.0000,50.0000,50.0000,NULL,'2024-10-04 12:04:20'),
	(17,26,2,1,50.0000,50.0000,50.0000,50.0000,NULL,'2024-10-04 12:04:20'),
	(18,26,3,1,50.0000,50.0000,50.0000,50.0000,NULL,'2024-10-04 12:04:20'),
	(19,27,1,1,60.0000,60.0000,60.0000,60.0000,NULL,'2024-10-04 11:58:52'),
	(20,27,2,1,60.0000,60.0000,60.0000,60.0000,NULL,'2024-10-04 11:58:52'),
	(21,27,3,1,60.0000,60.0000,60.0000,60.0000,NULL,'2024-10-04 11:58:52'),
	(22,28,1,1,25.0000,25.0000,25.0000,25.0000,NULL,'2024-10-04 11:54:06'),
	(23,28,2,1,25.0000,25.0000,25.0000,25.0000,NULL,'2024-10-04 11:54:06'),
	(24,28,3,1,25.0000,25.0000,25.0000,25.0000,NULL,'2024-10-04 11:54:06'),
	(25,29,1,1,30.0000,30.0000,30.0000,30.0000,NULL,'2024-10-04 11:45:03'),
	(26,29,2,1,30.0000,30.0000,30.0000,30.0000,NULL,'2024-10-04 11:45:03'),
	(27,29,3,1,30.0000,30.0000,30.0000,30.0000,NULL,'2024-10-04 11:45:03'),
	(28,30,1,1,70.0000,70.0000,70.0000,70.0000,NULL,'2024-10-04 11:33:25'),
	(29,30,2,1,70.0000,70.0000,70.0000,70.0000,NULL,'2024-10-04 11:33:25'),
	(30,30,3,1,70.0000,70.0000,70.0000,70.0000,NULL,'2024-10-04 11:33:25'),
	(31,31,1,1,40.0000,40.0000,40.0000,40.0000,NULL,'2024-10-04 11:28:44'),
	(32,31,2,1,40.0000,40.0000,40.0000,40.0000,NULL,'2024-10-04 11:28:44'),
	(33,31,3,1,40.0000,40.0000,40.0000,40.0000,NULL,'2024-10-04 11:28:44'),
	(34,33,1,1,70.0000,70.0000,70.0000,70.0000,NULL,NULL),
	(35,33,2,1,70.0000,70.0000,70.0000,70.0000,NULL,NULL),
	(36,33,3,1,70.0000,70.0000,70.0000,70.0000,NULL,NULL),
	(40,36,1,1,25.0000,25.0000,25.0000,25.0000,NULL,NULL),
	(41,36,2,1,25.0000,25.0000,25.0000,25.0000,NULL,NULL),
	(42,36,3,1,25.0000,25.0000,25.0000,25.0000,NULL,NULL);

/*!40000 ALTER TABLE `product_price_indices` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_relations`;

CREATE TABLE `product_relations` (
  `parent_id` int unsigned NOT NULL,
  `child_id` int unsigned NOT NULL,
  UNIQUE KEY `product_relations_parent_id_child_id_unique` (`parent_id`,`child_id`),
  KEY `product_relations_child_id_foreign` (`child_id`),
  CONSTRAINT `product_relations_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_relations_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `product_relations` WRITE;
/*!40000 ALTER TABLE `product_relations` DISABLE KEYS */;

INSERT INTO `product_relations` (`parent_id`, `child_id`)
VALUES
	(31,33),
	(33,36);

/*!40000 ALTER TABLE `product_relations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_review_attachments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_review_attachments`;

CREATE TABLE `product_review_attachments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `review_id` int unsigned NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'image',
  `mime_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_review_images_review_id_foreign` (`review_id`),
  CONSTRAINT `product_review_images_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `product_reviews` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_reviews
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_reviews`;

CREATE TABLE `product_reviews` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int unsigned NOT NULL,
  `customer_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reviews_product_id_foreign` (`product_id`),
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_super_attributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_super_attributes`;

CREATE TABLE `product_super_attributes` (
  `product_id` int unsigned NOT NULL,
  `attribute_id` int unsigned NOT NULL,
  UNIQUE KEY `product_super_attributes_product_id_attribute_id_unique` (`product_id`,`attribute_id`),
  KEY `product_super_attributes_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `product_super_attributes_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`),
  CONSTRAINT `product_super_attributes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_up_sells
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_up_sells`;

CREATE TABLE `product_up_sells` (
  `parent_id` int unsigned NOT NULL,
  `child_id` int unsigned NOT NULL,
  UNIQUE KEY `product_up_sells_parent_id_child_id_unique` (`parent_id`,`child_id`),
  KEY `product_up_sells_child_id_foreign` (`child_id`),
  CONSTRAINT `product_up_sells_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_up_sells_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table product_videos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_videos`;

CREATE TABLE `product_videos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_videos_product_id_foreign` (`product_id`),
  CONSTRAINT `product_videos_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table products
# ------------------------------------------------------------

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `attribute_family_id` int unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_sku_unique` (`sku`),
  KEY `products_attribute_family_id_foreign` (`attribute_family_id`),
  KEY `products_parent_id_foreign` (`parent_id`),
  CONSTRAINT `products_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`),
  CONSTRAINT `products_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;

INSERT INTO `products` (`id`, `sku`, `type`, `parent_id`, `attribute_family_id`, `additional`, `created_at`, `updated_at`)
VALUES
	(26,'Gel1','simple',NULL,1,NULL,'2024-09-25 16:47:08','2024-10-04 12:04:20'),
	(27,'Crema2','simple',NULL,1,NULL,'2024-09-25 17:05:11','2024-10-04 11:58:52'),
	(28,'Desoderante1','simple',NULL,1,NULL,'2024-09-25 17:09:23','2024-10-04 11:54:06'),
	(29,'Talcos1','simple',NULL,1,NULL,'2024-09-25 17:20:16','2024-10-04 11:45:03'),
	(30,'Crema1','simple',NULL,1,NULL,'2024-09-25 17:34:03','2024-10-04 11:39:40'),
	(31,'Shampoo1','simple',NULL,1,NULL,'2024-09-25 17:38:07','2024-10-04 11:28:44'),
	(32,'PKP','simple',NULL,1,NULL,'2024-09-26 11:00:36','2024-09-26 11:00:36'),
	(33,'temporary-sku-7e2205','simple',NULL,1,NULL,'2024-10-04 10:51:59','2024-10-04 10:51:59'),
	(36,'Crema3','simple',NULL,1,NULL,'2024-10-04 14:39:08','2024-10-04 14:40:59');

/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table refund_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `refund_items`;

CREATE TABLE `refund_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int unsigned DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `tax_amount` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000',
  `discount_percent` decimal(12,4) DEFAULT '0.0000',
  `discount_amount` decimal(12,4) DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `product_id` int unsigned DEFAULT NULL,
  `product_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_item_id` int unsigned DEFAULT NULL,
  `refund_id` int unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `refund_items_parent_id_foreign` (`parent_id`),
  KEY `refund_items_order_item_id_foreign` (`order_item_id`),
  KEY `refund_items_refund_id_foreign` (`refund_id`),
  CONSTRAINT `refund_items_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refund_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `refund_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refund_items_refund_id_foreign` FOREIGN KEY (`refund_id`) REFERENCES `refunds` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refund_items_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table refunds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `refunds`;

CREATE TABLE `refunds` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT '0',
  `total_qty` int DEFAULT NULL,
  `base_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjustment_refund` decimal(12,4) DEFAULT '0.0000',
  `base_adjustment_refund` decimal(12,4) DEFAULT '0.0000',
  `adjustment_fee` decimal(12,4) DEFAULT '0.0000',
  `base_adjustment_fee` decimal(12,4) DEFAULT '0.0000',
  `sub_total` decimal(12,4) DEFAULT '0.0000',
  `base_sub_total` decimal(12,4) DEFAULT '0.0000',
  `grand_total` decimal(12,4) DEFAULT '0.0000',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000',
  `shipping_amount` decimal(12,4) DEFAULT '0.0000',
  `base_shipping_amount` decimal(12,4) DEFAULT '0.0000',
  `tax_amount` decimal(12,4) DEFAULT '0.0000',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000',
  `discount_percent` decimal(12,4) DEFAULT '0.0000',
  `discount_amount` decimal(12,4) DEFAULT '0.0000',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000',
  `shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `order_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `refunds_order_id_foreign` (`order_id`),
  CONSTRAINT `refunds_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `roles_chk_1` CHECK (json_valid(`permissions`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;

INSERT INTO `roles` (`id`, `name`, `description`, `permission_type`, `permissions`, `created_at`, `updated_at`)
VALUES
	(1,'Administrador','Los usuarios con este rol tendrán acceso a todo','all',NULL,NULL,NULL);

/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table search_synonyms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `search_synonyms`;

CREATE TABLE `search_synonyms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `terms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table search_terms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `search_terms`;

CREATE TABLE `search_terms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `results` int NOT NULL DEFAULT '0',
  `uses` int NOT NULL DEFAULT '0',
  `redirect_url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_in_suggested_terms` tinyint(1) NOT NULL DEFAULT '0',
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `search_terms_channel_id_foreign` (`channel_id`),
  CONSTRAINT `search_terms_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `search_terms` WRITE;
/*!40000 ALTER TABLE `search_terms` DISABLE KEYS */;

INSERT INTO `search_terms` (`id`, `term`, `results`, `uses`, `redirect_url`, `display_in_suggested_terms`, `locale`, `channel_id`, `created_at`, `updated_at`)
VALUES
	(1,'Hombre',0,1,NULL,0,'es',1,'2024-10-01 10:12:31','2024-10-01 10:12:31'),
	(2,'Mujer',2,1,NULL,0,'es',1,'2024-10-01 10:12:43','2024-10-01 10:12:43'),
	(3,'Cerave',0,1,NULL,0,'es',1,'2024-10-07 11:02:22','2024-10-07 11:02:22');

/*!40000 ALTER TABLE `search_terms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shipment_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shipment_items`;

CREATE TABLE `shipment_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `price` decimal(12,4) DEFAULT '0.0000',
  `base_price` decimal(12,4) DEFAULT '0.0000',
  `total` decimal(12,4) DEFAULT '0.0000',
  `base_total` decimal(12,4) DEFAULT '0.0000',
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `product_id` int unsigned DEFAULT NULL,
  `product_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_item_id` int unsigned DEFAULT NULL,
  `shipment_id` int unsigned NOT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipment_items_shipment_id_foreign` (`shipment_id`),
  CONSTRAINT `shipment_items_shipment_id_foreign` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shipment_items_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table shipments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shipments`;

CREATE TABLE `shipments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_qty` int DEFAULT NULL,
  `total_weight` int DEFAULT NULL,
  `carrier_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `carrier_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `track_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `email_sent` tinyint(1) NOT NULL DEFAULT '0',
  `customer_id` int unsigned DEFAULT NULL,
  `customer_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` int unsigned NOT NULL,
  `order_address_id` int unsigned DEFAULT NULL,
  `inventory_source_id` int unsigned DEFAULT NULL,
  `inventory_source_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipments_order_id_foreign` (`order_id`),
  KEY `shipments_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `shipments_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE SET NULL,
  CONSTRAINT `shipments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table sitemaps
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitemaps`;

CREATE TABLE `sitemaps` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `file_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `generated_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table subscribers_list
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subscribers_list`;

CREATE TABLE `subscribers_list` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_subscribed` tinyint(1) NOT NULL DEFAULT '0',
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` int unsigned DEFAULT NULL,
  `channel_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscribers_list_customer_id_foreign` (`customer_id`),
  KEY `subscribers_list_channel_id_foreign` (`channel_id`),
  CONSTRAINT `subscribers_list_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscribers_list_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table tax_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_categories`;

CREATE TABLE `tax_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_categories_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table tax_categories_tax_rates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_categories_tax_rates`;

CREATE TABLE `tax_categories_tax_rates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tax_category_id` int unsigned NOT NULL,
  `tax_rate_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_map_index_unique` (`tax_category_id`,`tax_rate_id`),
  KEY `tax_categories_tax_rates_tax_rate_id_foreign` (`tax_rate_id`),
  CONSTRAINT `tax_categories_tax_rates_tax_category_id_foreign` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tax_categories_tax_rates_tax_rate_id_foreign` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table tax_rates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_rates`;

CREATE TABLE `tax_rates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_zip` tinyint(1) NOT NULL DEFAULT '0',
  `zip_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_to` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_rate` decimal(12,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_rates_identifier_unique` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table theme_customization_translations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `theme_customization_translations`;

CREATE TABLE `theme_customization_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `theme_customization_id` int unsigned NOT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `theme_customization_translations_theme_customization_id_foreign` (`theme_customization_id`),
  CONSTRAINT `theme_customization_translations_theme_customization_id_foreign` FOREIGN KEY (`theme_customization_id`) REFERENCES `theme_customizations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `theme_customization_translations_chk_1` CHECK (json_valid(`options`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `theme_customization_translations` WRITE;
/*!40000 ALTER TABLE `theme_customization_translations` DISABLE KEYS */;

INSERT INTO `theme_customization_translations` (`id`, `theme_customization_id`, `locale`, `options`)
VALUES
	(1,1,'es',X'7B22696D61676573223A5B7B22696D616765223A2273746F726167655C2F7468656D655C2F315C2F56596D346831394731724A47716548427949754C4A345249585352744B71637933364F65556F7A472E77656270222C226C696E6B223A2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D31222C227469746C65223A2248494452415441205455205049454C227D2C7B22696D616765223A2273746F726167655C2F7468656D655C2F315C2F493670597147494333306C474F44697478787A77546B6E4E4359706764484C5A4D357646366258332E77656270222C226C696E6B223A2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D31222C227469746C65223A2250726F647563746F73206E61747572616C6573227D2C7B22696D616765223A2273746F726167655C2F7468656D655C2F315C2F56575A486D704C4862344A41656C523163496F6D6D4F6A45324C56506A776534537A77547073764E2E77656270222C226C696E6B223A2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D31222C227469746C65223A226C6F206D656A6F7220656E206D617175696C6C616A65227D2C7B22696D616765223A2273746F726167655C2F7468656D655C2F315C2F346A317530384462316C7337384F67644E4855564E7261536C7266523043354C595257465032444E2E77656270222C226C696E6B223A2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D31222C227469746C65223A2262656C6C657A6120792073616C7564227D5D7D'),
	(2,2,'es',X'7B2268746D6C223A223C64697620636C6173733D5C22686F6D652D6F666665725C223E5C725C6E20202020203C68313E454E565C75303063644F2047524154495320706F7220636F6D70726173206D61796F726573206120243135302E303030203C5C2F68313E5C725C6E5C725C6E3C5C2F6469763E222C22637373223A222E686F6D652D6F66666572206831207B5C725C6E20202020646973706C61793A20626C6F636B3B5C725C6E20202020666F6E742D7765696768743A203530303B5C725C6E20202020746578742D616C69676E3A2063656E7465723B5C725C6E20202020666F6E742D73697A653A20323270783B5C725C6E20202020666F6E742D66616D696C793A20444D20536572696620446973706C61793B5C725C6E202020206261636B67726F756E642D636F6C6F723A20233837423746463B5C725C6E2020202070616464696E672D746F703A20323070783B5C725C6E2020202070616464696E672D626F74746F6D3A20323070783B5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A373638707829207B5C725C6E202020202E686F6D652D6F66666572206831207B5C725C6E2020202020202020666F6E742D73697A653A313870783B5C725C6E202020202020202070616464696E672D746F703A20313070783B5C725C6E202020202020202070616464696E672D626F74746F6D3A20313070783B5C725C6E202020207D5C725C6E20202020406D6564696120286D61782D77696474683A353235707829207B5C725C6E20202020202020202E686F6D652D6F66666572206831207B5C725C6E202020202020202020202020666F6E742D73697A653A313470783B5C725C6E20202020202020202020202070616464696E672D746F703A203670783B5C725C6E20202020202020202020202070616464696E672D626F74746F6D3A203670783B5C725C6E20202020202020207D5C725C6E202020207D227D'),
	(3,3,'es',X'7B2266696C74657273223A7B22736F7274223A22617363222C226C696D6974223A223130222C22706172656E745F6964223A2231227D7D'),
	(4,4,'es',X'7B227469746C65223A224E7565766F732050726F647563746F73222C2266696C74657273223A7B226E6577223A312C22736F7274223A22617363222C226C696D6974223A31307D7D'),
	(5,5,'es',X'7B2268746D6C223A223C6120687265663D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D315C223E5C725C6E20203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D636F6E7461696E65725C223E5C725C6E202020203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D6865616465725C223E5C725C6E2020202020202020203C68323E50726F6D6F63696F6E65733C5C2F68323E5C725C6E5C725C6E202020203C5C2F6469763E5C725C6E202020203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D6772696420636F6E7461696E65725C223E5C725C6E20202020202020203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D636172645C223E5C725C6E2020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F355C2F7543344330575A43584D70676A6342513074534B646836763231456B75386A703853304D5449474C2E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223339365C22206865696768743D5C223339365C2220616C743D5C225C7530306131456C206A7565676F20636F6E206E75657374726173206E75657661732061646963696F6E6573215C223E5C725C6E202020202020202020202020203C68333E2435392E3830303C5C2F68333E5C725C6E5C725C6E20202020202020203C5C2F6469763E5C725C6E20202020202020203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D636172645C223E5C725C6E2020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F355C2F6C67566B484569516F517166774174664B746777664F69774769685A76344B38356F5767714B32572E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223339365C22206865696768743D5C223339365C2220616C743D5C225C7530306131456C206A7565676F20636F6E206E75657374726173206E75657661732061646963696F6E6573215C223E5C725C6E202020202020202020202020203C68333E243132342E3030303C5C2F68333E5C725C6E5C725C6E20202020202020203C5C2F6469763E5C725C6E20202020202020203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D636172645C223E5C725C6E2020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F355C2F6B6D6F38674B73474B79746A647541485633745071714D486341794974724748785338346A464D492E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223339365C22206865696768743D5C223339365C2220616C743D5C225C7530306131456C206A7565676F20636F6E206E75657374726173206E75657661732061646963696F6E6573215C223E5C725C6E202020202020202020202020203C68333E243137372E3735303C5C2F68333E5C725C6E5C725C6E20202020202020203C5C2F6469763E5C725C6E20202020202020203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D636172645C223E5C725C6E2020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F355C2F467954496944336F6370444D696D32566363596B32706175424F4D6751697262644274314F4D66332E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223339365C22206865696768743D5C223339365C2220616C743D5C225C7530306131456C206A7565676F20636F6E206E75657374726173206E75657661732061646963696F6E6573215C223E5C725C6E202020202020202020202020203C68333E2439302E3330303C5C2F68333E5C725C6E5C725C6E20202020202020203C5C2F6469763E5C725C6E20202020202020203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D636172645C223E5C725C6E2020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F355C2F3576524958317473654D786B6E6E56693145366C764E4D66523361594A42696D53466D57327634722E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223339365C22206865696768743D5C223339365C2220616C743D5C225C7530306131456C206A7565676F20636F6E206E75657374726173206E75657661732061646963696F6E6573215C223E5C725C6E202020202020202020202020203C68333E2435392E3830303C5C2F68333E5C725C6E5C725C6E20202020202020203C5C2F6469763E5C725C6E20202020202020203C64697620636C6173733D5C22746F702D636F6C6C656374696F6E2D636172645C223E5C725C6E2020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F355C2F576F67596F4444725468444C706774655A56553778454A45757562534E546A654D33487153656C4F2E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223339365C22206865696768743D5C223339365C2220616C743D5C225C7530306131456C206A7565676F20636F6E206E75657374726173206E75657661732061646963696F6E6573215C223E5C725C6E202020202020202020202020203C68333E243132342E3030303C5C2F68333E5C725C6E5C725C6E20202020202020203C5C2F6469763E5C725C6E202020203C5C2F6469763E5C725C6E3C5C2F6469763E5C725C6E20203C5C2F613E222C22637373223A222E746F702D636F6C6C656374696F6E2D636F6E7461696E6572207B5C725C6E202020206F766572666C6F773A2068696464656E3B5C725C6E7D5C725C6E2E746F702D636F6C6C656374696F6E2D686561646572207B5C725C6E2020202070616464696E672D6C6566743A20313570783B5C725C6E2020202070616464696E672D72696768743A20313570783B5C725C6E20202020746578742D616C69676E3A2063656E7465723B5C725C6E20202020666F6E742D73697A653A20373070783B5C725C6E202020206C696E652D6865696768743A20393070783B5C725C6E20202020636F6C6F723A20233837423746463B5C725C6E202020206D617267696E2D746F703A20383070783B5C725C6E7D5C725C6E2E746F702D636F6C6C656374696F6E2D686561646572206832207B5C725C6E202020206D61782D77696474683A2035393570783B5C725C6E202020206D617267696E2D6C6566743A206175746F3B5C725C6E202020206D617267696E2D72696768743A206175746F3B5C725C6E20202020666F6E742D66616D696C793A20444D20536572696620446973706C61793B5C725C6E7D5C725C6E2E746F702D636F6C6C656374696F6E2D67726964207B5C725C6E20202020646973706C61793A20666C65783B5C725C6E20202020666C65782D777261703A20777261703B5C725C6E202020206761703A20333270783B5C725C6E202020206A7573746966792D636F6E74656E743A2063656E7465723B5C725C6E202020206D617267696E2D746F703A20363070783B5C725C6E2020202077696474683A20313030253B5C725C6E202020206D617267696E2D72696768743A206175746F3B5C725C6E202020206D617267696E2D6C6566743A206175746F3B5C725C6E2020202070616464696E672D72696768743A20393070783B5C725C6E2020202070616464696E672D6C6566743A20393070783B5C725C6E7D5C725C6E2E746F702D636F6C6C656374696F6E2D63617264207B5C725C6E20202020706F736974696F6E3A2072656C61746976653B5C725C6E202020206261636B67726F756E643A20236639666166623B5C725C6E202020206F766572666C6F773A68696464656E3B5C725C6E20202020626F726465722D7261646975733A323070783B5C725C6E7D5C725C6E2E746F702D636F6C6C656374696F6E2D6361726420696D67207B5C725C6E20202020626F726465722D7261646975733A20313670783B5C725C6E202020206D61782D77696474683A20313030253B5C725C6E20202020746578742D696E64656E743A2D3939393970783B5C725C6E202020207472616E736974696F6E3A207472616E73666F726D203330306D7320656173653B5C725C6E202020207472616E73666F726D3A207363616C652831293B5C725C6E7D5C725C6E2E746F702D636F6C6C656374696F6E2D636172643A686F76657220696D67207B5C725C6E202020207472616E73666F726D3A207363616C6528312E3035293B5C725C6E202020207472616E736974696F6E3A20616C6C203330306D7320656173653B5C725C6E7D5C725C6E2E746F702D636F6C6C656374696F6E2D63617264206833207B5C725C6E20202020636F6C6F723A20233030353839463B5C725C6E20202020666F6E742D73697A653A20333070783B5C725C6E20202020666F6E742D66616D696C793A20444D20536572696620446973706C61793B5C725C6E202020207472616E73666F726D3A207472616E736C61746558282D353025293B5C725C6E2020202077696474683A206D61782D636F6E74656E743B5C725C6E202020206C6566743A203530253B5C725C6E20202020626F74746F6D3A20333070783B5C725C6E20202020706F736974696F6E3A206162736F6C7574653B5C725C6E202020206D617267696E3A20303B5C725C6E20202020666F6E742D7765696768743A20696E68657269743B5C725C6E7D5C725C6E406D65646961206E6F7420616C6C20616E6420286D696E2D77696474683A20353235707829207B5C725C6E202020202E746F702D636F6C6C656374696F6E2D686561646572207B5C725C6E20202020202020206D617267696E2D746F703A20323870783B5C725C6E2020202020202020666F6E742D73697A653A20323070783B5C725C6E20202020202020206C696E652D6865696768743A20312E353B5C725C6E202020207D5C725C6E202020202E746F702D636F6C6C656374696F6E2D67726964207B5C725C6E20202020202020206761703A20313070785C725C6E202020207D5C725C6E7D5C725C6E406D65646961206E6F7420616C6C20616E6420286D696E2D77696474683A20373638707829207B5C725C6E202020202E746F702D636F6C6C656374696F6E2D686561646572207B5C725C6E20202020202020206D617267696E2D746F703A20333070783B5C725C6E2020202020202020666F6E742D73697A653A20323870783B5C725C6E20202020202020206C696E652D6865696768743A20333B5C725C6E202020207D5C725C6E202020202E746F702D636F6C6C656374696F6E2D686561646572206832207B5C725C6E20202020202020206C696E652D6865696768743A323B5C725C6E20202020202020206D617267696E2D626F74746F6D3A323070783B5C725C6E202020207D5C725C6E202020202E746F702D636F6C6C656374696F6E2D67726964207B5C725C6E20202020202020206761703A20313470785C725C6E202020207D5C725C6E7D5C725C6E406D65646961206E6F7420616C6C20616E6420286D696E2D77696474683A2031303234707829207B5C725C6E202020202E746F702D636F6C6C656374696F6E2D67726964207B5C725C6E202020202020202070616464696E672D6C6566743A20333070783B5C725C6E202020202020202070616464696E672D72696768743A20333070783B5C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A20373638707829207B5C725C6E202020202E746F702D636F6C6C656374696F6E2D67726964207B5C725C6E2020202020202020726F772D6761703A313570783B5C725C6E2020202020202020636F6C756D6E2D6761703A3070783B5C725C6E20202020202020206A7573746966792D636F6E74656E743A2073706163652D6265747765656E3B5C725C6E20202020202020206D617267696E2D746F703A203070783B5C725C6E202020207D5C725C6E202020202E746F702D636F6C6C656374696F6E2D63617264207B5C725C6E202020202020202077696474683A3438255C725C6E202020207D5C725C6E202020202E746F702D636F6C6C656374696F6E2D6361726420696D67207B5C725C6E202020202020202077696474683A313030253B5C725C6E202020207D5C725C6E202020202E746F702D636F6C6C656374696F6E2D63617264206833207B5C725C6E2020202020202020666F6E742D73697A653A323470783B5C725C6E2020202020202020626F74746F6D3A20313670783B5C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A353230707829207B5C725C6E202020202E746F702D636F6C6C656374696F6E2D67726964207B5C725C6E202020202020202070616464696E672D6C6566743A20313570783B5C725C6E202020202020202070616464696E672D72696768743A20313570783B5C725C6E202020207D5C725C6E202020202E746F702D636F6C6C656374696F6E2D63617264206833207B5C725C6E2020202020202020666F6E742D73697A653A313870783B5C725C6E2020202020202020626F74746F6D3A20313070783B5C725C6E202020207D5C725C6E7D227D'),
	(6,6,'es',X'7B2268746D6C223A223C64697620636C6173733D5C2273656374696F6E2D67617020626F6C642D636F6C6C656374696F6E7320636F6E7461696E65725C223E5C725C6E202020203C64697620636C6173733D5C22696E6C696E652D636F6C2D777261707065725C223E5C725C6E20202020202020203C64697620636C6173733D5C22696E6C696E652D636F6C2D696D6167652D777261707065725C223E5C725C6E2020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F365C2F64574D7442784C536F674A7943534E544D7248744148576F5532584F30596F766C506E3344496A732E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223633325C22206865696768743D5C223531305C2220616C743D5C225C7530306131507265705C7530306531726174652070617261206E75657374726173206E756576617320436F6C656363696F6E65732041756461636573215C223E5C725C6E20202020202020203C5C2F6469763E5C725C6E20202020202020203C64697620636C6173733D5C22696E6C696E652D636F6C2D636F6E74656E742D777261707065725C223E5C725C6E202020202020202020202020203C683220636C6173733D5C22696E6C696E652D636F6C2D7469746C655C223E205C753030613150726F647563746F73207061726120686F6D6272657321203C5C2F68323E205C725C6E2020202020202020202020203C7020636C6173733D5C22696E6C696E652D636F6C2D6465736372697074696F6E5C223E5C753030613150726573656E74616D6F73204E75657374726173204E7565766F732070726F647563746F73207061726120686F6D627265732120456C6576612074752073616C75642079206269656E657374617220636F6E2070726F647563746F7320696E7370697261646F73207061726120656C206375696461646F20706572736F6E616C206465206C6F7320686F6D627265732E204578706C6F7261206D756C7469706C6573206F7063696F6E65732070617261207475206375696461646F20706572736F6E616C2E205C7530306131507265705C753030653172617465207061726120656C657661722074752073616C756420792074752062656C6C657A61213C5C2F703E203C6120687265663D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D315C223E5C725C6E20202020202020202020202020203C627574746F6E20636C6173733D5C227072696D6172792D627574746F6E206D61782D6D643A726F756E6465642D6C67206D61782D6D643A70782D34206D61782D6D643A70792D322E35206D61782D6D643A746578742D736D5C223E5665722070726F647563746F73207061726120686F6D627265733C5C2F627574746F6E3E5C725C6E2020202020202020202020203C5C2F613E5C725C6E5C725C6E20202020202020203C5C2F6469763E5C725C6E202020203C5C2F6469763E5C725C6E3C5C2F6469763E222C22637373223A222E73656374696F6E2D676170207B5C725C6E202020206D617267696E2D746F703A383070785C725C6E7D5C725C6E2E646972656374696F6E2D6C7472207B5C725C6E20202020646972656374696F6E3A6C74725C725C6E7D5C725C6E2E646972656374696F6E2D72746C207B5C725C6E20202020646972656374696F6E3A72746C5C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572207B5C725C6E20202020646973706C61793A677269643B5C725C6E20202020677269642D74656D706C6174652D636F6C756D6E733A6175746F203166723B5C725C6E20202020677269642D6761703A363070783B5C725C6E20202020616C69676E2D6974656D733A63656E7465725C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D696D6167652D77726170706572207B5C725C6E202020206F766572666C6F773A68696464656E5C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D696D6167652D7772617070657220696D67207B5C725C6E202020206D61782D77696474683A313030253B5C725C6E202020206865696768743A6175746F3B5C725C6E20202020626F726465722D7261646975733A313670783B5C725C6E20202020746578742D696E64656E743A2D3939393970785C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572207B5C725C6E20202020646973706C61793A666C65783B5C725C6E20202020666C65782D777261703A777261703B5C725C6E202020206761703A323070783B5C725C6E202020206D61782D77696474683A34363470785C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572202E696E6C696E652D636F6C2D7469746C65207B5C725C6E202020206D61782D77696474683A34343270783B5C725C6E20202020666F6E742D73697A653A363070783B5C725C6E20202020666F6E742D7765696768743A3430303B5C725C6E20202020636F6C6F723A233837423746463B5C725C6E202020206C696E652D6865696768743A373070783B5C725C6E20202020666F6E742D66616D696C793A444D20536572696620446973706C61793B5C725C6E202020206D617267696E3A305C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572202E696E6C696E652D636F6C2D6465736372697074696F6E207B5C725C6E202020206D617267696E3A303B5C725C6E20202020666F6E742D73697A653A313870783B5C725C6E20202020636F6C6F723A233665366536653B5C725C6E20202020666F6E742D66616D696C793A506F7070696E735C725C6E7D5C725C6E406D6564696120286D61782D77696474683A393931707829207B5C725C6E202020202E696E6C696E652D636F6C2D77726170706572207B5C725C6E2020202020202020677269642D74656D706C6174652D636F6C756D6E733A3166723B5C725C6E2020202020202020677269642D6761703A313670785C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572207B5C725C6E20202020202020206761703A313070785C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A373638707829207B5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D696D6167652D7772617070657220696D67207B5C725C6E202020202020202077696474683A313030253B5C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572202E696E6C696E652D636F6C2D7469746C65207B5C725C6E2020202020202020666F6E742D73697A653A323870782021696D706F7274616E743B5C725C6E20202020202020206C696E652D6865696768743A6E6F726D616C2021696D706F7274616E745C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A353235707829207B5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572202E696E6C696E652D636F6C2D7469746C65207B5C725C6E2020202020202020666F6E742D73697A653A323070782021696D706F7274616E743B5C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D6465736372697074696F6E207B5C725C6E2020202020202020666F6E742D73697A653A313670785C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D77726170706572207B5C725C6E2020202020202020677269642D6761703A313070785C725C6E202020207D5C725C6E7D227D'),
	(7,7,'es',X'7B227469746C65223A2250726F647563746F732044657374616361646F73222C2266696C74657273223A7B22736F7274223A22637265617465645F61742D64657363222C226C696D6974223A223234222C226665617475726564223A2231227D7D'),
	(8,8,'es',X'7B2268746D6C223A223C64697620636C6173733D5C2273656374696F6E2D67616D655C223E5C725C6E202020203C64697620636C6173733D5C2273656374696F6E2D7469746C655C223E5C725C6E2020202020202020203C68323E5C753030613153616C756420792042656C6C657A61213C5C2F68323E205C725C6E202020203C5C2F6469763E5C725C6E202020203C64697620636C6173733D5C2273656374696F6E2D67617020636F6E7461696E65725C223E5C725C6E20202020202020203C64697620636C6173733D5C22636F6C6C656374696F6E2D636172642D777261707065725C223E5C725C6E2020202020202020202020203C64697620636C6173733D5C2273696E676C652D636F6C6C656374696F6E2D636172645C223E203C6120687265663D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D315C223E5C725C6E202020202020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F385C2F305432476F52386A78364E6178585943634D615633395974787736526B4E5554313159557A4C56622E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223631355C22206865696768743D5C223630305C2220616C743D5C225C7530306131456C206A7565676F20636F6E206E75657374726173206E75657661732061646963696F6E6573215C223E203C5C2F613E5C725C6E5C725C6E20202020202020202020202020202020203C683320636C6173733D5C226F7665726C61792D746578745C223E4D756A65723C5C2F68333E205C725C6E2020202020202020202020203C5C2F6469763E5C725C6E2020202020202020202020203C64697620636C6173733D5C2273696E676C652D636F6C6C656374696F6E2D636172645C223E203C6120687265663D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D315C223E5C725C6E202020202020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F385C2F6849744255524549376D356943676F6F44495A6B793856364F656E41346C63564F766D54643544342E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223631355C22206865696768743D5C223630305C2220616C743D5C225C7530306131456C206A7565676F20636F6E206E75657374726173206E75657661732061646963696F6E6573215C223E203C5C2F613E5C725C6E5C725C6E20202020202020202020202020202020203C683320636C6173733D5C226F7665726C61792D746578745C223E486F6D6272653C5C2F68333E205C725C6E2020202020202020202020203C5C2F6469763E5C725C6E20202020202020203C5C2F6469763E5C725C6E202020203C5C2F6469763E5C725C6E3C5C2F6469763E222C22637373223A222E73656374696F6E2D67616D65207B5C725C6E202020206F766572666C6F773A2068696464656E3B5C725C6E7D5C725C6E2E73656374696F6E2D7469746C652C202E73656374696F6E2D7469746C65206832207B5C725C6E20202020666F6E742D7765696768743A3430303B5C725C6E20202020666F6E742D66616D696C793A444D20536572696620446973706C61795C725C6E7D5C725C6E2E73656374696F6E2D7469746C65207B5C725C6E202020206D617267696E2D746F703A383070783B5C725C6E2020202070616464696E672D6C6566743A313570783B5C725C6E2020202070616464696E672D72696768743A313570783B5C725C6E20202020746578742D616C69676E3A63656E7465723B5C725C6E202020206C696E652D6865696768743A393070785C725C6E7D5C725C6E2E73656374696F6E2D7469746C65206832207B5C725C6E20202020666F6E742D73697A653A373070783B5C725C6E20202020636F6C6F723A233837423746463B5C725C6E202020206D61782D77696474683A35393570783B5C725C6E202020206D617267696E3A6175746F5C725C6E7D5C725C6E2E636F6C6C656374696F6E2D636172642D77726170706572207B5C725C6E20202020646973706C61793A666C65783B5C725C6E20202020666C65782D777261703A777261703B5C725C6E202020206A7573746966792D636F6E74656E743A63656E7465723B5C725C6E202020206761703A333070785C725C6E7D5C725C6E2E636F6C6C656374696F6E2D636172642D77726170706572202E73696E676C652D636F6C6C656374696F6E2D63617264207B5C725C6E20202020706F736974696F6E3A72656C61746976655C725C6E7D5C725C6E2E636F6C6C656374696F6E2D636172642D77726170706572202E73696E676C652D636F6C6C656374696F6E2D6361726420696D67207B5C725C6E20202020626F726465722D7261646975733A313670783B5C725C6E202020206261636B67726F756E642D636F6C6F723A236635663566353B5C725C6E202020206D61782D77696474683A313030253B5C725C6E202020206865696768743A6175746F3B5C725C6E20202020746578742D696E64656E743A2D3939393970785C725C6E7D5C725C6E2E636F6C6C656374696F6E2D636172642D77726170706572202E73696E676C652D636F6C6C656374696F6E2D63617264202E6F7665726C61792D74657874207B5C725C6E20202020666F6E742D73697A653A353070783B5C725C6E20202020666F6E742D7765696768743A3430303B5C725C6E202020206D61782D77696474683A32333470783B5C725C6E20202020666F6E742D7374796C653A6974616C69633B5C725C6E20202020636F6C6F723A233837423746463B5C725C6E20202020666F6E742D66616D696C793A444D20536572696620446973706C61793B5C725C6E20202020706F736974696F6E3A6162736F6C7574653B5C725C6E20202020626F74746F6D3A333070783B5C725C6E202020206C6566743A333070783B5C725C6E202020206D617267696E3A305C725C6E7D5C725C6E406D6564696120286D61782D77696474683A31303234707829207B5C725C6E202020202E73656374696F6E2D7469746C65207B5C725C6E202020202020202070616464696E673A3020333070785C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A393931707829207B5C725C6E202020202E636F6C6C656374696F6E2D636172642D77726170706572207B5C725C6E2020202020202020666C65782D777261703A777261705C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A373638707829207B5C725C6E202020202E636F6C6C656374696F6E2D636172642D77726170706572202E73696E676C652D636F6C6C656374696F6E2D63617264202E6F7665726C61792D74657874207B5C725C6E2020202020202020666F6E742D73697A653A333270783B5C725C6E2020202020202020626F74746F6D3A323070785C725C6E202020207D5C725C6E202020202E73656374696F6E2D7469746C65207B5C725C6E20202020202020206D617267696E2D746F703A333270785C725C6E202020207D5C725C6E202020202E73656374696F6E2D7469746C65206832207B5C725C6E2020202020202020666F6E742D73697A653A323870783B5C725C6E20202020202020206C696E652D6865696768743A6E6F726D616C5C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A353235707829207B5C725C6E202020202E636F6C6C656374696F6E2D636172642D77726170706572202E73696E676C652D636F6C6C656374696F6E2D63617264202E6F7665726C61792D74657874207B5C725C6E2020202020202020666F6E742D73697A653A313870783B5C725C6E2020202020202020626F74746F6D3A313070785C725C6E202020207D5C725C6E202020202E73656374696F6E2D7469746C65207B5C725C6E20202020202020206D617267696E2D746F703A323870785C725C6E202020207D5C725C6E202020202E73656374696F6E2D7469746C65206832207B5C725C6E2020202020202020666F6E742D73697A653A323070783B5C725C6E202020207D5C725C6E202020202E636F6C6C656374696F6E2D636172642D77726170706572207B5C725C6E20202020202020206761703A313070783B5C725C6E2020202020202020313570783B5C725C6E2020202020202020726F772D6761703A313570783B5C725C6E2020202020202020636F6C756D6E2D6761703A3070783B5C725C6E20202020202020206A7573746966792D636F6E74656E743A2073706163652D6265747765656E3B5C725C6E20202020202020206D617267696E2D746F703A20313570783B5C725C6E202020207D5C725C6E202020202E636F6C6C656374696F6E2D636172642D77726170706572202E73696E676C652D636F6C6C656374696F6E2D63617264207B5C725C6E202020202020202077696474683A3438253B5C725C6E202020207D5C725C6E7D227D'),
	(9,9,'es',X'7B227469746C65223A22546F646F73206C6F732050726F647563746F73222C2266696C74657273223A7B22736F7274223A2264657363222C226C696D6974223A31307D7D'),
	(10,10,'es',X'7B2268746D6C223A223C64697620636C6173733D5C2273656374696F6E2D67617020626F6C642D636F6C6C656374696F6E7320636F6E7461696E65725C223E5C725C6E202020203C64697620636C6173733D5C22696E6C696E652D636F6C2D7772617070657220646972656374696F6E2D72746C5C223E5C725C6E20202020202020203C64697620636C6173733D5C22696E6C696E652D636F6C2D696D6167652D777261707065725C223E5C725C6E2020202020202020202020203C696D67207372633D5C225C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F31305C2F457248674B36774A753264787A4552584349554B7A30336D35697231556636685059793251786D792E776562705C2220636C6173733D5C226C617A795C222077696474683D5C223633325C22206865696768743D5C223531305C2220616C743D5C225C7530306131507265705C7530306531726174652070617261206E75657374726173206E756576617320436F6C656363696F6E65732041756461636573215C223E5C725C6E20202020202020203C5C2F6469763E5C725C6E20202020202020203C64697620636C6173733D5C22696E6C696E652D636F6C2D636F6E74656E742D7772617070657220646972656374696F6E2D6C74725C223E5C725C6E202020202020202020202020203C683220636C6173733D5C22696E6C696E652D636F6C2D7469746C655C223E205C753030613141726D6120747520636F6D626F21203C5C2F68323E205C725C6E2020202020202020202020203C7020636C6173733D5C22696E6C696E652D636F6C2D6465736372697074696F6E5C223E5C753030613150726573656E74616D6F73204E75657374726F7320636F6D626F73206465206D61726361212041726D6120747520636F6D626F20636F6E2070726F647563746F73206465207475206D61726361206661766F72697461207920656C20656E76696F2074652073616C64726120746F74616C6D656E7465206772617469732E204578706C6F7261206C6173206D61726361732079206C6F732070726F647563746F732071756520717569657261732E205C7530306131507265705C75303065317261746520706172612061686F727261722064696E65726F20636F6E206E75657374726F7320636F6D626F73213C5C2F703E203C6120687265663D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D315C223E5C725C6E2020202020202020202020203C627574746F6E20636C6173733D5C227072696D6172792D627574746F6E206D61782D6D643A726F756E6465642D6C67206D61782D6D643A70782D34206D61782D6D643A70792D322E35206D61782D6D643A746578742D736D5C223E56657220436F6D626F733C5C2F627574746F6E3E203C5C2F613E5C725C6E5C725C6E20202020202020203C5C2F6469763E5C725C6E202020203C5C2F6469763E5C725C6E3C5C2F6469763E222C22637373223A222E73656374696F6E2D676170207B5C725C6E202020206D617267696E2D746F703A383070785C725C6E7D5C725C6E2E646972656374696F6E2D6C7472207B5C725C6E20202020646972656374696F6E3A6C74725C725C6E7D5C725C6E2E646972656374696F6E2D72746C207B5C725C6E20202020646972656374696F6E3A72746C5C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572207B5C725C6E20202020646973706C61793A677269643B5C725C6E20202020677269642D74656D706C6174652D636F6C756D6E733A6175746F203166723B5C725C6E20202020677269642D6761703A363070783B5C725C6E20202020616C69676E2D6974656D733A63656E7465725C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D696D6167652D77726170706572207B5C725C6E202020206F766572666C6F773A68696464656E5C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D696D6167652D7772617070657220696D67207B5C725C6E202020206D61782D77696474683A313030253B5C725C6E202020206865696768743A6175746F3B5C725C6E20202020626F726465722D7261646975733A313670783B5C725C6E20202020746578742D696E64656E743A2D3939393970785C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572207B5C725C6E20202020646973706C61793A666C65783B5C725C6E20202020666C65782D777261703A777261703B5C725C6E202020206761703A323070783B5C725C6E202020206D61782D77696474683A34363470785C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572202E696E6C696E652D636F6C2D7469746C65207B5C725C6E202020206D61782D77696474683A34343270783B5C725C6E20202020666F6E742D73697A653A363070783B5C725C6E20202020666F6E742D7765696768743A3430303B5C725C6E20202020636F6C6F723A233837423746463B5C725C6E202020206C696E652D6865696768743A373070783B5C725C6E20202020666F6E742D66616D696C793A444D20536572696620446973706C61793B5C725C6E202020206D617267696E3A305C725C6E7D5C725C6E2E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572202E696E6C696E652D636F6C2D6465736372697074696F6E207B5C725C6E202020206D617267696E3A303B5C725C6E20202020666F6E742D73697A653A313870783B5C725C6E20202020636F6C6F723A233665366536653B5C725C6E20202020666F6E742D66616D696C793A506F7070696E735C725C6E7D5C725C6E406D6564696120286D61782D77696474683A393931707829207B5C725C6E202020202E696E6C696E652D636F6C2D77726170706572207B5C725C6E2020202020202020677269642D74656D706C6174652D636F6C756D6E733A3166723B5C725C6E2020202020202020677269642D6761703A313670785C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572207B5C725C6E20202020202020206761703A313070785C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A373638707829207B5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D696D6167652D7772617070657220696D67207B5C725C6E20202020202020206D61782D77696474683A313030253B5C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572207B5C725C6E20202020202020206D61782D77696474683A313030253B5C725C6E20202020202020206A7573746966792D636F6E74656E743A63656E7465723B5C725C6E2020202020202020746578742D616C69676E3A63656E7465725C725C6E202020207D5C725C6E202020202E73656374696F6E2D676170207B5C725C6E202020202020202070616464696E673A3020333070783B5C725C6E20202020202020206761703A323070783B5C725C6E20202020202020206D617267696E2D746F703A323470785C725C6E202020207D5C725C6E202020202E626F6C642D636F6C6C656374696F6E73207B5C725C6E20202020202020206D617267696E2D746F703A333270783B5C725C6E202020207D5C725C6E7D5C725C6E406D6564696120286D61782D77696474683A353235707829207B5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572207B5C725C6E20202020202020206761703A313070785C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D77726170706572202E696E6C696E652D636F6C2D636F6E74656E742D77726170706572202E696E6C696E652D636F6C2D7469746C65207B5C725C6E2020202020202020666F6E742D73697A653A323070783B5C725C6E20202020202020206C696E652D6865696768743A6E6F726D616C5C725C6E202020207D5C725C6E202020202E73656374696F6E2D676170207B5C725C6E202020202020202070616464696E673A3020313570783B5C725C6E20202020202020206761703A313570783B5C725C6E20202020202020206D617267696E2D746F703A313070785C725C6E202020207D5C725C6E202020202E626F6C642D636F6C6C656374696F6E73207B5C725C6E20202020202020206D617267696E2D746F703A323870783B5C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D6465736372697074696F6E207B5C725C6E2020202020202020666F6E742D73697A653A313670782021696D706F7274616E745C725C6E202020207D5C725C6E202020202E696E6C696E652D636F6C2D77726170706572207B5C725C6E2020202020202020677269642D6761703A313570785C725C6E202020207D227D'),
	(11,11,'es',X'7B22636F6C756D6E5F31223A5B7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F61626F75742D7573222C227469746C65223A22416365726361206465204E6F736F74726F73222C22736F72745F6F72646572223A317D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F636F6E746163742D7573222C227469746C65223A22436F6E745C75303065316374656E6F73222C22736F72745F6F72646572223A327D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F637573746F6D65722D73657276696365222C227469746C65223A22536572766963696F20616C20436C69656E7465222C22736F72745F6F72646572223A337D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F77686174732D6E6577222C227469746C65223A224E6F76656461646573222C22736F72745F6F72646572223A347D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F7465726D732D6F662D757365222C227469746C65223A22545C7530306539726D696E6F732064652055736F222C22736F72745F6F72646572223A357D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F7465726D732D636F6E646974696F6E73222C227469746C65223A22545C7530306539726D696E6F73207920436F6E646963696F6E6573222C22736F72745F6F72646572223A367D5D2C22636F6C756D6E5F32223A5B7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F707269766163792D706F6C696379222C227469746C65223A22506F6C5C7530306564746963612064652050726976616369646164222C22736F72745F6F72646572223A317D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F7061796D656E742D706F6C696379222C227469746C65223A22506F6C5C753030656474696361206465205061676F222C22736F72745F6F72646572223A327D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F7368697070696E672D706F6C696379222C227469746C65223A22506F6C5C75303065647469636120646520456E765C75303065646F222C22736F72745F6F72646572223A337D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F726566756E642D706F6C696379222C227469746C65223A22506F6C5C753030656474696361206465204465766F6C7563695C75303066336E222C22736F72745F6F72646572223A347D2C7B2275726C223A2268747470733A5C2F5C2F6F75746C65742E68616C6C706F73322E636F6D2E636F5C2F706167655C2F72657475726E2D706F6C696379222C227469746C65223A22506F6C5C753030656474696361206465205265746F726E6F222C22736F72745F6F72646572223A357D5D7D'),
	(12,12,'es',X'7B227365727669636573223A5B7B227469746C65223A22456E765C75303065646F20677261747569746F222C226465736372697074696F6E223A22456E765C75303065646F20677261747569746F20656E20746F646F73206C6F732070656469646F73222C22736572766963655F69636F6E223A2269636F6E2D747275636B227D2C7B227469746C65223A225265656D706C617A6F2064652070726F647563746F222C226465736372697074696F6E223A225C75303061315265656D706C617A6F2064652070726F647563746F2073656E63696C6C6F20646973706F6E69626C6521222C22736572766963655F69636F6E223A2269636F6E2D70726F64756374227D2C7B227469746C65223A22454D4920646973706F6E69626C65222C226465736372697074696F6E223A22454D492073696E20636F73746F20646973706F6E69626C6520656E20746F646173206C6173207461726A657461732064652063725C75303065396469746F20636F6D756E6573222C22736572766963655F69636F6E223A2269636F6E2D646F6C6C61722D7369676E227D2C7B227469746C65223A22536F706F7274652032345C2F37222C226465736372697074696F6E223A22536F706F72746520646564696361646F2032345C2F3720706F722063686174207920636F7272656F20656C656374725C75303066336E69636F222C22736572766963655F69636F6E223A2269636F6E2D737570706F7274227D5D7D'),
	(13,13,'es',X'7B2268746D6C223A223C6120687265663D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D315C223E5C725C6E3C696D6720636C6173733D5C226C617A795C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F31335C2F31416579697855344E647267637A69396E687838695A6C37704370585066794F4845654F534F506B2E776562705C22207374796C653D5C226D617267696E2D746F703A20353070783B2077696474683A313030253B5C223E5C725C6E3C5C2F613E222C22637373223A22227D'),
	(15,18,'es',X'7B2268746D6C223A223C6120687265663D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F7365617263683F6E65773D315C223E5C725C6E3C696D6720636C6173733D5C226C617A795C2220646174612D7372633D5C2268747470733A5C2F5C2F62656C6C657A617973616C75642E68616C6C706F732E636F6D2E636F5C2F73746F726167655C2F7468656D655C2F31385C2F357364366C674475666A6D4252484F794A6A514A494A774B567544694B76397038506D7578634C702E776562705C22207374796C653D5C226D617267696E2D746F703A20353070783B2077696474683A313030253B5C223E5C725C6E3C5C2F613E222C22637373223A22227D');

/*!40000 ALTER TABLE `theme_customization_translations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table theme_customizations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `theme_customizations`;

CREATE TABLE `theme_customizations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `theme_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'default',
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `channel_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `theme_customizations_channel_id_foreign` (`channel_id`),
  CONSTRAINT `theme_customizations_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `theme_customizations` WRITE;
/*!40000 ALTER TABLE `theme_customizations` DISABLE KEYS */;

INSERT INTO `theme_customizations` (`id`, `theme_code`, `type`, `name`, `sort_order`, `status`, `channel_id`, `created_at`, `updated_at`)
VALUES
	(1,'default','image_carousel','Carrusel de Imágenes',1,1,1,'2024-09-25 10:19:36','2024-10-07 11:34:35'),
	(2,'default','static_content','Información de Oferta',1,1,1,'2024-09-25 10:19:36','2024-10-04 10:49:39'),
	(3,'default','category_carousel','Colecciones de Categorías',11,1,1,'2024-09-25 10:19:36','2024-10-07 10:58:07'),
	(4,'default','product_carousel','Nuevos Productos',4,1,1,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(5,'default','static_content','promociones',7,1,1,'2024-09-25 10:19:36','2024-10-07 11:52:12'),
	(6,'default','static_content','productos para hombres',5,1,1,'2024-09-25 10:19:36','2024-10-07 11:44:15'),
	(7,'default','product_carousel','Colecciones Destacadas',4,1,1,'2024-09-25 10:19:36','2024-10-07 10:49:39'),
	(8,'default','static_content','hombre y mujer',8,1,1,'2024-09-25 10:19:36','2024-10-07 11:54:26'),
	(9,'default','product_carousel','Todos los Productos',9,1,1,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(10,'default','static_content','Arma tu combo',10,1,1,'2024-09-25 10:19:36','2024-10-07 11:55:13'),
	(11,'default','footer_links','Enlaces del Pie de Página',11,1,1,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(12,'default','services_content','Contenido de Servicios',12,1,1,'2024-09-25 10:19:36','2024-09-25 10:19:36'),
	(13,'default','static_content','Rutina completa',4,1,1,'2024-09-26 08:49:27','2024-10-07 11:42:48'),
	(15,'default','category_carousel','N',5,0,1,'2024-09-26 09:58:23','2024-09-26 09:58:23'),
	(16,'default','category_carousel','Te Puede Interesar',5,0,1,'2024-09-26 09:59:31','2024-09-26 09:59:31'),
	(17,'default','static_content','Banner secundario',15,0,1,'2024-09-26 12:16:08','2024-09-26 12:16:08'),
	(18,'default','static_content','100% natural',11,1,1,'2024-10-07 10:28:07','2024-10-07 11:56:19');

/*!40000 ALTER TABLE `theme_customizations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table url_rewrites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `url_rewrites`;

CREATE TABLE `url_rewrites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `request_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

LOCK TABLES `url_rewrites` WRITE;
/*!40000 ALTER TABLE `url_rewrites` DISABLE KEYS */;

INSERT INTO `url_rewrites` (`id`, `entity_type`, `request_path`, `target_path`, `redirect_type`, `locale`, `created_at`, `updated_at`)
VALUES
	(1,'category','marcas','koaj','301','es','2024-09-26 10:57:50','2024-09-26 10:57:50'),
	(3,'product','copia-de-pantalon-marron','locion-de-rosas','301','es','2024-10-04 10:58:01','2024-10-04 10:58:01'),
	(4,'product','pantalon-marron','shampoo-oleil','301','es','2024-10-04 11:28:44','2024-10-04 11:28:44'),
	(6,'product','jabon-de-manos','kit-de-cremas','301','es','2024-10-04 11:39:40','2024-10-04 11:39:40'),
	(7,'product','vestido-cafe-de-motivos','talco-para-pies','301','es','2024-10-04 11:45:03','2024-10-04 11:45:03'),
	(8,'product','polo-blanco','desodorante-hombre','301','es','2024-10-04 11:54:06','2024-10-04 11:54:06'),
	(9,'product','vestido-mujer','crema-humectante','301','es','2024-10-04 11:58:52','2024-10-04 11:58:52'),
	(10,'product','camiseta-negra','gel-antibacterial','301','es','2024-10-04 12:04:20','2024-10-04 12:04:20'),
	(11,'product','oberol-mujer','crema-rostro','301','es','2024-10-04 12:09:50','2024-10-04 12:09:50'),
	(12,'product','copia-de-locion-de-rosas','crema-rostro','301','es','2024-10-04 14:40:59','2024-10-04 14:40:59'),
	(13,'category','gucci','loreal','301','es','2024-10-07 08:59:20','2024-10-07 08:59:20'),
	(14,'category','zara','dior','301','es','2024-10-07 09:00:48','2024-10-07 09:00:48'),
	(15,'category','fila','WELLA','301','es','2024-10-07 09:01:48','2024-10-07 09:01:48'),
	(16,'category','hm','nivea','301','es','2024-10-07 09:02:30','2024-10-07 09:02:30'),
	(17,'category','louis-vuitton','neutrogena','301','es','2024-10-07 09:03:29','2024-10-07 09:03:29'),
	(18,'category','lacoste','lbel','301','es','2024-10-07 09:04:30','2024-10-07 09:04:30'),
	(19,'category','chanel','natura','301','es','2024-10-07 09:05:28','2024-10-07 09:05:28'),
	(20,'category','studio-f','unilever','301','es','2024-10-07 09:06:40','2024-10-07 09:06:40');

/*!40000 ALTER TABLE `url_rewrites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table visits
# ------------------------------------------------------------

DROP TABLE IF EXISTS `visits`;

CREATE TABLE `visits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `url` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `referer` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `languages` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `useragent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `headers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `device` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `platform` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `browser` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visitable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visitable_id` bigint unsigned DEFAULT NULL,
  `visitor_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visitor_id` bigint unsigned DEFAULT NULL,
  `channel_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `visits_visitable_type_visitable_id_index` (`visitable_type`,`visitable_id`),
  KEY `visits_visitor_type_visitor_id_index` (`visitor_type`,`visitor_id`),
  KEY `visits_channel_id_foreign` (`channel_id`),
  CONSTRAINT `visits_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table wishlist
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wishlist`;

CREATE TABLE `wishlist` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `customer_id` int unsigned NOT NULL,
  `item_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `moved_to_cart` date DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `time_of_moving` date DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wishlist_channel_id_foreign` (`channel_id`),
  KEY `wishlist_product_id_foreign` (`product_id`),
  KEY `wishlist_customer_id_foreign` (`customer_id`),
  CONSTRAINT `wishlist_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_chk_1` CHECK (json_valid(`item_options`)),
  CONSTRAINT `wishlist_chk_2` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;



# Dump of table wishlist_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wishlist_items`;

CREATE TABLE `wishlist_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `customer_id` int unsigned NOT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `moved_to_cart` date DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wishlist_items_channel_id_foreign` (`channel_id`),
  KEY `wishlist_items_product_id_foreign` (`product_id`),
  KEY `wishlist_items_customer_id_foreign` (`customer_id`),
  CONSTRAINT `wishlist_items_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_items_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_items_chk_1` CHECK (json_valid(`additional`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
