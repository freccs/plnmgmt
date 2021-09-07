SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('UploadedPlanListToText','P') IS NOT NULL
   DROP PROCEDURE UploadedPlanListToText
GO
CREATE PROCEDURE UploadedPlanListToText 
	@PlanCode varchar(50) = NULL
AS
	SET NOCOUNT ON
	DECLARE cursor_PC CURSOR 
			FOR 
				SELECT CONCAT(Office,'-', Spec,'-', Phase,'-', Project,'-', Building,'-', Floor,'-', DocType,'-', PlanNum,'-', LOWER(Revision)) FROM Plans
				ORDER BY Office, Spec, Phase, Project, Building, Floor, DocType, PlanNum, Revision;
		OPEN cursor_PC
		FETCH NEXT FROM cursor_PC INTO @PlanCode  
			PRINT ('>>>___________________TERVLISTA A PLNMGMT RENDSZERB�L______Export�lva:' + CAST(FORMAT(GETDATE(),'yyyy. MMMM dd. hh:mm', 'hu-hu') AS varchar) + '__<<<')
		IF @@FETCH_STATUS <> 0   
				BEGIN
					PRINT 'Hiba t�rt�nt a [UploadedPlanListToText] t�rolt elj�r�s megh�v�sa k�zben!' 
					RETURN 1
				END
		WHILE @@FETCH_STATUS = 0  
				BEGIN  
					PRINT @PlanCode
					FETCH NEXT FROM cursor_PC INTO @PlanCode
				END
			PRINT ('>>>______________-----TERVLISTA V�GE-----_____________<<<') 
			RETURN 0;
	CLOSE cursor_PC;
DEALLOCATE cursor_PC;


--EXEC UploadedPlanListToText
