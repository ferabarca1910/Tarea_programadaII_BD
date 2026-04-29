-- STORED PROCEDURE: spConsultarEmpleado
-- DESCRIPCION: Retorna los datos de un empleado
--              especifico. Solo lectura.
-- =============================================
USE ControlVacaciones
GO
CREATE PROCEDURE spConsultarEmpleado
    -- IN
    @IdEmpleado  INT,
    -- OUT
    @CodigoError INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @CodigoError = 0;

    BEGIN TRY

        SELECT
            E.Id,
            E.ValorDocumentoIdentidad,
            E.Nombre,
            P.Nombre          AS NombrePuesto,
            E.SaldoVacaciones,
            E.FechaContratacion
        FROM
            Empleado E
            INNER JOIN Puesto P ON E.IdPuesto = P.Id
        WHERE
            E.Id       = @IdEmpleado
            AND E.EsActivo = 1;

    END TRY
    BEGIN CATCH
        SET @CodigoError = 50008;

        INSERT INTO DBError (UserName, Number, State, Severity, Line, [Procedure], Message, DateTime)
        VALUES (
            SYSTEM_USER,
            ERROR_NUMBER(),
            ERROR_STATE(),
            ERROR_SEVERITY(),
            ERROR_LINE(),
            ERROR_PROCEDURE(),
            ERROR_MESSAGE(),
            GETDATE()
        );
    END CATCH
END
GO
