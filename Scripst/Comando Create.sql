USE FacturacionDB
GO

--> Crear tabla  llamada TblPagos, para gestionar los pagos de los clientes, con los siguientes campos y restricciones:
	--> IdPago INT, como clave principal y auto incrementable.
	--> IdFactura INT, como clave foránea que referencie a la tabla Factura.
	--> MontoPagodo DECIMAL(11,2), no nulo.
	--> FechaPago DATETIME, con valor predeterminado de la fecha actual.

CREATE TABLE TblPagos(
	IdPago INT IDENTITY(1,1),
	IdFactura INT,
	MontoPagodo DECIMAL(11,2) NOT NULL,
	FechaPago DATETIME DEFAULT GETDATE(),
	
	CONSTRAINT[PK_TblPagos_IdPago] PRIMARY KEY(IdPago),
	CONSTRAINT[FK_TblPagos_IdFactura] FOREIGN KEY(IdFactura) REFERENCES TblFacturas(IdFactura)
);
GO

-->Crear una tabla llamada TblDevolucion, para almacenar la información de productos devueltos, con las siguientes columnas y restricciones:
	-->IdDevulucion INT, como clave primaria y auto incrementable.
	-->IdFactura INT, como clave foránea que referencie a la tabla Factura.
	-->Motivo VARCHAR(255), obligatorio.
	-->FechaDevolucion DATETIME, con valor predeterminado de la fecha actual.

CREATE TABLE TblDevolucion(
	IdDevolucion INT IDENTITY(1,1),
	IdFactura INT,
	Motivo VARCHAR(255) NOT NULL,
	FechaDevulucion DATETIME DEFAULT GETDATE(),

	CONSTRAINT[PK_TblDevolucion_IdDevolucion] PRIMARY KEY(IdDevolucion),
	CONSTRAINT[FK_TblDevolucion_IdFactura] FOREIGN KEY(IdFactura) REFERENCES TblFacturas(IdFactura)
);
GO



