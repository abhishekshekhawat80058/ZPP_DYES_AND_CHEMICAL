@EndUserText.label: 'Tmg For Process Issue Slip Master Table'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_TmgForProcessIssueS
  as select from ZPROCESS_ISSUE
  association to parent ZI_TmgForProcessIssueS_S as _TmgForProcessIssAll on $projection.SingletonID = _TmgForProcessIssAll.SingletonID
{
  key MACHINEGROUP as Machinegroup,
  key PROCESS_NAME as ProcessName,
  key MATHOD as Mathod,
  key PLANT as Plant,
  key MACHINE_NAME as MachineName,
  MANDI as Mandi,
  @Semantics.user.createdBy: true
  CREATED_BY as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  @Consumption.hidden: true
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  @Consumption.hidden: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Consumption.hidden: true
  1 as SingletonID,
  _TmgForProcessIssAll
  
}
