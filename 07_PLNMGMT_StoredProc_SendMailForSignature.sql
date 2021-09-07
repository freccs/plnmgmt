--JÓVÁHAGYÁSRA VÁRÓ TERVEK:TERVKÓD-felelős-emailcím-iroda-szakág:
USE PLNMGMT
GO

IF OBJECT_ID('SendNotification','P') IS NOT NULL
   DROP PROCEDURE SendNotification
GO
CREATE PROCEDURE SendNotification 
	@PlanstatusID char(1) = 1,
	@OfficeID char(3) = NULL,
	@UserRole char(1) = NULL --tervjóváhagyáshoz: 'A', 'S', 'C'-ből valamelyik
AS
	SET NOCOUNT ON
	SELECT * FROM
	dbo.GetActualPlanListPerStatusPerOffice (@PlanstatusID, @OfficeID)
	SELECT Email, UserName, UserOffice, Role, UserRoleName FROM Users
	JOIN UserRole ON Users.Role = UserRole.UserRoleID
	WHERE Users.UserOffice = @OfficeID AND Users.Role = @UserRole

GO
;

/* MEGHÍVÁS:

EXEC dbo.SendNotification 
	@PlanstatusID = 2,
	@OfficeID = 'MUE',
	@UserRole = 'S'


*/