CLASS zcl_product_service_run DEFINITION
  PUBLIC
  FINAL
  FOR CREATION
  SECTION PUBLIC.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS ZCL_PRODUCT_SERVICE_RUN IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    " Instantiate the product service implementation.
    DATA(lo_product_service) TYPE REF TO zif_product_service.
    CREATE OBJECT lo_product_service TYPE zcl_product_service_impl.

    " --- Scenario 1: Get all products ---
    out->write( '--- All Available Products ---' ).
    DATA(lt_all_products) = lo_product_service->get_all_products( ).
    LOOP AT lt_all_products INTO DATA(ls_product).
      out->write( |ID: { ls_product-product_id }, Name: { ls_product-product_name }, Price: { ls_product-price } { ls_product-currency }| ).
    ENDLOOP.
    out->write( '' ). " New line for readability

    " --- Scenario 2: Get a specific product by ID ---
    out->write( '--- Searching for Product PRD002 ---' ).
    TRY.
        DATA(ls_single_product) = lo_product_service->get_product_by_id( 'PRD002' ).
        out->write( |Found: { ls_single_product-product_name }| ).
      CATCH zcx_product_not_found.
        out->write( 'Product PRD002 not found (this should not happen).' ).
    ENDTRY.
    out->write( '' ).

    " --- Scenario 3: Attempt to get a non-existent product (expecting exception) ---
    out->write( '--- Searching for Product NONEXISTENT ---' ).
    TRY.
        DATA(ls_nonexistent_product) = lo_product_service->get_product_by_id( 'NONEXISTENT' ).
        out->write( |Found unexpected product: { ls_nonexistent_product-product_name }| ). " This line should not be reached
      CATCH zcx_product_not_found INTO DATA(lx_exception).
        out->write( |Caught expected exception: Product not found for ID NONEXISTENT.| ).
        " In a real scenario, you might log lx_exception->get_text()
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
