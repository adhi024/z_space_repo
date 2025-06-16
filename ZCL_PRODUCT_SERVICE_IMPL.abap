CLASS zcl_product_service_impl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_product_service.

    METHODS:
      " Private helper method to simulate a data source.
      " This method is used internally by the service.
      _get_mock_data
        RETURNING
          VALUE(rt_mock_products) TYPE zif_product_service=>tt_product_data.

ENDCLASS.


CLASS ZCL_PRODUCT_SERVICE_IMPL IMPLEMENTATION.

  METHOD zif_product_service~get_all_products.
    " Simply return all mock products.
    rt_products = _get_mock_data( ).
  ENDMETHOD.

  METHOD zif_product_service~get_product_by_id.
    " Search for the product by ID in mock data.
    DATA(lt_mock_data) = _get_mock_data( ).
    READ TABLE lt_mock_data INTO rs_product
      WITH KEY product_id = iv_product_id.

    IF sy-subrc <> 0.
      " Product not found, raise a custom exception.
      RAISE EXCEPTION NEW zcx_product_not_found( ).
    ENDIF.
  ENDMETHOD.

  METHOD _get_mock_data.
    " Simulates fetching product data from a database or external source.
    " In a real scenario, this would involve actual data retrieval.
    INSERT VALUE #( product_id = 'PRD001'
                   product_name = 'Laptop Pro X'
                   price = '1500.00'
                   currency = 'USD'
                   is_available = abap_true ) INTO TABLE rt_mock_products.
    INSERT VALUE #( product_id = 'PRD002'
                   product_name = 'Wireless Mouse'
                   price = '35.99'
                   currency = 'USD'
                   is_available = abap_true ) INTO TABLE rt_mock_products.
    INSERT VALUE #( product_id = 'PRD003'
                   product_name = 'Ergonomic Keyboard'
                   price = '75.00'
                   currency = 'EUR'
                   is_available = abap_true ) INTO TABLE rt_mock_products.
    INSERT VALUE #( product_id = 'PRD004'
                   product_name = 'USB-C Hub'
                   price = '20.00'
                   currency = 'USD'
                   is_available = abap_false ) INTO TABLE rt_mock_products.
  ENDMETHOD.

ENDCLASS.
