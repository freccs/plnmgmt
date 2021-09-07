USE PLNMGMT;  
GO  
-- Find an existing index named IX_ApprovedPlansLog_PlanAppIdPlanStatus and delete it if found.   
IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'IX_ApprovedPlansLog_PlanAppIdPlanStatus')   
    DROP INDEX IX_ApprovedPlansLog_PlanAppIdPlanStatus ON ApprovedPlansLog;   
GO  
-- Create a nonclustered index called IX_ApprovedPlansLog_PlanAppIdPlanStatus   
-- on the ApprovedPlansLog table using the PlanAppId, PlanStatus columns.   
CREATE NONCLUSTERED INDEX IX_ApprovedPlansLog_PlanAppIdPlanStatus   
    ON ApprovedPlansLog (PlanAppId, PlanStatus);   
GO

---

-- Find an existing index named IX_Plans_PlanID and delete it if found.   
IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'IX_Plans_PlanID')   
    DROP INDEX IX_Plans_PlanID ON Plans;   
GO  
-- Create a nonclustered index called IX_Plans_PlanID   
-- on the Plans table using the PlanID column.   
CREATE NONCLUSTERED INDEX IX_Plans_PlanID   
    ON Plans (PlanID);   
GO

---

-- Find an existing index named IX_Users_UserID and delete it if found.   
IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'IX_Users_UserID')   
    DROP INDEX IX_Users_UserID ON Users;   
GO  
-- Create a nonclustered index called IX_Users_UserID  
-- on the Users table using the UserID column.   
CREATE NONCLUSTERED INDEX IX_Users_UserID  
    ON Users (UserID);   
GO
