CREATE TABLE [Sales].[StoreContact]
(
[CustomerID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[ContactTypeID] [int] NOT NULL,
[rowguid] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_StoreContact_rowguid] DEFAULT (newid()),
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_StoreContact_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Sales].[StoreContact] ADD CONSTRAINT [PK_StoreContact_CustomerID_ContactID] PRIMARY KEY CLUSTERED  ([CustomerID], [ContactID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_StoreContact_ContactID] ON [Sales].[StoreContact] ([ContactID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_StoreContact_ContactTypeID] ON [Sales].[StoreContact] ([ContactTypeID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_StoreContact_rowguid] ON [Sales].[StoreContact] ([rowguid]) ON [PRIMARY]
GO
ALTER TABLE [Sales].[StoreContact] ADD CONSTRAINT [FK_StoreContact_Contact_ContactID] FOREIGN KEY ([ContactID]) REFERENCES [Person].[Contact] ([ContactID])
GO
ALTER TABLE [Sales].[StoreContact] ADD CONSTRAINT [FK_StoreContact_ContactType_ContactTypeID] FOREIGN KEY ([ContactTypeID]) REFERENCES [Person].[ContactType] ([ContactTypeID])
GO
ALTER TABLE [Sales].[StoreContact] ADD CONSTRAINT [FK_StoreContact_Store_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Store] ([CustomerID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping stores and their employees.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contact (store employee) identification number. Foreign key to Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'COLUMN', N'ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contact type such as owner or purchasing agent. Foreign key to ContactType.ContactTypeID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'COLUMN', N'ContactTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Store identification number. Foreign key to Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'COLUMN', N'CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'DF_StoreContact_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'DF_StoreContact_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'FK_StoreContact_Contact_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ContactType.ContactTypeID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'FK_StoreContact_ContactType_ContactTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Store.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'FK_StoreContact_Store_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'PK_StoreContact_CustomerID_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'INDEX', N'AK_StoreContact_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'INDEX', N'IX_StoreContact_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'INDEX', N'IX_StoreContact_ContactTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'INDEX', N'PK_StoreContact_CustomerID_ContactID'
GO
