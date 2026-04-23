-- =============================================
-- BASE DE DATOS: Control de Vacaciones
-- SCRIPT: 02_cargar_datos.sql
-- DESCRIPCION: Carga de datos de prueba desde XML
-- AUTORES: Fernando Abarca e Isaac Van de Bom
-- FECHA: 22 de Abril 2026
-- =============================================

USE ControlVacaciones;
GO

DECLARE @xml XML 
SET @xml = '<Puestos>
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
</Puestos>'

INSERT INTO Puesto (Nombre,SalarioxHora)
SELECT
    Puesto.value('@Nombre', 'VARCHAR(100)'),
    Puesto.value('@SalarioxHora', 'DECIMAL(10,2)') --No se porque pero no se puede poner el .value en CAPS porque no funka
FROM @xml.nodes('/Puestos/Puesto') AS T(Puesto);

GO

DECLARE @xml XML 
SET @xml = '<TiposEvento>
<TipoEvento Id="1" Nombre="Login Exitoso"/>
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
</TiposEvento>'

INSERT INTO TipoEvento (Id,Nombre)
SELECT
    TipoEvento.value('@Id', 'INT'),
    TipoEvento.value('@Nombre', 'VARCHAR(100)')
FROM @xml.nodes('/TiposEvento/TipoEvento') AS T(TipoEvento);

GO

DEClARE @xml XML
SET @xml = '<TiposMovimientos>
<TipoMovimiento Id="1" Nombre="Cumplir mes" TipoAccion="Credito"/>
<TipoMovimiento Id="2" Nombre="Bono vacacional" TipoAccion="Credito"/>
<TipoMovimiento Id="3" Nombre="Reversion Debito" TipoAccion="Credito"/>
<TipoMovimiento Id="4" Nombre="Disfrute de vacaciones" TipoAccion="Debito"/>
<TipoMovimiento Id="5" Nombre="Venta de vacaciones" TipoAccion="Debito"/>
<TipoMovimiento Id="6" Nombre="Reversion de Credito" TipoAccion="Debito"/>
</TiposMovimientos>'

INSERT INTO TipoMovimiento(Id,Nombre,TipoAccion)
SELECT
    TipoMovimiento.value('@Id','INT'),
    TipoMovimiento.value('@Nombre','VARCHAR(100)'),
    TipoMovimiento.value('@TipoAccion','VARCHAR(10)')
FROM @xml.nodes('/TiposMovimientos/TipoMovimiento') AS T(TipoMovimiento);

GO

DECLARE @xml XML
SET @xml = '<Error>
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
</Error>'

INSERT INTO Error(Codigo, Descripcion)
SELECT
    Error.value('@Codigo','INT'),
    Error.value('@Descripcion', 'VARCHAR(255)')
FROM @xml.nodes('/Error/error') AS T(Error);

GO

DECLARE @xml XML
SET @xml = '<Usuarios>
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
</Usuarios>'

INSERT INTO Usuario(Id, Username, [Password])
SELECT 
    Usuario.value('@Id','INT'),
    Usuario.value('@Nombre','VARCHAR(100)'),
    Usuario.value('@Pass','VARCHAR(100)')
FROM @xml.nodes('/Usuarios/usuario') AS T(Usuario);

GO

DECLARE @xml XML 
SET @xml = '<Empleados>
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
</Empleados>'

INSERT INTO Empleado(IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion)
SELECT
    (SELECT Id FROM Puesto WHERE Nombre = Empleado.value('@Puesto','VARCHAR(100)')),
    Empleado.value('@ValorDocumentoIdentidad','VARCHAR(20)'),
    Empleado.value('@Nombre','VARCHAR(150)'),
    Empleado.value('@FechaContratacion','DATE')
FROM @xml.nodes('/Empleados/empleado') AS T(Empleado);

GO
    
