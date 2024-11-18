USE FacturacionDB
GO

--> 1. Agregar 30 d�as a la fecha actual de la factura 1.
SELECT IdFactura, FechaFacturacion, DATEADD(DAY, 30, FechaFacturacion) AS NuevaFecha
FROM TblFacturas
WHERE IdFactura = 1;
GO

--> 2. Calcular la diferencia en d�as entre la fecha de la factura 1 y la fecha actual.
SELECT IdFactura, FechaFacturacion, DATEDIFF(DAY, FechaFacturacion, GETDATE()) AS DiferenciaDias
FROM TblFacturas
WHERE IdFactura = 1;
GO

--> 3. Obtener el mes de la fecha de facturaci�n.
SELECT IdFactura, FechaFacturacion, DATEPART(MONTH, FechaFacturacion) AS MesFacturado
FROM TblFacturas;
GO

--> 4. Verificar si la columna Total de la tabla Factura es una fecha v�lida.
SELECT IdFactura, FechaAnulacion , ISDATE(FechaAnulacion) AS EsFecha
FROM TblFacturas;
GO


/*
1.	Obtener la fecha de la factura m�s una semana (7 d�as) desde la fecha de creaci�n.
2.	Calcular la diferencia en d�as entre la fecha actual y la fecha de cada factura.
3.	Extraer el a�o y el mes de la fecha de cada factura.
*/
