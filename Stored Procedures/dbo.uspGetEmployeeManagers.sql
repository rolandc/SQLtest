SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[uspGetEmployeeManagers]
    @EmployeeID [int]
AS
BEGIN
    SET NOCOUNT ON;

    -- Use recursive query to list out all Employees required for a particular Manager
    WITH [EMP_cte]([EmployeeID], [ManagerID], [FirstName], [LastName], [Title], [RecursionLevel]) -- CTE name and columns
    AS (
        SELECT e.[EmployeeID], e.[ManagerID], c.[FirstName], c.[LastName], e.[Title], 0 -- Get the initial Employee
        FROM [HumanResources].[Employee] e 
            INNER JOIN [Person].[Contact] c 
            ON e.[ContactID] = c.[ContactID]
        WHERE e.[EmployeeID] = @EmployeeID
        UNION ALL
        SELECT e.[EmployeeID], e.[ManagerID], c.[FirstName], c.[LastName], e.[Title], [RecursionLevel] + 1 -- Join recursive member to anchor
        FROM [HumanResources].[Employee] e 
            INNER JOIN [EMP_cte]
            ON e.[EmployeeID] = [EMP_cte].[ManagerID]
            INNER JOIN [Person].[Contact] c 
            ON e.[ContactID] = c.[ContactID]
    )
    -- Join back to Employee to return the manager name 
    SELECT [EMP_cte].[RecursionLevel], [EMP_cte].[EmployeeID], [EMP_cte].[FirstName], [EMP_cte].[LastName], 
        [EMP_cte].[ManagerID], c.[FirstName] AS 'ManagerFirstName', c.[LastName] AS 'ManagerLastName'  -- Outer select from the CTE
    FROM [EMP_cte] 
        INNER JOIN [HumanResources].[Employee] e 
        ON [EMP_cte].[ManagerID] = e.[EmployeeID]
        INNER JOIN [Person].[Contact] c 
        ON e.[ContactID] = c.[ContactID]
    ORDER BY [RecursionLevel], [ManagerID], [EmployeeID]
    OPTION (MAXRECURSION 25) 
END;
GO
EXEC sp_addextendedproperty N'MS_Description', N'Stored procedure using a recursive query to return the direct and indirect managers of the specified employee.', 'SCHEMA', N'dbo', 'PROCEDURE', N'uspGetEmployeeManagers', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Input parameter for the stored procedure uspGetEmployeeManagers. Enter a valid EmployeeID from the HumanResources.Employee table.', 'SCHEMA', N'dbo', 'PROCEDURE', N'uspGetEmployeeManagers', 'PARAMETER', N'@EmployeeID'
GO
