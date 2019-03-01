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