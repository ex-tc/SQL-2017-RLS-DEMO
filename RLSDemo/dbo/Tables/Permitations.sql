CREATE TABLE [dbo].[Permitations] (
    [PermitationID]                      INT    IDENTITY (1, 1) NOT NULL,
    [FK_A]         INT NULL,
    [FK_B]       INT    NULL,
    [FK_X]     INT    NULL,
    [FK_Y] INT    NULL,
    CONSTRAINT [PK_Permitations] PRIMARY KEY CLUSTERED ([PermitationID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20190228-213240]
    ON [dbo].[Permitations]([FK_A] ASC, [FK_B] ASC, [FK_X] ASC, [FK_Y] ASC);

