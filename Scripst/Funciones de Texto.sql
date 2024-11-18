USE FacturacionDB
GO

--> 1. Obtener los primeros tres caracteres del nombre de producto.
SELECT LEFT(NombreProducto, 3) AS INICIALES
FROM TblProductos;
GO

--> 2. Obtener los últimos dos dígitos del teléfono de los clientes.
SELECT RIGHT(TelefonoCliente, 2) AS ULTIMOSDIGITOS
FROM TblClientes;
GO

--> 3. Obtener la longitud de los nombres de productos.
SELECT LEN(NombreProducto) AS LONGITUDNOMBRE
FROM TblProductos;
GO 

--> 4. Mostrar los nombres de los productos en minúsculas.
SELECT LOWER(NombreProducto) AS NOMBREMINUSCULAS
FROM TblProductos;
GO

--> 5. Mostrar los nombres de los clientes en mayúsculas.
SELECT UPPER(NombreCliente) AS NOMBREMAYUSCULAS
FROM TblClientes;
GO

--> 6. Concatenar el nombre del cliente con su teléfono.
SELECT CONCAT(NombreCliente, ' - ', TelefonoCliente) AS NOMBRETELEFONO
FROM TblClientes;
GO


/*
1.	Obtener los primeros tres caracteres del nombre de cada producto.
2.	Obtener los últimos cuatro caracteres del nombre de cada cliente.
3.	Concatenar el nombre, email, teléfono y dirección del cliente, separados por una coma.
*/


