USE FacturacionDB
GO

--> Obtener la lista de todos los usuarios, con su teléfono y email, que registraron facturas, 
--> incluyendo la fecha de facturación.
SELECT U.Nombre, U.Telefono, U.Email, F.FechaFacturacion
FROM TblUsuarios U, TblFacturas F
WHERE U.IdUsuario = F.IdUsuario;
GO

--> Conocer los clientes que han comprado productos que pertenecen a la categoría “Teléfonos Inteligentes”.
SELECT C.NombreCliente, P.NombreProducto, F.FechaFacturacion  
FROM TblClientes C, TblFacturas F, TblDetallesFactura D, TblProductos P, TblCategoriaProducto Cat
WHERE C.IdCliente = F.IdCliente
	  AND F.IdFactura = D.IdFactura 
	  AND D.IdProducto = P.IdProducto 
	  AND P.IdCategoria = Cat.IdCategoria 
	  AND Cat.CategoriaProducto = 'Teléfonos Inteligentes';
GO

--> Obtener lista de las facturas con el cliente a quien fueron emitidas.
SELECT F.IdFactura, C.NombreCliente 
FROM TblFacturas F, TblClientes C
WHERE F.IdCliente = C.IdCliente;
GO

--> Listar facturas con el cliente y fecha de facturación
SELECT F.IdFactura, C.NombreCliente, F.FechaFacturacion
FROM TblFacturas F, TblClientes C
WHERE F.IdCliente = C.IdCliente;
GO

--> Obtener las facturas para un cliente específico, dado su nombre.
SELECT F.IdFactura, C.NombreCliente, F.FechaFacturacion, F.TotalGeneral 
FROM TblFacturas F, TblClientes C
WHERE F.IdCliente = C.IdCliente AND C.NombreCliente = 'Sofía Ruiz';
GO
