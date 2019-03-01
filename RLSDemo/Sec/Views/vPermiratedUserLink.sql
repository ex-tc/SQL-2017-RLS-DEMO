

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