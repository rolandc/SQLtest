SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Sales].[vIndividualCustomer] 
AS 
SELECT 
    i.[CustomerID]
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
    ,[StateProvinceName] = sp.[Name]
    ,a.[PostalCode]
    ,[CountryRegionName] = cr.[Name]
    ,i.[Demographics]
FROM [Sales].[Individual] i
    INNER JOIN [Person].[Contact] c 
    ON c.[ContactID] = i.[ContactID]
    INNER JOIN [Sales].[CustomerAddress] ca 
    ON ca.[CustomerID] = i.[CustomerID]
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = ca.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    INNER JOIN [Person].[AddressType] at 
    ON ca.[AddressTypeID] = at.[AddressTypeID]
WHERE i.[CustomerID] IN (SELECT [Sales].[Customer].[CustomerID] 
    FROM [Sales].[Customer] WHERE UPPER([Sales].[Customer].[CustomerType]) = 'I');
GO
EXEC sp_addextendedproperty N'MS_Description', N'Individual customers (names and addresses) that purchase Adventure Works Cycles products online.', 'SCHEMA', N'Sales', 'VIEW', N'vIndividualCustomer', NULL, NULL
GO
