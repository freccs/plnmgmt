--Ez a trigger megakadályozza, hogy bárki is eltüntethessen egyetlen táblát is, 
--hiszen majdnem az összesre hivatkozik a [Plans] táblánk, így a rendszer használhatalanná válna.

DROP TRIGGER IF EXISTS DenyDropTable ON DATABASE
GO
CREATE TRIGGER DenyDropTable
ON DATABASE
FOR DROP_TABLE
AS
        PRINT 'A [Plans] táblához kapcsolt táblák eldobása a rendszer azonnali leállásához vezet!'
        PRINT 'Ha ennek tudatában mégis szerenéd valamelyik táblát kidobni, akkor a ""DenyDropTable"" triggert kell elõbb eldobnod.'
        ROLLBACK
GO

--Ez a trigger pedig letiltja a [Plans] tábla updatejeit, a beszúrandó tervkódok a webes alkalmazásból érkeznek
--és egy másik trigger felel azért, hogy helyesen legyenek beszúrva

DROP TRIGGER IF EXISTS DenyUpdateTable_Plans
GO

CREATE TRIGGER DenyUpdateTable_Plans
ON Plans
INSTEAD OF UPDATE
AS
        PRINT 'A [Plans] táblán az update mûveletek tiltottak: ""DenyUpdateTable_Plans"" triggerrel.'
        ROLLBACK
GO

---
--Innentõl az egyes táblákat "õrzõ" UPDATE/DELETE triggerek:

DROP TRIGGER IF EXISTS DenyDelSpec
GO
CREATE TRIGGER DenyDelSpec
ON Specialisation
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [Specialisation] táblán az update és törlés mûveletek tiltottak: ""DenyDelSpec"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelPhase
GO
CREATE TRIGGER DenyDelPhase
ON Phase
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [Phase] táblán az update és törlés mûveletek tiltottak: ""DenyDelPhase"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelDocType
GO
CREATE TRIGGER DenyDelDocType
ON DocType
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [DocType] táblán az update és törlés mûveletek tiltottak: ""DenyDelDocType"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelOffice
GO
CREATE TRIGGER DenyDelOffice
ON Office
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [Office] táblán az update és törlés mûveletek tiltottak: ""DenyDelOffice"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelProject
GO
CREATE TRIGGER DenyDelProject
ON Project
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [Project] táblán az update és törlés mûveletek tiltottak: ""DenyDelProject"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelProjectBuilding
GO
CREATE TRIGGER DenyDelProjectBuilding
ON ProjBuilding
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [ProjBuilding] táblán az update és törlés mûveletek tiltottak: ""DenyDelProjectBuilding"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelProjectFloor
GO
CREATE TRIGGER DenyDelProjectFloor
ON ProjFloor
INSTEAD OF DELETE
AS
        PRINT 'A [ProjFloor] táblán a törlés mûvelet tiltott: ""DenyDelProjectFloor"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelUserRole
GO
CREATE TRIGGER DenyDelUserRole
ON UserRole
INSTEAD OF DELETE
AS
        PRINT 'A [UserRole] táblán a törlés mûvelet tiltott: ""DenyDelUserRole"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelPlanStatus
GO
CREATE TRIGGER DenyDelPlanStatus
ON PlanStatus
INSTEAD OF DELETE
AS
        PRINT 'A [PlanStatus] táblán a törlés mûvelet tiltott: ""DenyDelPlanStatus"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelPlanApproval
GO
CREATE TRIGGER DenyDelPlanApproval
ON ApprovedPlansLog
INSTEAD OF DELETE, UPDATE
AS
        PRINT 'A [ApprovedPlansLog] táblán a törlés mûvelet tiltott: ""DenyDelPlanApproval"" triggerrel.'
        ROLLBACK
GO

---