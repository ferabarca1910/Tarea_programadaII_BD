-- STORED PROCEDURE: spInsertarMovimiento
-- DESCRIPCION: Inserta un movimiento de vacaciones.
--              Valida que el saldo no quede negativo.
--              Actualiza SaldoVacaciones del empleado.
--              Registra resultado en bitacora.
-- =============================================
USE ControlVacaciones;
GO

CREATE PROCEDURE spInsertarMovimiento
    -- IN
    @IdEmpleado           INT,
    @NombreTipoMovimiento VARCHAR(100),
    @Monto                DECIMAL(10,2),
    @Fecha                DATE,
    @IdUsuario            INT,
    @IP                   VARCHAR(50),
    -- OUT
    @CodigoError          INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdTipoMovimiento  INT;
    DECLARE @TipoAccion        VARCHAR(10);
    DECLARE @SaldoActual       DECIMAL(10,2);
    DECLARE @NuevoSaldo        DECIMAL(10,2);
    DECLARE @NombreEmpleado    VARCHAR(150);
    DECLARE @Cedula            VARCHAR(20);
    DECLARE @DescBitacora      VARCHAR(500);

    SET @CodigoError = 0;

    BEGIN TRY

        -- ---------------------------------------------
        -- Etapa 1: Obtenemos los datos del tipo de movimiento
        -- ---------------------------------------------
        SELECT
            @IdTipoMovimiento = Id,
            @TipoAccion       = TipoAccion
        FROM TipoMovimiento
        WHERE Nombre = @NombreTipoMovimiento;

        -- ---------------------------------------------
        -- Etaps 2: Obtener datos del empleado
        -- ---------------------------------------------
        SELECT
            @SaldoActual    = SaldoVacaciones,
            @NombreEmpleado = Nombre,
            @Cedula         = ValorDocumentoIdentidad
        FROM Empleado
        WHERE Id = @IdEmpleado;

        -- ---------------------------------------------
        -- Etapa 3: Calcular nuevo saldo
        -- ---------------------------------------------
        IF @TipoAccion = 'Credito'
            SET @NuevoSaldo = @SaldoActual + @Monto;
        ELSE
            SET @NuevoSaldo = @SaldoActual - @Monto;

        -- ---------------------------------------------
        -- Etapa 4: Validamos que saldo no sae negativo
        -- ---------------------------------------------
        IF @NuevoSaldo < 0
        BEGIN
            SET @CodigoError = 50011;

            SET @DescBitacora =
                'Error ' + CAST(@CodigoError AS VARCHAR) +
                ' - Cedula='   + @Cedula +
                ' Nombre='     + @NombreEmpleado +
                ' SaldoActual='+ CAST(@SaldoActual AS VARCHAR) +
                ' TipoMov='    + @NombreTipoMovimiento +
                ' Monto='      + CAST(@Monto AS VARCHAR);

            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (13, @DescBitacora, @IdUsuario, @IP, GETDATE());

            RETURN;
        END

        -- ---------------------------------------------
        -- Etap 5: Insertar movimiento y actualizar saldo
        -- ---------------------------------------------
        BEGIN TRANSACTION;

            INSERT INTO Movimiento (IdEmpleado, IdTipoMovimiento, Fecha, Monto, NuevoSaldo, IdPostByUser, PostInIP, PostTime)
            VALUES (@IdEmpleado, @IdTipoMovimiento, @Fecha, @Monto, @NuevoSaldo, @IdUsuario, @IP, GETDATE());

            UPDATE Empleado
            SET SaldoVacaciones = @NuevoSaldo
            WHERE Id = @IdEmpleado;

        COMMIT;

        SET @DescBitacora =
            'Cedula='      + @Cedula +
            ' Nombre='     + @NombreEmpleado +
            ' NuevoSaldo=' + CAST(@NuevoSaldo AS VARCHAR) +
            ' TipoMov='    + @NombreTipoMovimiento +
            ' Monto='      + CAST(@Monto AS VARCHAR);

        INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
        VALUES (14, @DescBitacora, @IdUsuario, @IP, GETDATE());

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
