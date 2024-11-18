USE FacturacionDB
GO

--> 1. Obtener los productos cuyo precio sea mayor a 800 o el Stock sea menor a 5.
SELECT * FROM TblProductos 
WHERE Precio > 800 AND Stock < 40;
GO

--> 2. Listar productos cuyo precio sea mayor a 300 y tengan un Stock mayor a 20.
SELECT * FROM TblProductos 
WHERE Precio > 300 AND Stock > 20;
GO

--> 3. Obtener facturas realizadas por los clientes 1,2 o 3.
SELECT *FROM TblFacturas
WHERE IdCliente IN(1,2,3);
GO

SELECT *FROM TblFacturas 
WHERE IdCliente = 1 OR IdCliente = 2 OR IdCliente = 3;
GO

--> 4. Obtener los productos cuyo nombre contenga la letra “m”.
SELECT * FROM TblProductos
WHERE NombreProducto LIKE '%' + 'm' + '%';
GO

--> 5. Obtener todos los clientes que no vivan en Calle 444.
SELECT * FROM
TblClientes 
WHERE NOT DireccionCliente = 'Calle 444';
GO

--> 6. Obtener las ventas comprendidas entre el 17 al 19/10/2024.
SELECT * FROM TblFacturas 
WHERE CAST(FechaFacturacion AS DATE) BETWEEN '17/10/2024' AND '19/10/2024';
GO

/*
1.	Obtener todos los productos que pertenezcan a la categoría “Teléfonos Inteligentes” y que su precio se superior a 600.
2.	Mostrar las facturas que fueron emitidas por el usuario con IdUsuario 1 o 3.
3.	Listar todos los clientes cuyos IdCliente son 1,2 o 3.
4.	Filtrar los productos cuyo nombre contiene la palabra “Samsung”.
5.	Obtener los usuarios que su dirección no sea “Calle 555”.
6.	Obtener las facturas emitidas entre el 01 de enero de 2024 y el 01 de octubre de 2024.
7.	Obtener los teléfonos que no pertenezcan a la categoría de “Teléfonos Inteligentes”.
*/
