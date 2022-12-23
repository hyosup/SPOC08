class ZCL_POC08_RESULT definition
  public
  final
  create public .

public section.

  interfaces IF_RAP_QUERY_PROVIDER .

  class-methods DO_RE_PRICING
    importing
      !IV_VBELN type VBAK-VBELN
      !IS_PARAM type ZSPOC08_RE_PRICING
    returning
      value(RT_BAPIRET2) type BAPIRET2_TT .
  class-methods DO_REJECT_ALL
    importing
      !IV_VBELN type VBAK-VBELN
      !IS_PARAM type ZSPOC08_REJECT_ALL
    returning
      value(RT_BAPIRET2) type BAPIRET2_TT .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_POC08_RESULT IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA: lt_vbak                TYPE TABLE OF vbak,
          ls_vbak                TYPE vbak,
          lt_vbuk                TYPE TABLE OF vbuk,
          lt_result              TYPE TABLE OF zi_poc08_result,
          ls_result              TYPE zi_poc08_result,
          lt_range               TYPE if_rap_query_filter=>tt_name_range_pairs,
          ls_range               TYPE if_rap_query_filter=>ty_name_range_pairs,
          lt_range_auart         TYPE RANGE OF vbak-auart,
          lt_range_vkorg         TYPE RANGE OF vbak-vkorg,
          lt_range_vtweg         TYPE RANGE OF vbak-vtweg,
          lt_range_spart         TYPE RANGE OF vbak-spart,
          lt_range_vkbur         TYPE RANGE OF vbak-vkbur,
          lt_range_vkgrp         TYPE RANGE OF vbak-vkgrp,
          lt_range_kunnr         TYPE RANGE OF vbak-kunnr,
          lt_range_ctlpc         TYPE RANGE OF vbak-ctlpc,
          lt_range_audat         TYPE RANGE OF vbak-audat,
          lt_range_abstk         TYPE RANGE OF vbuk-abstk,
          lt_range_cmpsa         TYPE RANGE OF vbuk-cmpsa,
          lt_range_lfstk         TYPE RANGE OF vbuk-lfstk,
          lt_range_vbeln         TYPE RANGE OF vbak-vbeln,
          lv_no_zero_order_value TYPE zi_poc08_result-no_zero_order_value,
          BEGIN OF ls_kna1,
            kunnr TYPE kna1-kunnr,
            name1 TYPE kna1-name1,
          END OF ls_kna1,
          lt_kna1  LIKE TABLE OF ls_kna1,
          lv_top   TYPE int8,
          lv_skip  TYPE int8,
          lv_count TYPE int8.

    IF io_request->is_data_requested( ).
      lv_top = io_request->get_paging( )->get_page_size( ).
      lv_skip = io_request->get_paging( )->get_offset( ).


      TRY.
          lt_range = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range. " RAP query filter is too complex to be converted to a range.
      ENDTRY.
      LOOP AT lt_range INTO ls_range.
        CASE ls_range-name.
          WHEN 'AUART'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_auart.
          WHEN 'VKORG'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_vkorg.
          WHEN 'VTWEG'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_vtweg.
          WHEN 'SPART'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_spart.
          WHEN 'VKBUR'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_vkbur.
          WHEN 'VKGRP'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_vkgrp.
          WHEN 'KUNNR'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_kunnr.
          WHEN 'CTLPC'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_ctlpc.
          WHEN 'AUDAT'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_audat.
          WHEN 'ABSTK'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_abstk.
          WHEN 'CMPSA'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_cmpsa.
          WHEN 'LFSTK'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_lfstk.
          WHEN 'VBELN'.
            MOVE-CORRESPONDING ls_range-range TO lt_range_vbeln.
          WHEN 'NO_ZERO_ORDER_VALUE'.
            IF ls_range-range IS NOT INITIAL.
              lv_no_zero_order_value = ls_range-range[ 1 ]-low.
            ENDIF.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.


      SELECT a~audat, a~auart, a~vbeln, a~vkorg, a~vtweg,
             a~spart, a~vkbur, a~vkgrp, u~abstk, u~cmpsa,
             u~lfstk, a~ernam, a~kunnr, a~knkli, a~ctlpc,
             a~waerk, a~kkber
        FROM vbak AS a
        LEFT OUTER JOIN vbuk AS u
          ON a~vbeln = u~vbeln
        WHERE a~auart IN @lt_range_auart
          AND a~vkorg IN @lt_range_vkorg
          AND a~vtweg IN @lt_range_vtweg
          AND a~spart IN @lt_range_spart
          AND a~vkbur IN @lt_range_vkbur
          AND a~vkgrp IN @lt_range_vkgrp
          AND a~kunnr IN @lt_range_kunnr
          AND a~ctlpc IN @lt_range_ctlpc
          AND a~audat IN @lt_range_audat
          AND u~abstk IN @lt_range_abstk
          AND u~cmpsa IN @lt_range_cmpsa
          AND u~lfstk IN @lt_range_lfstk
          AND a~vbeln IN @lt_range_vbeln
        ORDER BY a~vbeln
        INTO CORRESPONDING FIELDS OF TABLE @lt_result
        UP TO @lv_top ROWS OFFSET @lv_skip.


      LOOP AT lt_result INTO ls_result WHERE kunnr IS NOT INITIAL OR knkli IS NOT INITIAL.
        IF ls_result-kunnr IS NOT INITIAL.
          ls_kna1-kunnr = ls_result-kunnr.
          APPEND ls_kna1 TO lt_kna1.
        ENDIF.
        IF ls_result-knkli IS NOT INITIAL.
          ls_kna1-kunnr = ls_result-knkli.
          APPEND ls_kna1 TO lt_kna1.
        ENDIF.
      ENDLOOP.

      IF lt_kna1 IS NOT INITIAL.
        SORT lt_kna1 BY kunnr.
        DELETE ADJACENT DUPLICATES FROM lt_kna1 COMPARING kunnr.
        SELECT kunnr, name1
          FROM kna1
          FOR ALL ENTRIES IN @lt_kna1
          WHERE kunnr = @lt_kna1-kunnr
          INTO TABLE @lt_kna1.
        SORT lt_kna1 BY kunnr.
      ENDIF.


      LOOP AT lt_result INTO ls_result.

        IF ls_result-kunnr IS NOT INITIAL.
          READ TABLE lt_kna1 INTO ls_kna1 WITH KEY kunnr = ls_result-kunnr BINARY SEARCH.
          IF sy-subrc EQ 0.
            ls_result-kunnr_txt = ls_kna1-name1.
          ENDIF.
        ENDIF.
        IF ls_result-knkli IS NOT INITIAL.
          READ TABLE lt_kna1 INTO ls_kna1 WITH KEY kunnr = ls_result-knkli BINARY SEARCH.
          IF sy-subrc EQ 0.
            ls_result-knkli_txt = ls_kna1-name1.
          ENDIF.
        ENDIF.

*1) VBAK 레벨의 부가세를 포함한 금액
*- 거절사유가 없는 품목의 여신에 반영되는 단가(CMPRE) 와 누적확정 수량을 가져온다.
*select CMPRE, KBMENG from VBAP where VBELN = 판매오더 번호 and ABGRU NE NULL
*  - 품목의 2개 정보(CMPRE, KBMENG)를  곱하고, 품목의 계산한 그 값을 더한다
        SELECT cmpre, kbmeng
          FROM vbap
          WHERE vbeln = @ls_result-vbeln
            AND abgru <> ''
          INTO TABLE @DATA(lt_vbap).
        IF sy-subrc EQ 0.
          LOOP AT lt_vbap INTO DATA(ls_vbap).
            ls_result-value = ls_result-value + ( ls_vbap-cmpre * ls_vbap-kbmeng ).
          ENDLOOP.
        ENDIF.

*Credit Currency  KNKK or KNKA  CASHC
*WAERS  먼저 KNKK-CASHC
*없으면 KNKA-WAERS
        SELECT SINGLE cashc, klimk, ssobl, skfor
          FROM knkk
          WHERE kkber = @ls_result-kkber
            AND kunnr = @ls_result-knkli
          INTO ( @ls_result-cashc, @ls_result-klimk, @ls_result-ssobl, @ls_result-skfor ).
        IF sy-subrc <> 0.
          SELECT SINGLE waers, klimg
            FROM knka
            WHERE kunnr = @ls_result-kunnr
            INTO ( @ls_result-cashc, @ls_result-klimk ).
        ENDIF.

        IF ls_result-klimk IS NOT INITIAL.
*Credit limit left      여신한도 - 여신사용액
          ls_result-credit_limit_left = ls_result-klimk - ls_result-value.
*Cred.lim.used      여신사용액/여신한도 (예:23.5%)
          ls_result-credit_limit_used = 100 * ls_result-value / ls_result-klimk.
        ENDIF.

*Credit exposure  KNKK  SSOBL 총채권 + 미결오더 + 미결납품 + 특별부채

*Open orders  S066  SUM(OEIKW)  조건 : Where KKBER = VBAK-KKBER and KUNNR = VBAK-KNKLI
        SELECT SINGLE SUM( oeikw )
          FROM s066
          WHERE kkber = @ls_result-kkber
            AND knkli = @ls_result-knkli
          INTO @ls_result-open_orders.

*Open delivery  S067  SUM(OLIKW)  조건 : Where KKBER = VBAK-KKBER and KUNNR = VBAK-KNKLI
        SELECT SINGLE SUM( olikw )
          FROM s067
          WHERE kkber = @ls_result-kkber
            AND knkli = @ls_result-knkli
          INTO @ls_result-open_delivery.

      ENDLOOP.

      IF lv_no_zero_order_value EQ abap_true.
        DELETE lt_result WHERE value = 0.
      ENDIF.

      TRY.
          io_response->set_data( lt_result ).
          lv_count = lines( lt_result ).
          io_response->set_total_number_of_records( lv_count ).
        CATCH cx_rap_query_response_set_twic.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD do_reject_all.
    DATA: ls_order_header_in  TYPE bapisdh1,
          ls_order_header_inx TYPE bapisdh1x,
          lt_order_item_in    TYPE TABLE OF bapisditm,
          ls_order_item_in    TYPE bapisditm,
          lt_order_item_inx   TYPE TABLE OF bapisditmx,
          ls_order_item_inx   TYPE bapisditmx.

* 2) 선택한 판매오더 번호의 품목 중 납품문서가 생성된 품목은 제외해야 한다. VBUP-LFSTA = A 인 것만 대상이 된다.
*    ORDER_ITEM_IN-ITM_NUMBER : 품목번호
*ORDER_ITEM_IN-REASON_REJ : 거절사유 코드
*ORDER_ITEM_INX-ITM_NUMBER : 품목번호
*ORDER_ITEM_INX-UPDATEFLAG : U
*ORDER_ITEM_INX-REASON_REJ : X

    SELECT posnr AS itm_number
      FROM vbup
      WHERE vbeln = @iv_vbeln
        AND lfsta = 'A'
      INTO CORRESPONDING FIELDS OF TABLE @lt_order_item_in.
    CHECK: lt_order_item_in IS NOT INITIAL.

    ls_order_header_inx-updateflag = 'U'.
    LOOP AT lt_order_item_in INTO ls_order_item_in.
      ls_order_item_in-reason_rej = is_param-abgru.
      MODIFY lt_order_item_in FROM ls_order_item_in.

      CLEAR: ls_order_item_inx.
      ls_order_item_inx-itm_number = ls_order_item_in-itm_number.
      ls_order_item_inx-updateflag = 'U'.
      ls_order_item_inx-reason_rej = abap_true.
      APPEND ls_order_item_inx TO lt_order_item_inx.
    ENDLOOP.

    CALL FUNCTION 'BAPI_SALESORDER_CHANGE'
      EXPORTING
        salesdocument    = iv_vbeln
        order_header_inx = ls_order_header_inx
      TABLES
        return           = rt_bapiret2
        order_item_in    = lt_order_item_in
        order_item_inx   = lt_order_item_inx.
  ENDMETHOD.


  METHOD do_re_pricing.
    DATA: ls_order_header_in  TYPE bapisdh1,
          ls_order_header_inx TYPE bapisdh1x.

* 2) 입력 받은 판매오더번호와 가격결정일을 갖고 “BAPI_SALESORDER_CHANGE”를 수행한다.
*  - 입력값
*    SALESDOCUMENT : 판매오더 번호
*    ORDER_HEADER_IN-PRICE_DATE : 입력 받은 가격 결정일
*    ORDER_HEADER_INX-UPDATEFLAG : U
*ORDER_HEADER_INX-PRICE_DATE : X
    ls_order_header_inx-updateflag = 'U'.

    ls_order_header_in-price_date = is_param-prsdt.
    ls_order_header_inx-price_date = abap_true.

    CALL FUNCTION 'BAPI_SALESORDER_CHANGE'
      EXPORTING
        salesdocument    = iv_vbeln
        order_header_in  = ls_order_header_in
        order_header_inx = ls_order_header_inx
      TABLES
        return           = rt_bapiret2.
  ENDMETHOD.
ENDCLASS.
