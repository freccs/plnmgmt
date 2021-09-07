USE PLNMGMT
GO

--TERVKÓD FORMÁTUM:
--U-K1-A-X-T-600-c@Rakodóudvar-Építési helyszínrajz


--DOKUMENTUMTÍPUSOK
INSERT INTO DocType (DocTypeID, DocTypeName)
VALUES 
('T', 'Terv'),
('L', 'Mûszaki leírás'),
('S', 'Szakértés'),
('K', 'Kimutatás, táblázat, lista'),
('E', 'Engedély'),
('I', 'Irat: Helyszínrajz, Tulajdoni lap')
;
GO

--ÉPÍTÉSI FÁZISOK
INSERT INTO Phase (PhaseID, PhaseName)
VALUES 
('XX', 'Nem értelmezhetõ'),
('PE', 'Projekt-elõkészítés'),
('TT', 'Tanulmányterv'),
('T1', 'Tenderterv 1.fázis'),
('T2', 'Tenderterv 2.fázis'),
('E1', 'Engedélyzési terv - 1. fázis'),
('E2', 'Engedélyzési terv - 2. fázis'),
('K1', 'Kiviteli terv - 1. fázis'),
('K2', 'Kiviteli terv - 2. fázis'),
('M1', 'Megvalósulási terv'),
('FT', 'Felmérési terv'),
('SZ', 'Szakértés'),
('JK', 'Jegyzõkönyv')
;
GO

--SZAKÁGAK
INSERT INTO Specialisation (SpecID, SpecName)
VALUES
('X', 'Nem értelmezhetõ'),
('E', 'Építészet'),
('S', 'Statika'),
('L', 'Elektromos'),
('G', 'Gépész'),
('T', 'Tûzvédelem'),
('U', 'Úttervezés'),
('O', 'Objektumvédelem')
;
GO

--PROJEKTEK &
--PROJEKTÉPÜLETEK &
--PROJEKTÉPÜLETSZINTEK

--Ezt még ki lehetne egészíteni oszlopokkal: Helyrajzi szám, ország, teljes kirészletezett cím (irszám, város, kerület...), Régió, Koordináták, idõzóna...
INSERT INTO Project (ProjectID, PName, PAddress)
VALUES
('BIGH', 'Fõvárosi Nagy Ház', '1111 Budapest, Duna sétány 3.'),
('HOTL', 'Dunaparti Hotel', '2400 Dunaújváros, Duna sor 234.'),
('OFFC', 'Szegedi Irodakomplexum', 'Szeged, DózsaGyörgy út 3.')
;
GO

INSERT INTO ProjBuilding (ProjectParent, ProjectBuildingID, PBName)
VALUES
('BIGH', 'A1', 'A1 fõépület'),
('BIGH', 'A2', 'A2 melléképület'),
('BIGH', 'G1', 'G1 Gazdasági épület'),
('BIGH', 'PT', 'Portaépület'),
('BIGH', 'MH', 'Mûhelyépület'),
-----
('HOTL', 'P1', 'Fõporta'),
('HOTL', 'P2', 'Gazdasági portaépület'),
('OFFC', 'B1', 'B1 fõépület'),
('OFFC', 'B2', 'B2 melléképület'),
('OFFC', 'GK', 'Gondnokság')
;
GO
--PROJEKTSZINTEK--
INSERT INTO ProjFloor (ProjBuilding, ProjectBuildingFloorID, PBFName, /* GroundLevelToBS, */ BottomLevelHeight, TopLevelHeight)
VALUES
('A1', 'TT', 'tetõterasz', /* ' ', */ 36.25, 40.00),
('A1', '80', 'nyolcadik emelet', /* ' ', */ 32.25, 36.25),
('A1', '70', 'hetedik emelet', /* ' ', */ 28.25, 32.25),
('A1', '60', 'hatodik emelet', /* ' ', */ 24.25, 28.25),
('A1', '50', 'ötödik emelet', /* ' ', */ 20.25, 24.25),
('A1', '40', 'negyedik emelet', /* ' ', */ 16.25, 20.25),
('A1', '30', 'harmadik emelet', /* ' ', */ 12.25, 16.25),
('A1', '20', 'második emelet', /* ' ', */ 8.25, 12.25),
('A1', '15', 'elsõ félszint', /* ' ', */ 6.25, 10.25),
('A1', '10', 'elsõ emelet', /* ' ', */ 4.25, 8.25),
('A1', '05', 'félszint', /* ' ', */ 2.25, 6.25),
('A1', '00', 'földszint', /* ' ', */ 0.00, 4.25),
('A1', 'X1', 'pinceszint', /* ' ', */ -2.80, 00.00),
('A1', 'X2', 'pinceszint2', /* ' ', */ -5.60, -2.80)
;
GO


--IRODÁK--
INSERT INTO Office (OfficeID, OfficeName)
VALUES
('MUE', 'MÛÉP Építõmérnöki Kft.'),
('TRI', 'TRIGRÁNIT Kft.'),
('3HD', '3 HÍD Kft.'),
('KES', 'KÉSZ Zrt.'),
('STG', 'STRABAG Zrt.'),
('TET', 'Tóth és Társaa Jogi Iroda Kft.'),
('MGM', 'MEGOLDJUK Management És Lebonyolító Kft.')
;

--TERVSZÁMOK--

DECLARE @counter SMALLINT;  
SET @counter = 1;  
WHILE @counter < 1000  
   BEGIN  
      INSERT INTO Plans (Office, Spec, Phase, Project, Building, Floor, DocType, PlanNum, Revision)
		VALUES
		(
			(SELECT TOP 1 Office.OfficeID					FROM Office ORDER BY NEWID()), 
			(SELECT TOP 1 Specialisation.SpecID				FROM Specialisation ORDER BY NEWID()),
			(SELECT TOP 1 Phase.PhaseID						FROM Phase ORDER BY NEWID()),
			(SELECT TOP 1 Project.ProjectID					FROM Project ORDER BY NEWID()),
			(SELECT TOP 1 ProjBuilding.ProjectBuildingID	FROM ProjBuilding ORDER BY NEWID()),
			(SELECT TOP 1 ProjFloor.ProjectBuildingFloorID	FROM ProjFloor ORDER BY NEWID()),
			(SELECT TOP 1 DocType.DocTypeID					FROM DocType ORDER BY NEWID()),
			(SELECT CONVERT(decimal(5,0), ROUND((RAND()* 90000+10000),5,0))),
			/*(SELECT char((RAND()*25 + 65))) --Ezzel adna A-Z-ig egy random betût */
			(SELECT char((RAND()*15 + 97)))  --Így pedig csak az ABC 15. betûjéig megy (kis abécé 'a':97-->z:122)
		)  
      SET @counter = @counter + 1  
   END;  
GO

;

--USERROLES--
INSERT INTO UserRole (UserRoleID, UserRoleName)
VALUES
('A', 'Admin'),
('U', 'Feltöltõ'),
('S', 'Jóváhagyó, aláíró'),
('C', 'Mûszaki Ellenõr'),
('P', 'Pénzügy'),
('G', 'Vendég'),
('L', 'Jogász'),
('D', 'Tervezõ')
;
GO

--USEREK--
INSERT INTO Users(UserName, Email, UserOffice, Role, Nickname, Password)
VALUES
('Katona Richárd', 'freccs@gmail.com', 'MUE', 'A', 'KaR','password1123410'),
('Szabó László', 'aldfjk@gmail.com', 'TRI', 'U', 'SzaL','password76510'),
('Kovács Péter', 'lkjgeg@gmail.com', 'MUE', 'U', 'KoP','password120653210'),
('Horváth Gábor', 'sdlgkjsg@gmail.com', '3HD', 'U', 'HoG','password12356210'),
('Szabó László', 'lkjsdg@gmail.com', '3HD', 'S', 'Laci','password12034245210'),
('Szabó Péter', 'lkjlkj@gmail.com', 'KES', 'D', 'Pítör','password120767610'),
('Esetlen János', 'aeraer@gmail.com', 'KES', 'D', 'Jancsi','password120253610'),
('Molnár József', 'khrera@gmail.com', 'KES', 'S', 'Moyo','password12027610'),
('Kovács János', 'jhasvcd@gmail.com', 'STG', 'S', 'Jánoska','password12987610'),
('Molnár János', 'hkkgcads@gmail.com', 'TET', 'L', 'Jani','password12012310'),
('Molnár Péter', 'qwer@gmail.com', 'TET', 'L', 'Petya','password1202847847'),
('Molnár József', 'trew@gmail.com', 'TET', 'S', 'Molni','password120546870'),
('Molnár Gábor Péter', 'xbxy@gmail.com', 'MUE', 'S', 'MPeti','password12467210'),
('Molnár József', 'kjasbgsf@gmail.com', 'TRI', 'C', 'Józsi','password1205670'),
('Molnár József', 'yxcbyxc@gmail.com', 'MGM', 'P', 'Jozsó','password1207546210'),
('Molnár Zsolt', 'bbsdgb@gmail.com', 'MGM', 'U', 'MoZs','password12020555510'),
('Molnár Gáspár', 'sggas@gmail.com', 'MGM', 'S', 'MoG','password12055677710')
;
GO

--LEHETSÉGES TERVÁLLAPOTOK--
INSERT INTO PlanStatus(PlanStatusID, PlanStatusName)
VALUES
('1', 'Feltöltött'),
('2', 'Jóváhagyásra vár'),
('3', 'Jóváhagyott'),
('4', 'Lejárt dokumentum'),
('5', 'Visszavont dokumentum')
;
GO
;

--TERVTÁR (JÓVÁHAGYOTT ÉS VISSZAVONT TERVEK JEGYZÉKE) feltöltése random adatokkal

/*

DECLARE @a int =1
WHILE @a<999
BEGIN
	INSERT INTO ApprovedPlansLog (PlanAppId, PlanStatus, ApprovalDate, Approvant)
	VALUES (
		(SELECT Plans.PlanID FROM Plans ORDER BY Plans.PlanID OFFSET @a ROWS FETCH FIRST 1 ROW ONLY), 
		(SELECT TOP 1 PlanStatus.PlanStatusID FROM PlanStatus ORDER BY NEWID()),
		(SELECT GETDATE()),
		(SELECT TOP 1 Users.UserID	FROM Users ORDER BY NEWID())
		)
	SET @a=@a+1
END
GO 2
;


*/


--VAGY UGYANEZ RANDOM DÁTUMOKKAL

DECLARE @a int =0
WHILE @a<999
BEGIN
	INSERT INTO ApprovedPlansLog (PlanAppId, PlanStatus, ApprovalDate, Approvant)
	VALUES (
		(SELECT Plans.PlanID FROM Plans ORDER BY Plans.PlanID OFFSET @a ROWS FETCH FIRST 1 ROW ONLY), 
		(SELECT TOP 1 PlanStatus.PlanStatusID FROM PlanStatus ORDER BY NEWID()),
		(SELECT DATEADD(day, -(ABS(CHECKSUM(NEWID())) % 300), GETDATE())),
		(SELECT TOP 1 Users.UserID	FROM Users ORDER BY NEWID())
		)
	SET @a=@a+1
END
GO
;

