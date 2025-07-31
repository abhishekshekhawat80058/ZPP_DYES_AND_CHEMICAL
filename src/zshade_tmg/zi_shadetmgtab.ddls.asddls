@EndUserText.label: 'Shade tmg tab'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_ShadeTmgTab
  as select from zshade_tmg_tab
  association to parent ZI_ShadeTmgTab_S as _ShadeTmgTabAll on $projection.SingletonID = _ShadeTmgTabAll.SingletonID
{
  key plant as Plant,
  key department as Department,
  key shade as Shade,
  @Consumption.hidden: true
  1 as SingletonID,
  _ShadeTmgTabAll
  
}
