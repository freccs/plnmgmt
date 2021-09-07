USE PLNMGMT
GO

--TERVK�D FORM�TUM:
--U-K1-A-X-T-600-c@Rakod�udvar-�p�t�si helysz�nrajz


--DOKUMENTUMT�PUSOK
INSERT INTO DocType (DocTypeID, DocTypeName)
VALUES 
('T', 'Terv'),
('L', 'M�szaki le�r�s'),
('S', 'Szak�rt�s'),
('K', 'Kimutat�s, t�bl�zat, lista'),
('E', 'Enged�ly'),
('I', 'Irat: Helysz�nrajz, Tulajdoni lap')
;
GO

--�P�T�SI F�ZISOK
INSERT INTO Phase (PhaseID, PhaseName)
VALUES 
('XX', 'Nem �rtelmezhet�'),
('PE', 'Projekt-el�k�sz�t�s'),
('TT', 'Tanulm�nyterv'),
('T1', 'Tenderterv 1.f�zis'),
('T2', 'Tenderterv 2.f�zis'),
('E1', 'Enged�lyz�si terv - 1. f�zis'),
('E2', 'Enged�lyz�si terv - 2. f�zis'),
('K1', 'Kiviteli terv - 1. f�zis'),
('K2', 'Kiviteli terv - 2. f�zis'),
('M1', 'Megval�sul�si terv'),
('FT', 'Felm�r�si terv'),
('SZ', 'Szak�rt�s'),
('JK', 'Jegyz�k�nyv')
;
GO

--SZAK�GAK
INSERT INTO Specialisation (SpecID, SpecName)
VALUES
('X', 'Nem �rtelmezhet�'),
('E', '�p�t�szet'),
('S', 'Statika'),
('L', 'Elektromos'),
('G', 'G�p�sz'),
('T', 'T�zv�delem'),
('U', '�ttervez�s'),
('O', 'Objektumv�delem')
;
GO

--PROJEKTEK &
--PROJEKT�P�LETEK &
--PROJEKT�P�LETSZINTEK

--Ezt m�g ki lehetne eg�sz�teni oszlopokkal: Helyrajzi sz�m, orsz�g, teljes kir�szletezett c�m (irsz�m, v�ros, ker�let...), R�gi�, Koordin�t�k, id�z�na...
INSERT INTO Project (ProjectID, PName, PAddress)
VALUES
('BIGH', 'F�v�rosi Nagy H�z', '1111 Budapest, Duna s�t�ny 3.'),
('HOTL', 'Dunaparti Hotel', '2400 Duna�jv�ros, Duna sor 234.'),
('OFFC', 'Szegedi Irodakomplexum', 'Szeged, D�zsaGy�rgy �t 3.')
;
GO

INSERT INTO ProjBuilding (ProjectParent, ProjectBuildingID, PBName)
VALUES
('BIGH', 'A1', 'A1 f��p�let'),
('BIGH', 'A2', 'A2 mell�k�p�let'),
('BIGH', 'G1', 'G1 Gazdas�gi �p�let'),
('BIGH', 'PT', 'Porta�p�let'),
('BIGH', 'MH', 'M�hely�p�let'),
-----
('HOTL', 'P1', 'F�porta'),
('HOTL', 'P2', 'Gazdas�gi porta�p�let'),
('OFFC', 'B1', 'B1 f��p�let'),
('OFFC', 'B2', 'B2 mell�k�p�let'),
('OFFC', 'GK', 'Gondnoks�g')
;
GO
--PROJEKTSZINTEK--
INSERT INTO ProjFloor (ProjBuilding, ProjectBuildingFloorID, PBFName, /* GroundLevelToBS, */ BottomLevelHeight, TopLevelHeight)
VALUES
('A1', 'TT', 'tet�terasz', /* ' ', */ 36.25, 40.00),
('A1', '80', 'nyolcadik emelet', /* ' ', */ 32.25, 36.25),
('A1', '70', 'hetedik emelet', /* ' ', */ 28.25, 32.25),
('A1', '60', 'hatodik emelet', /* ' ', */ 24.25, 28.25),
('A1', '50', '�t�dik emelet', /* ' ', */ 20.25, 24.25),
('A1', '40', 'negyedik emelet', /* ' ', */ 16.25, 20.25),
('A1', '30', 'harmadik emelet', /* ' ', */ 12.25, 16.25),
('A1', '20', 'm�sodik emelet', /* ' ', */ 8.25, 12.25),
('A1', '15', 'els� f�lszint', /* ' ', */ 6.25, 10.25),
('A1', '10', 'els� emelet', /* ' ', */ 4.25, 8.25),
('A1', '05', 'f�lszint', /* ' ', */ 2.25, 6.25),
('A1', '00', 'f�ldszint', /* ' ', */ 0.00, 4.25),
('A1', 'X1', 'pinceszint', /* ' ', */ -2.80, 00.00),
('A1', 'X2', 'pinceszint2', /* ' ', */ -5.60, -2.80)
;
GO


--IROD�K--
INSERT INTO Office (OfficeID, OfficeName)
VALUES
('MUE', 'M��P �p�t�m�rn�ki Kft.'),
('TRI', 'TRIGR�NIT Kft.'),
('3HD', '3 H�D Kft.'),
('KES', 'K�SZ Zrt.'),
('STG', 'STRABAG Zrt.'),
('TET', 'T�th �s T�rsaa Jogi Iroda Kft.'),
('MGM', 'MEGOLDJUK Management �s Lebonyol�t� Kft.')
;

--TERVSZ�MOK--

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
			/*(SELECT char((RAND()*25 + 65))) --Ezzel adna A-Z-ig egy random bet�t */
			(SELECT char((RAND()*15 + 97)))  --�gy pedig csak az ABC 15. bet�j�ig megy (kis ab�c� 'a':97-->z:122)
		)  
      SET @counter = @counter + 1  
   END;  
GO

;

--USERROLES--
INSERT INTO UserRole (UserRoleID, UserRoleName)
VALUES
('A', 'Admin'),
('U', 'Felt�lt�'),
('S', 'J�v�hagy�, al��r�'),
('C', 'M�szaki Ellen�r'),
('P', 'P�nz�gy'),
('G', 'Vend�g'),
('L', 'Jog�sz'),
('D', 'Tervez�')
;
GO

--USEREK--
INSERT INTO Users(UserName, Email, UserOffice, Role, Nickname, Password)
VALUES
('Katona Rich�rd', 'freccs@gmail.com', 'MUE', 'A', 'KaR','password1123410'),
('Szab� L�szl�', 'aldfjk@gmail.com', 'TRI', 'U', 'SzaL','password76510'),
('Kov�cs P�ter', 'lkjgeg@gmail.com', 'MUE', 'U', 'KoP','password120653210'),
('Horv�th G�bor', 'sdlgkjsg@gmail.com', '3HD', 'U', 'HoG','password12356210'),
('Szab� L�szl�', 'lkjsdg@gmail.com', '3HD', 'S', 'Laci','password12034245210'),
('Szab� P�ter', 'lkjlkj@gmail.com', 'KES', 'D', 'P�t�r','password120767610'),
('Esetlen J�nos', 'aeraer@gmail.com', 'KES', 'D', 'Jancsi','password120253610'),
('Moln�r J�zsef', 'khrera@gmail.com', 'KES', 'S', 'Moyo','password12027610'),
('Kov�cs J�nos', 'jhasvcd@gmail.com', 'STG', 'S', 'J�noska','password12987610'),
('Moln�r J�nos', 'hkkgcads@gmail.com', 'TET', 'L', 'Jani','password12012310'),
('Moln�r P�ter', 'qwer@gmail.com', 'TET', 'L', 'Petya','password1202847847'),
('Moln�r J�zsef', 'trew@gmail.com', 'TET', 'S', 'Molni','password120546870'),
('Moln�r G�bor P�ter', 'xbxy@gmail.com', 'MUE', 'S', 'MPeti','password12467210'),
('Moln�r J�zsef', 'kjasbgsf@gmail.com', 'TRI', 'C', 'J�zsi','password1205670'),
('Moln�r J�zsef', 'yxcbyxc@gmail.com', 'MGM', 'P', 'Jozs�','password1207546210'),
('Moln�r Zsolt', 'bbsdgb@gmail.com', 'MGM', 'U', 'MoZs','password12020555510'),
('Moln�r G�sp�r', 'sggas@gmail.com', 'MGM', 'S', 'MoG','password12055677710')
;
GO

--LEHETS�GES TERV�LLAPOTOK--
INSERT INTO PlanStatus(PlanStatusID, PlanStatusName)
VALUES
('1', 'Felt�lt�tt'),
('2', 'J�v�hagy�sra v�r'),
('3', 'J�v�hagyott'),
('4', 'Lej�rt dokumentum'),
('5', 'Visszavont dokumentum')
;
GO
;

--TERVT�R (J�V�HAGYOTT �S VISSZAVONT TERVEK JEGYZ�KE) felt�lt�se random adatokkal

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


--VAGY UGYANEZ RANDOM D�TUMOKKAL

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

