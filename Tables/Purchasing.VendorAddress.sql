CREATE TABLE [Purchasing].[VendorAddress]
(
[VendorID] [int] NOT NULL,
[AddressID] [int] NOT NULL,
[AddressTypeID] [int] NOT NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_VendorAddress_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Purchasing].[VendorAddress] ADD CONSTRAINT [PK_VendorAddress_VendorID_AddressID] PRIMARY KEY CLUSTERED  ([VendorID], [AddressID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_VendorAddress_AddressID] ON [Purchasing].[VendorAddress] ([AddressID]) ON [PRIMARY]
GO
ALTER TABLE [Purchasing].[VendorAddress] ADD CONSTRAINT [FK_VendorAddress_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Person].[Address] ([AddressID])
GO
ALTER TABLE [Purchasing].[VendorAddress] ADD CONSTRAINT [FK_VendorAddress_AddressType_AddressTypeID] FOREIGN KEY ([AddressTypeID]) REFERENCES [Person].[AddressType] ([AddressTypeID])
GO
ALTER TABLE [Purchasing].[VendorAddress] ADD CONSTRAINT [FK_VendorAddress_Vendor_VendorID] FOREIGN KEY ([VendorID]) REFERENCES [Purchasing].[Vendor] ([VendorID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cross-reference mapping vendors and addresses.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. Foreign key to Address.AddressID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'COLUMN', N'AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Address type. Foreign key to AddressType.AddressTypeID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'COLUMN', N'AddressTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. Foreign key to Vendor.VendorID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'COLUMN', N'VendorID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'DF_VendorAddress_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'FK_VendorAddress_Address_AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing AddressType.AddressTypeID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'FK_VendorAddress_AddressType_AddressTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Vendor.VendorID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'FK_VendorAddress_Vendor_VendorID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'PK_VendorAddress_VendorID_AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'INDEX', N'IX_VendorAddress_AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'INDEX', N'PK_VendorAddress_VendorID_AddressID'
GO
