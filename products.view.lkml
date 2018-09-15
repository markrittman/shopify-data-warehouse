# Docs here: https://help.shopify.com/api/data-warehouse/schema-reference/products

view: products {

  sql_table_name: colourpop_data.products_custom ;;

  # IDs -------------------------------------------------------------------

  dimension: product_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: shop_id {
    type: number
    hidden: yes
    sql: ${TABLE}.shop_id ;;
  }

  # Dates -------------------------------------------------------------------

  dimension_group: created {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: deleted {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deleted_at ;;
  }

   # Other -------------------------------------------------------------------

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: title {
    label: "Product Title"
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: vendor {
    label: "Product Vendor"

    type: string
    sql: ${TABLE}.vendor ;;
  }

   # Measures -------------------------------------------------------------------



}
