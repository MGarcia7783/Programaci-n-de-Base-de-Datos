USE FacturacionDB
GO

--> 1. Filtrar los productos con un stock menor o igual a 20.
SELECT
* FROM TblProductos 
WHERE Stock <= 20
GO

--> 2. Filtrar las facturas emitidas el d�a 20/10/2024.
SELECT
* FROM TblFacturas 
WHERE CAST(FechaFacturacion AS DATE) = '20/10/2024'
GO

--> 3. Mostrar todos los clientes ordenados alfab�ticamente.
SELECT
* FROM TblClientes 
ORDER BY NombreCliente ASC
GO

--> 4. Leer las primeras 10 facturas emitidas el d�a 20/10/2024.
SELECT TOP(10)
* FROM TblFacturas 
WHERE CAST(FechaFacturacion AS DATE) = '20/10/2024'
GO

--> 5. Listar todas las facturas agrupadas por IdCliente y fecha de emisi�n.
SELECT IdCliente, FechaFacturacion 
FROM TblFacturas
GROUP BY IdCliente, FechaFacturacion 
GO

--> 6. Conocer la lista de todos los productos que se han vendido orden�ndolos descendentemente.
SELECT DISTINCT IdProducto
FROM TblDetallesFactura
ORDER BY IdProducto DESC
GO


/*
1.	Obtener los cinco productos m�s caros en la base de datos.
2.	Listar todas las facturas ordenadas por la fecha de facturaci�n en orden ascendente.
3.	Listar los diferentes clientes que han realizado compras.
*/
