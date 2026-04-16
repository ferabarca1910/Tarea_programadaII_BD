-- =============================================
-- BASE DE DATOS: Control de Vacaciones
-- SCRIPT: 01_crear_tablas.sql
-- DESCRIPCION: Creacion de todas las tablas
-- AUTOR: [Tu nombre]
-- FECHA: Abril 2026
-- =============================================

-- Crear la base de datos
CREATE DATABASE ControlVacaciones;
GO

USE ControlVacaciones;
GO

-- =============================================
-- TABLA: Puesto
-- ID autoincremental (el XML no trae IDs fijos para puestos)
-- =============================================
CREATE TABLE Puesto (
    Id           INT           PRIMARY KEY IDENTITY(1,1),
    Nombre       VARCHAR(100)  NOT NULL,
    SalarioxHora DECIMAL(10,2) NOT NULL
);
GO

-- =============================================
-- TABLA: Usuario
-- ID fijo: el XML trae los IDs definidos, NO puede ser IDENTITY
-- =============================================
CREATE TABLE Usuario (
    Id       INT          PRIMARY KEY,   -- SIN IDENTITY, el ID viene del XML
    Username VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL
);
GO

-- =============================================
-- TABLA: TipoEvento
-- ID fijo: viene del XML (1 al 14)
-- =============================================
CREATE TABLE TipoEvento (
    Id     INT          PRIMARY KEY,   -- SIN IDENTITY, el ID viene del XML
    Nombre VARCHAR(100) NOT NULL
);
GO

-- =============================================
-- TABLA: TipoMovimiento
-- ID fijo: viene del XML (1 al 6)
-- =============================================
CREATE TABLE TipoMovimiento (
    Id         INT          PRIMARY KEY,   -- SIN IDENTITY, el ID viene del XML
    Nombre     VARCHAR(100) NOT NULL,
    TipoAccion VARCHAR(10)  NOT NULL       -- 'Credito' o 'Debito'
);
GO

-- =============================================
-- TABLA: Error
-- El Codigo es el identificador unico (50001 al 50011), viene del XML
-- =============================================
CREATE TABLE Error (
    Codigo      INT          PRIMARY KEY,  -- SIN IDENTITY, viene del XML
    Descripcion VARCHAR(255) NOT NULL
);
GO

-- =============================================
-- TABLA: Empleado
-- Depende de: Puesto
-- =============================================
CREATE TABLE Empleado (
    Id                      INT           PRIMARY KEY IDENTITY(1,1),
    IdPuesto                INT           NOT NULL,
    ValorDocumentoIdentidad VARCHAR(20)   NOT NULL,
    Nombre                  VARCHAR(150)  NOT NULL,
    FechaContratacion       DATE          NOT NULL,
    SaldoVacaciones         DECIMAL(10,2) NOT NULL DEFAULT 0,
    EsActivo                BIT           NOT NULL DEFAULT 1,

    CONSTRAINT FK_Empleado_Puesto FOREIGN KEY (IdPuesto)
        REFERENCES Puesto(Id)
);
GO

-- =============================================
-- TABLA: Movimiento
-- Depende de: Empleado, TipoMovimiento, Usuario
-- =============================================
CREATE TABLE Movimiento (
    Id               INT           PRIMARY KEY IDENTITY(1,1),
    IdEmpleado       INT           NOT NULL,
    IdTipoMovimiento INT           NOT NULL,
    Fecha            DATE          NOT NULL,
    Monto            DECIMAL(10,2) NOT NULL,
    NuevoSaldo       DECIMAL(10,2) NOT NULL,
    IdPostByUser     INT           NOT NULL,
    PostInIP         VARCHAR(50)   NOT NULL,
    PostTime         DATETIME      NOT NULL,

    CONSTRAINT FK_Movimiento_Empleado       FOREIGN KEY (IdEmpleado)
        REFERENCES Empleado(Id),
    CONSTRAINT FK_Movimiento_TipoMovimiento FOREIGN KEY (IdTipoMovimiento)
        REFERENCES TipoMovimiento(Id),
    CONSTRAINT FK_Movimiento_Usuario        FOREIGN KEY (IdPostByUser)
        REFERENCES Usuario(Id)
);
GO

-- =============================================
-- TABLA: BitacoraEvento
-- Depende de: TipoEvento, Usuario
-- =============================================
CREATE TABLE BitacoraEvento (
    Id           INT          PRIMARY KEY IDENTITY(1,1),
    IdTipoEvento INT          NOT NULL,
    Descripcion  VARCHAR(500) NULL,       -- NULL porque algunos eventos no requieren descripcion
    IdPostByUser INT          NOT NULL,
    PostInIP     VARCHAR(50)  NOT NULL,
    PostTime     DATETIME     NOT NULL,

    CONSTRAINT FK_Bitacora_TipoEvento FOREIGN KEY (IdTipoEvento)
        REFERENCES TipoEvento(Id),
    CONSTRAINT FK_Bitacora_Usuario    FOREIGN KEY (IdPostByUser)
        REFERENCES Usuario(Id)
);
GO

-- =============================================
-- TABLA: DBError
-- Registra errores capturados en bloques CATCH de los SPs
-- Sin FK a Usuario porque debe funcionar incluso cuando algo falla
-- NOTA: [Procedure] va entre corchetes porque es palabra reservada en SQL Server
-- =============================================
CREATE TABLE DBError (
    ID          INT          PRIMARY KEY IDENTITY(1,1),
    UserName    VARCHAR(100) NULL,
    Number      INT          NULL,
    State       INT          NULL,
    Severity    INT          NULL,
    Line        INT          NULL,
    [Procedure] VARCHAR(200) NULL,        -- corchetes obligatorios, es palabra reservada
    Message     VARCHAR(500) NULL,
    DateTime    DATETIME     NOT NULL DEFAULT GETDATE()
);
GO

-- =============================================
-- VERIFICACION: Lista todas las tablas creadas
-- Si todo salio bien deben aparecer 9 tablas
-- =============================================
SELECT
    TABLE_NAME AS Tabla
FROM
    INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_TYPE = 'BASE TABLE'
ORDER BY
    TABLE_NAME;
GO
