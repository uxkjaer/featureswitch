class ZCL_FEATURE_SWITCH definition
  public
  final
  create public .

public section.

  class-methods CHECK_SWITCH
    importing
      !IV_FEATURE type CHAR20
      !IV_AUTH_OBJ type XUOBJECT default 'ZFEATURE'
    returning
      value(EV_ENABLED) type BOOLEAN
    raising
      ZCX_FEATURE_SWITCH .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FEATURE_SWITCH IMPLEMENTATION.


  METHOD check_switch.

    SELECT SINGLE * FROM zfeature INTO @DATA(ls_feature) WHERE feature = @iv_feature.

    IF sy-subrc = 4.
      RAISE EXCEPTION TYPE zcx_feature_switch.

    ELSEIF ls_feature-enabled = abap_false. "Feature switch is turned off
      ev_enabled = abap_false.
      RETURN.
    ENDIF.

* Now check if the user has the assigned auth object.
    SELECT SINGLE usr~AGR_NAME
        INTO @DATA(lv_agr)
        FROM AGR_USERS AS USR
        INNER JOIN AGR_1251 AS VAL
        ON usr~agr_name = val~agr_name
        WHERE UNAME = @sy-uname
        AND DELETED = ''
        AND val~low = @iv_feature
        AND from_dat <= @sy-datum
        AND to_dat >= @sy-datum.


    IF sy-subrc = 4.
* Check if there are any user whos got the auth object
      SELECT SINGLE AGR_NAME INTO lv_agr FROM agr_1251 WHERE low = iv_feature AND deleted = ''.
      IF sy-subrc = 0. " Auth value is still active in a role.
        ev_enabled = abap_false.
        RETURN.
      ELSE.
        ev_enabled = abap_true.
        RETURN.
      ENDIF.
    ELSE. " The values are present on the user
        ev_enabled = abap_true.
        RETURN.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
