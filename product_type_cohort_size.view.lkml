view: product_type_cohort_size {
  view_label: "Orders"
  # If necessary, uncomment the line below to include explore_source.
  derived_table: {
    explore_source: sales {
      column: product_type { field: products.product_type }
      column: count { field: customers.count }
      column: first_type_order_processed_at_month {field: order_product_type_fact.first_type_order_processed_at_month}
      filters: {
        field: sales.test
        value: "no"
      }
      filters: {
        field: sales.is_deleted
        value: "no"
      }
      filters: {
        field: order_product_type_fact.product_type_order_index
        value: "1"
      }
    }
  }
  dimension: product_type {
    hidden: yes
    primary_key: yes
  }
  measure: count {
    label: "Product Type Cohort Size"
    hidden: yes
    group_label: "Repurchases"
    type: sum
  }
  dimension: first_type_order_processed_at_month {
    label: "Product Type Cohort"
    hidden: yes
    group_label: "Repurchases"

  }
}
