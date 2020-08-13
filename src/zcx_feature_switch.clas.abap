class ZCX_FEATURE_SWITCH definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  constants:
    begin of ZCX_FEATURE_SWITCH,
      msgid type symsgid value 'ZBC_FEATURE',
      msgno type symsgno value '000',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ZCX_FEATURE_SWITCH .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional .

  methods IF_MESSAGE~GET_TEXT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCX_FEATURE_SWITCH IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_FEATURE_SWITCH .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.


  method IF_MESSAGE~GET_TEXT.
CLEAR result.

  CALL METHOD SUPER->IF_Message~Get_Text
    RECEIVING
      result = result.
  endmethod.
ENDCLASS.
