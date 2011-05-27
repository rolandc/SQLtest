CREATE TABLE [Sales].[CustomerAddress]
(
[CustomerID] [int] NOT NULL,
[AddressID] [int] NOT NULL,
[AddressTypeID] [int] NOT NULL,
[rowguid] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_CustomerAddress_rowguid] DEFAULT (newid()),
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CustomerAddress_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Sales].[CustomerAddress] ADD CONSTRAINT [PK_CustomerAddress_CustomerID_AddressID] PRIMARY KEY CLUSTERED  ([CustomerID], [AddressID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_CustomerAddress_rowguid] ON [Sales].[CustomerAddress] ([rowguid]) ON [PRIMARY]
GO
ALTER TABLE [Sales].[CustomerAddress] ADD CONSTRAINT [FK_CustomerAddress_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Person].[Address] ([AddressID])
GO
ALTER TABLE [Sales].[CustomerAddress] ADD CONSTRAINT [FK_CustomerAddress_AddressType_AddressTypeID] FOREIGN KEY ([AddressTypeID]) REFERENCES [Person].[AddressType] ([AddressTypeID])
GO
ALTER TABLE [Sales].[CustomerAddress] ADD CONSTRAINT [FK_CustomerAddress_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customer] ([CustomerID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping customers to their address(es).', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. Foreign key to Address.AddressID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'COLUMN', N'AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Address type. Foreign key to AddressType.AddressTypeID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'COLUMN', N'AddressTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. Foreign key to Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'COLUMN', N'CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'DF_CustomerAddress_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'DF_CustomerAddress_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'FK_CustomerAddress_Address_AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing AddressType.AddressTypeID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'FK_CustomerAddress_AddressType_AddressTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'FK_CustomerAddress_Customer_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'PK_CustomerAddress_CustomerID_AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'INDEX', N'AK_CustomerAddress_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'INDEX', N'PK_CustomerAddress_CustomerID_AddressID'
GO
