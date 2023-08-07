drop database if exists ccw;
create database ccw;
use ccw;

create table LOG(
    id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp DATETIME NOT NULL,
    descrizione VARCHAR(122) NOT NULL
);

create table SENSORE(
    id char(4) PRIMARY KEY,
    descrizione VARCHAR(80) NOT NULL 
);


create table FINESTRA(
    numero int NOT NULL,
    aula VARCHAR(50) NOT NULL,
    sensore_id char(4),
    FOREIGN KEY (sensore_id) REFERENCES SENSORE(id) on delete set null,
    PRIMARY KEY (numero, aula)
);


create table STATO(
    id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp DATETIME,
    stato tinyint(1) NOT NULL,
    sensore_id char(4),
    finestra_numero int NOT NULL,
    finestra_aula VARCHAR(50) NOT NULL,
    FOREIGN KEY (finestra_numero, finestra_aula) REFERENCES FINESTRA(numero, aula),
    FOREIGN KEY (sensore_id) REFERENCES SENSORE(id) on delete set null
);


create table TIPO(
    nome varchar(25) PRIMARY KEY
);

create table UTENTE(
    nome varchar(50) PRIMARY KEY,
    password varchar(60) NOT NULL,
    tipo_nome varchar(25) NOT NULL,
    FOREIGN KEY (tipo_nome) REFERENCES TIPO(nome)
);





/* Creazione utenti */
DROP USER IF EXISTS 'mysql-mqtt-user'@'%';
CREATE USER 'mysql-mqtt-user'@'%' IDENTIFIED BY 'Password&1';
GRANT INSERT ON ccw.STATO TO 'mysql-mqtt-user'@'%';

DROP USER IF EXISTS 'mysql-kyudd-user'@'%';
CREATE USER 'mysql-kyudd-user'@'%' IDENTIFIED BY 'Password&1';
GRANT SELECT ON ccw.* TO 'mysql-kyudd-user'@'%';
GRANT UPDATE ON ccw.LOG TO 'mysql-kyudd-user'@'%';

FLUSH PRIVILEGES;

insert into SENSORE(id, descrizione) VALUES("00AD", "un sensore");
insert into SENSORE(id, descrizione) VALUES("3426", "Primo sensore");
insert into FINESTRA(numero,aula,sensore_id) VALUES(1,"404","00AD");
insert into FINESTRA(numero,aula,sensore_id) VALUES(2,"404","00AD");
insert into STATO(timestamp,stato,finestra_numero,finestra_aula) VALUES("2023-05-04 09:55:00",0,1,"404");
insert into STATO(timestamp,stato,finestra_numero,finestra_aula) VALUES('2023-05-04 10:55:00',1,1,"404");
insert into STATO(timestamp,stato,finestra_numero,finestra_aula) VALUES('2023-05-04 11:55:00',0,1,"404");
insert into STATO(timestamp,stato,finestra_numero,finestra_aula) VALUES('2023-05-04 09:55:00',1,2,"404");

insert into TIPO(nome) VALUES("standard");
insert into TIPO(nome) VALUES("admin");
insert into UTENTE(nome,password,tipo_nome) VALUES("admin","$2b$12$ed0NKe7REbgEIILwVM8qo.HeWowRZWK/zIfNxO/8eyIQ4bgEYLmSm","admin");
insert into UTENTE(nome,password,tipo_nome) VALUES("standard","$2b$12$D/Fk/rLGslMKRBjxP9IUNOT1U00W4/mv5vh8opuVRr0Kogwreo4A.","standard");
insert into UTENTE(nome,password,tipo_nome) VALUES("kyudd-imi","$2b$12$p.HUpIOku9N5KP4VDG212uVyuSV9I8rhZ8opX/nT6f0UYuL8xXcG.","admin");


/* Inserimento stati aule e aule*/
 
 insert into FINESTRA(numero,aula,sensore_id) VALUES(1,"444","00AD"); 
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-02-17 10:13:45',0,1,"444","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(2,"444","00AD"); 
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2020-02-17 10:13:45',0,2,"444","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"444","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"444","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"443","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"443","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"442","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"442","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"441","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"441","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"445","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"445","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"446","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"446","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"447","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"447","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"448","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"448","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"409","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"409","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"410","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"410","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"411","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"411","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"412","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"412","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"413","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"413","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"414","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"414","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"415","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"415","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"All-4","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"All-4","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"417","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"417","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"418","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"418","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"419","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"419","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"420","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"420","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"421","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"421","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"422","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"422","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"407","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"407","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"406","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"406","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"405","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"405","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"404","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"404","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"403","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"403","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"402","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"402","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"401","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"401","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"425","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"425","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"426","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"426","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"427","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"427","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"428","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"428","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"429","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"429","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"430","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"430","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"431","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"431","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"432","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"432","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"244","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"244","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"243","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"243","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"242","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"242","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"241","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"241","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"245","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"245","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"246","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"246","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"247","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"247","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"248","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"248","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"224","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"224","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"222","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"222","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"221","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"221","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"220","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"220","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"219","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"219","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"All-2","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"All-2","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"217","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"217","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"216","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"216","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"215","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"215","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"214","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"214","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"213","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"213","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"212","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"212","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"211","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"211","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"226","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"226","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"227","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"227","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"228","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"228","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"229","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"229","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"230","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"230","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"231","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"231","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"232","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"232","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"209","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"209","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"208","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"208","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"207","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"207","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"206","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"206","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"205","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"205","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"204","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"204","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"203","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"203","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"202","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"202","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"115","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"115","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"120","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"120","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"119","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"119","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"118","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"118","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"117","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"117","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"116","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"116","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"114","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"114","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"All-1","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"All-1","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"113","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"113","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"112","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"112","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"111","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"111","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"110","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"110","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"109","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"109","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"128","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"128","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"127","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"127","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"126","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"126","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"125","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"125","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"124","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"124","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"123","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"123","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"122","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"122","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"107","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"107","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"106","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"106","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"105","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"105","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"104","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"104","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"103","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"103","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"102","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"102","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"147","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"147","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"145","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"145","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"148","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"148","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"146","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"146","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"144","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"144","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"143","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"143","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"142","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"142","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"141","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"141","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"149","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"149","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"150","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"150","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"152","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"152","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"153","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"153","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"341","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"341","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"342","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"342","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"343","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"343","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"344","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"344","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"348","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"348","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"347","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"347","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"346","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"346","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"345","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"345","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"322","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"322","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"321","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"321","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"320","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"320","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"319","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"319","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"318","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"318","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"317","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"317","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"All-3","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"All-3","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"315","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"315","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"314","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"314","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"313","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"313","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"312","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"312","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"311","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"311","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"310","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"310","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"324","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"324","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"325","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"325","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"326","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"326","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"327","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"327","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"328","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"328","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"329","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"329","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"330","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"330","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"308","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"308","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"307","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"307","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"306","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"306","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"305","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"305","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"304","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"304","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"303","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"303","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"302","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"302","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"019","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"019","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"018","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"018","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"017","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"017","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"016","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"016","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"All-0","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"All-0","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"014","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"014","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"013","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"013","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"012","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"012","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"011","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"011","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"010","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"010","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"021","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"021","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"022","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"022","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"023","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"023","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"024","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"024","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"008","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"008","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"007","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"007","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"006","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"006","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"005","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"005","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"004","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"004","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"003","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"003","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"002","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',1,0,"002","00AD");
 insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"041","00AD");
 insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('2023-05-17 10:13:45',0,0,"041","00AD");
