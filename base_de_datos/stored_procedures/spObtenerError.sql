-- STORED PROCEDURE: spObtenerError
-- DESCRIPCION: Recibe un codigo y retorna la
--              descripcion del error desde la tabla Error.
-- =============================================
USE ControlVacaciones;
GO

CREATE PROCEDURE spObtenerError
    -- IN
    @Codigo      INT,
    -- OUT
    @CodigoError INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @CodigoError = 0;

    BEGIN TRY

        SELECT
            Codigo,
            Descripcion
        FROM Error
        WHERE Codigo = @Codigo;

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
