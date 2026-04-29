-- STORED PROCEDURE: spEliminarEmpleado
-- DESCRIPCION: Borrado logico del empleado y lo haremos con un (EsActivo=0).
--              Si Confirmado=0 solo registrará  el intento de que se quiso borrar.
--              Si Confirmado=1 realizara la eliminacción.
-- =============================================
USE ControlVaciones
GO
CREATE PROCEDURE spEliminarEmpleado
    -- IN
    @IdEmpleado    INT,
    @Confirmado    BIT,
    @IdUsuario     INT,
    @IP            VARCHAR(50),
    -- OUT
    @CodigoError   INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DescBitacora    VARCHAR(500);
    DECLARE @Cedula          VARCHAR(20);
    DECLARE @Nombre          VARCHAR(150);
    DECLARE @NombrePuesto    VARCHAR(100);
    DECLARE @SaldoVacaciones DECIMAL(10,2);

    SET @CodigoError = 0;

    BEGIN TRY

        -- ---------------------------------------------
        -- Etapa 1: Obtendremos los  datos del empleado para la bitacora
        -- ---------------------------------------------
        SELECT
            @Cedula          = E.ValorDocumentoIdentidad,
            @Nombre          = E.Nombre,
            @NombrePuesto    = P.Nombre,
            @SaldoVacaciones = E.SaldoVacaciones
        FROM
            Empleado E
            INNER JOIN Puesto P ON E.IdPuesto = P.Id
        WHERE
            E.Id = @IdEmpleado;

        SET @DescBitacora =
            'Cedula='  + @Cedula +
            ' Nombre=' + @Nombre +
            ' Puesto=' + @NombrePuesto +
            ' Saldo='  + CAST(@SaldoVacaciones AS VARCHAR);

        -- ---------------------------------------------
        -- Etapa 2: Solo se hara el intento
        -- ---------------------------------------------
        IF @Confirmado = 0
        BEGIN
            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (9, @DescBitacora, @IdUsuario, @IP, GETDATE());

            RETURN;
        END

        -- ---------------------------------------------
        -- Etapa 3: Si esta confirmado se realiza el borrado logico
        -- ---------------------------------------------
        BEGIN TRANSACTION;

            UPDATE Empleado
            SET EsActivo = 0
            WHERE Id = @IdEmpleado;

            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (10, @DescBitacora, @IdUsuario, @IP, GETDATE());

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
