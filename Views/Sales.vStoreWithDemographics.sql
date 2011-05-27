SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Sales].[vStoreWithDemographics] AS 
SELECT 
    s.[CustomerID] 
    ,s.[Name] 
    ,ct.[Name] AS [ContactType] 
    ,c.[Title] 
    ,c.[FirstName] 
    ,c.[MiddleName] 
    ,c.[LastName] 
    ,c.[Suffix] 
    ,c.[Phone] 
    ,c.[EmailAddress] 
    ,c.[EmailPromotion] 
    ,at.[Name] AS [AddressType]
    ,a.[AddressLine1] 
    ,a.[AddressLine2] 
    ,a.[City] 
    ,sp.[Name] AS [StateProvinceName] 
    ,a.[PostalCode] 
    ,cr.[Name] AS [CountryRegionName] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualSales)[1]', 'money') AS [AnnualSales] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualRevenue)[1]', 'money') AS [AnnualRevenue] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BankName)[1]', 'nvarchar(50)') AS [BankName] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BusinessType)[1]', 'nvarchar(5)') AS [BusinessType] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/YearOpened)[1]', 'integer') AS [YearOpened] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Specialty)[1]', 'nvarchar(50)') AS [Specialty] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/SquareFeet)[1]', 'integer') AS [SquareFeet] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Brands)[1]', 'nvarchar(30)') AS [Brands] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Internet)[1]', 'nvarchar(30)') AS [Internet] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/NumberEmployees)[1]', 'integer') AS [NumberEmployees] 
FROM [Sales].[Store] s
    INNER JOIN [Sales].[StoreContact] sc 
    ON sc.[CustomerID] = s.[CustomerID]
    INNER JOIN [Person].[Contact] c 
    ON c.[ContactID] = sc.[ContactID]
    INNER JOIN [Person].[ContactType] ct 
    ON sc.[ContactTypeID] = ct.[ContactTypeID]
    INNER JOIN [Sales].[CustomerAddress] ca 
    ON ca.[CustomerID] = s.[CustomerID]
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = ca.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    INNER JOIN [Person].[AddressType] at 
    ON ca.[AddressTypeID] = at.[AddressTypeID]
WHERE s.[CustomerID] IN (SELECT [Sales].[Customer].[CustomerID] 
    FROM [Sales].[Customer] WHERE UPPER([Sales].[Customer].[CustomerType]) = 'S');
GO
EXEC sp_addextendedproperty N'MS_Description', N'Stores (names and addresses) that sell Adventure Works Cycles products to consumers.', 'SCHEMA', N'Sales', 'VIEW', N'vStoreWithDemographics', NULL, NULL
GO
