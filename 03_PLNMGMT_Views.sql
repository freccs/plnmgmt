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


--Teljes tervtár legyûjtése, minden tervjóváhagyási állapottal---

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
  GROUP BY PlanAppId, Approvant)) AP ON	PL.PlanID = AP.PAI --leválogatás az ApprovedPlansLog táblából a legutolsó tervállapot szerint
JOIN Users U ON				AP.APP = U.UserID
JOIN UserRole UR ON			U.Role = UR.UserRoleID
JOIN PlanStatus PS ON		LASTSTATUS = PS.PlanStatusID
;
GO

-----
--Teljes tervtár aktuálisan érvényes állapotának nézete---

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
  GROUP BY PlanAppId) AP ON	PL.PlanID = AP.PAI --leválogatás az ApprovedPlansLog táblából a legutolsó tervállapot szerint
LEFT JOIN ApprovedPlansLog APL ON LASTSTATUSMOD = APL.ApprovalDate
JOIN Users U ON				APL.Approvant = U.UserID
JOIN UserRole UR ON			U.Role = UR.UserRoleID
JOIN PlanStatus PS ON		APL.PlanStatus = PS.PlanStatusID
;
GO


--Összes elõforduló tervkód konkatálva---
DROP VIEW IF EXISTS FullPlanCodes
GO
CREATE VIEW FullPlanCodes AS
SELECT CONCAT(Office,'-', Spec,'-', Phase,'-', Project,'-', Building,'-', Floor,'-', DocType,'-', PlanNum,'-', LOWER(Revision)) TERVKÓD 
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




--MEGHÍVÁS:
--
----ÖSSZES TERV MINDEN ADATA:
--SELECT * FROM Masterview			ORDER BY PlanID
--
----ÖSSZES TERVFELTÖLTÉS MINDEN ADATÁVAL, ÉS TERVÁLLAPOTÁVAL:
--SELECT * FROM FullPlanInventory
--
----MINDEN ÉPPEN JÓVÁHAGYÁSRA VÁRÓ TERV:
--SELECT * FROM ActualPlanInventory WHERE PlanStatusID = 2 ORDER BY PlanID
--
----ÖSSZES TERV SORBARENDEZVE(text):
--SELECT * FROM FullPlanCodes        ORDER BY TERVKÓD ASC

