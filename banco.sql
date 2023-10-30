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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

/*Data for the table `pedidosdadosgerais` */

insert  into `pedidosdadosgerais`(`NumeroPedido`,`DataEmissao`,`CodigoCliente`,`ValorTotal`) values 
(2,'2023-10-29',1,0.00),
(3,'2023-10-29',1,0.00),
(7,'2023-10-29',3,0.00),
(9,'2023-10-29',3,0.00),
(10,'2023-10-29',0,0.00),
(11,'2023-10-29',3,0.00),
(12,'2023-10-29',6,0.00),
(13,'2023-10-29',8,0.00),
(14,'2023-10-29',4,0.00),
(15,'2023-10-29',1,0.00),
(16,'2023-10-29',1,0.00),
(17,'2023-10-29',4,0.00),
(18,'2023-10-29',5,0.00),
(19,'2023-10-29',5,0.00),
(20,'2023-10-29',6,0.00),
(21,'2023-10-29',6,0.00),
(22,'2023-10-29',17,0.00),
(23,'2023-10-29',9,0.00),
(24,'2023-10-29',8,0.00),
(25,'2023-10-29',3,0.00),
(26,'2023-10-29',4,0.00),
(27,'2023-10-29',1,0.00),
(28,'2023-10-29',4,0.00),
(29,'2023-10-29',6,0.00),
(30,'2023-10-29',8,0.00),
(31,'2023-10-29',5,0.00),
(32,'2023-10-29',8,0.00),
(33,'2023-10-29',5,0.00),
(34,'2023-10-29',3,0.00),
(35,'2023-10-29',5,0.00),
(36,'2023-10-29',6,0.00),
(37,'2023-10-29',20,0.00),
(38,'2023-10-29',5,0.00),
(39,'2023-10-29',18,0.00),
(40,'2023-10-29',4,0.00),
(41,'2023-10-29',1,0.00),
(42,'2023-10-29',2,0.00),
(43,'2023-10-29',7,0.00),
(44,'2023-10-29',1,0.00),
(45,'2023-10-29',1,0.00),
(46,'2023-10-29',0,0.00),
(47,'2023-10-29',2,0.00),
(48,'2023-10-29',8,0.00),
(49,'2023-10-29',7,0.00),
(50,'2023-10-29',1,0.00),
(51,'2023-10-29',8,0.00),
(52,'2023-10-29',9,0.00),
(53,'2023-10-29',7,0.00),
(54,'2023-10-30',9,0.00),
(55,'2023-10-30',6,0.00);

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

/*Data for the table `pedidosprodutos` */

insert  into `pedidosprodutos`(`Autoincrem`,`NumeroPedido`,`CodigoProduto`,`Quantidade`,`ValorUnitario`,`ValorTotal`) values 
(2,9,5,1,1499.99,1499.99),
(3,11,7,5,249.99,1249.95),
(4,12,10,1,149.99,149.99),
(5,12,10,1,149.99,149.99),
(6,13,8,1,1499.99,1499.99),
(7,14,9,1,799.99,799.99),
(8,14,8,1,1499.99,1499.99),
(9,15,4,5,899.99,4499.95),
(10,16,3,5,4000.00,20000.00),
(11,17,4,3,899.99,2699.97),
(12,18,5,1,1499.99,1499.99),
(13,19,7,7,249.99,1749.93),
(14,22,5,8,1499.99,11999.92),
(15,24,7,1,249.99,249.99),
(17,26,5,1,1499.99,1499.99),
(18,28,3,1,4000.00,4000.00),
(19,29,5,1,1499.99,1499.99),
(20,30,3,1,4000.00,4000.00),
(21,31,21,1,2499.99,2499.99),
(22,33,6,1,799.99,799.99),
(23,34,3,1,4000.00,4000.00),
(24,34,6,1,799.99,799.99),
(25,35,3,1,4000.00,4000.00),
(26,36,4,8,899.99,899.99),
(27,37,22,5,1799.99,1799.99),
(28,37,5,5,1499.99,7499.95),
(29,38,11,2,799.99,799.99),
(30,38,8,1,1499.99,1499.99),
(31,39,8,1,1499.99,1499.99),
(32,39,5,2,1499.99,1499.99),
(33,39,9,1,799.99,799.99),
(34,40,14,1,299.99,299.99),
(35,41,7,2,249.99,499.98),
(36,42,7,1,249.99,249.99),
(37,42,7,3,249.99,749.97),
(38,43,7,0,249.99,0.00),
(39,44,3,1,4000.00,4000.00),
(40,46,3,1,4000.00,4000.00),
(41,49,3,1,4000.00,4000.00),
(42,49,9,7,799.99,5599.93),
(43,49,19,1,199.99,199.99),
(44,50,6,1,799.99,799.99),
(45,50,6,1,799.99,799.99),
(46,50,5,2,1499.99,2999.98),
(48,51,13,1,199.99,199.99),
(50,53,4,1,899.99,899.99),
(52,53,9,1,799.99,799.99);

/*Table structure for table `produtos` */

DROP TABLE IF EXISTS `produtos`;

CREATE TABLE `produtos` (
  `Codigo` int(11) NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(255) NOT NULL,
  `PrecoVenda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

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
(23,'Forno Elétrico Brastemp Gourmet',499.99),
(24,'Coleira',20.00);

/*Table structure for table `view_listarpedido` */

DROP TABLE IF EXISTS `view_listarpedido`;

/*!50001 DROP VIEW IF EXISTS `view_listarpedido` */;
/*!50001 DROP TABLE IF EXISTS `view_listarpedido` */;

/*!50001 CREATE TABLE  `view_listarpedido`(
 `Autoincrem` int(11) ,
 `G_NumeroPedido` int(11) ,
 `CodigoProduto` int(11) ,
 `Descricao` varchar(255) ,
 `Quantidade` int(11) ,
 `ValorUnitario` decimal(10,2) ,
 `ValorTotal` decimal(10,2) 
)*/;

/*View structure for view view_listarpedido */

/*!50001 DROP TABLE IF EXISTS `view_listarpedido` */;
/*!50001 DROP VIEW IF EXISTS `view_listarpedido` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_listarpedido` AS select `i`.`Autoincrem` AS `Autoincrem`,`g`.`NumeroPedido` AS `G_NumeroPedido`,`p`.`Codigo` AS `CodigoProduto`,`p`.`Descricao` AS `Descricao`,`i`.`Quantidade` AS `Quantidade`,`i`.`ValorUnitario` AS `ValorUnitario`,`i`.`ValorTotal` AS `ValorTotal` from ((`pedidosdadosgerais` `g` join `produtos` `p` on((`g`.`NumeroPedido` = `p`.`Codigo`))) join `pedidosprodutos` `i` on((`g`.`NumeroPedido` = `i`.`NumeroPedido`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
