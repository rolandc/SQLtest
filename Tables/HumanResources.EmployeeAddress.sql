CREATE TABLE [HumanResources].[EmployeeAddress]
(
[EmployeeID] [int] NOT NULL,
[AddressID] [int] NOT NULL,
[rowguid] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_EmployeeAddress_rowguid] DEFAULT (newid()),
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_EmployeeAddress_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [HumanResources].[EmployeeAddress] ADD CONSTRAINT [PK_EmployeeAddress_EmployeeID_AddressID] PRIMARY KEY CLUSTERED  ([EmployeeID], [AddressID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_EmployeeAddress_rowguid] ON [HumanResources].[EmployeeAddress] ([rowguid]) ON [PRIMARY]
GO
ALTER TABLE [HumanResources].[EmployeeAddress] ADD CONSTRAINT [FK_EmployeeAddress_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Person].[Address] ([AddressID])
GO
ALTER TABLE [HumanResources].[EmployeeAddress] ADD CONSTRAINT [FK_EmployeeAddress_Employee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping employees to their address(es).', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. Foreign key to Address.AddressID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'COLUMN', N'AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. Foreign key to Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'COLUMN', N'EmployeeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'DF_EmployeeAddress_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'DF_EmployeeAddress_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'FK_EmployeeAddress_Address_AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'FK_EmployeeAddress_Employee_EmployeeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'PK_EmployeeAddress_EmployeeID_AddressID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'INDEX', N'AK_EmployeeAddress_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'INDEX', N'PK_EmployeeAddress_EmployeeID_AddressID'
GO
