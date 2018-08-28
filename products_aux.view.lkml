view: products_aux {
  sql_table_name: colourpop_data.products_aux ;;
  view_label: "Products"

  dimension: product_category {
    group_label: "PIM Dimensions"
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_collab {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_collab ;;
  }

  dimension: product_finish {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_finish ;;
  }

  dimension: product_id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_line {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_line ;;
  }

  dimension: product_name {
    hidden: yes
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_primary_color {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_primary_color ;;
  }

  dimension: product_secondary_color {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_secondary_color ;;
  }

  dimension: product_size {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_size ;;
  }

  dimension: product_subcategory {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_subcategory ;;
  }

  dimension: product_technology {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_technology ;;
  }

  dimension: product_unit_number {
    group_label: "PIM Dimensions"

    type: number
    sql: ${TABLE}.product_unit_number ;;
  }

  dimension: product_unit_type {
    group_label: "PIM Dimensions"

    type: string
    sql: ${TABLE}.product_unit_type ;;
  }


}
