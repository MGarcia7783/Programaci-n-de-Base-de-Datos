USE FacturacionDB
GO

--> 1. Insertar un nuevo registro en la tabla productos.
INSERT INTO TblProductos(CodigoProducto, NombreProducto, IdCategoria, Precio, Stock)
VALUES('COD01',
	   'Producto Ejemplo',
	   3,
	   50,
	   5);
GO

--> 2. Actualizar el precio del producto con el IdProducto que sea 23.
UPDATE TblProductos
SET Precio = 100
WHERE IdProducto = 23;
GO

--> 3. Eliminar el registro de la tabla productos que el IdProducto sea 23.
DELETE FROM TblProductos
WHERE IdProducto = 23;
GO


SELECT *FROM TblProductos 

SELECT NombreProducto, Precio, Stock
FROM TblProductos 
