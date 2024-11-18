USE FacturacionDB
GO

--> 1. Contar el total de productos.
SELECT COUNT(*) AS TotalProductos
FROM TblProductos 
GO

--> 2. Calcular el total promedio de las facturas emitidas el día 20/10/2024.
SELECT AVG(TotalGeneral) AS PromedioFacturas
FROM TblFacturas 
WHERE CAST(FechaFacturacion AS DATE) = '20/10/2024'
GO

--> 3. Obtener el Stock total de todos los productos.
SELECT SUM(Stock) AS TotalStock
FROM TblProductos
GO

--> 4. Conocer la venta más alta que se haya registrado.
SELECT MAX(TotalGeneral)
FROM TblFacturas
GO

--> 5. Contar cuantas facturas por cliente se han emitido.
SELECT IdCliente, COUNT(*) AS TotalFacturas
FROM TblClientes
GROUP BY IdCliente
GO

--> 6. Mostrar los productos que se hayan vendido mas de 500 unidades.
SELECT IdProducto, SUM(Cantidad) AS CantidadVendida
FROM TblDetallesFactura 
GROUP BY IdProducto
HAVING SUM(Cantidad) > 500
GO

--> 7. Filtrar los clientes cuyos pagos sean mayores a 60000.
SELECT IdCliente, SUM(TotalGeneral) AS PagosTotales
FROM TblFacturas
GROUP BY IdCliente
HAVING SUM(TotalGeneral) > 60000
GO

/*
1.	Obtener el precio más alto de todos los productos.
2.	Obtener la venta más baja registrada en la base de datos.
3.	Calcular el total de ventas de todas las facturas.
4.	Obtener el precio promedio de todos los productos.
5.	Contar el número total de usuarios en la base de datos.
6.	Obtener el promedio y el total en productos en stock, además del precio máximo y mínimo de todos los productos. 
*/
