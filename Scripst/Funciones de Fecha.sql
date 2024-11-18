USE FacturacionDB
GO

--> 1. Agregar 30 días a la fecha actual de la factura 1.
SELECT IdFactura, FechaFacturacion, DATEADD(DAY, 30, FechaFacturacion) AS NuevaFecha
FROM TblFacturas
WHERE IdFactura = 1;
GO

--> 2. Calcular la diferencia en días entre la fecha de la factura 1 y la fecha actual.
SELECT IdFactura, FechaFacturacion, DATEDIFF(DAY, FechaFacturacion, GETDATE()) AS DiferenciaDias
FROM TblFacturas
WHERE IdFactura = 1;
GO

--> 3. Obtener el mes de la fecha de facturación.
SELECT IdFactura, FechaFacturacion, DATEPART(MONTH, FechaFacturacion) AS MesFacturado
FROM TblFacturas;
GO

--> 4. Verificar si la columna Total de la tabla Factura es una fecha válida.
SELECT IdFactura, FechaAnulacion , ISDATE(FechaAnulacion) AS EsFecha
FROM TblFacturas;
GO


/*
1.	Obtener la fecha de la factura más una semana (7 días) desde la fecha de creación.
2.	Calcular la diferencia en días entre la fecha actual y la fecha de cada factura.
3.	Extraer el año y el mes de la fecha de cada factura.
*/
