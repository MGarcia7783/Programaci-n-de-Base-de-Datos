USE FacturacionDB
GO

--> Realizar consulta que permita mostrar el número, fecha de factura y cliente. 
SELECT F.IdFactura, F.FechaFacturacion, C.NombreCliente 
FROM TblFacturas F
INNER JOIN TblClientes C ON F.IdCliente = C.IdCliente;
GO

--> Lista de todos los clientes y sus facturas asociadas. Incluyendo clientes sin facturas asociadas.
SELECT F.IdFactura, F.FechaFacturacion, C.NombreCliente 
FROM TblFacturas F
RIGHT JOIN TblClientes C ON F.IdCliente = C.IdCliente;
GO

--> Realizar consulta que permita mostrar el número, fecha de factura y usuario.
SELECT F.IdFactura, F.FechaFacturacion, U.Nombre 
FROM TblFacturas F
INNER JOIN TblUsuarios U ON F.IdUsuario = U.IdUsuario;
GO

--> Mostrar facturas anuladas, incluyendo el nombre del cliente.
SELECT F.IdFactura, C.NombreCliente, F.FechaFacturacion, F.FechaAnulacion, F.MotivoAnulacion, F.TotalGeneral, F.Estado
FROM TblFacturas F
INNER JOIN TblClientes C ON C.IdCliente = F.IdCliente 
WHERE F.Estado = 0;
GO

--> Mostrar los productos con sus categorías.
SELECT P.CodigoProducto, P.NombreProducto, C.CategoriaProducto, P.Precio, P.Stock 
FROM TblProductos P
INNER JOIN TblCategoriaProducto C ON C.IdCategoria = P.IdProducto;
GO

--> Realizar consulta que devuelva el producto, precio unitario, cantidad, descuento y total.
SELECT P.NombreProducto, D.PrecioUnitario, D.Cantidad, D.Descuento, D.Total 
FROM TblDetallesFactura D
INNER JOIN TblProductos P ON D.IdProducto = P.IdProducto;
GO

