USE PLNMGMT
GO
--

DROP VIEW IF EXISTS MasterView
GO
CREATE VIEW MasterView AS
SELECT * 
FROM Plans PL
JOIN Office O ON			PL.Office = O.OfficeID
JOIN Specialisation S ON	PL.Spec = S.SpecID
JOIN Phase PH ON			PL.Phase = PH.PhaseID
JOIN Project PR ON			PL.Project = PR.ProjectID
JOIN ProjBuilding PB ON		PL.Building = PB.ProjectBuildingID
JOIN ProjFloor PF ON		PL.Floor = PF.ProjectBuildingFloorID
JOIN DocType DT ON			PL.DocType = DT.DocTypeID
JOIN ApprovedPlansLog AP ON	PL.PlanID = AP.PlanAppID
JOIN Users U ON				AP.Approvant = U.UserID
JOIN UserRole UR ON			U.Role = UR.UserRoleID
JOIN PlanStatus PS ON		AP.PlanStatus = PS.PlanStatusID
;
GO


--Teljes tervt�r legy�jt�se, minden tervj�v�hagy�si �llapottal---

DROP VIEW IF EXISTS FullPlanInventory
GO
CREATE VIEW FullPlanInventory AS
SELECT [Office]
      ,[Spec]
      ,[Phase]
      ,[Project]
      ,[Building]
      ,[Floor]
      ,[DocType]
      ,[PlanNum]
      ,[Revision]
      ,[OfficeName]
      ,[SpecName]
      ,[PhaseName]
      ,[PName]
      ,[PAddress]
      ,[PBName]
      ,[PBFName]
      ,[DocTypeName]
      ,[UserName]
      ,[PlanStatusName]
FROM Plans PL
JOIN Office O ON			PL.Office = O.OfficeID
JOIN Specialisation S ON	PL.Spec = S.SpecID
JOIN Phase PH ON			PL.Phase = PH.PhaseID
JOIN Project PR ON			PL.Project = PR.ProjectID
JOIN ProjBuilding PB ON		PL.Building = PB.ProjectBuildingID
JOIN ProjFloor PF ON		PL.Floor = PF.ProjectBuildingFloorID
JOIN DocType DT ON			PL.DocType = DT.DocTypeID
JOIN ((SELECT DISTINCT PlanAppId PAI, MAX(Planstatus) LASTSTATUS, Approvant APP
  FROM ApprovedPlansLog
  GROUP BY PlanAppId, Approvant)) AP ON	PL.PlanID = AP.PAI --lev�logat�s az ApprovedPlansLog t�bl�b�l a legutols� terv�llapot szerint
JOIN Users U ON				AP.APP = U.UserID
JOIN UserRole UR ON			U.Role = UR.UserRoleID
JOIN PlanStatus PS ON		LASTSTATUS = PS.PlanStatusID
;
GO

-----
--Teljes tervt�r aktu�lisan �rv�nyes �llapot�nak n�zete---

DROP VIEW IF EXISTS ActualPlanInventory
GO
CREATE VIEW ActualPlanInventory AS
SELECT * 
FROM Plans PL
JOIN Office O ON			PL.Office = O.OfficeID
JOIN Specialisation S ON	PL.Spec = S.SpecID
JOIN Phase PH ON			PL.Phase = PH.PhaseID
JOIN Project PR ON			PL.Project = PR.ProjectID
JOIN ProjBuilding PB ON		PL.Building = PB.ProjectBuildingID
JOIN ProjFloor PF ON		PL.Floor = PF.ProjectBuildingFloorID
JOIN DocType DT ON			PL.DocType = DT.DocTypeID
JOIN (SELECT DISTINCT PlanAppId PAI, MAX(ApprovalDate) LASTSTATUSMOD
FROM ApprovedPlansLog
  GROUP BY PlanAppId) AP ON	PL.PlanID = AP.PAI --lev�logat�s az ApprovedPlansLog t�bl�b�l a legutols� terv�llapot szerint
LEFT JOIN ApprovedPlansLog APL ON LASTSTATUSMOD = APL.ApprovalDate
JOIN Users U ON				APL.Approvant = U.UserID
JOIN UserRole UR ON			U.Role = UR.UserRoleID
JOIN PlanStatus PS ON		APL.PlanStatus = PS.PlanStatusID
;
GO


--�sszes el�fordul� tervk�d konkat�lva---
DROP VIEW IF EXISTS FullPlanCodes
GO
CREATE VIEW FullPlanCodes AS
SELECT CONCAT(Office,'-', Spec,'-', Phase,'-', Project,'-', Building,'-', Floor,'-', DocType,'-', PlanNum,'-', LOWER(Revision)) TERVK�D 
FROM Plans PL
JOIN Office O ON			PL.Office = O.OfficeID
JOIN Specialisation S ON	PL.Spec = S.SpecID
JOIN Phase PH ON			PL.Phase = PH.PhaseID
JOIN Project PR ON			PL.Project = PR.ProjectID
JOIN ProjBuilding PB ON		PL.Building = PB.ProjectBuildingID
JOIN ProjFloor PF ON		PL.Floor = PF.ProjectBuildingFloorID
JOIN DocType DT ON			PL.DocType = DT.DocTypeID
;
GO




--MEGH�V�S:
--
----�SSZES TERV MINDEN ADATA:
--SELECT * FROM Masterview			ORDER BY PlanID
--
----�SSZES TERVFELT�LT�S MINDEN ADAT�VAL, �S TERV�LLAPOT�VAL:
--SELECT * FROM FullPlanInventory
--
----MINDEN �PPEN J�V�HAGY�SRA V�R� TERV:
--SELECT * FROM ActualPlanInventory WHERE PlanStatusID = 2 ORDER BY PlanID
--
----�SSZES TERV SORBARENDEZVE(text):
--SELECT * FROM FullPlanCodes        ORDER BY TERVK�D ASC

