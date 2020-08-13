*"* use this source file for your ABAP unit test classes

*"* use this source file for your ABAP unit test classes

CLASS ltc_check_feature_switch DEFINITION FOR TESTING
    RISK LEVEL HARMLESS
    DURATION SHORT.

  PRIVATE SECTION.
    DATA: m_cut TYPE REF TO zcl_feature_switch.
    METHODS setup.
    METHODS switch1_enabled FOR TESTING RAISING cx_static_check.
    METHODS switch2_disabled FOR TESTING RAISING cx_static_check.
    METHODS switch4_global FOR TESTING RAISING cx_static_check.
    METHODS switch3_not_found FOR TESTING RAISING cx_static_check.
    METHODS switch999_exception FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_check_feature_switch IMPLEMENTATION.
  METHOD setup.
    "given
    m_cut = NEW zcl_feature_switch(  ).
  ENDMETHOD.
  METHOD switch1_enabled.

    "when
    DATA(lv_enabled) = m_cut->check_switch( iv_feature = 'SWITCH1' ).
    "when
    cl_abap_unit_assert=>assert_equals( act = lv_enabled
                                        exp = abap_true ).

  ENDMETHOD.

  METHOD switch2_disabled.

    "when
    DATA(lv_enabled) = m_cut->check_switch( iv_feature = 'SWITCH2' ).
    "when
    cl_abap_unit_assert=>assert_equals( act = lv_enabled
                                        exp = abap_false ).

  ENDMETHOD.

  METHOD switch3_not_found.
     DATA l_exception_occured TYPE abap_bool VALUE abap_false.

    "when
    "when
    DATA(lv_enabled) = m_cut->check_switch( iv_feature = 'SWITCH3' ).
    "when
    cl_abap_unit_assert=>assert_equals( act = lv_enabled
                                        exp = abap_false ).


  ENDMETHOD.

  METHOD switch4_global.
     DATA l_exception_occured TYPE abap_bool VALUE abap_false.

    "when
    DATA(lv_enabled) = m_cut->check_switch( iv_feature = 'SWITCH4' ).
    "when
    cl_abap_unit_assert=>assert_equals( act = lv_enabled
                                        exp = abap_true ).

  ENDMETHOD.

  METHOD switch999_exception.
     DATA l_exception_occured TYPE abap_bool VALUE abap_false.

    "when
    TRY.
    DATA(lv_enabled) = m_cut->check_switch( iv_feature = 'SWITCH999' ).
    cl_abap_unit_assert=>fail( 'Exception did not occur as expected' ).

    CATCH zcx_feature_switch.
                   l_exception_occured = abap_true.

    ENDTRY.
    "when
        cl_abap_unit_assert=>assert_true(
          act = l_exception_occured
          msg = 'Exception did not occur as expected'
        ).

  ENDMETHOD.



ENDCLASS.
