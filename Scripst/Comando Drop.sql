USE FacturacionDB
GO

-->Eliminar la restricción   de TblPagosCliente.
ALTER TABLE TblPagosClientes
DROP CONSTRAINT CK_TblPagosClientes_MontoPagodo;
GO

-->Eliminar la columna FechaModificacion de la tabla TblPagosCliente.
ALTER TABLE TblPagosClientes
DROP COLUMN FechaModificacion;
GO

-->Eliminar la tabla TblPagosClientes.
DROP TABLE TblPagosClientes;
GO
