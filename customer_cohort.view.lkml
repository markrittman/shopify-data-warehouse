# If necessary, uncomment the line below to include explore_source.
# include: "shopify.model.lkml"

view: customer_cohort {
  view_label: "Customers"
  derived_table: {
    persist_for: "8 hours"
    indexes: ["customer_id","processed_month"]
    distribution_style: "all"

    explore_source: sales {
      timezone: "America/Los_Angeles"
      column: customer_id { field: customers.customer_id }
      column: full_name { field: customers.full_name}
      column: order_index { field: order_fact.order_index }
      column: processed_date { field: orders.processed_date }
      column: processed_month { field: orders.processed_month}
      column: processed_time { field: orders.processed_time}
      column: order_id { field: orders.order_id}
      column: country { field: billing_addresses.country }
      column: zone { field: billing_addresses.zone }
      column: zone_name { field: billing_addresses.zone_name }
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
  dimension: customer_id {
    primary_key: yes
    hidden: yes

    type: number
  }
  dimension: order_index {
    label: "First Order Order Index"
    hidden: yes

    type: number
  }
  dimension: order_id {
    label: "First Order Order ID"
    hidden: yes

    type: string
  }
  dimension: processed_date {
    hidden: yes
  }
  dimension: processed_time {
    hidden: yes

  }
  dimension: processed_month {

    label: "Cohort Month"
    group_label: "Category"

  }
  dimension: country {

    label: "Default Country"
    group_label: "Category"

  }

  dimension: zone {

    label: "Default Zone"
    group_label: "Category"

  }
  dimension: zone_name {

    label: "Default Zone Name"
    group_label: "Category"

  }


  #dimension: country {}
  #dimension: zone {
  #  type: number
  #}
  #dimension: zone_name {}
}
