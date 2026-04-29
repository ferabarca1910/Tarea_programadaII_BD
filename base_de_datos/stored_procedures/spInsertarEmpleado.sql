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

        -- ---------------------------------------------
        -- Etapa 1: Obtendremos el Id del puesto
        -- ---------------------------------------------
        SELECT @IdPuesto = Id
        FROM Puesto
        WHERE Nombre = @NombrePuesto;

        -- ---------------------------------------------
        -- Etapa 2: Validar cedula duplicada
        -- ---------------------------------------------
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

        -- ---------------------------------------------
        -- PASO 3: Validaremos si el nombre estaduplicado
        -- ---------------------------------------------
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
