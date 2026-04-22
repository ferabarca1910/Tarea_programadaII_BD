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