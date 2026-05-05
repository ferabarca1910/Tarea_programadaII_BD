-- STORED PROCEDURE: spLogin
-- DESCRIPCION: Valida usuario y contrasena,
--              revisa intentos fallidos en bitacora,
--              deshabilita login si hay mas de 5 intentos
--              en los ultimos 20 minutos

USE ControlVacaciones;
GO

CREATE PROCEDURE spLogin
    -- IN
    @Username    VARCHAR(100),
    @Password    VARCHAR(100),
    @IP          VARCHAR(50),
    -- OUT
    @IdUsuario   INT OUTPUT,
    @CodigoError INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdUsuarioScript  INT;
    DECLARE @IntentosRecientes INT;
    DECLARE @NumeroIntento    INT;

    SET @IdUsuario   = 0;
    SET @CodigoError = 0;

    SELECT @IdUsuarioScript = Id
    FROM Usuario
    WHERE Username = 'UsuarioScripts';

    BEGIN TRY

        IF EXISTS (
            SELECT 1
            FROM BitacoraEvento
            WHERE IdTipoEvento = 3
              AND PostInIP     = @IP
              AND PostTime     >= DATEADD(MINUTE, -10, GETDATE())
              AND Descripcion  LIKE '%' + @Username + '%'
        )
        BEGIN
            SET @CodigoError = 50003;

            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (3, @Username, @IdUsuarioScript, @IP, GETDATE());

            RETURN;
        END


        SELECT @IdUsuario = Id
        FROM Usuario
        WHERE Username = @Username;

        IF @IdUsuario IS NULL OR @IdUsuario = 0
        BEGIN
            SET @IdUsuario   = 0;
            SET @CodigoError = 50001;

            SELECT @IntentosRecientes = COUNT(*)
            FROM BitacoraEvento
            WHERE IdTipoEvento = 2
              AND PostInIP     = @IP
              AND PostTime     >= DATEADD(MINUTE, -20, GETDATE())
              AND Descripcion  LIKE '%' + @Username + '%';

            SET @NumeroIntento = @IntentosRecientes + 1;

            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (
                2,
                'Intento ' + CAST(@NumeroIntento AS VARCHAR) + ' - Error: ' + CAST(@CodigoError AS VARCHAR) + ' - User: ' + @Username,
                @IdUsuarioScript, @IP, GETDATE()
            );

            IF @NumeroIntento >= 5
            BEGIN
                INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
                VALUES (3, @Username, @IdUsuarioScript, @IP, GETDATE());
            END

            RETURN;
        END

    IF NOT EXISTS (
        SELECT 1
        FROM Usuario
        WHERE Id       = @IdUsuario
          AND Password = @Password
    )
    BEGIN
        SET @CodigoError = 50002;

        SELECT @IntentosRecientes = COUNT(*)
        FROM BitacoraEvento
        WHERE IdTipoEvento = 2
          AND PostInIP     = @IP
          AND PostTime     >= DATEADD(MINUTE, -20, GETDATE())
          AND Descripcion  LIKE '%' + @Username + '%';

        SET @NumeroIntento = @IntentosRecientes + 1;

        INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
        VALUES (
            2,
            'Intento ' + CAST(@NumeroIntento AS VARCHAR) + ' - Error: ' + CAST(@CodigoError AS VARCHAR),
            @IdUsuarioScript, @IP, GETDATE()
        );

        IF @NumeroIntento >= 5
        BEGIN
            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (3, @Username, @IdUsuarioScript, @IP, GETDATE());
        END

        RETURN;
    END


    SET @CodigoError = 0;

    INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
    VALUES (1, 'Exitoso', @IdUsuario, @IP, GETDATE());
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
