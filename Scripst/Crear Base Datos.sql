USE master
GO

IF DB_ID('FacturacionDB') IS NOT NULL
BEGIN
	-- Se desconectan los usuarios y se elimina la base de datos
	ALTER DATABASE FacturacionDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE FacturacionDB
END
GO

-- Crear la base de datos de Facturación
CREATE DATABASE FacturacionDB;
GO

-- Usar la base de datos recién creada
USE FacturacionDB;
GO


-- Crear tabla de Usuarios
CREATE TABLE TblUsuarios(
    IdUsuario TINYINT IDENTITY,
    Nombre VARCHAR(70) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Direccion VARCHAR(MAX) NOT NULL,
    Clave VARBINARY(MAX),
    Estado BIT DEFAULT 1 NOT NULL,
    
    CONSTRAINT PK_TblUsuarios_IdUsuario PRIMARY KEY(IdUsuario),
    CONSTRAINT UN_TblUsuarios_Nombre UNIQUE(Nombre),
    CONSTRAINT UN_TblUsuarios_Email UNIQUE(Email),
    CONSTRAINT UN_TblUsuarios_Telefono UNIQUE(Telefono),
    CONSTRAINT CK_TblUsuarios_Estado CHECK(Estado IN(1,0))
);
GO

-- Crear tabla de Clientes
CREATE TABLE TblClientes(
    IdCliente INT IDENTITY,
    NombreCliente VARCHAR(100),
    EmailCliente VARCHAR(50),
    TelefonoCliente VARCHAR(15),
    DireccionCliente VARCHAR(MAX),
	Estado BIT DEFAULT 1

	CONSTRAINT PK_TblClientes_IdCliente PRIMARY KEY(IdCliente),
    CONSTRAINT UN_TblClientes_TelefonoCliente UNIQUE(TelefonoCliente),
    CONSTRAINT CK_TblClientes_Estado CHECK(Estado IN(1,0))
);
GO

-- Crear tabla Categoria de Productos
CREATE TABLE TblCategoriaProducto(
	IdCategoria TINYINT IDENTITY,
	CategoriaProducto VARCHAR(100)

	CONSTRAINT PK_TblcategoriaProducto_IdCategoria PRIMARY KEY(IdCategoria),
    CONSTRAINT UN_TblcategoriaProducto_CategoriaProducto UNIQUE(CategoriaProducto),
);
GO


-- Crear tabla de Productos
CREATE TABLE TblProductos(
    IdProducto INT IDENTITY,
	CodigoProducto CHAR(5),
    NombreProducto VARCHAR(100) NOT NULL,
	IdCategoria TINYINT NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    
    CONSTRAINT PK_TblProductos_IdProducto PRIMARY KEY(IdProducto),
	CONSTRAINT UN_TblProductos_CodigoProducto UNIQUE(CodigoProducto),
	CONSTRAINT FK_TblProductos_IdCategoria FOREIGN KEY(IdCategoria) REFERENCES TblcategoriaProducto(IdCategoria),
    CONSTRAINT CK_TblProductos_Stock CHECK(Stock >= 0)
);
GO

-- Crear tabla de Facturas
CREATE TABLE TblFacturas(
    IdFactura INT IDENTITY,
    IdCliente INT NOT NULL,
	IdUsuario TINYINT NOT NULL,
    FechaFacturacion DATETIME NOT NULL,
	SubTotal DECIMAL(10,2) DEFAULT 0,
	Descuento DECIMAL(10, 2) DEFAULT 0,
    TotalGeneral AS SubTotal - Descuento,
    
    CONSTRAINT PK_TblFacturas_IdFactura PRIMARY KEY(IdFactura),
    CONSTRAINT FK_TblFacturas_IdCliente FOREIGN KEY(IdCliente) REFERENCES TblClientes(IdCliente),
	CONSTRAINT FK_TblFacturas_IdUsuario FOREIGN KEY(IdUsuario) REFERENCES TblUsuarios(IdUsuario)
);
GO

-- Crear tabla de Detalles de Factura
CREATE TABLE TblDetallesFactura(
    IdDetalle INT IDENTITY,
    IdFactura INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
	Descuento DECIMAL(10, 2) DEFAULT 0,
	Total AS (Cantidad * PrecioUnitario) - Descuento,
    
    CONSTRAINT PK_TblDetallesFactura_IdDetalle PRIMARY KEY(IdDetalle),
    CONSTRAINT FK_TblDetallesFactura_IdFactura FOREIGN KEY(IdFactura) REFERENCES TblFacturas(IdFactura),
    CONSTRAINT FK_TblDetallesFactura_IdProducto FOREIGN KEY(IdProducto) REFERENCES TblProductos(IdProducto)
);
GO
