CREATE TABLE [Purchasing].[VendorContact]
(
[VendorID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[ContactTypeID] [int] NOT NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_VendorContact_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Purchasing].[VendorContact] ADD CONSTRAINT [PK_VendorContact_VendorID_ContactID] PRIMARY KEY CLUSTERED  ([VendorID], [ContactID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_VendorContact_ContactID] ON [Purchasing].[VendorContact] ([ContactID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_VendorContact_ContactTypeID] ON [Purchasing].[VendorContact] ([ContactTypeID]) ON [PRIMARY]
GO
ALTER TABLE [Purchasing].[VendorContact] ADD CONSTRAINT [FK_VendorContact_Contact_ContactID] FOREIGN KEY ([ContactID]) REFERENCES [Person].[Contact] ([ContactID])
GO
ALTER TABLE [Purchasing].[VendorContact] ADD CONSTRAINT [FK_VendorContact_ContactType_ContactTypeID] FOREIGN KEY ([ContactTypeID]) REFERENCES [Person].[ContactType] ([ContactTypeID])
GO
ALTER TABLE [Purchasing].[VendorContact] ADD CONSTRAINT [FK_VendorContact_Vendor_VendorID] FOREIGN KEY ([VendorID]) REFERENCES [Purchasing].[Vendor] ([VendorID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping vendors and their employees.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contact (Vendor employee) identification number. Foreign key to Contact.ContactID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'COLUMN', N'ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contact type such as sales manager, or sales agent.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'COLUMN', N'ContactTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'COLUMN', N'VendorID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'DF_VendorContact_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'FK_VendorContact_Contact_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ContactType.ContactTypeID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'FK_VendorContact_ContactType_ContactTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Vendor.VendorID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'FK_VendorContact_Vendor_VendorID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'PK_VendorContact_VendorID_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'INDEX', N'IX_VendorContact_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'INDEX', N'IX_VendorContact_ContactTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'INDEX', N'PK_VendorContact_VendorID_ContactID'
GO
