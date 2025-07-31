@AbapCatalog.sqlViewName: 'YSDFMDSML'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDYESF4'
@Metadata.ignorePropagatedAnnotations: true
define view ZDYES_F4 as select from zdyes_and_che
{
     key slipno,
     key beamno     
}
where deletionflag = ''
