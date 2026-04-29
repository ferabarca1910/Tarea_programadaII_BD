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

END
GO
