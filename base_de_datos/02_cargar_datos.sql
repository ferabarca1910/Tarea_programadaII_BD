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

INSERT INTO Puesto (Nombre, SalarioxHora)
SELECT
    Puesto.value('@Nombre', 'VARCHAR(100)'),
    Puesto.value('@SalarioxHora', 'DECIMAL(10,2)') --No se porque pero no se puede poner el .value en CAPS porque no funka
FROM @xml.nodes('/Puestos/Puesto') AS T(Puesto);

GO