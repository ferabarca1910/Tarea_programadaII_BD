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