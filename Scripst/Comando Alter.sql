USE FacturacionDB
GO

--> Renombrar la tabla TblPagos por TblPagosClientes.
EXEC sp_rename TblPagos, TblPagosClientes;
GO

--> Renombrar la columna FechaPago de la tabla TblPagosClientes, por Fecha.
EXEC sp_rename 'TblPagosClientes.FechaPago', 'Fecha', 'COLUMN';
GO

--> Agregar la columna FechaModificacion de tipo DATETIME  a la tabla TblPagosCliente, la columna debe permitir valores nulos.
ALTER TABLE TblPagosClientes
ADD FechaModificacion DATETIME NOT NULL;
GO

--> Cambiar el tipo de dato de la columna Motivo a VARCHAR(MAX) de la tabla TblDevolucion.
ALTER TABLE TblDevolucion
ALTER COLUMN Motivo VARCHAR(MAX);
GO

--> Agregar una restricción CHECK en la columna MontoPago de la tabla TblPagosClientes,
--> para que los valores en esta columna sean mayores que cero.
ALTER TABLE TblPagosClientes
ADD CONSTRAINT CK_TblPagosClientes_MontoPagodo CHECK(MontoPagodo > 0);
GO