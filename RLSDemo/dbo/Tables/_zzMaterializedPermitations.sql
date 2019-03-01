CREATE TABLE [dbo].[_zzMaterializedPermitations] (
    [RIDX]                               BIGINT           NOT NULL,
    [UID]                                UNIQUEIDENTIFIER NULL,
    [FK_A]         INT           NULL,
    [FK_B]       INT              NULL,
    [FK_X]     INT              NULL,
    [FK_Y] INT              NULL,
    [PermitationID]                      INT              DEFAULT ((-1)) NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_NC_PermitationID]
    ON [dbo].[_zzMaterializedPermitations]([PermitationID] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_NC_Suplimentary]
    ON [dbo].[_zzMaterializedPermitations]([FK_A] ASC, [FK_B] ASC, [FK_X] ASC, [FK_Y] ASC);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_RIDX]
    ON [dbo].[_zzMaterializedPermitations]([RIDX] ASC);

