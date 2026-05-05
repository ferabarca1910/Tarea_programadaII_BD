-- =============================================
-- STORED PROCEDURE: spListarMovimientos
-- DESCRIPCION: Lista todos los movimientos de un
--              empleado ordenados por fecha descendente.
--              Retorna tambien los datos del empleado
--              para el encabezado de la pantalla.
-- =============================================

USE ControlVacaciones;
GO

CREATE PROCEDURE spListarMovimientos
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
            E.ValorDocumentoIdentidad,
            E.Nombre,
            E.SaldoVacaciones
        FROM Empleado E
        WHERE E.Id = @IdEmpleado;

        SELECT
            M.Fecha,
            TM.Nombre     AS NombreTipoMovimiento,
            TM.TipoAccion,
            M.Monto,
            M.NuevoSaldo,
            U.Username    AS NombreUsuario,
            M.PostInIP,
            M.PostTime
        FROM
            Movimiento    M
            INNER JOIN TipoMovimiento TM ON M.IdTipoMovimiento = TM.Id
            INNER JOIN Usuario        U  ON M.IdPostByUser     = U.Id
        WHERE
            M.IdEmpleado = @IdEmpleado
        ORDER BY
            M.Fecha    DESC,
            M.PostTime DESC;

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
