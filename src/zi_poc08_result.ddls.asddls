@EndUserText.label: 'ZI_POC08_RESULT'
@Metadata.allowExtensions: true
@ObjectModel.query.implementedBy: 'ABAP:ZCL_POC08_RESULT'
define root custom entity ZI_POC08_RESULT
{
      @UI.lineItem        : [{ type: #FOR_ACTION, dataAction: 're_pricing', label: 'Re Pricing' },
                             { type: #FOR_ACTION, dataAction: 'reject_all', label: 'Reject All' }]

      @UI.lineItem        : [{ position: 10 }]
      @UI.selectionField  : [{ position: 90 }]
  key audat               : audat;
      @UI.lineItem        : [{ position: 20 }]
      @UI.selectionField  : [{ position: 10 }]
  key auart               : auart;
      @UI.lineItem        : [{ position: 30 }]
      @UI.selectionField  : [{ position: 130 }]
  key vbeln               : vbeln_va;
      @UI.lineItem        : [{ position: 40 }]
      @UI.selectionField  : [{ position: 20 }]
      vkorg               : vkorg;
      @UI.lineItem        : [{ position: 50 }]
      @UI.selectionField  : [{ position: 30 }]
      vtweg               : vtweg;
      @UI.lineItem        : [{ position: 60 }]
      @UI.selectionField  : [{ position: 40 }]
      spart               : spart;
      @UI.lineItem        : [{ position: 70 }]
      @UI.selectionField  : [{ position: 50 }]
      vkbur               : vkbur;
      @UI.lineItem        : [{ position: 80 }]
      @UI.selectionField  : [{ position: 60 }]
      vkgrp               : vkgrp;
      @UI.lineItem        : [{ position: 90 }]
      @UI.selectionField  : [{ position: 100 }]
      abstk               : abstk;
      @UI.lineItem        : [{ position: 100 }]
      @UI.selectionField  : [{ position: 110 }]
      cmpsa               : cmpsa;
      @UI.lineItem        : [{ position: 110 }]
      @UI.selectionField  : [{ position: 120 }]
      lfstk               : lfstk;
      @UI.lineItem        : [{ position: 120 }]
      ernam               : ernam;
      @UI.lineItem        : [{ position: 130 }]
      @UI.selectionField  : [{ position: 70 }]
      kunnr               : kunag;
      @UI.lineItem        : [{ position: 140 }]
      kunnr_txt           : zepoc08_kunnr_txt;
      @UI.lineItem        : [{ position: 150 }]
      knkli               : knkli;
      @UI.lineItem        : [{ position: 160 }]
      knkli_txt           : zepoc08_knkli_txt;
      @UI.lineItem        : [{ position: 170 }]
      @UI.selectionField  : [{ position: 80 }]
      ctlpc               : ctlpc_cm;
      @UI.lineItem        : [{ position: 180 }]
      waerk               : waerk;
      @UI.lineItem        : [{ position: 190 }]
      @Semantics.amount.currencyCode : 'waerk'
      value               : zepoc08_value;
      @UI.lineItem        : [{ position: 200 }]
      cashc               : cashc;
      @UI.lineItem        : [{ position: 210 }]
      @Semantics.amount.currencyCode : 'cashc'
      klimk               : klimk;
      @UI.lineItem        : [{ position: 220 }]
      @Semantics.amount.currencyCode : 'cashc'
      credit_limit_left   : zepoc08_credit_limit_left;
      @UI.lineItem        : [{ position: 230 }]
      credit_limit_used   : zepoc08_credit_limit_used;
      @UI.lineItem        : [{ position: 240 }]
      @Semantics.amount.currencyCode : 'waerk'
      ssobl               : ssobl;
      @UI.lineItem        : [{ position: 250 }]
      @Semantics.amount.currencyCode : 'waerk'
      credit_exposure     : zepoc08_credit_exposure;
      @UI.lineItem        : [{ position: 260 }]
      @Semantics.amount.currencyCode : 'waerk'
      skfor               : skfor;
      @UI.lineItem        : [{ position: 270 }]
      @Semantics.amount.currencyCode : 'waerk'
      open_orders         : zepoc08_open_orders;
      @UI.lineItem        : [{ position: 280 }]
      @Semantics.amount.currencyCode : 'waerk'
      open_delivery       : zepoc08_open_delivery;
      @UI.lineItem        : [{ position: 290 , exclude: true }]
      @UI.selectionField  : [{ position: 140 }]
      no_zero_order_value : zepoc08_no_zero_order_value;
      @UI.hidden: true
      kkber : kkber;
}
