--Ez a trigger megakad�lyozza, hogy b�rki is elt�ntethessen egyetlen t�bl�t is, 
--hiszen majdnem az �sszesre hivatkozik a [Plans] t�bl�nk, �gy a rendszer haszn�lhatalann� v�lna.

DROP TRIGGER IF EXISTS DenyDropTable ON DATABASE
GO
CREATE TRIGGER DenyDropTable
ON DATABASE
FOR DROP_TABLE
AS
        PRINT 'A [Plans] t�bl�hoz kapcsolt t�bl�k eldob�sa a rendszer azonnali le�ll�s�hoz vezet!'
        PRINT 'Ha ennek tudat�ban m�gis szeren�d valamelyik t�bl�t kidobni, akkor a ""DenyDropTable"" triggert kell el�bb eldobnod.'
        ROLLBACK
GO

--Ez a trigger pedig letiltja a [Plans] t�bla updatejeit, a besz�rand� tervk�dok a webes alkalmaz�sb�l �rkeznek
--�s egy m�sik trigger felel az�rt, hogy helyesen legyenek besz�rva

DROP TRIGGER IF EXISTS DenyUpdateTable_Plans
GO

CREATE TRIGGER DenyUpdateTable_Plans
ON Plans
INSTEAD OF UPDATE
AS
        PRINT 'A [Plans] t�bl�n az update m�veletek tiltottak: ""DenyUpdateTable_Plans"" triggerrel.'
        ROLLBACK
GO

---
--Innent�l az egyes t�bl�kat "�rz�" UPDATE/DELETE triggerek:

DROP TRIGGER IF EXISTS DenyDelSpec
GO
CREATE TRIGGER DenyDelSpec
ON Specialisation
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [Specialisation] t�bl�n az update �s t�rl�s m�veletek tiltottak: ""DenyDelSpec"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelPhase
GO
CREATE TRIGGER DenyDelPhase
ON Phase
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [Phase] t�bl�n az update �s t�rl�s m�veletek tiltottak: ""DenyDelPhase"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelDocType
GO
CREATE TRIGGER DenyDelDocType
ON DocType
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [DocType] t�bl�n az update �s t�rl�s m�veletek tiltottak: ""DenyDelDocType"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelOffice
GO
CREATE TRIGGER DenyDelOffice
ON Office
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [Office] t�bl�n az update �s t�rl�s m�veletek tiltottak: ""DenyDelOffice"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelProject
GO
CREATE TRIGGER DenyDelProject
ON Project
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [Project] t�bl�n az update �s t�rl�s m�veletek tiltottak: ""DenyDelProject"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelProjectBuilding
GO
CREATE TRIGGER DenyDelProjectBuilding
ON ProjBuilding
INSTEAD OF UPDATE, DELETE
AS
        PRINT 'A [ProjBuilding] t�bl�n az update �s t�rl�s m�veletek tiltottak: ""DenyDelProjectBuilding"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelProjectFloor
GO
CREATE TRIGGER DenyDelProjectFloor
ON ProjFloor
INSTEAD OF DELETE
AS
        PRINT 'A [ProjFloor] t�bl�n a t�rl�s m�velet tiltott: ""DenyDelProjectFloor"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelUserRole
GO
CREATE TRIGGER DenyDelUserRole
ON UserRole
INSTEAD OF DELETE
AS
        PRINT 'A [UserRole] t�bl�n a t�rl�s m�velet tiltott: ""DenyDelUserRole"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelPlanStatus
GO
CREATE TRIGGER DenyDelPlanStatus
ON PlanStatus
INSTEAD OF DELETE
AS
        PRINT 'A [PlanStatus] t�bl�n a t�rl�s m�velet tiltott: ""DenyDelPlanStatus"" triggerrel.'
        ROLLBACK
GO

---

DROP TRIGGER IF EXISTS DenyDelPlanApproval
GO
CREATE TRIGGER DenyDelPlanApproval
ON ApprovedPlansLog
INSTEAD OF DELETE, UPDATE
AS
        PRINT 'A [ApprovedPlansLog] t�bl�n a t�rl�s m�velet tiltott: ""DenyDelPlanApproval"" triggerrel.'
        ROLLBACK
GO

---