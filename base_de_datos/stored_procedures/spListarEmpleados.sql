USE ControlVacaciones;
GO  
CREATE PROCEDURE spListarEmpleados
@Filtro VARCHAR(150),
@IdUsuario INT,
@IP VARCHAR(50),
@CodigoError INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EsNumerico BIT;
    SET @CodigoError = 0;

    BEGIN TRY
        --Etapa 1, vamos a ver si es numerico
        IF ISNUMERIC(@Filtro) = 1 AND LEN(@Filtro) > 0 
            SET @ESNumerico = 1;
        ELSE
            SET @EsNumerico = 0;
        --Etapa 2 vamos a listar empleados segun el filtro
        SELECT
            E.Id,
            E.ValorDocumentoIdentidad,
            E.Nombre,
            P.Nombre AS NombrePuesto,
            E.SaldoVacaciones,
            E.FechaContratacion
        FROM
            Empleado E
            INNER JOIN Puesto P ON E.IdPuesto = P.Id
        WHERE
            E.EsActivo = 1
            AND(
                LEN(@Filtro)= 0
                OR
                (@EsNumerico = 1 AND E.ValorDocumentoIdentidad LIKE '%' + @Filtro + '%')
                OR
                (@EsNumerico= 0 AND E.Nombre LIKE '%' + @Filtro + '%')
            )
        ORDER BY
            E.Nombre ASC;
        --Etapa 3 Registrar en la bitacora
        IF LEN(@Filtro) > 0 AND @EsNumerico = 1
        BEGIN
            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (12, 'Filtro cedula: ' + @Filtro, @IdUsuario, @IP, GETDATE());
        END
        ELSE IF LEN(@Filtro) > 0 AND @EsNumerico = 0
        BEGIN
            INSERT INTO BitacoraEvento (IdTipoEvento, Descripcion, IdPostByUser, PostInIP, PostTime)
            VALUES (11, 'Filtro nombre: ' + @Filtro, @IdUsuario, @IP, GETDATE());
        END
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