CREATE TABLE [Production].[Document]
(
[DocumentID] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (50) COLLATE Latin1_General_CS_AS NOT NULL,
[FileName] [nvarchar] (400) COLLATE Latin1_General_CS_AS NOT NULL,
[FileExtension] [nvarchar] (8) COLLATE Latin1_General_CS_AS NOT NULL,
[Revision] [nchar] (5) COLLATE Latin1_General_CS_AS NOT NULL,
[ChangeNumber] [int] NOT NULL CONSTRAINT [DF_Document_ChangeNumber] DEFAULT ((0)),
[Status] [tinyint] NOT NULL,
[DocumentSummary] [nvarchar] (max) COLLATE Latin1_General_CS_AS NULL,
[Document] [varbinary] (max) NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Document_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Production].[Document] ADD CONSTRAINT [CK_Document_Status] CHECK (([Status]>=(1) AND [Status]<=(3)))
GO
ALTER TABLE [Production].[Document] ADD CONSTRAINT [PK_Document_DocumentID] PRIMARY KEY CLUSTERED  ([DocumentID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Document_FileName_Revision] ON [Production].[Document] ([FileName], [Revision]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Product maintenance documents.', 'SCHEMA', N'Production', 'TABLE', N'Document', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Engineering change approval number.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'ChangeNumber'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Complete document.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'Document'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key for Document records.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'DocumentID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Document abstract.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'DocumentSummary'
GO
EXEC sp_addextendedproperty N'MS_Description', N'File extension indicating the document type. For example, .doc or .txt.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'FileExtension'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Directory path and file name of the document', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'FileName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Revision number of the document. ', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'Revision'
GO
EXEC sp_addextendedproperty N'MS_Description', N'1 = Pending approval, 2 = Approved, 3 = Obsolete', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'Status'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Title of the document.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'COLUMN', N'Title'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [Status] BETWEEN (1) AND (3)', 'SCHEMA', N'Production', 'TABLE', N'Document', 'CONSTRAINT', N'CK_Document_Status'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Production', 'TABLE', N'Document', 'CONSTRAINT', N'DF_Document_ChangeNumber'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'Document', 'CONSTRAINT', N'DF_Document_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'Document', 'CONSTRAINT', N'PK_Document_DocumentID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'INDEX', N'AK_Document_FileName_Revision'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'INDEX', N'PK_Document_DocumentID'
GO
