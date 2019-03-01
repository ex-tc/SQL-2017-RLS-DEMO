CREATE TABLE [Sec].[RlsUser] (
    [RlsUserID]      INT  IDENTITY(1,1)            NOT NULL,
    [UserName]       NVARCHAR (128)   NULL,
    [SID]            UNIQUEIDENTIFIER NULL,
    [AB_LNK] INT              NOT NULL,
    [XY_LNK]    INT              NOT NULL, 
    CONSTRAINT [PK_RlsUser] PRIMARY KEY ([RlsUserID])
);

