CREATE TABLE [HumanResources].[JobCandidate]
(
[JobCandidateID] [int] NOT NULL IDENTITY(1, 1),
[EmployeeID] [int] NULL,
[Resume] [xml] (CONTENT [HumanResources].[HRResumeSchemaCollection]) NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_JobCandidate_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [PK_JobCandidate_JobCandidateID] PRIMARY KEY CLUSTERED  ([JobCandidateID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_JobCandidate_EmployeeID] ON [HumanResources].[JobCandidate] ([EmployeeID]) ON [PRIMARY]
GO
ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [FK_JobCandidate_Employee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Résumés submitted to Human Resources by job applicants.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Employee identification number if applicant was hired. Foreign key to Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'COLUMN', N'EmployeeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key for JobCandidate records.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'COLUMN', N'JobCandidateID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Résumé in XML format.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'COLUMN', N'Resume'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'CONSTRAINT', N'DF_JobCandidate_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'CONSTRAINT', N'FK_JobCandidate_Employee_EmployeeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'CONSTRAINT', N'PK_JobCandidate_JobCandidateID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'INDEX', N'IX_JobCandidate_EmployeeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'INDEX', N'PK_JobCandidate_JobCandidateID'
GO
