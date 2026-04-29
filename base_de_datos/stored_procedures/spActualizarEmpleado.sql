-- STORED PROCEDURE: spActualizarEmpleado
-- DESCRIPCION: Actualizará cedula, nombre y puesto
--              de un empleado. El saldo NO es editable.
--              Validara duplicados contra otros empleados.
--              Registrara resultado en bitacora.
-- =============================================
USE ControlVacaciones;
GO

CREATE PROCEDURE spActualizarEmpleado
    -- IN
    @IdEmpleado                   INT,
    @NuevaValorDocumentoIdentidad VARCHAR(20),
    @NuevoNombre                  VARCHAR(150),
    @NuevoNombrePuesto            VARCHAR(100),
    @IdUsuario                    INT,
    @IP                           VARCHAR(50),
    -- OUT
    @CodigoError                  INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdPuesto          INT;
    DECLARE @DescBitacora      VARCHAR(500);
    DECLARE @CedulaAntes       VARCHAR(20);
    DECLARE @NombreAntes       VARCHAR(150);
    DECLARE @NombrePuestoAntes VARCHAR(100);
    DECLARE @SaldoVacaciones   DECIMAL(10,2);

    SET @CodigoError = 0;

    BEGIN TRY

        -- ---------------------------------------------
        -- Etape 1: Aqui se obtienen los datos actuales del empleado
        -- ---------------------------------------------
        SELECT
            @CedulaAntes       = E.ValorDocumentoIdentidad,
            @NombreAntes       = E.Nombre,
            @NombrePuestoAntes = P.Nombre,
            @SaldoVacaciones   = E.SaldoVacaciones
        FROM
            Empleado E
            INNER JOIN Puesto P ON E.IdPuesto = P.Id
        WHERE
            E.Id = @IdEmpleado;

        -- ---------------------------------------------
        -- Etapa 2: Obtendremos el  Id del nuevo puesto
        -- ---------------------------------------------
        SELECT @IdPuesto = Id
        FROM Puesto
        WHERE Nombre = @NuevoNombrePuesto;

        -- ---------------------------------------------
        -- Etapa 3: Validaremos si la  cedula duplicada ests duplicada  en otro empleado
        -- ---------------------------------------------
        IF EXISTS (
            SELECT 1 FROM Empleado
            WHERE ValorDocumentoIdentidad = @NuevaValorDocumentoIdentidad
              AND EsActivo               = 1
              AND Id                     <> @IdEmpleado
        )
        BEGIN
            SET @CodigoError = 50006;

            SET @DescBitacora =
                'Error ' + CAST(@CodigoError AS VARCHAR) +
                ' - Antes: Cedula=' + @CedulaAntes + ' Nombre=' + @NombreAntes + ' Puesto=' + @NombrePuestoAntes +
                ' - Despues: Cedula=' + @NuevaValorDocumentoIdentidad + ' Nombre=' + @NuevoNombre + ' Puesto=' + @NuevoNombrePuesto +
                ' - Saldo=' + CAST(@SaldoVacaciones AS VARCHAR);

            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (7, @DescBitacora, @IdUsuario, @IP, GETDATE());

            RETURN;
        END
END
GO
