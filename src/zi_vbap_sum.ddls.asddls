@AbapCatalog.sqlViewName: 'ZCV_VBAP_SUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VBAP SUM'
define view ZI_VBAP_SUM
  as select from ZI_VBAP
{
  key vbeln,
      sum(ORDERSUM) as ORDERSUM
}
group by
  vbeln
