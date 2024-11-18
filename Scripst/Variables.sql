USE FacturacionDB
GO

---> Calcular el total de ventas para un cliente específico.
DECLARE @Cliente VARCHAR(35) = 'Sofía Ruiz';
DECLARE @TotalVentas DECIMAL(11, 2);

SELECT @TotalVentas = SUM(TotalGeneral)
FROM TblFacturas F
INNER JOIN TblClientes C ON F.IdCliente = C.IdCliente
WHERE C.NombreCliente = @Cliente;

PRINT 'Total de ventas para ' + @Cliente +' es de: ' + FORMAT(@TotalVentas, 'N2');
GO

---> Obtener el nombre y el total de compras de un cliente en un rango de fechas.
DECLARE @FechaInicio DATE = '2024-01-01';
DECLARE @FechaFin DATE = '2024-12-31';
DECLARE @IdCliente INT = 2;
DECLARE @NombreCliente VARCHAR(100);
DECLARE @TotalCompras DECIMAL(11, 2);

SELECT @NombreCliente = NombreCliente
FROM TblClientes 
WHERE IdCliente = @IdCliente;

SELECT @TotalCompras = SUM(TotalGeneral)
FROM TblFacturas
WHERE IdCliente = @IdCliente AND FechaFacturacion BETWEEN @FechaInicio AND @FechaFin;

PRINT 'Cliente: ' + @NombreCliente + ' realizó un total de compras en el año de:' + CAST(@TotalCompras AS VARCHAR);
GO

---> Incrementar el stock de un producto en un porcentaje 10%.
DECLARE @IdProducto INT = 2;
DECLARE @Incremento DECIMAL(5,2) = 0.10;
DECLARE @StockActual INT;

UPDATE TblProductos 
SET Stock = Stock + CAST(Stock * @Incremento AS INT)
WHERE IdProducto = @IdProducto;

SELECT @StockActual = Stock
FROM TblProductos 
WHERE IdProducto = @IdProducto;

PRINT 'Nuevo stock del producto: ' + CAST(@StockActual AS VARCHAR);
GO


