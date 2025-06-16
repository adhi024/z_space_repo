CLASS zcx_product_not_found DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    METHODS constructor
      IMPORTING
        textid LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL.

ENDCLASS.


CLASS ZCX_PRODUCT_NOT_FOUND IMPLEMENTATION.

  METHOD constructor.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->if_t100_message~t100key = textid.
  ENDMETHOD.

ENDCLASS.
