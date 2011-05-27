CREATE TABLE [Person].[Contact]
(
[ContactID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[NameStyle] [dbo].[NameStyle] NOT NULL CONSTRAINT [DF_Contact_NameStyle] DEFAULT ((0)),
[Title] [nvarchar] (8) COLLATE Latin1_General_CS_AS NULL,
[FirstName] [dbo].[Name] NOT NULL,
[MiddleName] [dbo].[Name] NULL,
[LastName] [dbo].[Name] NOT NULL,
[Suffix] [nvarchar] (10) COLLATE Latin1_General_CS_AS NULL,
[EmailAddress] [nvarchar] (50) COLLATE Latin1_General_CS_AS NULL,
[EmailPromotion] [int] NOT NULL CONSTRAINT [DF_Contact_EmailPromotion] DEFAULT ((0)),
[Phone] [dbo].[Phone] NULL,
[PasswordHash] [varchar] (128) COLLATE Latin1_General_CS_AS NOT NULL,
[PasswordSalt] [varchar] (10) COLLATE Latin1_General_CS_AS NOT NULL,
[AdditionalContactInfo] [xml] (CONTENT [Person].[AdditionalContactInfoSchemaCollection]) NULL,
[rowguid] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_Contact_rowguid] DEFAULT (newid()),
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Contact_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Person].[Contact] ADD CONSTRAINT [CK_Contact_EmailPromotion] CHECK (([EmailPromotion]>=(0) AND [EmailPromotion]<=(2)))
GO
ALTER TABLE [Person].[Contact] ADD CONSTRAINT [PK_Contact_ContactID] PRIMARY KEY CLUSTERED  ([ContactID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Contact_EmailAddress] ON [Person].[Contact] ([EmailAddress]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Contact_rowguid] ON [Person].[Contact] ([rowguid]) ON [PRIMARY]
GO
CREATE PRIMARY XML INDEX [PXML_Contact_AddContact] ON [Person].[Contact] ([AdditionalContactInfo])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Names of each employee, customer contact, and vendor contact.', 'SCHEMA', N'Person', 'TABLE', N'Contact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Additional contact information about the person stored in xml format. ', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'AdditionalContactInfo'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key for Contact records.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'E-mail address for the person.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'EmailAddress'
GO
EXEC sp_addextendedproperty N'MS_Description', N'0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners. ', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'EmailPromotion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'First name of the person.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'FirstName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Last name of the person.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'LastName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Middle name or middle initial of the person.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'MiddleName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'NameStyle'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Password for the e-mail account.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'PasswordHash'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Random value concatenated with the password string before the password is hashed.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'PasswordSalt'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Phone number associated with the person.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'Phone'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Surname suffix. For example, Sr. or Jr.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'Suffix'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A courtesy title. For example, Mr. or Ms.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'COLUMN', N'Title'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [EmailPromotion] >= (0) AND [EmailPromotion] <= (2)', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'CK_Contact_EmailPromotion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'DF_Contact_EmailPromotion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'DF_Contact_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'DF_Contact_NameStyle'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'DF_Contact_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'PK_Contact_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'INDEX', N'AK_Contact_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'INDEX', N'IX_Contact_EmailAddress'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'INDEX', N'PK_Contact_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary XML index.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'INDEX', N'PXML_Contact_AddContact'
GO
