USE FacturacionDB;
GO

-- Inserción de usuarios
INSERT INTO TblUsuarios (Nombre, Email, Telefono, Direccion, Clave)
VALUES
('Juan Pérez', 'juan.perez@example.com', '1234567890', 'Calle 123', CONVERT(VARBINARY(MAX), 'clave1')),
('Maria López', 'maria.lopez@example.com', '0987654321', 'Avenida 456', CONVERT(VARBINARY(MAX), 'clave2')),
('Carlos Gómez', 'carlos.gomez@example.com', '5551234567', 'Boulevard 789', CONVERT(VARBINARY(MAX), 'clave3')),
('Ana Torres', 'ana.torres@example.com', '5558765432', 'Calle 111', CONVERT(VARBINARY(MAX), 'clave4')),
('Luis Martínez', 'luis.martinez@example.com', '5552345678', 'Calle 222', CONVERT(VARBINARY(MAX), 'clave5'));
GO


-- Inserción de clientes
INSERT INTO TblClientes (NombreCliente, EmailCliente, TelefonoCliente, DireccionCliente)
VALUES
('Sofía Ruiz', 'sofia.ruiz@example.com', '5559876543', 'Calle 333'),
('José Fernández', 'jose.fernandez@example.com', '5556543210', 'Calle 444'),
('Patricia Gómez', 'patricia.gomez@example.com', '5553216540', 'Calle 555'),
('Ricardo Salazar', 'ricardo.salazar@example.com', '5551472583', 'Calle 666'),
('Laura Medina', 'laura.medina@example.com', '5559517530', 'Calle 777');
GO


-- Inserción de categorías de productos en español
INSERT INTO TblcategoriaProducto (CategoriaProducto)
VALUES
('Teléfonos Inteligentes'),
('Tabletas'),
('Portátiles'),
('Auriculares'),
('Relojes Inteligentes'),
('Asistentes para el Hogar');
GO


-- Inserción de nuevos productos con categorías en español
INSERT INTO TblProductos (CodigoProducto, NombreProducto, IdCategoria, Precio, Stock)
VALUES
('SGS23', 'Samsung Galaxy S23', 1, 799.99, 100),
('IP14', 'iPhone 14', 1, 999.99, 80),
('GP7', 'Google Pixel 7', 1, 599.99, 75),
('OP11', 'OnePlus 11', 1, 749.99, 60),
('XM12', 'Xiaomi 12', 1, 699.99, 50),
('HW40', 'Huawei P40', 1, 599.99, 40),
('MT30', 'Motorola Edge 30', 1, 499.99, 30),
('NG50', 'Nokia G50', 1, 299.99, 25),
('SX10', 'Sony Xperia 10 III', 1, 399.99, 20),
('LGV', 'LG Velvet', 1, 449.99, 15),
('IPAD', 'iPad Pro', 2, 1099.99, 50),
('MBP', 'MacBook Pro', 3, 1999.99, 30),
('SSW', 'Samsung Galaxy Watch', 5, 299.99, 70),
('AHEAD', 'Apple AirPods Pro', 4, 249.99, 150),
('SFSP', 'Surface Pro 7', 2, 899.99, 40),
('AMZ', 'Amazon Echo', 6, 99.99, 80),
('GASS', 'Google Nest', 6, 129.99, 60),
('BPAD', 'Microsoft Surface Pro', 2, 899.99, 50),
('TLM', 'Dell XPS 13', 3, 1199.99, 40),
('SDND', 'Sony WH-1000XM4', 4, 349.99, 70);
GO

-- Inserción de más facturas con múltiples detalles por factura
DECLARE @i INT = 0;
DECLARE @StartDate DATETIME = '01/03/2024';
DECLARE @EndDate DATETIME = GETDATE();
DECLARE @NumFacturas INT = 50000;
DECLARE @CurrentDate DATETIME = @StartDate;

WHILE @i < @NumFacturas
BEGIN
    DECLARE @IdCliente INT = 1 + ABS(CHECKSUM(NEWID()) % 5);
	DECLARE @IdUsuario TINYINT = 1 + ABS(CHECKSUM(NEWID()) % 5); -- Selecciona un usuario aleatorio
	DECLARE @FechaFacturacion DATETIME = DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % DATEDIFF(SECOND, @CurrentDate, @EndDate), @CurrentDate);
    DECLARE @SubTotal DECIMAL(10, 2) = 0.00;

    INSERT INTO TblFacturas (IdCliente, IdUsuario, FechaFacturacion, SubTotal)
    VALUES (@IdCliente, @IdUsuario, @FechaFacturacion, 0);
    
    DECLARE @IdFactura INT = SCOPE_IDENTITY();

    -- Inserción de detalles de factura
    DECLARE @Detalles INT = 1 + ABS(CHECKSUM(NEWID()) % 5);
    DECLARE @j INT = 0;
	DECLARE @TotalDescuento DECIMAL(10,2) = 0;
    
    WHILE @j < @Detalles
    BEGIN
        DECLARE @IdProducto INT = 1 + ABS(CHECKSUM(NEWID()) % 20);
        DECLARE @Cantidad INT = 1 + ABS(CHECKSUM(NEWID()) % 5);
        DECLARE @PrecioUnitario DECIMAL(10, 2) = (SELECT Precio FROM TblProductos WHERE IdProducto = @IdProducto);
        DECLARE @AplicarDescuento BIT = CAST(RAND() * 2 AS BIT);
        DECLARE @DescuentoDetalle DECIMAL(10, 2) = CASE WHEN @AplicarDescuento = 1 THEN RAND() * 0.1 * @PrecioUnitario ELSE 0 END;
        
        INSERT INTO TblDetallesFactura (IdFactura, IdProducto, Cantidad, PrecioUnitario, Descuento)
        VALUES (@IdFactura, @IdProducto, @Cantidad, @PrecioUnitario, @DescuentoDetalle);

        SET @SubTotal = @SubTotal + (@PrecioUnitario * @Cantidad);
		SET @TotalDescuento = @TotalDescuento + @DescuentoDetalle;
        SET @j = @j + 1;
    END;

    -- Actualizar el total en TblFacturas
    UPDATE TblFacturas
    SET Descuento = @TotalDescuento,
		SubTotal = @SubTotal
    WHERE IdFactura = @IdFactura;

	SET @CurrentDate = @FechaFacturacion;
    SET @i = @i + 1;
END;
