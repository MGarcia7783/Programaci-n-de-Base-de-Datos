USE FacturacionDB
GO

/*SUBCONSULTAS EN LA CLAUSULA SELECT*/
--> Mostrar las facturas junto con el nombre del cliente.
SELECT IdFactura, TotalGeneral,
	   (SELECT NombreCliente
	   FROM TblClientes
	   WHERE TblClientes.IdCliente = TblFacturas.IdCliente) AS NombreCliente
FROM TblFacturas;
GO

--> Mostrar las facturas junto con el número de productos comprados en cada factura.
SELECT IdFactura, TotalGeneral,
	   (SELECT COUNT(*)
	   FROM TblDetallesFactura
	   WHERE TblDetallesFactura.IdFactura = TblFacturas.IdFactura) AS NumProductos
FROM TblFacturas;
GO


--> Mostrar facturas junto con el descuento máximo aplicado en los productos de la factura.
--> Mostrar los clientes junto con el total de todas sus facturas.
--> Mostrar clientes con el número de facturas que han sido anuladas.


/*SUBCONSULTAS EN LA CLAUSULA FROM*/
--> Calcular el total de ventas realizadas por usuario.
SELECT U.IdUsuario, U.Nombre, VentasTotales.TotalVendido
FROM TblUsuarios U
INNER JOIN(SELECT IdUsuario, SUM(TotalGeneral) AS TotalVendido
		   FROM TblFacturas
		   GROUP BY IdUsuario) VentasTotales ON U.IdUsuario = VentasTotales.IdUsuario;
GO

--> Mostrar el total de ventas junto con el promedio de ventas por cliente.
SELECT C.IdCliente, C.NombreCliente, VentasTotales.TotalVendido, VentasPromedio.PromedioVendido
FROM TblClientes C
INNER JOIN(SELECT IdCliente, SUM(TotalGeneral) AS TotalVendido
		   FROM TblFacturas
		   GROUP BY IdCliente) VentasTotales ON C.IdCliente = VentasTotales.IdCliente
INNER JOIN(SELECT IdCliente, AVG(TotalGeneral) AS PromedioVendido
		   FROM TblFacturas 
		   GROUP BY IdCliente) VentasPromedio ON C.IdCliente = VentasPromedio.IdCliente;
GO

--> Obtener la cantidad de productos vendidos por categoría de productos.
--> Calcular el promedio de ventas por cliente.



/*SUBCONSULTAS EN LA CLAUSULA WHERE*/
--> Se necesita obtener las facturas cuyo total sea mayor que el promedio del total de todas las facturas en la base de datos.
SELECT IdFactura, TotalGeneral 
FROM TblFacturas
WHERE TotalGeneral > (SELECT AVG(TotalGeneral) FROM TblFacturas);
GO

--> Obtener todas las facturas que pertenecen a clientes ubicados en la calle 444 (múltiples valores).
SELECT C.NombreCliente, F.IdFactura, F.TotalGeneral
FROM TblFacturas F
INNER JOIN TblClientes C ON C.IdCliente = F.IdCliente 
WHERE F.IdCliente IN(SELECT IdCliente
					 FROM TblClientes
					 WHERE DireccionCliente = 'Calle 444');
GO

--> Obtener todas las facturas que tienen detalles asociados en la tabla TblDetallesFacturas (operador EXISTS).
SELECT IdFactura, TotalGeneral
FROM TblFacturas F
WHERE NOT EXISTS(SELECT 1
			 FROM TblDetallesFactura D
			 WHERE F.IdFactura = D.IdFactura);
GO

INSERT INTO TblFacturas(IdCliente, IdUsuario, FechaFacturacion, SubTotal, Descuento, Estado)
			VALUES(4,
				   2,
				   GETDATE(),
				   500,
				   50,
				   1);
GO

SELECT *FROM TblFacturas 

--> Obtener todas las facturas cuyo total es mayor que el promedio de todas las facturas del mismo cliente (subconsulta correlacionada).
--> Seleccionar clientes con más de 300 facturas anuladas.
--> Listar las facturas cuyo monto total sea mayor que la factura más alta de un cliente específico.
--> Listar clientes que no tienen ninguna factura.
