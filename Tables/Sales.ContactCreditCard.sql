CREATE TABLE [Sales].[ContactCreditCard]
(
[ContactID] [int] NOT NULL,
[CreditCardID] [int] NOT NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ContactCreditCard_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Sales].[ContactCreditCard] ADD CONSTRAINT [PK_ContactCreditCard_ContactID_CreditCardID] PRIMARY KEY CLUSTERED  ([ContactID], [CreditCardID]) ON [PRIMARY]
GO
ALTER TABLE [Sales].[ContactCreditCard] ADD CONSTRAINT [FK_ContactCreditCard_Contact_ContactID] FOREIGN KEY ([ContactID]) REFERENCES [Person].[Contact] ([ContactID])
GO
ALTER TABLE [Sales].[ContactCreditCard] ADD CONSTRAINT [FK_ContactCreditCard_CreditCard_CreditCardID] FOREIGN KEY ([CreditCardID]) REFERENCES [Sales].[CreditCard] ([CreditCardID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping customers in the Contact table to their credit card information in the CreditCard table. ', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Customer identification number. Foreign key to Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'COLUMN', N'ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Credit card identification number. Foreign key to CreditCard.CreditCardID.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'COLUMN', N'CreditCardID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'CONSTRAINT', N'DF_ContactCreditCard_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'CONSTRAINT', N'FK_ContactCreditCard_Contact_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing CreditCard.CreditCardID.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'CONSTRAINT', N'FK_ContactCreditCard_CreditCard_CreditCardID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'CONSTRAINT', N'PK_ContactCreditCard_ContactID_CreditCardID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'INDEX', N'PK_ContactCreditCard_ContactID_CreditCardID'
GO
