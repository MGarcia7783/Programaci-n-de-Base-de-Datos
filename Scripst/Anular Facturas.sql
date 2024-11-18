USE FacturacionDB
GO

ALTER TABLE TblFacturas
ADD FechaAnulacion DATETIME NULL;
GO

ALTER TABLE TblFacturas
ADD MotivoAnulacion VARCHAR(500) NULL;
GO

ALTER TABLE TblFacturas
ADD Estado BIT DEFAULT 1 NOT NULL;
GO


-- Crear una tabla temporal para los motivos de anulación
CREATE TABLE #TempMotivosAnulacion (
    IdMotivo INT IDENTITY(1,1),
    Motivo VARCHAR(255)
);

-- Insertar los motivos de anulación en la tabla temporal
INSERT INTO #TempMotivosAnulacion (Motivo)
VALUES ('Cliente canceló el pedido'),
       ('Error en la factura'),
       ('Factura duplicada'),
       ('Producto no disponible'),
       ('Descuento mal aplicado'),
       ('Factura errónea'),
       ('Factura fuera de tiempo');

-- Seleccionar facturas aleatorias y unirlas con motivos aleatorios
WITH FacturasAleatorias AS (
    SELECT TOP 1500 F.IdFactura, T.Motivo
    FROM TblFacturas F
    CROSS JOIN #TempMotivosAnulacion T -- Hacer combinación con la tabla temporal
    WHERE F.FechaAnulacion IS NULL  
    ORDER BY NEWID()  -- Ordenar aleatoriamente para que las facturas y motivos se mezclen
)

-- Actualizar las facturas con motivos aleatorios
UPDATE F
SET F.Estado = 0,
    F.FechaAnulacion = GETDATE(),
    F.MotivoAnulacion = A.Motivo
FROM TblFacturas F
JOIN FacturasAleatorias A ON F.IdFactura = A.IdFactura;

-- Limpiar la tabla temporal
DROP TABLE #TempMotivosAnulacion;

