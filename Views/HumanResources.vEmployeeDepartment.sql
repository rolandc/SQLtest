SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [HumanResources].[vEmployeeDepartment] 
AS 
SELECT 
    e.[EmployeeID] 
    ,c.[Title] 
    ,c.[FirstName] 
    ,c.[MiddleName] 
    ,c.[LastName] 
    ,c.[Suffix] 
    ,e.[Title] AS [JobTitle] 
    ,d.[Name] AS [Department] 
    ,d.[GroupName] 
    ,edh.[StartDate] 
FROM [HumanResources].[Employee] e
    INNER JOIN [Person].[Contact] c 
    ON c.[ContactID] = e.[ContactID]
    INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh 
    ON e.[EmployeeID] = edh.[EmployeeID] 
    INNER JOIN [HumanResources].[Department] d 
    ON edh.[DepartmentID] = d.[DepartmentID] 
WHERE GETDATE() BETWEEN edh.[StartDate] AND ISNULL(edh.[EndDate], GETDATE());
GO
EXEC sp_addextendedproperty N'MS_Description', N'Returns employee name, title, and current department.', 'SCHEMA', N'HumanResources', 'VIEW', N'vEmployeeDepartment', NULL, NULL
GO
