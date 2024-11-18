USE FacturacionDB
GO

--> Usar IF…ELSE para verificar si un cliente determinado tiene más de 10,000 facturas y mostrar un mensaje.
DECLARE @numFacturas INT;
SELECT @numFacturas = COUNT(*)
FROM TblFacturas F
INNER JOIN TblClientes C ON F.IdCliente = C.IdCliente
WHERE C.NombreCliente = 'José Fernandez';

IF @numFacturas >= 10000
	PRINT 'Elcliente tiene más de 10,000 o más facturas.'
ELSE
	PRINT 'El cliente tiene mesno de 10,0000 factuas.';
GO

--> Mediante IF…ELSE, validar si hay suficiente stock en la tabla Productos antes de registrar una compra.
--> Usar CASE para mostrar si un cliente está activo o inactivo.
SELECT IdCliente, NombreCliente,
	   CASE
			WHEN Estado = 1 THEN 'Activo'
			ELSE 'Inactivo'
	   END AS Estadocliente
FROM TblClientes;
GO

--> Clasificar el ingreso de facturas según el monto total.
--> Total > 1000  => ‘Ingreso Alto’.
--> Total  >= 500 y Total <= 1000 => ‘Ingreso Medio’.
--> Total < 500   => ‘Ingreso Bajo’.

SELECT IdFactura, TotalGeneral,
	   CASE
			WHEN TotalGeneral > 1000 THEN 'Ingreso Alto'
			WHEN TotalGeneral BETWEEN 500 AND 1000 THEN 'Ingreso Medio'
			ELSE 'Ingreso Bajo'
	   END AS [Clasificación de Ingreso]
FROM TblFacturas;
GO
