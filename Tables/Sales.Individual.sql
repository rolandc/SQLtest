CREATE TABLE [Sales].[Individual]
(
[CustomerID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[Demographics] [xml] (CONTENT [Sales].[IndividualSurveySchemaCollection]) NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Individual_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [Sales].[iuIndividual] ON [Sales].[Individual] 
AFTER INSERT, UPDATE NOT FOR REPLICATION AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    -- Only allow the Customer to be a Store OR Individual
    IF EXISTS (SELECT * FROM inserted INNER JOIN [Sales].[Store] 
        ON inserted.[CustomerID] = [Sales].[Store].[CustomerID]) 
    BEGIN
        -- Rollback any active or uncommittable transactions
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
    END;

    IF UPDATE([CustomerID]) OR UPDATE([Demographics]) 
    BEGIN
        UPDATE [Sales].[Individual] 
        SET [Sales].[Individual].[Demographics] = N'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"> 
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            </IndividualSurvey>' 
        FROM inserted 
        WHERE [Sales].[Individual].[CustomerID] = inserted.[CustomerID] 
            AND inserted.[Demographics] IS NULL;
        
        UPDATE [Sales].[Individual] 
        SET [Demographics].modify(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            insert <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            as first 
            into (/IndividualSurvey)[1]') 
        FROM inserted 
        WHERE [Sales].[Individual].[CustomerID] = inserted.[CustomerID] 
            AND inserted.[Demographics] IS NOT NULL 
            AND inserted.[Demographics].exist(N'declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                /IndividualSurvey/TotalPurchaseYTD') <> 1;
    END;
END;
GO
ALTER TABLE [Sales].[Individual] ADD CONSTRAINT [PK_Individual_CustomerID] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
CREATE PRIMARY XML INDEX [PXML_Individual_Demographics] ON [Sales].[Individual] ([Demographics])
GO
CREATE XML INDEX [XMLPATH_Individual_Demographics] ON [Sales].[Individual] ([Demographics]) USING XML INDEX [PXML_Individual_Demographics] FOR PATH
GO
CREATE XML INDEX [XMLPROPERTY_Individual_Demographics] ON [Sales].[Individual] ([Demographics]) USING XML INDEX [PXML_Individual_Demographics] FOR PROPERTY
GO
CREATE XML INDEX [XMLVALUE_Individual_Demographics] ON [Sales].[Individual] ([Demographics]) USING XML INDEX [PXML_Individual_Demographics] FOR VALUE
GO
ALTER TABLE [Sales].[Individual] ADD CONSTRAINT [FK_Individual_Contact_ContactID] FOREIGN KEY ([ContactID]) REFERENCES [Person].[Contact] ([ContactID])
GO
ALTER TABLE [Sales].[Individual] ADD CONSTRAINT [FK_Individual_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customer] ([CustomerID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Demographic data about customers that purchase Adventure Works products online.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies the customer in the Contact table. Foreign key to Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'COLUMN', N'ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique customer identification number. Foreign key to Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'COLUMN', N'CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'COLUMN', N'Demographics'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'CONSTRAINT', N'DF_Individual_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'CONSTRAINT', N'FK_Individual_Contact_ContactID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'CONSTRAINT', N'FK_Individual_Customer_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'CONSTRAINT', N'PK_Individual_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'INDEX', N'PK_Individual_CustomerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary XML index.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'INDEX', N'PXML_Individual_Demographics'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Secondary XML index for path.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'INDEX', N'XMLPATH_Individual_Demographics'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Secondary XML index for property.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'INDEX', N'XMLPROPERTY_Individual_Demographics'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Secondary XML index for value.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'INDEX', N'XMLVALUE_Individual_Demographics'
GO
EXEC sp_addextendedproperty N'MS_Description', N'AFTER INSERT, UPDATE trigger inserting Individual only if the Customer does not exist in the Store table and setting the ModifiedDate column in the Individual table to the current date.', 'SCHEMA', N'Sales', 'TABLE', N'Individual', 'TRIGGER', N'iuIndividual'
GO
