USE [products]
GO
/****** Object:  User [leidy]    Script Date: 2/10/2020 2:36:40 a. m. ******/
CREATE USER [leidy] FOR LOGIN [leidy] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [leidy]
GO
ALTER ROLE [db_datareader] ADD MEMBER [leidy]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [leidy]
GO
/****** Object:  Table [dbo].[inventory]    Script Date: 2/10/2020 2:36:40 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventory](
	[idReference] [int] NULL,
	[cant_inventory] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productsReferences]    Script Date: 2/10/2020 2:36:40 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productsReferences](
	[idReference] [int] NOT NULL,
	[reference] [varchar](30) NULL,
	[descriptionReference] [nvarchar](50) NULL,
	[colour] [varchar](30) NULL,
	[price] [int] NULL,
	[statusRef] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idReference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD FOREIGN KEY([idReference])
REFERENCES [dbo].[productsReferences] ([idReference])
GO
/****** Object:  StoredProcedure [dbo].[ActionsInventory]    Script Date: 2/10/2020 2:36:40 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActionsInventory](@idReference INT = null, @cant_inventory INT = null, @actionType VARCHAR(10) = '' )
AS
	DECLARE @sumRegister INT;
	DECLARE @message VARCHAR (30)
	DECLARE @countId INT;
	DECLARE @status VARCHAR (10);
	SET @countId = (SELECT COUNT (idReference) FROM inventory WHERE idReference = @idReference);
	BEGIN

			SET @status = (SELECT statusRef FROM productsReferences where idReference = @idReference)
			IF @actionType = 'insert' and  @status = 'activo'
				BEGIN 
					SET @sumRegister = (SELECT SUM (cant_inventory + @cant_inventory ) FROM inventory);
				IF @sumRegister > 200 
					BEGIN 
						SET @message = 'Se está excediendo la cantidad de inventario'
						SELECT  @message 
					END
 				ELSE IF @countId >0
					BEGIN 
						SET @sumRegister = (SELECT SUM (cant_inventory + @cant_inventory ) FROM inventory WHERE idReference = @idReference)
						UPDATE inventory
						SET cant_inventory = @sumRegister WHERE idReference = @idReference
					END
				ELSE 
					BEGIN 
						INSERT INTO inventory (idReference,cant_inventory) VALUES (@idReference,@cant_inventory)
					END 
			END
		IF @actionType = 'select'
	BEGIN 	
		SELECT * FROM inventory 
	END 
END
GO
/****** Object:  StoredProcedure [dbo].[ActionsProducts]    Script Date: 2/10/2020 2:36:40 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActionsProducts](@idReference INT = null,@reference VARCHAR(30) = null,@descriptionReference NVARCHAR(50) = null,@colour VARCHAR(30) = null,
								 @price INT = null,@statusRef VARCHAR(10) = null,@actionType VARCHAR(10) = '')							 
AS
DECLARE @message VARCHAR (30)
	BEGIN 
		IF @actionType = 'insert'
	BEGIN 
		INSERT INTO productsReferences (idReference,reference,descriptionReference,colour,price,statusRef)
		VALUES (@idReference,@reference,@descriptionReference,@colour,@price,@statusRef)
	END
		IF @actionType = 'select'
	BEGIN 	
		SELECT * FROM productsReferences 
	END 
		IF @actionType = 'selectById'
	BEGIN 	
		SELECT * FROM productsReferences WHERE  idReference = @idReference 
	END 
		IF @actionType = 'update'
	BEGIN 	
		UPDATE productsReferences 
		SET reference = @reference,
			descriptionReference = @descriptionReference,
			colour = @colour,
			price = @price,
			statusRef = @statusRef
		WHERE idReference = @idReference
	END 
		IF @actionType = 'delete'
	BEGIN 	
		DELETE FROM productsReferences WHERE  idReference = @idReference 
	END 
END
GO
