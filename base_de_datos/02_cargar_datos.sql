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