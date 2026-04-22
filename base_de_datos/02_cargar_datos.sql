-- =============================================
-- BASE DE DATOS: Control de Vacaciones
-- SCRIPT: 02_cargar_datos.sql
-- DESCRIPCION: Carga de datos de prueba
-- AUTORES: Fernando Abarca e Isaac Van de Bon
-- FECHA: 22 de Abril 2026
-- =============================================

USE ControlVacaciones;
GO

--Aquí vamos a cargar la tabla puestos: --XML de referencia 
/*
<Puesto Nombre="Cajero" SalarioxHora="11.00"/>
<Puesto Nombre="Camarero" SalarioxHora="10.00"/>
<Puesto Nombre="Cuidador" SalarioxHora="13.50"/>
<Puesto Nombre="Conductor" SalarioxHora="15.00"/>
<Puesto Nombre="Asistente" SalarioxHora="11.00"/>
<Puesto Nombre="Recepcionista" SalarioxHora="12.00"/>
<Puesto Nombre="Fontanero" SalarioxHora="13.00"/>
<Puesto Nombre="Niñera" SalarioxHora="12.00"/>
<Puesto Nombre="Conserje" SalarioxHora="11.00"/>
<Puesto Nombre="Albañil" SalarioxHora="10.50"/>
*/

INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Cajero', 11.00)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Camarero', 10.00)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Cuidador', 13.50)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Conductor', 15.00)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Asistente', 11.00)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Recepcionista', 12.00)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Fontanero', 13.00)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Niñera', 12.00)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Conserje', 11.00)
INSERT INTO Puesto (Nombre, SalarioxHora) VALUES('Albañil', 10.50)

--Creo que hice mal esto, porque no sé si debe haber algún script que cargue esto automáticamente :,(  

GO

--Aqui vamos a insertar los tipos de evento
/*
TipoEvento Id="1" Nombre="Login Exitoso"/>
<TipoEvento Id="2" Nombre="Login No Exitoso"/>
<TipoEvento Id="3" Nombre="Login deshabilitado"/>
<TipoEvento Id="4" Nombre="Logout"/>
<TipoEvento Id="5" Nombre="Insercion no exitosa"/>
<TipoEvento Id="6" Nombre="Insercion exitosa"/>
<TipoEvento Id="7" Nombre="Update no exitoso"/>
<TipoEvento Id="8" Nombre="Update exitoso"/>
<TipoEvento Id="9" Nombre="Intento de borrado"/>
<TipoEvento Id="10" Nombre="Borrado exitoso"/>
<TipoEvento Id="11" Nombre="Consulta con filtro de nombre"/>
<TipoEvento Id="12" Nombre="Consulta con filtro de cedula"/>
<TipoEvento Id="13" Nombre="Intento de insertar movimiento"/>
<TipoEvento Id="14" Nombre="Insertar movimiento exitoso"/>
*/

INSERT INTO TipoEvento(Id, Nombre) VALUES(1, 'Login Exitoso')
INSERT INTO TipoEvento(Id, Nombre) VALUES(2, 'Login No Exitoso')
INSERT INTO TipoEvento(Id, Nombre) VALUES(3, 'Login deshabilitado')
INSERT INTO TipoEvento(Id, Nombre) VALUES(4, 'Logout')
INSERT INTO TipoEvento(Id, Nombre) VALUES(5, 'Insercion no exitosa')
INSERT INTO TipoEvento(Id, Nombre) VALUES(6, 'Insercion exitosa')
INSERT INTO TipoEvento(Id, Nombre) VALUES(7, 'Update no exitoso')
INSERT INTO TipoEvento(Id, Nombre) VALUES(8, 'Update exitoso')
INSERT INTO TipoEvento(Id, Nombre) VALUES(9, 'Intento de borrado')
INSERT INTO TipoEvento(Id, Nombre) VALUES(10, 'Borrado exitoso')
INSERT INTO TipoEvento(Id, Nombre) VALUES(11, 'Consulta con filtro de nombre')
INSERT INTO TipoEvento(Id, Nombre) VALUES(12, 'Consulta con filtro de cedula')
INSERT INTO TipoEvento(Id, Nombre) VALUES(13, 'Intento de insertar movimiento')
INSERT INTO TipoEvento(Id, Nombre) VALUES(14, 'Insertar movimiento exitoso')

GO

/*
<error Codigo="50001" Descripcion="Username no existe"/>
<error Codigo="50002" Descripcion="Password no existe"/>
<error Codigo="50003" Descripcion="Login deshabilitado"/>
<error Codigo="50004" Descripcion="Empleado con ValorDocumentoIdentidad ya existe en inserción"/>
<error Codigo="50005" Descripcion="Empleado con mismo nombre ya existe en inserción"/>
<error Codigo="50006" Descripcion="Empleado con ValorDocumentoIdentidad ya existe en actualizacion"/>
<error Codigo="50007" Descripcion="Empleado con mismo nombre ya existe en actualización"/>
<error Codigo="50008" Descripcion="Error de base de datos"/>
<error Codigo="50009" Descripcion="Nombre de empleado no alfabético"/>
<error Codigo="50010" Descripcion="Valor de documento de identidad no alfabético"/>
<error Codigo="50011" Descripcion="Monto del movimiento rechazado pues si se aplicar el saldo seria negativo."/>
*/
--Aqui van los codigos de error
INSERT INTO Error (Codigo, Descripcion) VALUES (50001, 'Username no existe');
INSERT INTO Error (Codigo, Descripcion) VALUES (50002, 'Password no existe');
INSERT INTO Error (Codigo, Descripcion) VALUES (50003, 'Login deshabilitado');
INSERT INTO Error (Codigo, Descripcion) VALUES (50004, 'Empleado con ValorDocumentoIdentidad ya existe en inserción');
INSERT INTO Error (Codigo, Descripcion) VALUES (50005, 'Empleado con mismo nombre ya existe en inserción');
INSERT INTO Error (Codigo, Descripcion) VALUES (50006, 'Empleado con ValorDocumentoIdentidad ya existe en actualizacion');
INSERT INTO Error (Codigo, Descripcion) VALUES (50007, 'Empleado con mismo nombre ya existe en actualización');
INSERT INTO Error (Codigo, Descripcion) VALUES (50008, 'Error de base de datos');
INSERT INTO Error (Codigo, Descripcion) VALUES (50009, 'Nombre de empleado no alfabético');
INSERT INTO Error (Codigo, Descripcion) VALUES (50010, 'Valor de documento de identidad no alfabético');
INSERT INTO Error (Codigo, Descripcion) VALUES (50011, 'Monto del movimiento rechazado pues si se aplicar el saldo seria negativo.');
GO

/*
<Usuarios>
<usuario Id="1" Nombre="UsuarioScripts" Pass="UsuarioScripts"/>
<usuario Id="2" Nombre="mgarrison" Pass=")*2LnSr^lk"/>
<usuario Id="3" Nombre="jgonzalez" Pass="3YSI0HtiXI"/>
<usuario Id="4" Nombre="zkelly" Pass="X4US4aLam@"/>
<usuario Id="5" Nombre="andersondeborah" Pass="732F34xo%S"/>
<usuario Id="6" Nombre="hardingmicheal" Pass="himB9Dzd%_"/>
<usuario Id="7" Nombre="martinezlisa" Pass="7Kp9vQ2mT1"/>
<usuario Id="8" Nombre="floresdaniel" Pass="H4s8Nq3xL6"/>
<usuario Id="9" Nombre="perezmaria" Pass="R2m7Bv5cZ8"/>
<usuario Id="10" Nombre="torresluis" Pass="J9t6Wk4pS3"/>
</Usuarios>
*/

--Aqui vamos a insertar Usuario
INSERT INTO Usuario(Id, Username, [Password]) VALUES(1, 'UsuarioScripts', 'UsuarioScripts')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(2, 'mgarrison', ')*2LnSr^lk')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(3, 'jgonzalez', '3YSI0HtiXI')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(4, 'zkelly', 'X4US4aLam@')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(5, 'andersondeborah', '732F34xo%S')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(6, 'hardingmicheal', 'himB9Dzd%_')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(7, 'martinezlisa', '7Kp9vQ2mT1')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(8, 'floresdaniel', 'H4s8Nq3xL6')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(9, 'perezmaria', 'R2m7Bv5cZ8')
INSERT INTO Usuario(Id, Username, [Password]) VALUES(10, 'torresluis', 'J9t6Wk4pS3')

GO

/*
<TipoMovimiento Id="1" Nombre="Cumplir mes" TipoAccion="Credito"/>
<TipoMovimiento Id="2" Nombre="Bono vacacional" TipoAccion="Credito"/>
<TipoMovimiento Id="3" Nombre="Reversion Debito" TipoAccion="Credito"/>
<TipoMovimiento Id="4" Nombre="Disfrute de vacaciones" TipoAccion="Debito"/>
<TipoMovimiento Id="5" Nombre="Venta de vacaciones" TipoAccion="Debito"/>
<TipoMovimiento Id="6" Nombre="Reversion de Credito" TipoAccion="Debito"/>
*/
--Aqui vamos a insertar el TipoMovimiento
INSERT INTO TipoMovimiento (Id, Nombre, TipoAccion) VALUES (1, 'Cumplir mes', 'Credito');
INSERT INTO TipoMovimiento (Id, Nombre, TipoAccion) VALUES (2, 'Bono vacacional', 'Credito');
INSERT INTO TipoMovimiento (Id, Nombre, TipoAccion) VALUES (3, 'Reversion Debito', 'Credito');
INSERT INTO TipoMovimiento (Id, Nombre, TipoAccion) VALUES (4, 'Disfrute de vacaciones', 'Debito');
INSERT INTO TipoMovimiento (Id, Nombre, TipoAccion) VALUES (5, 'Venta de vacaciones', 'Debito');
INSERT INTO TipoMovimiento (Id, Nombre, TipoAccion) VALUES (6, 'Reversion de Credito', 'Debito');

GO

/*
<empleado Puesto="Camarero" ValorDocumentoIdentidad="6993943" Nombre="Kaitlyn Jensen" FechaContratacion="2017-12-07"/>
<empleado Puesto="Albañil" ValorDocumentoIdentidad="1896802" Nombre="Robert Buchanan" FechaContratacion="2020-09-20"/>
<empleado Puesto="Cajero" ValorDocumentoIdentidad="5095109" Nombre="Christina Ward" FechaContratacion="2015-09-13"/>
<empleado Puesto="Fontanero" ValorDocumentoIdentidad="8403646" Nombre="Bradley Wright" FechaContratacion="2020-01-27"/>
<empleado Puesto="Conserje" ValorDocumentoIdentidad="6019592" Nombre="Robert Singh" FechaContratacion="2017-02-01"/>
<empleado Puesto="Asistente" ValorDocumentoIdentidad="4510358" Nombre="Ryan Mitchell" FechaContratacion="2018-06-08"/>
<empleado Puesto="Asistente" ValorDocumentoIdentidad="7517662" Nombre="Candace Fox" FechaContratacion="2013-12-17"/>
<empleado Puesto="Asistente" ValorDocumentoIdentidad="8326328" Nombre="Allison Murillo" FechaContratacion="2020-04-19"/>
<empleado Puesto="Cuidador" ValorDocumentoIdentidad="2161775" Nombre="Jessica Murphy" FechaContratacion="2017-04-12"/>
<empleado Puesto="Fontanero" ValorDocumentoIdentidad="2918773" Nombre="Nancy Newton PhD" FechaContratacion="2016-11-22"/>
<empleado Puesto="Conductor" ValorDocumentoIdentidad="9772211" Nombre="Alicia Ortega" FechaContratacion="2021-05-14"/>
<empleado Puesto="Recepcionista" ValorDocumentoIdentidad="6641189" Nombre="Pedro Salas" FechaContratacion="2019-03-21"/>
<empleado Puesto="Niñera" ValorDocumentoIdentidad="3389054" Nombre="Sofía Herrera" FechaContratacion="2022-08-09"/>
*/
--Aqui vamos a insertar los empleados
--Tuve que reaprender como funcionaba buscar en la misma base de datos xd

INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Camarero'),     '6993943', 'Kaitlyn Jensen',   '2017-12-07');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Albañil'),       '1896802', 'Robert Buchanan',  '2020-09-20');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Cajero'),        '5095109', 'Christina Ward',   '2015-09-13');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Fontanero'),     '8403646', 'Bradley Wright',   '2020-01-27');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Conserje'),      '6019592', 'Robert Singh',     '2017-02-01');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Asistente'),     '4510358', 'Ryan Mitchell',    '2018-06-08');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Asistente'),     '7517662', 'Candace Fox',      '2013-12-17');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Asistente'),     '8326328', 'Allison Murillo',  '2020-04-19');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Cuidador'),      '2161775', 'Jessica Murphy',   '2017-04-12');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Fontanero'),     '2918773', 'Nancy Newton PhD', '2016-11-22');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Conductor'),     '9772211', 'Alicia Ortega',    '2021-05-14');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Recepcionista'), '6641189', 'Pedro Salas',      '2019-03-21');
INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion) VALUES (
    (SELECT Id FROM Puesto WHERE Nombre = 'Niñera'),        '3389054', 'Sofía Herrera',    '2022-08-09');
GO


/*
<movimiento ValorDocId="7517662" IdTipoMovimiento="Venta de vacaciones" Fecha="2024-01-18" Monto="2" PostByUser="hardingmicheal" PostInIP="42.142.119.153" PostTime="2024-01-18 18:47:14"/>
<movimiento ValorDocId="6993943" IdTipoMovimiento="Bono vacacional" Fecha="2024-10-31" Monto="1" PostByUser="mgarrison" PostInIP="156.92.82.57" PostTime="2024-10-31 12:43:18"/>
<movimiento ValorDocId="8326328" IdTipoMovimiento="Venta de vacaciones" Fecha="2024-11-22" Monto="7" PostByUser="andersondeborah" PostInIP="218.213.110.232" PostTime="2024-11-22 00:23:53"/>
<movimiento ValorDocId="4510358" IdTipoMovimiento="Reversion de Credito" Fecha="2024-07-03" Monto="3" PostByUser="hardingmicheal" PostInIP="143.42.131.166" PostTime="2024-07-03 17:07:39"/>
<movimiento ValorDocId="8403646" IdTipoMovimiento="Reversion de Credito" Fecha="2024-12-07" Monto="8" PostByUser="zkelly" PostInIP="155.44.100.105" PostTime="2024-12-07 15:44:30"/>
<movimiento ValorDocId="8326328" IdTipoMovimiento="Venta de vacaciones" Fecha="2024-11-26" Monto="10" PostByUser="hardingmicheal" PostInIP="141.163.255.56" PostTime="2024-11-26 09:33:41"/>
<movimiento ValorDocId="6993943" IdTipoMovimiento="Disfrute de vacaciones" Fecha="2024-11-20" Monto="6" PostByUser="hardingmicheal" PostInIP="4.176.52.1" PostTime="2024-11-20 23:31:41"/>
<movimiento ValorDocId="2918773" IdTipoMovimiento="Disfrute de vacaciones" Fecha="2024-10-30" Monto="10" PostByUser="zkelly" PostInIP="220.164.108.231" PostTime="2024-10-30 03:55:57"/>
<movimiento ValorDocId="2161775" IdTipoMovimiento="Reversion Debito" Fecha="2024-06-13" Monto="2" PostByUser="hardingmicheal" PostInIP="135.223.57.22" PostTime="2024-06-13 13:28:39"/>
<movimiento ValorDocId="8403646" IdTipoMovimiento="Bono vacacional" Fecha="2024-01-01" Monto="6" PostByUser="zkelly" PostInIP="150.250.94.62" PostTime="2024-01-01 05:17:10"/>
<movimiento ValorDocId="2918773" IdTipoMovimiento="Venta de vacaciones" Fecha="2024-07-12" Monto="6" PostByUser="hardingmicheal" PostInIP="218.191.123.15" PostTime="2024-07-12 09:10:16"/>
<movimiento ValorDocId="5095109" IdTipoMovimiento="Reversion de Credito" Fecha="2024-12-27" Monto="14" PostByUser="hardingmicheal" PostInIP="136.103.23.170" PostTime="2024-12-27 12:59:03"/>
<movimiento ValorDocId="6993943" IdTipoMovimiento="Venta de vacaciones" Fecha="2024-04-08" Monto="1" PostByUser="jgonzalez" PostInIP="158.48.100.86" PostTime="2024-04-08 01:24:38"/>
<movimiento ValorDocId="8403646" IdTipoMovimiento="Bono vacacional" Fecha="2024-08-25" Monto="8" PostByUser="jgonzalez" PostInIP="204.0.219.231" PostTime="2024-08-25 16:24:07"/>
<movimiento ValorDocId="5095109" IdTipoMovimiento="Bono vacacional" Fecha="2024-03-07" Monto="7" PostByUser="andersondeborah" PostInIP="208.0.4.33" PostTime="2024-03-07 08:19:28"/>
<movimiento ValorDocId="9772211" IdTipoMovimiento="Cumplir mes" Fecha="2024-02-14" Monto="4" PostByUser="martinezlisa" PostInIP="10.10.10.10" PostTime="2024-02-14 08:11:00"/>
<movimiento ValorDocId="6641189" IdTipoMovimiento="Bono vacacional" Fecha="2024-02-28" Monto="3" PostByUser="floresdaniel" PostInIP="10.10.10.11" PostTime="2024-02-28 09:20:15"/>
<movimiento ValorDocId="3389054" IdTipoMovimiento="Disfrute de vacaciones" Fecha="2024-03-12" Monto="5" PostByUser="perezmaria" PostInIP="10.10.10.12" PostTime="2024-03-12 14:05:45"/>
<movimiento ValorDocId="9772211" IdTipoMovimiento="Reversion de Credito" Fecha="2024-04-03" Monto="2" PostByUser="torresluis" PostInIP="10.10.10.13" PostTime="2024-04-03 11:30:05"/>
<movimiento ValorDocId="6641189" IdTipoMovimiento="Venta de vacaciones" Fecha="2024-04-19" Monto="1" PostByUser="mgarrison" PostInIP="172.16.0.21" PostTime="2024-04-19 16:42:31"/>
<movimiento ValorDocId="3389054" IdTipoMovimiento="Reversion Debito" Fecha="2024-05-02" Monto="3" PostByUser="jgonzalez" PostInIP="172.16.0.22" PostTime="2024-05-02 07:18:09"/>
<movimiento ValorDocId="5095109" IdTipoMovimiento="Cumplir mes" Fecha="2024-05-18" Monto="6" PostByUser="andersondeborah" PostInIP="172.16.0.23" PostTime="2024-05-18 18:22:40"/>
<movimiento ValorDocId="4510358" IdTipoMovimiento="Disfrute de vacaciones" Fecha="2024-06-09" Monto="4" PostByUser="hardingmicheal" PostInIP="172.16.0.24" PostTime="2024-06-09 12:10:55"/>
<movimiento ValorDocId="6019592" IdTipoMovimiento="Bono vacacional" Fecha="2024-06-25" Monto="2" PostByUser="martinezlisa" PostInIP="172.16.0.25" PostTime="2024-06-25 09:44:03"/>
<movimiento ValorDocId="7517662" IdTipoMovimiento="Reversion de Credito" Fecha="2024-07-11" Monto="5" PostByUser="floresdaniel" PostInIP="172.16.0.26" PostTime="2024-07-11 13:55:27"/>
<movimiento ValorDocId="8403646" IdTipoMovimiento="Venta de vacaciones" Fecha="2024-08-08" Monto="4" PostByUser="perezmaria" PostInIP="172.16.0.27" PostTime="2024-08-08 15:00:00"/>
<movimiento ValorDocId="6993943" IdTipoMovimiento="Cumplir mes" Fecha="2024-09-14" Monto="7" PostByUser="torresluis" PostInIP="172.16.0.28" PostTime="2024-09-14 10:25:18"/>
<movimiento ValorDocId="2161775" IdTipoMovimiento="Reversion Debito" Fecha="2024-10-05" Monto="1" PostByUser="zkelly" PostInIP="172.16.0.29" PostTime="2024-10-05 08:12:49"/>
<movimiento ValorDocId="2918773" IdTipoMovimiento="Bono vacacional" Fecha="2024-11-03" Monto="2" PostByUser="martinezlisa" PostInIP="172.16.0.30" PostTime="2024-11-03 17:33:12"/>
<movimiento ValorDocId="8326328" IdTipoMovimiento="Venta de vacaciones" Fecha="2024-12-18" Monto="8" PostByUser="floresdaniel" PostInIP="172.16.0.31" PostTime="2024-12-18 19:47:59"/>
*/
--Aqui vamos a insertar los movimientos aquí aprendí a que se puede poner como todo un un mismo paréntesis de value y se inserta todo

INSERT INTO Movimiento (IdEmpleado, IdTipoMovimiento, Fecha, Monto, NuevoSaldo, IdPostByUser, PostInIP, PostTime) VALUES
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '7517662'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Venta de vacaciones'), '2024-01-18', 2, 0, (SELECT Id FROM Usuario WHERE Username = 'hardingmicheal'), '42.142.119.153', '2024-01-18 18:47:14'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '6993943'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Bono vacacional'), '2024-10-31', 1, 0, (SELECT Id FROM Usuario WHERE Username = 'mgarrison'), '156.92.82.57', '2024-10-31 12:43:18'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '8326328'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Venta de vacaciones'), '2024-11-22', 7, 0, (SELECT Id FROM Usuario WHERE Username = 'andersondeborah'), '218.213.110.232', '2024-11-22 00:23:53'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '4510358'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Reversion de Credito'), '2024-07-03', 3, 0, (SELECT Id FROM Usuario WHERE Username = 'hardingmicheal'), '143.42.131.166', '2024-07-03 17:07:39'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '8403646'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Reversion de Credito'), '2024-12-07', 8, 0, (SELECT Id FROM Usuario WHERE Username = 'zkelly'), '155.44.100.105', '2024-12-07 15:44:30'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '8326328'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Venta de vacaciones'), '2024-11-26', 10, 0, (SELECT Id FROM Usuario WHERE Username = 'hardingmicheal'), '141.163.255.56', '2024-11-26 09:33:41'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '6993943'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Disfrute de vacaciones'), '2024-11-20', 6, 0, (SELECT Id FROM Usuario WHERE Username = 'hardingmicheal'), '4.176.52.1', '2024-11-20 23:31:41'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '2918773'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Disfrute de vacaciones'), '2024-10-30', 10, 0, (SELECT Id FROM Usuario WHERE Username = 'zkelly'), '220.164.108.231', '2024-10-30 03:55:57'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '2161775'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Reversion Debito'), '2024-06-13', 2, 0, (SELECT Id FROM Usuario WHERE Username = 'hardingmicheal'), '135.223.57.22', '2024-06-13 13:28:39'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '8403646'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Bono vacacional'), '2024-01-01', 6, 0, (SELECT Id FROM Usuario WHERE Username = 'zkelly'), '150.250.94.62', '2024-01-01 05:17:10'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '2918773'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Venta de vacaciones'), '2024-07-12', 6, 0, (SELECT Id FROM Usuario WHERE Username = 'hardingmicheal'), '218.191.123.15', '2024-07-12 09:10:16'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '5095109'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Reversion de Credito'), '2024-12-27', 14, 0, (SELECT Id FROM Usuario WHERE Username = 'hardingmicheal'), '136.103.23.170', '2024-12-27 12:59:03'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '6993943'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Venta de vacaciones'), '2024-04-08', 1, 0, (SELECT Id FROM Usuario WHERE Username = 'jgonzalez'), '158.48.100.86', '2024-04-08 01:24:38'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '8403646'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Bono vacacional'), '2024-08-25', 8, 0, (SELECT Id FROM Usuario WHERE Username = 'jgonzalez'), '204.0.219.231', '2024-08-25 16:24:07'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '5095109'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Bono vacacional'), '2024-03-07', 7, 0, (SELECT Id FROM Usuario WHERE Username = 'andersondeborah'), '208.0.4.33', '2024-03-07 08:19:28'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '9772211'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Cumplir mes'), '2024-02-14', 4, 0, (SELECT Id FROM Usuario WHERE Username = 'martinezlisa'), '10.10.10.10', '2024-02-14 08:11:00'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '6641189'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Bono vacacional'), '2024-02-28', 3, 0, (SELECT Id FROM Usuario WHERE Username = 'floresdaniel'), '10.10.10.11', '2024-02-28 09:20:15'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '3389054'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Disfrute de vacaciones'), '2024-03-12', 5, 0, (SELECT Id FROM Usuario WHERE Username = 'perezmaria'), '10.10.10.12', '2024-03-12 14:05:45'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '9772211'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Reversion de Credito'), '2024-04-03', 2, 0, (SELECT Id FROM Usuario WHERE Username = 'torresluis'), '10.10.10.13', '2024-04-03 11:30:05'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '6641189'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Venta de vacaciones'), '2024-04-19', 1, 0, (SELECT Id FROM Usuario WHERE Username = 'mgarrison'), '172.16.0.21', '2024-04-19 16:42:31'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '3389054'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Reversion Debito'), '2024-05-02', 3, 0, (SELECT Id FROM Usuario WHERE Username = 'jgonzalez'), '172.16.0.22', '2024-05-02 07:18:09'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '5095109'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Cumplir mes'), '2024-05-18', 6, 0, (SELECT Id FROM Usuario WHERE Username = 'andersondeborah'), '172.16.0.23', '2024-05-18 18:22:40'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '4510358'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Disfrute de vacaciones'), '2024-06-09', 4, 0, (SELECT Id FROM Usuario WHERE Username = 'hardingmicheal'), '172.16.0.24', '2024-06-09 12:10:55'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '6019592'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Bono vacacional'), '2024-06-25', 2, 0, (SELECT Id FROM Usuario WHERE Username = 'martinezlisa'), '172.16.0.25', '2024-06-25 09:44:03'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '7517662'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Reversion de Credito'), '2024-07-11', 5, 0, (SELECT Id FROM Usuario WHERE Username = 'floresdaniel'), '172.16.0.26', '2024-07-11 13:55:27'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '8403646'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Venta de vacaciones'), '2024-08-08', 4, 0, (SELECT Id FROM Usuario WHERE Username = 'perezmaria'), '172.16.0.27', '2024-08-08 15:00:00'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '6993943'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Cumplir mes'), '2024-09-14', 7, 0, (SELECT Id FROM Usuario WHERE Username = 'torresluis'), '172.16.0.28', '2024-09-14 10:25:18'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '2161775'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Reversion Debito'), '2024-10-05', 1, 0, (SELECT Id FROM Usuario WHERE Username = 'zkelly'), '172.16.0.29', '2024-10-05 08:12:49'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '2918773'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Bono vacacional'), '2024-11-03', 2, 0, (SELECT Id FROM Usuario WHERE Username = 'martinezlisa'), '172.16.0.30', '2024-11-03 17:33:12'),
((SELECT Id FROM Empleado WHERE ValorDocumentoIdentidad = '8326328'), (SELECT Id FROM TipoMovimiento WHERE Nombre = 'Venta de vacaciones'), '2024-12-18', 8, 0, (SELECT Id FROM Usuario WHERE Username = 'floresdaniel'), '172.16.0.31', '2024-12-18 19:47:59');
GO