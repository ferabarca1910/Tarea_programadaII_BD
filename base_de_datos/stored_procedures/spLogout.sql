-- STORED PROCEDURE: spLogout
-- DESCRIPCION: Registra el cierre de sesion
--              del usuario en la bitacora
-- =============================================
USE ControlVacaciones;
GO

CREATE PROCEDURE spLogout
    -- IN
    @IdUsuario   INT,
    @IP          VARCHAR(50),
    -- OUT
    @CodigoError INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @CodigoError = 0;

    BEGIN TRY

        INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
        VALUES (4, NULL, @IdUsuario, @IP, GETDATE());

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
