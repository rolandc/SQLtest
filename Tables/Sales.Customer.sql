CREATE TABLE [Sales].[Customer]
(
[CustomerID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[TerritoryID] [int] NULL,
[AccountNumber] AS (isnull('AW'+[dbo].[ufnLeadingZeros]([CustomerID]),'')),
[CustomerType] [nchar] (1) COLLATE Latin1_General_CS_AS NOT NULL,
[rowguid] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_Customer_rowguid] DEFAULT (newid()),
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Sales].[Customer] ADD CONSTRAINT [CK_Customer_CustomerType] CHECK ((upper([CustomerType])='I' OR upper([CustomerType])='S'))
GO
ALTER TABLE [Sales].[Customer] ADD CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Customer_AccountNumber] ON [Sales].[Customer] ([AccountNumber]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Customer_rowguid] ON [Sales].[Customer] ([rowguid]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Customer_TerritoryID] ON [Sales].[Customer] ([TerritoryID]) ON [PRIMARY]
GO
ALTER TABLE [Sales].[Customer] ADD CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Current customer information. Also see the Individual and Store tables.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique number identifying the customer assigned by the accounting system.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'AccountNumber'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key for Customer records.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Customer type: I = Individual, S = Store', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'CustomerType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'TerritoryID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [CustomerType]=''I'' OR [CustomerType]=''i'' OR [CustomerType]=''S'' OR [CustomerType]=''s''', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'CK_Customer_CustomerType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'DF_Customer_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'DF_Customer_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'FK_Customer_SalesTerritory_TerritoryID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'PK_Customer_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'INDEX', N'AK_Customer_AccountNumber'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'INDEX', N'AK_Customer_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'INDEX', N'IX_Customer_TerritoryID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'INDEX', N'PK_Customer_CustomerID'
GO
