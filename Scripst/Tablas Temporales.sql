USE FacturacionDB
GO

--> Crear tabla local que permita almacenar los totales facturados por cliente.
CREATE TABLE #TotalFacturadoPorCliente(
	IdCliente INT,
	TotalFacturado DECIMAL(11,2)
);
GO

INSERT INTO #TotalFacturadoPorCliente
SELECT IdCliente,
	   SUM(TotalGeneral)
FROM TblFacturas
GROUP BY IdCliente;
GO

SELECT *FROM #TotalFacturadoPorCliente
GO

DROP TABLE #TotalFacturadoPorCliente
GO

--> Crear tabla global que almacene IdFactura, Cliente, Fecha y Total.
CREATE TABLE ##FacturaTemporal(
	Contador INT IDENTITY(1,1),
	IdFactura INT,
	NombreCliente VARCHAR(100),
	FechaFactura DATETIME,
	TotalFacturado DECIMAL(11,2)
);
GO

INSERT INTO ##FacturaTemporal
SELECT F.IdFactura,
	   C.NombreCliente,
	   F.FechaFacturacion,
	   F.TotalGeneral
FROM TblClientes C, TblFacturas F
WHERE C.IdCliente = F.IdFactura;
GO

SELECT *FROM ##FacturaTemporal
GO

DROP TABLE ##FacturaTemporal
GO

--> Crear tabla local para almacenar toda la información de la tabla factura
--> con subtotal > 1000 y calcular el total de dichas facturas.
CREATE TABLE #SumaFactura(
	IdFactura INT,
	FechaFactura DATETIME,
	IdCliente INT,
	SubTotal DECIMAL(11,2),
	Descuento DECIMAL(11,2),
	TotalGeneral DECIMAL(11,2)
);
GO

INSERT INTO #SumaFactura
SELECT IdFactura,
	   FechaFacturacion,
	   IdCliente,
	   SubTotal,
	   Descuento,
	   TotalGeneral
FROM TblFacturas 
WHERE SubTotal > 1000;
GO

SELECT *FROM #SumaFactura 
GO

DROP TABLE #SumaFactura
GO

--> Crear tabla global que almacene el cliente, número de facturas anuladas.
--> Almacenar facturas emitidas a Sofía Ruiz.
--> Crear tabla con identity para enumerar las facturas de “Laura Medida”. 
