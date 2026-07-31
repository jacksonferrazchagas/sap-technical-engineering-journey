CLASS zcl_hsm_hello DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_hsm_hello IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( 'Hamilton Steel Manufacturing' ).
    out->write( 'SAP Data, Integration and Finance Project' ).
    out->write( 'Sprint 1 - ABAP environment validated successfully' ).

  ENDMETHOD.

ENDCLASS.
