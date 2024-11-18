USE FacturacionDB
GO

--> Crear un procedimiento almacenado que devuelva el IdFactura, Fecha, Cliente y Total de una factura en específico.
CREATE OR ALTER PROC spListadoFacturas
	@IdFactura INT
AS
BEGIN
	SELECT F.IdFactura, F.FechaFacturacion, C.NombreCliente, F.TotalGeneral 
	FROM TblFacturas F
	INNER JOIN TblClientes C ON F.IdCliente = C.IdCliente 
	WHERE F.IdFactura = @IdFactura 
END;
GO

EXEC spListadoFacturas 1
GO

--> Crear un procedimiento almacenado para actualizar el stock de un producto.
CREATE OR ALTER PROC spProductoActualizarStock
	@IdProducto INT,
	@Stock INT
AS
BEGIN
	UPDATE TblProductos 
	SET Stock = @Stock
	WHERE IdProducto = @IdProducto
END;
GO

EXEC spProductoActualizarStock 1, 90
GO



--> Crear procedimiento almacenado que reciba los datos del cliente como parámetro y los inserte en la tabla clientes.
CREATE OR ALTER PROC spClientesInsertar
	@Nombre VARCHAR(100),
	@Email VARCHAR(50),
	@Telefono VARCHAR(15),
	@Direccion VARCHAR(MAX),
	@Estado BIT
AS
BEGIN
	INSERT INTO TblClientes(NombreCliente, EmailCliente, TelefonoCliente, DireccionCliente, Estado)
	VALUES(@Nombre,
		   @Email,
		   @Telefono,
		   @Direccion,
		   @Estado)
END;
GO


DECLARE @Nombre VARCHAR(100) = 'Jonas' 
DECLARE @Email VARCHAR(50) = 'jonas@gmail.com'
DECLARE @Telefono VARCHAR(15) = '789456'
DECLARE @Direccion VARCHAR(MAX) = 'Rivas'
DECLARE @Estado BIT = 1

EXEC spClientesInsertar @Nombre, @Email, @Telefono, @Direccion, @Estado

SELECT *FROM TblClientes
GO

--> Crear un procedimiento almacenado que reciba el IdCliente y elimine el cliente de la tabla Clientes.
CREATE OR ALTER PROC spClienteEliminar
	@IdCliente INT
AS
BEGIN
	DELETE FROM TblClientes 
	WHERE IdCliente = @IdCliente 
END;
GO

EXEC spClienteEliminar 3006

--> Crear procedimiento almacenado que inserte una nueva Factura y guarde registros en la tabla detalles de factura.

CREATE TABLE #TempDetalleFacturas(
	IdProducto INT,
	Cantidad INT,
	PrecioUnitario DECIMAL(10, 2),
	Descuento DECIMAL(10, 2)
);
GO

INSERT INTO #TempDetalleFacturas(IdProducto, Cantidad, PrecioUnitario, Descuento)
VALUES(1, 5, 800, 50),
	   (2, 3, 1000, 50),
	   (3, 3, 600, 50);
GO

SELECT *FROM #TempDetalleFacturas

CREATE OR ALTER PROC spFacturaInsertar
	@IdCliente INT,
	@IdUsuario TINYINT,
	@Fecha DATETIME,
	@SubTotal DECIMAL(11,2),
	@Descuento DECIMAL(11,2)
AS
BEGIN
	INSERT INTO TblFacturas(IdCliente, IdUsuario, FechaFacturacion, SubTotal, Descuento)
	VALUES(@IdCliente,
		   @IdUsuario,
		   @Fecha,
		   @SubTotal,
		   @Descuento)

	DECLARE @IdFactura INT = SCOPE_IDENTITY();

	INSERT INTO TblDetallesFactura(IdFactura, IdProducto, Cantidad, PrecioUnitario, Descuento)
	SELECT @IdFactura,
		   D.IdProducto,
		   D.Cantidad,
		   D.PrecioUnitario,
		   D.Descuento
	FROM #TempDetalleFacturas D

	DROP TABLE #TempDetalleFacturas
END;
GO


DECLARE @IdCliente INT = 1
DECLARE @IdUsuario TINYINT = 1
DECLARE @Fecha DATETIME = '16/11/2024'
DECLARE @SubTotal DECIMAL(11,2) = 2400
DECLARE @Descuento DECIMAL(11,2) = 150

EXEC spFacturaInsertar @IdCliente, @IdUsuario, @Fecha, @SubTotal, @Descuento

SELECT *FROM TblFacturas
WHERE IdFactura = 53002

SELECT *FROM TblDetallesFactura 
WHERE IdFactura = 53002