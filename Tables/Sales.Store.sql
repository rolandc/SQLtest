CREATE TABLE [Sales].[Store]
(
[CustomerID] [int] NOT NULL,
[Name] [dbo].[Name] NOT NULL,
[SalesPersonID] [int] NULL,
[Demographics] [xml] (CONTENT [Sales].[StoreSurveySchemaCollection]) NULL,
[rowguid] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_Store_rowguid] DEFAULT (newid()),
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Store_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [Sales].[iStore] ON [Sales].[Store] 
AFTER INSERT AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- Only allow the Customer to be a Store OR Individual
        IF EXISTS (SELECT * FROM inserted INNER JOIN [Sales].[Individual] 
            ON inserted.[CustomerID] = [Sales].[Individual].[CustomerID]) 
        BEGIN
            -- Rollback any active or uncommittable transactions
            IF @@TRANCOUNT > 0
            BEGIN
                ROLLBACK TRANSACTION;
            END
        END;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;
GO
ALTER TABLE [Sales].[Store] ADD CONSTRAINT [PK_Store_CustomerID] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Store_rowguid] ON [Sales].[Store] ([rowguid]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Store_SalesPersonID] ON [Sales].[Store] ([SalesPersonID]) ON [PRIMARY]
GO
CREATE PRIMARY XML INDEX [PXML_Store_Demographics] ON [Sales].[Store] ([Demographics])
GO
ALTER TABLE [Sales].[Store] ADD CONSTRAINT [FK_Store_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customer] ([CustomerID])
GO
ALTER TABLE [Sales].[Store] ADD CONSTRAINT [FK_Store_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [Sales].[SalesPerson] ([SalesPersonID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Customers (resellers) of Adventure Works products.', 'SCHEMA', N'Sales', 'TABLE', N'Store', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. Foreign key to Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Demographic informationg about the store such as the number of employees, annual sales and store type.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'Demographics'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the store.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'Name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ID of the sales person assigned to the customer. Foreign key to SalesPerson.SalesPersonID.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'SalesPersonID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'DF_Store_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'DF_Store_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'FK_Store_Customer_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesPerson.SalesPersonID', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'FK_Store_SalesPerson_SalesPersonID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'PK_Store_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'INDEX', N'AK_Store_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'INDEX', N'IX_Store_SalesPersonID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'INDEX', N'PK_Store_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary XML index.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'INDEX', N'PXML_Store_Demographics'
GO
EXEC sp_addextendedproperty N'MS_Description', N'AFTER INSERT trigger inserting Store only if the Customer does not exist in the Individual table.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'TRIGGER', N'iStore'
GO
