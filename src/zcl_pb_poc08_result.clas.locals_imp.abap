CLASS lhc_zi_poc08_result DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_poc08_result RESULT result.

    METHODS reject_all FOR MODIFY
      IMPORTING keys FOR ACTION zi_poc08_result~reject_all.

    METHODS re_pricing FOR MODIFY
      IMPORTING keys FOR ACTION zi_poc08_result~re_pricing.

ENDCLASS.

CLASS lhc_zi_poc08_result IMPLEMENTATION.

  METHOD read.
  ENDMETHOD.

  METHOD reject_all.
    LOOP AT keys INTO DATA(ls_key).
      zcl_poc08_result=>do_reject_all(
        EXPORTING
          iv_vbeln    = ls_key-vbeln
          is_param    = ls_key-%param
        RECEIVING
          rt_bapiret2 = DATA(lt_bapiret2)
      ).
      LOOP AT lt_bapiret2 INTO DATA(ls_bapiret2).
        APPEND VALUE #(
          %tky = ls_key-%tky
          vbeln = ls_key-vbeln
          auart = ls_key-auart
          audat = ls_key-audat
          %msg = me->new_message(
                   id       = ls_bapiret2-id
                   number   = ls_bapiret2-number
                   severity = CONV #( ls_bapiret2-type )
                   v1       = ls_bapiret2-message_v1
                   v2       = ls_bapiret2-message_v2
                   v3       = ls_bapiret2-message_v3
                   v4       = ls_bapiret2-message_v4
                 )
        ) TO reported-zi_poc08_result.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD re_pricing.
    LOOP AT keys INTO DATA(ls_key).
      zcl_poc08_result=>do_re_pricing(
        EXPORTING
          iv_vbeln    = ls_key-vbeln
          is_param    = ls_key-%param
        RECEIVING
          rt_bapiret2 = DATA(lt_bapiret2)
      ).
      LOOP AT lt_bapiret2 INTO DATA(ls_bapiret2).
        APPEND VALUE #(
          %tky = ls_key-%tky
          vbeln = ls_key-vbeln
          auart = ls_key-auart
          audat = ls_key-audat
          %msg = me->new_message(
                   id       = ls_bapiret2-id
                   number   = ls_bapiret2-number
                   severity = CONV #( ls_bapiret2-type )
                   v1       = ls_bapiret2-message_v1
                   v2       = ls_bapiret2-message_v2
                   v3       = ls_bapiret2-message_v3
                   v4       = ls_bapiret2-message_v4
                 )
        ) TO reported-zi_poc08_result.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_poc08_result DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_poc08_result IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
