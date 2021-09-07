USE PLNMGMT
GO
CREATE OR ALTER FUNCTION [dbo].[GetActualPlanListPerStatus]
(@PlanStatusId char(1) = 0
)
RETURNS TABLE
AS
RETURN
(SELECT CONCAT(Office,'-', Spec,'-', Phase,'-', Project,'-', Building,'-', Floor,'-', DocType,'-', PlanNum,'-', LOWER(Revision)) PLANS, PlanStatusId
 FROM  [PLNMGMT].[dbo].[ActualPlanInventory]
 WHERE PlanStatusId = @PlanStatusId)

 GO
 --SELECT * FROM dbo.GetActualPlanListPerStatus (2)

 ----

 CREATE OR ALTER FUNCTION [dbo].[GetActualPlanListPerStatusPerOffice]
(@PlanStatusId char(1),
@OfficeID char(3) 
)
RETURNS TABLE
AS
RETURN
(SELECT CONCAT(Office,'-', Spec,'-', Phase,'-', Project,'-', Building,'-', Floor,'-', DocType,'-', PlanNum,'-', LOWER(Revision)) AS PLANS, Office, PlanStatusName
 FROM  [PLNMGMT].[dbo].[ActualPlanInventory]
 WHERE PlanStatusId = @PlanStatusId AND OfficeID = @OfficeID)
 GO

 --SELECT * FROM dbo.GetActualPlanListPerStatusPerOffice (2, 'MUE')

