-- STORED PROCEDURE: spInsertarEmpleado
-- DESCRIPCION: Inserta un nuevo empleado.
--              Valida cedula y nombre duplicados.
--              Registra resultado en bitacora.
-- =============================================
USE ControlVacaciones;
GO

CREATE PROCEDURE spInsertarEmpleado
    -- IN
    @ValorDocumentoIdentidad VARCHAR(20),
    @Nombre                  VARCHAR(150),
    @NombrePuesto            VARCHAR(100),
    @IdUsuario               INT,
    @IP                      VARCHAR(50),
    -- OUT
    @CodigoError             INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdPuesto      INT;
    DECLARE @DescBitacora  VARCHAR(500);

    SET @CodigoError = 0;

    BEGIN TRY


        SELECT @IdPuesto = Id
        FROM Puesto
        WHERE Nombre = @NombrePuesto;

        IF EXISTS (
            SELECT 1 FROM Empleado
            WHERE ValorDocumentoIdentidad = @ValorDocumentoIdentidad
              AND EsActivo               = 1
        )
        BEGIN
            SET @CodigoError = 50004;

            SET @DescBitacora =
                'Error ' + CAST(@CodigoError AS VARCHAR) +
                ' - Cedula: '  + @ValorDocumentoIdentidad +
                ' - Nombre: '  + @Nombre +
                ' - Puesto: '  + @NombrePuesto;

            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (5, @DescBitacora, @IdUsuario, @IP, GETDATE());

            RETURN;
        END


        IF EXISTS (
            SELECT 1 FROM Empleado
            WHERE Nombre   = @Nombre
              AND EsActivo = 1
        )
        BEGIN
            SET @CodigoError = 50005;

            SET @DescBitacora =
                'Error ' + CAST(@CodigoError AS VARCHAR) +
                ' - Cedula: '  + @ValorDocumentoIdentidad +
                ' - Nombre: '  + @Nombre +
                ' - Puesto: '  + @NombrePuesto;

            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (5, @DescBitacora, @IdUsuario, @IP, GETDATE());

            RETURN;
        END

        BEGIN TRANSACTION;

            INSERT INTO Empleado (IdPuesto, ValorDocumentoIdentidad, Nombre, FechaContratacion, SaldoVacaciones, EsActivo)
            VALUES (@IdPuesto, @ValorDocumentoIdentidad, @Nombre, GETDATE(), 0, 1);

            SET @DescBitacora =
                'Cedula: ' + @ValorDocumentoIdentidad +
                ' - Nombre: ' + @Nombre +
                ' - Puesto: ' + @NombrePuesto;

            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (6, @DescBitacora, @IdUsuario, @IP, GETDATE());

        COMMIT;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

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

