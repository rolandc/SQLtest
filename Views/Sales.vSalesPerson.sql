SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Sales].[vSalesPerson] 
AS 
SELECT 
    s.[SalesPersonID]
    ,c.[Title]
    ,c.[FirstName]
    ,c.[MiddleName]
    ,c.[LastName]
    ,c.[Suffix]
    ,[JobTitle] = e.[Title]
    ,c.[Phone]
    ,c.[EmailAddress]
    ,c.[EmailPromotion]
    ,a.[AddressLine1]
    ,a.[AddressLine2]
    ,a.[City]
    ,[StateProvinceName] = sp.[Name]
    ,a.[PostalCode]
    ,[CountryRegionName] = cr.[Name]
    ,[TerritoryName] = st.[Name]
    ,[TerritoryGroup] = st.[Group]
    ,s.[SalesQuota]
    ,s.[SalesYTD]
    ,s.[SalesLastYear]
FROM [Sales].[SalesPerson] s
    INNER JOIN [HumanResources].[Employee] e 
    ON e.[EmployeeID] = s.[SalesPersonID]
    LEFT OUTER JOIN [Sales].[SalesTerritory] st 
    ON st.[TerritoryID] = s.[TerritoryID]
    INNER JOIN [Person].[Contact] c 
    ON c.[ContactID] = e.[ContactID]
    INNER JOIN [HumanResources].[EmployeeAddress] ea 
    ON e.[EmployeeID] = ea.[EmployeeID] 
    INNER JOIN [Person].[Address] a 
    ON ea.[AddressID] = a.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode];
GO
EXEC sp_addextendedproperty N'MS_Description', N'Sales representiatives (names and addresses) and their sales-related information.', 'SCHEMA', N'Sales', 'VIEW', N'vSalesPerson', NULL, NULL
GO
