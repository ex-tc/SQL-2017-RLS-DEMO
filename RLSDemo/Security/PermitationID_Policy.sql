CREATE SECURITY POLICY [dbo].[PermitationID_Policy]
    ADD FILTER PREDICATE [SEC].[fn_securitypredicate]([PermitationID]) ON [dbo].[_zzMaterializedPermitations]
    WITH (STATE = ON);

