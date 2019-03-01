CREATE TABLE [Sec].[PermiratedUserLink] (
    [RLSUserID]     INT NOT NULL,
    [PermitationID] INT NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_RLS_PERMITATION]
    ON [Sec].[PermiratedUserLink]([RLSUserID] ASC, [PermitationID] ASC) WITH (FILLFACTOR = 100);

