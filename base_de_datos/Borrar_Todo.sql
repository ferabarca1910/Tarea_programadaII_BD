USE ControlVacaciones;

DELETE FROM Movimiento;
DELETE FROM BitacoraEvento;
DELETE FROM Empleado;
DELETE FROM Usuario;
DELETE FROM TipoMovimiento;
DELETE FROM TipoEvento;
DELETE FROM Error;
DELETE FROM Puesto;

DBCC CHECKIDENT ('Puesto',   RESEED, 0);
DBCC CHECKIDENT ('Empleado', RESEED, 0);