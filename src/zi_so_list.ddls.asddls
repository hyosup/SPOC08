@AbapCatalog.sqlViewName: 'ZCV_SO_LIST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD 장기 미결 오더 리스트'
@OData.entitySet.name: 'SOData'
@OData.publish: true
define view ZI_SO_LIST
  as select from    vbak
    inner join      ZI_VBAP_SUM as _VBAP on vbak.vbeln = _VBAP.vbeln
    left outer join vbuk                 on vbak.vbeln = vbuk.vbeln
    left outer join kna1        as N1    on vbak.kunnr = N1.kunnr
    left outer join kna1        as N2    on vbak.knkli = N2.kunnr
{
         // VBAK
         @EndUserText: { label: '판매오더번호', quickInfo: '판매오더번호' }
  key    vbak.vbeln,
         @EndUserText: { label: '생성일', quickInfo: '생성일' }
         vbak.audat,
         @EndUserText: { label: '유형', quickInfo: '유형' }
         vbak.auart,
         @EndUserText: { label: '영업조직', quickInfo: '영업조직' }
         vbak.vkorg,
         @EndUserText: { label: '유통경로', quickInfo: '유통경로' }
         vbak.vtweg,
         @EndUserText: { label: '제품군', quickInfo: '제품군' }
         vbak.spart,
         @EndUserText: { label: '사업장', quickInfo: '사업장' }
         vbak.vkbur,
         @EndUserText: { label: '영업그룹', quickInfo: '영업그룹' }
         vbak.vkgrp,
         @EndUserText: { label: '생성자 ', quickInfo: '생성자' }
         vbak.ernam,
         @EndUserText: { label: '판매처 ', quickInfo: '판매처' }
         vbak.kunnr,
         @EndUserText: { label: '여신계정 ', quickInfo: '여신계정' }
         vbak.knkli,
         @EndUserText: { label: '리스크 ', quickInfo: '리스크' }
         vbak.ctlpc,
         @EndUserText: { label: '화폐 ', quickInfo: '화폐' }
         vbak.waerk,

         // VBUK
         @EndUserText: { label: '거절 ', quickInfo: '거절' }
         vbuk.abstk,
         @EndUserText: { label: '여신 ', quickInfo: '여신' }
         vbuk.cmpsa,
         @EndUserText: { label: '납품 ', quickInfo: '납품' }
         vbuk.lfstk,

         // NAME
         @EndUserText: { label: '판매처명 ', quickInfo: '판매처명' }
         N1.name1 as KUNNR_NM,
         @EndUserText: { label: '여신계정명 ', quickInfo: '여신계정명' }
         N2.name1 as KNKLI_NM,

         // 기타
         @EndUserText: { label: '오더금액 ', quickInfo: '오더금액' }
         _VBAP.ORDERSUM
         //         @EndUserText: { label: '여신한도 ', quickInfo: '여신한도' }
         //         @EndUserText: { label: '여신잔액 ', quickInfo: '여신잔액' }
         //         @EndUserText: { label: '사용율 ', quickInfo: '사용율' }
         //         @EndUserText: { label: '여신사용액 ', quickInfo: '여신사용액' }
         //         @EndUserText: { label: '총채권 ', quickInfo: '총채권' }
         //         @EndUserText: { label: '미결오더 ', quickInfo: '미결오더' }
         //         @EndUserText: { label: '미결납품 ', quickInfo: '미결납품' }
}
