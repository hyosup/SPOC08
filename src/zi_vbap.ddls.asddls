@AbapCatalog.sqlViewName: 'ZCV_VBAP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VBAP'
define view ZI_VBAP
  as select from vbap
{
  key vbeln,
  key posnr,
      ( cmpre ) * ( kbmeng ) as ORDERSUM
}
where
  abgru is not null
