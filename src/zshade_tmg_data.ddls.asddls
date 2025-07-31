@AbapCatalog.sqlViewName: 'ZSHADEDATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shade tmg data'
@Metadata.ignorePropagatedAnnotations: true
define view ZSHADE_TMG_DATA as select from zshade_tmg_tab
{
    key plant as Plant,
    key department as Department,
    key shade as Shade
}
