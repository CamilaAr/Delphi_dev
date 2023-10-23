/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 5.7.43-log : Database - lojateste
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lojateste` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `lojateste`;

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `Codigo` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(255) NOT NULL,
  `Cidade` varchar(100) DEFAULT NULL,
  `UF` char(2) DEFAULT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `clientes` */

insert  into `clientes`(`Codigo`,`Nome`,`Cidade`,`UF`) values 
(1,'João Silva','São Paulo','SP'),
(2,'Maria Santos','Rio de Janeiro','RJ'),
(3,'Pedro Rocha','Belo Horizonte','MG'),
(4,'Ana Pereira','Brasília','DF'),
(5,'Luiz Ferreira','Porto Alegre','RS'),
(6,'Carla Mendes','Salvador','BA'),
(7,'Ricardo Oliveira','Fortaleza','CE'),
(8,'Fernanda Almeida','Recife','PE'),
(9,'Eduardo Souza','Manaus','AM'),
(10,'Patrícia Costa','Curitiba','PR'),
(11,'Marcos Santos','Belém','PA'),
(12,'Camila Lima','Goiânia','GO'),
(13,'Lucas Fernandes','Cuiabá','MT'),
(14,'Mariana Cardoso','Natal','RN'),
(15,'Gustavo Alves','Vitória','ES'),
(16,'Isabela Cunha','Campo Grande','MS'),
(17,'Thiago Gomes','Teresina','PI'),
(18,'André Xavier','João Pessoa','PB'),
(19,'Juliana Barbosa','Aracaju','SE'),
(20,'Roberto Duarte','Teresópolis','RJ');

/*Table structure for table `pedidosdadosgerais` */

DROP TABLE IF EXISTS `pedidosdadosgerais`;

CREATE TABLE `pedidosdadosgerais` (
  `NumeroPedido` int(11) NOT NULL AUTO_INCREMENT,
  `DataEmissao` date DEFAULT NULL,
  `CodigoCliente` int(11) DEFAULT NULL,
  `ValorTotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`NumeroPedido`),
  KEY `idx_NumeroPedido_PedidosDadosGerais` (`NumeroPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pedidosdadosgerais` */

/*Table structure for table `pedidosprodutos` */

DROP TABLE IF EXISTS `pedidosprodutos`;

CREATE TABLE `pedidosprodutos` (
  `Autoincrem` int(11) NOT NULL AUTO_INCREMENT,
  `NumeroPedido` int(11) DEFAULT NULL,
  `CodigoProduto` int(11) DEFAULT NULL,
  `Quantidade` int(11) DEFAULT NULL,
  `ValorUnitario` decimal(10,2) DEFAULT NULL,
  `ValorTotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Autoincrem`),
  KEY `idx_NumeroPedido_PedidosProdutos` (`NumeroPedido`),
  KEY `idx_CodigoProduto_PedidosProdutos` (`CodigoProduto`),
  CONSTRAINT `pedidosprodutos_ibfk_1` FOREIGN KEY (`NumeroPedido`) REFERENCES `pedidosdadosgerais` (`NumeroPedido`),
  CONSTRAINT `pedidosprodutos_ibfk_2` FOREIGN KEY (`CodigoProduto`) REFERENCES `produtos` (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pedidosprodutos` */

/*Table structure for table `produtos` */

DROP TABLE IF EXISTS `produtos`;

CREATE TABLE `produtos` (
  `Codigo` int(11) NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(255) NOT NULL,
  `PrecoVenda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `produtos` */

insert  into `produtos`(`Codigo`,`Descricao`,`PrecoVenda`) values 
(3,'TV LG OLED 55 ',4000.00),
(4,'Fogão Brastemp 3 bocas',899.99),
(5,'Geladeira Electrolux 2 portas',1499.99),
(6,'Máquina de Lavar Roupa Panasonic',799.99),
(7,'Cadeira de Escritório Ergonômic',249.99),
(8,'Sofá de Couro Legítimo',1499.99),
(9,'Mesa de Jantar em Madeira Maciça',799.99),
(10,'Tênis Nike Air Max 90',149.99),
(11,'Bicicleta Mountain Bike Cannondale',799.99),
(12,'Máquina de Café Espresso Breville',399.99),
(13,'Impressora Multifuncional HP',199.99),
(14,'Relógio Seiko Automático',299.99),
(15,'Câmera Canon EOS Rebel T7',599.99),
(16,'Ventilador de Teto Hunter',199.99),
(17,'Mala de Viagem Samsonite',149.99),
(18,'Churrasqueira a Gás Weber',799.99),
(19,'Secador de Cabelo Dyson',199.99),
(20,'Forno Elétrico Brastemp Gourmet',499.99),
(21,'Smartphone Samsung Galaxy S21',2499.99),
(22,'Notebook Dell Inspiron 15',1799.99),
(23,'Forno Elétrico Brastemp Gourmet',499.99);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
