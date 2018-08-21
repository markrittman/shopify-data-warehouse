view: cohort_size {
  view_label: "Customers"
  derived_table: {
    persist_for: "24 hours"
    indexes: ["processed_month"]
    distribution_style: "all"

      explore_source: sales {
        timezone: "America/Los_Angeles"

      column: processed_month { field: orders.processed_month }
      column: count_customers { field: orders.count_customers }
      filters: {
        field: sales.test
        value: "no"
      }
      filters: {
        field: sales.is_deleted
        value: "no"
      }
      filters: {
        field: order_fact.order_index
        value: "1"
      }
    }
  }
  dimension: processed_month {
  }
  dimension: count_customers {
    label: "Cohort Size"
    group_label: "Category"
    type: number
  }
}
