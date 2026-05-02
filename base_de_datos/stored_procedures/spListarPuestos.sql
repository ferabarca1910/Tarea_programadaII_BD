-- STORED PROCEDURE: spListarPuestos
-- DESCRIPCION: Retorna todos los puestos en orden
--              alfabetico para llenar los dropdowns.
-- =============================================
USE ControlVacaciones
GO
CREATE PROCEDURE spListarPuestos
    -- OUT
    @CodigoError INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @CodigoError = 0;

    BEGIN TRY

        SELECT
            Id,
            Nombre,
            SalarioxHora
        FROM Puesto
        ORDER BY Nombre ASC;

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
