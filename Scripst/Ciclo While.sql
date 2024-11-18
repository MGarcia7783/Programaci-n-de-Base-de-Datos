USE FacturacionDB
GO

--> Imprimir los primeros 4 clientes.
--> Sumar ventas de las primeras 10 facturas.
DECLARE @SumaTotal DECIMAL(11, 2) = 0;
DECLARE @Contador INT = 1;

WHILE @Contador <= 10
BEGIN
	SELECT @SumaTotal = @SumaTotal + TotalGeneral
	FROM TblFacturas 
	WHERE IdFactura = @Contador 

	SET @Contador = @Contador + 1;
END;

PRINT 'El total de las primeras 10 facturas es: ' + CAST(@sumaTotal AS VARCHAR);
GO

--> Insertar 5 registros de prueba en la tabla Proveedor de forma iteractiva.
DECLARE @contador INT = 1;

WHILE @contador <= 5
BEGIN
	INSERT INTO TblProveedores(NombreProveedor, Telefono, Email)
	VALUES('Proveedor ' + CAST(@contador AS VARCHAR),
		   '123456', 
		   'proveedor' + CAST(@contador AS VARCHAR) + '@email.com'
		   )
	SET @contador = @contador + 1;
END
GO

SELECT *FROM TblProveedores 

--> Actualizar el estado a 0, de las facturas con un TotalGeneral mayor a 26000.
--> Contar cuantas facturas tienen un total menor a 500.
DECLARE @contador INT = 1;
DECLARE @conteo INT = 0;

WHILE @contador <= (SELECT MAX(IdFactura) FROM TblFacturas)
BEGIN
	IF(SELECT TotalGeneral FROM TblFacturas WHERE IdFactura = @contador) < 500
	BEGIN
		SET @conteo = @conteo + 1;
	END
	SET @contador = @contador + 1;
END

PRINT 'Numero de facturas con un totaL menor a 500: ' + CAST(@conteo AS VARCHAR);
GO

--> Borrar todos los registros de la tabla Proveedor de forma iteractiva.
