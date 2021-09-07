DROP DATABASE IF EXISTS [PLNMGMT]
GO
CREATE DATABASE PLNMGMT
GO
USE PLNMGMT
GO
CREATE SCHEMA UserApp
GO
CREATE SCHEMA FEApp
GO

CREATE TABLE [Specialisation] (
	SpecID char(1) NOT NULL PRIMARY KEY,
	--AUTO_INCREMENT,
	SpecName varchar(255) NOT NULL,
  )
GO
CREATE TABLE [Phase] (
	PhaseID char(2) NOT NULL PRIMARY KEY,
	PhaseName varchar(255) NOT NULL,

)
GO
CREATE TABLE [DocType] (
	DocTypeID char(1) NOT NULL PRIMARY KEY,
	DocTypeName varchar(255) NOT NULL,
)
GO
CREATE TABLE [Office] (
	OfficeID char(3) NOT NULL,
	OfficeName varchar(255) NOT NULL,
  CONSTRAINT [PK_OFFICE] PRIMARY KEY CLUSTERED
  (
  [OfficeID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Users] (
	UserID int IDENTITY(1000,1),
	UserName varchar(100) NOT NULL,
	Email varchar(100) NOT NULL,
	UserOffice char(3) NOT NULL,
	Role char(1) NOT NULL,
	Nickname varchar(32),
	Password varchar(32) NOT NULL,
  CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED
  (
  [UserID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
ALTER TABLE [Users]
ADD CONSTRAINT CheckEmail CHECK(Email LIKE '%___@___%.__%')
GO


CREATE TABLE [Plans] (
	PlanID int IDENTITY(1000000000,1) NOT NULL,
	-- lehetne 'uniqueidentifier' datatype, de az feleslegesen hosszú lenne
	Office char(3) NOT NULL,
	Spec char(1) NOT NULL,
	Phase char(2) NOT NULL,
	Project char(4) NOT NULL,
	Building char(2) NOT NULL,
	Floor char(2) NOT NULL,
	DocType char(1) NOT NULL,
	PlanNum numeric(5) NOT NULL,
	Revision char(1) NOT NULL DEFAULT 'a' ---ebbõl még csinálhatnék számot a betû helyett!!!
  CONSTRAINT [PK_PLANS] PRIMARY KEY CLUSTERED
  (
  [PlanID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
GO
CREATE TABLE [Project] (
	ProjectID char(4) NOT NULL,
	PName varchar(255) NOT NULL,
	PAddress varchar(255) NOT NULL,
  CONSTRAINT [PK_PROJECT] PRIMARY KEY CLUSTERED
  (
  [ProjectID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [UserRole] (
	UserRoleID char(1) NOT NULL UNIQUE,
	UserRoleName varchar(100) NOT NULL UNIQUE,
	CONSTRAINT [PK_USERROLE] PRIMARY KEY CLUSTERED
  (
  [UserRoleID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [ProjBuilding] (
	ProjectParent char(4) NOT NULL,
	ProjectBuildingID char(2) NOT NULL UNIQUE,
	PBName varchar(255) NOT NULL UNIQUE,
  CONSTRAINT [PK_PROJBUILDING] PRIMARY KEY CLUSTERED
  (
  [ProjectBuildingID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [ProjFloor] (
	ProjBuilding char(2) NOT NULL,
	ProjectBuildingFloorID char(2) NOT NULL,
	PBFName varchar(255) NOT NULL,
	TopLevelHeight decimal(5,2) NOT NULL DEFAULT '000.00',
	BottomLevelHeight decimal(5,2) NOT NULL DEFAULT '000.00',
	GroundLevelToBS decimal(5,2) NOT NULL DEFAULT '000.00',
  CONSTRAINT [PK_PROJFLOOR] PRIMARY KEY CLUSTERED
  (
  [ProjectBuildingFloorID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

CREATE TABLE [ApprovedPlansLog] (
	ApprovalID int IDENTITY,
	PlanAppId int NOT NULL,
	PlanStatus char(1) NOT NULL DEFAULT '0',
	ApprovalDate datetime2 NOT NULL,
	Approvant int NOT NULL,
	CONSTRAINT [PK_APPROVEDPLANSLOG] PRIMARY KEY CLUSTERED
	(
	[ApprovalID] ASC
	) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--ALTER TABLE [ApprovedPlansLog] ADD CONSTRAINT DF_ApprovedPlansLog DEFAULT GETDATE() FOR ApprovalDate
--GO

CREATE TABLE [PlanStatus] (
	PlanStatusID char(1) NOT NULL UNIQUE,
	PlanStatusName char(25) NOT NULL UNIQUE,
	CONSTRAINT [PK_PLANSTATUS] PRIMARY KEY CLUSTERED
	(
	[PlanStatusID] ASC
	) WITH (IGNORE_DUP_KEY = OFF)
)
GO


ALTER TABLE [Users] WITH CHECK ADD CONSTRAINT [Users_fk0_OfficeID] FOREIGN KEY ([UserOffice]) REFERENCES [Office]([OfficeID])
GO
ALTER TABLE [Users] CHECK CONSTRAINT [Users_fk0_OfficeID]
GO

ALTER TABLE [Users] WITH CHECK ADD CONSTRAINT [Users_fk1_RoleID] FOREIGN KEY ([Role]) REFERENCES [UserRole]([UserRoleID])
GO
ALTER TABLE [Users] CHECK CONSTRAINT [Users_fk1_RoleID]
GO

ALTER TABLE [Plans] WITH CHECK ADD CONSTRAINT [Plans_fk0_OfficeID] FOREIGN KEY ([Office]) REFERENCES [Office]([OfficeID])
GO
ALTER TABLE [Plans] CHECK CONSTRAINT [Plans_fk0_OfficeID]
GO

ALTER TABLE [Plans] WITH CHECK ADD CONSTRAINT [Plans_fk1_SpecID] FOREIGN KEY ([Spec]) REFERENCES [Specialisation]([SpecID])
GO
ALTER TABLE [Plans] CHECK CONSTRAINT [Plans_fk1_SpecID]
GO

ALTER TABLE [Plans] WITH CHECK ADD CONSTRAINT [Plans_fk2_PhaseID] FOREIGN KEY ([Phase]) REFERENCES [Phase]([PhaseID])
GO
ALTER TABLE [Plans] CHECK CONSTRAINT [Plans_fk2_PhaseID]
GO

ALTER TABLE [Plans] WITH CHECK ADD CONSTRAINT [Plans_fk3_ProjectID] FOREIGN KEY ([Project]) REFERENCES [Project]([ProjectID])
GO
ALTER TABLE [Plans] CHECK CONSTRAINT [Plans_fk3_ProjectID]
GO

ALTER TABLE [Plans] WITH CHECK ADD CONSTRAINT [Plans_fk4_ProjBuildingID] FOREIGN KEY ([Building]) REFERENCES [ProjBuilding]([ProjectBuildingID])
GO
ALTER TABLE [Plans] CHECK CONSTRAINT [Plans_fk4_ProjBuildingID]
GO

ALTER TABLE [Plans] WITH CHECK ADD CONSTRAINT [Plans_fk5_ProjectBuildingFloorID] FOREIGN KEY ([Floor]) REFERENCES [ProjFloor]([ProjectBuildingFloorID])
GO
ALTER TABLE [Plans] CHECK CONSTRAINT [Plans_fk5_ProjectBuildingFloorID]
GO

ALTER TABLE [Plans] WITH CHECK ADD CONSTRAINT [Plans_fk6_DocTypeID] FOREIGN KEY ([DocType]) REFERENCES [DocType]([DocTypeID])
GO
ALTER TABLE [Plans] CHECK CONSTRAINT [Plans_fk6_DocTypeID]
GO

ALTER TABLE [ProjBuilding] WITH CHECK ADD CONSTRAINT [ProjBuilding_fk0_ProjectID] FOREIGN KEY ([ProjectParent]) REFERENCES [Project]([ProjectID])
ON DELETE NO ACTION
GO
ALTER TABLE [ProjBuilding] CHECK CONSTRAINT [ProjBuilding_fk0_ProjectID]
GO

ALTER TABLE [ProjFloor] WITH CHECK ADD CONSTRAINT [ProjFloor_fk0_ProjectBuildingID] FOREIGN KEY ([ProjBuilding]) REFERENCES [ProjBuilding]([ProjectBuildingID])
ON DELETE NO ACTION
GO
ALTER TABLE [ProjFloor] CHECK CONSTRAINT [ProjFloor_fk0_ProjectBuildingID]
GO

ALTER TABLE [ApprovedPlansLog] WITH CHECK ADD CONSTRAINT [ApprovedPlansLog_fk0_PlanAppID] FOREIGN KEY ([PlanAppId]) REFERENCES [Plans]([PlanID])
GO
ALTER TABLE [ApprovedPlansLog] CHECK CONSTRAINT [ApprovedPlansLog_fk0_PlanAppID]
GO

ALTER TABLE [ApprovedPlansLog] WITH CHECK ADD CONSTRAINT [ApprovedPlansLog_fk1_PlanStatusID] FOREIGN KEY ([PlanStatus]) REFERENCES [PlanStatus]([PlanStatusID])
GO
ALTER TABLE [ApprovedPlansLog] CHECK CONSTRAINT [ApprovedPlansLog_fk1_PlanStatusID]
GO

ALTER TABLE [ApprovedPlansLog] WITH CHECK ADD CONSTRAINT [ApprovedPlansLog_fk2_UserID] FOREIGN KEY ([Approvant]) REFERENCES [Users]([UserID])
ON DELETE NO ACTION
GO
ALTER TABLE [ApprovedPlansLog] CHECK CONSTRAINT [ApprovedPlansLog_fk2_UserID]
GO


