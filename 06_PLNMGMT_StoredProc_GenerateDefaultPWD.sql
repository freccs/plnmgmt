---TÁROLT ELJÁRÁS A JELSZAVAK GENERÁLÁSÁRA

CREATE OR ALTER PROCEDURE GENERATEPWD(@GENPASS VARCHAR(10) = 1 OUTPUT)  
AS   
BEGIN  
SET NOCOUNT ON  
DECLARE @CharPool varchar(92), @PoolLength INT, @LoopCount INT  
DECLARE @RandomString VARCHAR(10)  
  
SET @CharPool = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,.<>/\|?`~'
DECLARE @TMPSTR VARCHAR(3)  

SET @PoolLength = DataLength(@CharPool)  
SET @LoopCount = 0  
SET @RandomString = ''  
  
    WHILE (@LoopCount <10)  
    BEGIN  
        SET @TMPSTR =   SUBSTRING(@Charpool, CONVERT(int, RAND() * @PoolLength), 1)           
        SELECT @RandomString  = @RandomString + CONVERT(VARCHAR(5), CONVERT(INT, RAND() * 10))  
        IF(DATALENGTH(@TMPSTR) > 0)  
        BEGIN   
            SELECT @RandomString = @RandomString + @TMPSTR    
            SELECT @LoopCount = @LoopCount + 1  
        END  
    END  
    SET @LOOPCOUNT = 0    
    SET @GENPASS=@RandomString
	PRINT @GENPASS
END

--EXEC dbo.GENERATEPWD

