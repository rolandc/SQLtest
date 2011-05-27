SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[ufnGetContactInformation](@ContactID int)
RETURNS @retContactInformation TABLE 
(
    -- Columns returned by the function
    [ContactID] int PRIMARY KEY NOT NULL, 
    [FirstName] [nvarchar](50) NULL, 
    [LastName] [nvarchar](50) NULL, 
    [JobTitle] [nvarchar](50) NULL, 
    [ContactType] [nvarchar](50) NULL
)
AS 
-- Returns the first name, last name, job title and contact type for the specified contact.
BEGIN
    DECLARE 
        @FirstName [nvarchar](50), 
        @LastName [nvarchar](50), 
        @JobTitle [nvarchar](50), 
        @ContactType [nvarchar](50);

    -- Get common contact information
    SELECT 
        @ContactID = ContactID, 
        @FirstName = FirstName, 
        @LastName = LastName
    FROM [Person].[Contact] 
    WHERE [ContactID] = @ContactID;

    SET @JobTitle = 
        CASE 
            -- Check for employee
            WHEN EXISTS(SELECT * FROM [HumanResources].[Employee] e 
                WHERE e.[ContactID] = @ContactID) 
                THEN (SELECT [Title] 
                    FROM [HumanResources].[Employee] 
                    WHERE [ContactID] = @ContactID)

            -- Check for vendor
            WHEN EXISTS(SELECT * FROM [Purchasing].[VendorContact] vc 
                    INNER JOIN [Person].[ContactType] ct 
                    ON vc.[ContactTypeID] = ct.[ContactTypeID] 
                WHERE vc.[ContactID] = @ContactID) 
                THEN (SELECT ct.[Name] 
                    FROM [Purchasing].[VendorContact] vc 
                        INNER JOIN [Person].[ContactType] ct 
                        ON vc.[ContactTypeID] = ct.[ContactTypeID] 
                    WHERE vc.[ContactID] = @ContactID)

            -- Check for store
            WHEN EXISTS(SELECT * FROM [Sales].[StoreContact] sc 
                    INNER JOIN [Person].[ContactType] ct 
                    ON sc.[ContactTypeID] = ct.[ContactTypeID] 
                WHERE sc.[ContactID] = @ContactID) 
                THEN (SELECT ct.[Name] 
                    FROM [Sales].[StoreContact] sc 
                        INNER JOIN [Person].[ContactType] ct 
                        ON sc.[ContactTypeID] = ct.[ContactTypeID] 
                    WHERE [ContactID] = @ContactID)

            ELSE NULL 
        END;

    SET @ContactType = 
        CASE 
            -- Check for employee
            WHEN EXISTS(SELECT * FROM [HumanResources].[Employee] e 
                WHERE e.[ContactID] = @ContactID) 
                THEN 'Employee'

            -- Check for vendor
            WHEN EXISTS(SELECT * FROM [Purchasing].[VendorContact] vc 
                    INNER JOIN [Person].[ContactType] ct 
                    ON vc.[ContactTypeID] = ct.[ContactTypeID] 
                WHERE vc.[ContactID] = @ContactID) 
                THEN 'Vendor Contact'

            -- Check for store
            WHEN EXISTS(SELECT * FROM [Sales].[StoreContact] sc 
                    INNER JOIN [Person].[ContactType] ct 
                    ON sc.[ContactTypeID] = ct.[ContactTypeID] 
                WHERE sc.[ContactID] = @ContactID) 
                THEN 'Store Contact'

            -- Check for individual consumer
            WHEN EXISTS(SELECT * FROM [Sales].[Individual] i 
                WHERE i.[ContactID] = @ContactID) 
                THEN 'Consumer'
        END;

    -- Return the information to the caller
    IF @ContactID IS NOT NULL 
    BEGIN
        INSERT @retContactInformation
        SELECT @ContactID, @FirstName, @LastName, @JobTitle, @ContactType;
    END;

    RETURN;
END;
GO
EXEC sp_addextendedproperty N'MS_Description', N'Table value function returning the first name, last name, job title and contact type for a given contact.', 'SCHEMA', N'dbo', 'FUNCTION', N'ufnGetContactInformation', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Input parameter for the table value function ufnGetContactInformation. Enter a valid ContactID from the Person.Contact table.', 'SCHEMA', N'dbo', 'FUNCTION', N'ufnGetContactInformation', 'PARAMETER', N'@ContactID'
GO
