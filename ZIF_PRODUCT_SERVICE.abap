INTERFACE zif_product_service
  PUBLIC.

  " Defines a service for managing product data.

  TYPES:
    BEGIN OF ty_product_data,
      product_id   TYPE c LENGTH 10,
      product_name TYPE string,
      price        TYPE decfloat34,
      currency     TYPE c LENGTH 3,
      is_available TYPE abap_bool,
    END OF ty_product_data,
    tt_product_data TYPE STANDARD TABLE OF ty_product_data WITH EMPTY KEY.

  METHODS:
    " Retrieves all available products.
    " RETURNING: A table of product data.
    get_all_products
      RETURNING
        VALUE(rt_products) TYPE tt_product_data,

    " Retrieves a single product by its ID.
    " IMPORTING: iv_product_id - The ID of the product to retrieve.
    " RETURNING: A single product data structure.
    " RAISING:   zcx_product_not_found if product does not exist.
    get_product_by_id
      IMPORTING
        iv_product_id TYPE zif_product_service=>ty_product_data-product_id
      RETURNING
        VALUE(rs_product) TYPE ty_product_data
      RAISING
        zcx_product_not_found.

ENDINTERFACE.
