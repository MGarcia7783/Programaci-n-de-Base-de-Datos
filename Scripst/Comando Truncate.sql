USE FacturacionDB
GO

--> Reiniciar los valores de IDENTIY.
	--> Crear una tabla TblRegistrosDiarios con una columna IdRegistro que tenga IDENTITY.
	--> Insertar varios registros en esta tabla.
	--> Finalmente usar TRUNCATE.

CREATE TABLE TblRegistrosDiarios(
	IdRegistro INT IDENTITY(1,1),
	Descripcion VARCHAR(20),

	CONSTRAINT[PK_TblRegistrosDiarios_IdRegistro] PRIMARY KEY(IdRegistro)
);
GO

INSERT INTO TblRegistrosDiarios(Descripcion)
VALUES('Registro 1'),
	  ('Registro 2'),
	  ('Registro 3'),
	  ('Registro 4'),
	  ('Registro 5');
GO

SELECT *FROM TblRegistrosDiarios;
GO

DELETE FROM TblRegistrosDiarios;
GO

TRUNCATE TABLE TblRegistrosDiarios;
GO


--> En la tabla TblRegistrosDiarios
	--> Insertar cinco registros nuevos.
	--> Usando el comando DELETE eliminar los últimos tres registros.
	--> Insertar un nuevo registro.
	--> Con el comando DELETE eliminar el último registro insertado.
	--> Reiniciar el valor del campo IdRegistro usando el comando DBCC CHECKIDENT.
	--> Insertar dos nuevos registros.

INSERT INTO TblRegistrosDiarios(Descripcion)
VALUES('Registro 1'),
	  ('Registro 2'),
	  ('Registro 3'),
	  ('Registro 4'),
	  ('Registro 5');
GO

SELECT *FROM TblRegistrosDiarios;
GO

DELETE FROM TblRegistrosDiarios
WHERE IdRegistro IN(6)
GO

SELECT *FROM TblRegistrosDiarios;
GO

DBCC CHECKIDENT ('TblRegistrosDiarios', RESEED, 2);
GO

INSERT INTO TblRegistrosDiarios(Descripcion)
VALUES('Registro 3'),
	  ('Registro 4'),
	  ('Registro 5')

