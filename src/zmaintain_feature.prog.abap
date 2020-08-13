*&---------------------------------------------------------------------*
*& Report zmaintain_feature
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmaintain_feature.

TYPE-POOLS:slis.

************************************************************************
* Internal Table
************************************************************************
DATA: gi_zfeature TYPE TABLE OF zfeature.

*** ALV ***
DATA: gi_fieldcat TYPE slis_t_fieldcat_alv.

************************************************************************
* Structure
************************************************************************
FIELD-SYMBOLS: <fs_zfeature> LIKE LINE OF gi_zfeature.

*** ALV ***
DATA: gw_layout   TYPE slis_layout_alv.
DATA: gw_variant  TYPE disvariant.
DATA: gw_fieldcat TYPE slis_fieldcat_alv.

************************************************************************
* Variable
************************************************************************
DATA: v_feature TYPE zfeature-feature.



************************************************************************
* Screen
************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-t01.
SELECT-OPTIONS     s_feat FOR v_feature.
SELECTION-SCREEN END OF BLOCK b01.

************************************************************************
* Initial Process
************************************************************************
INITIALIZATION.
  CLEAR: gi_zfeature.

************************************************************************
* Main Process
************************************************************************
START-OF-SELECTION.
  PERFORM get_data.
  PERFORM edit_data.
  PERFORM set_variant.
  PERFORM set_layout.
  PERFORM get_fieldcatalog.
  PERFORM output_alv.

************************************************************************
* GET_DATA
************************************************************************
FORM get_data.

  IF s_feat IS INITIAL.
    SELECT * INTO TABLE gi_zfeature
        FROM zfeature
      .
  ELSE.

    SELECT * INTO TABLE gi_zfeature
      FROM zfeature
     WHERE feature = s_feat.
  ENDIF.
ENDFORM.

************************************************************************
* EDIT_DATA
************************************************************************
FORM edit_data.

  LOOP AT gi_zfeature ASSIGNING <fs_zfeature>.
****** If you need edit to internal table, please write here　******
  ENDLOOP.

ENDFORM.

************************************************************************
* SET_VARIANT
************************************************************************
FORM set_variant.

  gw_variant-report    = sy-cprog.
**  IT_VARIANT-HANDLE    =
**  IT_VARIANT-LOG_GROUP  =
  gw_variant-username  = sy-uname.
**  IT_VARIANT-VARIANT   =
**  IT_VARIANT-TEXT      =
**  IT_VARIANT-DEPENDVARS =

ENDFORM.

************************************************************************
* SET_LAYOUT
************************************************************************
FORM set_layout.

  gw_layout-zebra  = 'X'.
  gw_layout-colwidth_optimize = 'X'.
  gw_layout-window_titlebar   = sy-title.
**  GW_LAYOUT-no_colhead =
**  GW_LAYOUT-no_hotspot =
**  GW_LAYOUT-no_vline =
**  GW_LAYOUT-no_hline =
**  GW_LAYOUT-cell_merge =
*  GW_LAYOUT-edit = abap_true.
**  GW_LAYOUT-edit_mode =
**  GW_LAYOUT-numc_sum =
**  GW_LAYOUT-no_input =
**  GW_LAYOUT-f2code =
**  GW_LAYOUT-reprep =
**  GW_LAYOUT-no_keyfix =
**  GW_LAYOUT-expand_all =
**  GW_LAYOUT-no_author =
**  GW_LAYOUT-def_status =
**  GW_LAYOUT-item_text =
**  GW_LAYOUT-countfname =
**  GW_LAYOUT-colwidth_optimize =
**  GW_LAYOUT-no_min_linesize =
**  GW_LAYOUT-min_linesize =
**  GW_LAYOUT-max_linesize =
**  GW_LAYOUT-window_titlebar =
**  GW_LAYOUT-no_uline_hs =
**  GW_LAYOUT-lights_fieldname =
**  GW_LAYOUT-lights_tabname =
**  GW_LAYOUT-lights_rollname =
**  GW_LAYOUT-lights_condense =
**  GW_LAYOUT-no_sumchoice =
**  GW_LAYOUT-no_totalline =
**  GW_LAYOUT-no_subchoice =
**  GW_LAYOUT-no_subtotals =
**  GW_LAYOUT-no_unit_splitting =
**  GW_LAYOUT-totals_before_items =
**  GW_LAYOUT-totals_only =
**  GW_LAYOUT-totals_text =
**  GW_LAYOUT-subtotals_text =
**  GW_LAYOUT-box_fieldname =
**  GW_LAYOUT-box_tabname =
**  GW_LAYOUT-box_rollname =
**  GW_LAYOUT-expand_fieldname =
**  GW_LAYOUT-hotspot_fieldname =
**  GW_LAYOUT-confirmation_prompt =
**  GW_LAYOUT-key_hotspot =
**  GW_LAYOUT-flexible_key =
**  GW_LAYOUT-group_buttons =
**  GW_LAYOUT-get_selinfos =
**  GW_LAYOUT-group_change_edit =
**  GW_LAYOUT-no_scrolling =
**  GW_LAYOUT-detail_popup =
**  GW_LAYOUT-detail_initial_lines =
**  GW_LAYOUT-detail_titlebar =
**  GW_LAYOUT-header_text =
**  GW_LAYOUT-default_item =
**  GW_LAYOUT-info_fieldname =
**  GW_LAYOUT-coltab_fieldname =
**  GW_LAYOUT-list_append =
**  GW_LAYOUT-xifunckey =
**  GW_LAYOUT-xidirect =
**  GW_LAYOUT-dtc_layout =

ENDFORM.

************************************************************************
* GET_FIELDCATALOG
************************************************************************
FORM get_fieldcatalog.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name   = sy-repid
*     i_internal_tabname =
      i_structure_name = 'zfeature'
*     I_CLIENT_NEVER_DISPLAY       = 'X'
*     I_INCLNAME       =
*     I_BYPASSING_BUFFER =
*     I_BUFFER_ACTIVE  =
    CHANGING
      ct_fieldcat      = gi_fieldcat
* EXCEPTIONS
*     INCONSISTENT_INTERFACE       = 1
*     PROGRAM_ERROR    = 2
*     OTHERS           = 3
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.

************************************************************************
* OUTPUT_ALV
************************************************************************
FORM output_alv.


  LOOP AT gi_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).
    CASE sy-tabix.
      WHEN 1.
        <fs_fieldcat>-seltext_l = 'Feature'.
        <fs_fieldcat>-seltext_s = 'Feature'.
        <fs_fieldcat>-seltext_m = 'Feature'.
      WHEN 2.
        <fs_fieldcat>-seltext_l = 'Description'.
        <fs_fieldcat>-seltext_s = 'Description'.
        <fs_fieldcat>-seltext_m = 'Description'.
        <fs_fieldcat>-text_fieldname = 'Description'.
      WHEN 3.
        <fs_fieldcat>-seltext_l = 'Auth Object'.
        <fs_fieldcat>-seltext_s = 'Auth Object'.
        <fs_fieldcat>-seltext_m = 'Auth Object'.

    ENDCASE.
    IF sy-tabix = 4.
      <fs_fieldcat>-edit = abap_true.
      <fs_fieldcat>-checkbox = abap_true.
      <fs_fieldcat>-seltext_l = 'Enabled'.
      <fs_fieldcat>-seltext_s = 'Enabled'.
      <fs_fieldcat>-seltext_m = 'Enabled'.

    ENDIF.
  ENDLOOP.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gw_layout
      it_fieldcat        = gi_fieldcat
      is_variant         = gw_variant
    TABLES
      t_outtab           = gi_zfeature
* EXCEPTIONS
*     PROGRAM_ERROR      = 1
*     OTHERS             = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
