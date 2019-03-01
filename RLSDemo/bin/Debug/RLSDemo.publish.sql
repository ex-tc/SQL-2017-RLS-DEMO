﻿/*
Deployment script for RLSDemo

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "RLSDemo"
:setvar DefaultFilePrefix "RLSDemo"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [Sec]...';


GO
CREATE SCHEMA [Sec]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [Sec].[RlsUser]...';


GO
CREATE TABLE [Sec].[RlsUser] (
    [RlsUserID] INT              IDENTITY (1, 1) NOT NULL,
    [UserName]  NVARCHAR (128)   NULL,
    [SID]       UNIQUEIDENTIFIER NULL,
    [AB_LNK]    INT              NOT NULL,
    [XY_LNK]    INT              NOT NULL,
    CONSTRAINT [PK_RlsUser] PRIMARY KEY CLUSTERED ([RlsUserID] ASC)
);


GO
PRINT N'Creating [Sec].[RlsUserXYLNK]...';


GO
CREATE TABLE [Sec].[RlsUserXYLNK] (
    [RlsUserID] INT NOT NULL,
    [XYLNKID]   INT NOT NULL
);


GO
PRINT N'Creating [Sec].[RlsUserABLNK]...';


GO
CREATE TABLE [Sec].[RlsUserABLNK] (
    [RlsUserID] INT NOT NULL,
    [ABLNKID]   INT NOT NULL
);


GO
PRINT N'Creating [Sec].[PermiratedUserLink]...';


GO
CREATE TABLE [Sec].[PermiratedUserLink] (
    [RLSUserID]     INT NOT NULL,
    [PermitationID] INT NOT NULL
);


GO
PRINT N'Creating [Sec].[PermiratedUserLink].[IX_RLS_PERMITATION]...';


GO
CREATE UNIQUE CLUSTERED INDEX [IX_RLS_PERMITATION]
    ON [Sec].[PermiratedUserLink]([RLSUserID] ASC, [PermitationID] ASC) WITH (FILLFACTOR = 100);


GO
PRINT N'Creating [dbo].[_zzMaterializedPermitations]...';


GO
CREATE TABLE [dbo].[_zzMaterializedPermitations] (
    [RIDX]          BIGINT           NOT NULL,
    [UID]           UNIQUEIDENTIFIER NULL,
    [FK_A]          INT              NULL,
    [FK_B]          INT              NULL,
    [FK_X]          INT              NULL,
    [FK_Y]          INT              NULL,
    [PermitationID] INT              NULL
);


GO
PRINT N'Creating [dbo].[_zzMaterializedPermitations].[IX_RIDX]...';


GO
CREATE UNIQUE CLUSTERED INDEX [IX_RIDX]
    ON [dbo].[_zzMaterializedPermitations]([RIDX] ASC);


GO
PRINT N'Creating [dbo].[_zzMaterializedPermitations].[idx_NC_PermitationID]...';


GO
CREATE NONCLUSTERED INDEX [idx_NC_PermitationID]
    ON [dbo].[_zzMaterializedPermitations]([PermitationID] ASC);


GO
PRINT N'Creating [dbo].[_zzMaterializedPermitations].[idx_NC_Suplimentary]...';


GO
CREATE NONCLUSTERED INDEX [idx_NC_Suplimentary]
    ON [dbo].[_zzMaterializedPermitations]([FK_A] ASC, [FK_B] ASC, [FK_X] ASC, [FK_Y] ASC);


GO
PRINT N'Creating [dbo].[Permitations]...';


GO
CREATE TABLE [dbo].[Permitations] (
    [PermitationID] INT IDENTITY (1, 1) NOT NULL,
    [FK_A]          INT NULL,
    [FK_B]          INT NULL,
    [FK_X]          INT NULL,
    [FK_Y]          INT NULL,
    CONSTRAINT [PK_Permitations] PRIMARY KEY CLUSTERED ([PermitationID] ASC)
);


GO
PRINT N'Creating [dbo].[Permitations].[NonClusteredIndex-20190228-213240]...';


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20190228-213240]
    ON [dbo].[Permitations]([FK_A] ASC, [FK_B] ASC, [FK_X] ASC, [FK_Y] ASC);


GO
PRINT N'Creating [dbo].[zzSequence]...';


GO
CREATE TABLE [dbo].[zzSequence] (
    [RIDX] BIGINT           NOT NULL,
    [UID]  UNIQUEIDENTIFIER NOT NULL
);


GO
PRINT N'Creating unnamed constraint on [dbo].[_zzMaterializedPermitations]...';


GO
ALTER TABLE [dbo].[_zzMaterializedPermitations]
    ADD DEFAULT ((-1)) FOR [PermitationID];


GO
PRINT N'Creating unnamed constraint on [dbo].[zzSequence]...';


GO
ALTER TABLE [dbo].[zzSequence]
    ADD DEFAULT (NEWID()) FOR [UID];


GO
PRINT N'Creating [SEC].[vPermiratedUserLink]...';


GO


CREATE VIEW SEC.vPermiratedUserLink
AS
  SELECT DISTINCT U.RLSUserID,P.[PermitationID]  
  
  FROM SEC.RLSUser U
  INNER JOIN [Sec].[RlsUserXYLNK] C ON U.RLSUserID=C.RLSUserID AND U.XY_LNK=1
  INNER JOIN [dbo].[Permitations] P     ON C.[XYLNKID] = FK_X 
										OR C.[XYLNKID] = FK_Y
  
  
  UNION ALL
  SELECT DISTINCT U.RLSUserID,P.[PermitationID]  
  
  FROM SEC.RLSUser U
  INNER JOIN [Sec].[RlsUserABLNK] C ON U.RLSUserID=C.RLSUserID AND U.AB_LNK=1
  INNER JOIN [dbo].[Permitations] P     ON C.[ABLNKID] = FK_A
										OR C.[ABLNKID] = FK_B
GO
PRINT N'Creating [Sec].[fn_securitypredicate]...';


GO
CREATE FUNCTION Sec.[fn_securitypredicate](@PermitationID AS INT)  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  --SELECT CONVERT(uniqueidentifier,USER_SID())
    RETURN SELECT 1 AS fn_securitypredicate_result   
WHERE @PermitationID = (SELECT TOP 1 PermitationID 
				from [Sec].[PermiratedUserLink] 
				WHERE (RlsUserID = (SELECT TOP 1 RlsUserID FROM SEC.RlsUser 
									WHERE [SID]=Convert(UniqueIdentifier,SUSER_SID()))
				AND PermitationID=@PermitationID)) 
				;
GO
PRINT N'Creating [SEC].[REBUILD_PermiratedUserLink]...';


GO
CREATE PROCEDURE SEC.REBUILD_PermiratedUserLink
AS BEGIN

BEGIN TRY
DROP INDEX [IX_RLS_PERMITATION] ON [Sec].[PermiratedUserLink] WITH ( ONLINE = OFF )
END TRY
BEGIN CATCH 
PRINT 'IX Did Not Exist'
END CATCH

TRUNCATE TABLE [Sec].[PermiratedUserLink]

INSERT INTO [Sec].[PermiratedUserLink]
SELECT DISTINCT * FROM [Sec].[vPermiratedUserLink] ORDER BY 1,2




CREATE UNIQUE CLUSTERED INDEX [IX_RLS_PERMITATION] ON [Sec].[PermiratedUserLink]
(
	[RLSUserID] ASC,
	[PermitationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]



END
GO
PRINT N'Creating [dbo].[PermitationID_Policy]...';


GO
CREATE SECURITY POLICY [dbo].[PermitationID_Policy]
    ADD FILTER PREDICATE [SEC].[fn_securitypredicate]([PermitationID]) ON [dbo].[_zzMaterializedPermitations]
    WITH (STATE = ON);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '416b0413-8096-4926-a750-312814405a6e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('416b0413-8096-4926-a750-312814405a6e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ed2f232c-6916-4436-92c4-cf74c7c02ff7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ed2f232c-6916-4436-92c4-cf74c7c02ff7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ba776e5d-6578-4e6c-8891-531edd256702')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ba776e5d-6578-4e6c-8891-531edd256702')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'dd5762a0-d470-478b-aa3c-97a4553c6680')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('dd5762a0-d470-478b-aa3c-97a4553c6680')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '01892d63-2f82-405f-b8ff-2f388c3ddae7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('01892d63-2f82-405f-b8ff-2f388c3ddae7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ccbd140f-658a-4fc5-b819-2ab7b52c5905')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ccbd140f-658a-4fc5-b819-2ab7b52c5905')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bcb68d36-2e41-41a0-83f6-5d8d31e5a986')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bcb68d36-2e41-41a0-83f6-5d8d31e5a986')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'aa914db2-aaea-4a38-a32d-7d2a779fc51d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('aa914db2-aaea-4a38-a32d-7d2a779fc51d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9abecc7a-f214-4da0-b728-dec52d12bb91')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9abecc7a-f214-4da0-b728-dec52d12bb91')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '18f6a075-6998-474d-824b-04b39e1ff645')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('18f6a075-6998-474d-824b-04b39e1ff645')

GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
--SETUP BASE ENUMIRATOR
DECLARE @@A AS TABLE (X INT)
INSERT INTO @@A
SELECT X=1 UNION ALL
SELECT X=2 UNION ALL
SELECT X=3 UNION ALL
SELECT X=4 UNION ALL
SELECT X=5 UNION ALL
SELECT X=6 UNION ALL
SELECT X=7 UNION ALL
SELECT X=8 UNION ALL
SELECT X=9 UNION ALL
SELECT X=10

--CREATE TEMP TABLE
CREATE TABLE #SEED
(
RIDX BIGINT NOT NULL
,UID UNIQUEIDENTIFIER DEFAULT(NEWID())
)

--GENERATE 10,000,000 ROWS
INSERT INTO #SEED (RIDX)
SELECT RIDX=ROW_NUMBER() OVER (ORDER BY X) FROM
(
SELECT A.X 
			FROM @@A A --10
			CROSS JOIN @@A B --100
			CROSS JOIN @@A C --1000
			CROSS JOIN @@A D --10000
			CROSS JOIN @@A E --100000
			CROSS JOIN @@A F --1000000
			CROSS JOIN @@A G --10000000
		--	CROSS JOIN @@A H
) XX


INSERT INTO ZZSEQUENCE
SELECT * 
FROM #SEED

--CLEAN UP
DROP TABLE #SEED
GO
--DISABLE FILTER POLICY
ALTER SECURITY POLICY [dbo].[PermitationID_Policy] WITH (STATE = OFF)
GO
/****** Object:  Index [IX_RIDX]    Script Date: 01/03/2019 22:42:48 ******/
DROP INDEX [IX_RIDX] ON [dbo].[_zzMaterializedPermitations] WITH ( ONLINE = OFF )
GO

TRUNCATE TABLE _zzMaterializedPermitations
GO
--BUILD Permutation Attribution
INSERT INTO _zzMaterializedPermitations (RIDX,[UID],FK_A,FK_B,FK_X,FK_Y)
SELECT  TOP (1000000) [RIDX]
      ,[UID]
	  ,FK_A = ABS(CONVERT(BIGINT,HASHBYTES('SHA1',CONVERT(VARCHAR(50),[UID])))%20)+1
	  ,FK_B=CONVERT(INT,(RAND(ABS(CONVERT(BIGINT,HASHBYTES('SHA1',CONVERT(VARCHAR(50),NEWID())))%10)+1)*100000))%10+1
	  ,FK_X=CONVERT(INT,(RAND(ABS(CONVERT(BIGINT,HASHBYTES('SHA1',CONVERT(VARCHAR(50),NEWID())))%150)+1)*100000))%10+1
	  ,FK_Y=CONVERT(INT,(RAND(ABS(CONVERT(BIGINT,HASHBYTES('SHA1',CONVERT(VARCHAR(50),NEWID())))%150)+1)*100000))%10+1
   
FROM [dbo].[zzSequence]
GO

/****** Object:  Index [IX_RIDX]    Script Date: 01/03/2019 22:42:48 ******/
CREATE UNIQUE CLUSTERED INDEX [IX_RIDX] ON [dbo].[_zzMaterializedPermitations]
(
	[RIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

--BUILD PERMITATION TABLE
TRUNCATE TABLE Permitations
GO
INSERT INTO Permitations (FK_A,FK_B,FK_X,FK_Y)
SELECT DISTINCT FK_A,FK_B,FK_X,FK_Y
FROM _zzMaterializedPermitations 
ORDER BY 1,2,3,4
GO



--UPDATE PERMITATIONID ON FACT TABLE 
UPDATE MP
SET MP.PermitationID=P.PermitationID
FROM Permitations P
INNER JOIN _zzMaterializedPermitations MP 
ON	P.FK_A=MP.FK_A 
	AND P.FK_B=MP.FK_B 
	AND P.FK_X=MP.FK_X 
	AND P.FK_Y=MP.FK_Y
GO


--INSERT CURRENT USERS DETAILS
TRUNCATE TABLE [Sec].[RlsUser]
GO
INSERT INTO [Sec].[RlsUser]
SELECT [UserName]=SUSER_SNAME()
      ,[SID]=CONVERT(uniqueidentifier,SUSER_SID())
      ,[AB_LNK]=1
      ,[XY_LNK]=1
GO

--INSERT ACCESS CONFIG FOR AB ID 1
TRUNCATE TABLE SEC.RlsUserABLNK
GO
INSERT INTO SEC.RlsUserABLNK(RLSUserID,ABLNKID)
SELECT TOP 1 RlsUserID,1 
FROM SEC.RlsUser
GO

--GRANT ACCESS
EXEC [Sec].[REBUILD_PermiratedUserLink]


--DEPLOYMENT DONE
--DISABLE FILTER POLICY
ALTER SECURITY POLICY [dbo].[PermitationID_Policy] WITH (STATE = OFF)
GO
--SELECT WITHOUT FILTER
SELECT UN_FILTERED_COUNT=COUNT(1) FROM _zzMaterializedPermitations
GO

--ENABLE SECURITY POLICY
ALTER SECURITY POLICY [dbo].[PermitationID_Policy] WITH (STATE = ON)
GO
--SELECT WITH FILTER
SELECT FILTERED_COUNT=COUNT(1) FROM _zzMaterializedPermitations

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
