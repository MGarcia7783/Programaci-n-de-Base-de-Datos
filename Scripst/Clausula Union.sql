USE FacturacionDB
GO

--> Listar facturas con o sin descuento.
SELECT IdFactura, 'Con Descuento' AS Estado
FROM TblFacturas
WHERE Descuento > 0
UNION
SELECT IdFactura, 'Sin Descuento' AS ESTADO
FROM TblFacturas 
WHERE Descuento = 0;
GO

--> Mostrar productos y sus categorías.
SELECT NombreProducto 
FROM TblProductos 
UNION
SELECT CategoriaProducto
FROM TblCategoriaProducto;
GO

--> Listar email de usuarios y clientes.
SELECT NombreCliente, EmailCliente, 'Cliente' AS Tipo 
FROM TblClientes
UNION
SELECT Nombre, Email, 'Usuario' AS Tipo 
FROM TblUsuarios;
GO

--> Listar facturas anuladas y no anuladas.
SELECT IdFactura, 'Anulada' AS Estado
FROM TblFacturas
WHERE Estado = 0
UNION
SELECT IdFactura, 'Activa' AS Estado
FROM TblFacturas 
WHERE Estado = 1;
GO

--> Mostrar direcciones de usuarios y clientes.
SELECT NombreCliente, DireccionCliente, 'Cliente' AS Tipo
FROM TblClientes
UNION
SELECT Nombre, Direccion, 'Usuario' AS Tipo
FROM TblUsuarios;
GO

--> Obtener el nombre y email de los usuarios y clientes.
SELECT NombreCliente, EmailCliente, 'Cliente' AS Tipo
FROM TblClientes 
UNION
SELECT Nombre, Email, 'Usuario' AS Tipo
FROM TblUsuarios; 
GO

--> Listar usuarios y productos cuyo nombre comienza con la letra “A”.
SELECT Nombre, 'Usuario' AS Tipo
FROM TblUsuarios 
WHERE Nombre LIKE 'A%'
UNION
SELECT NombreCliente, 'Cliente' AS Tipo
FROM TblClientes
WHERE NombreCliente LIKE 'A%';
GO