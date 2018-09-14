connection: "cp_shopify_data_warehouse"

include: "*.view.lkml"


named_value_format: local_currency {
  value_format: "$0.00"
}

# explore: customers {}

explore: sales {
  persist_for: "1 hours"
  # label: ""
  description: "this explore shows x"

  always_filter: {
    filters: {
      field: test
      value: "no"
    }
    filters: {
      field: is_deleted
      value: "no"
    }
  }



  join: orders {
    sql_on: ${sales.order_id} = ${orders.order_id} ;;
    type: inner
    relationship: many_to_one
  }

  join: order_fact {
    view_label: "Orders"
    sql_on: ${orders.order_id} = ${order_fact.order_id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: order_categorization {
    view_label: "Orders"
    sql_on: ${orders.order_id} = ${order_categorization.order_id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: products {
    sql_on:  ${sales.product_id} = ${products.product_id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: collab_from_tags {
    sql_on:  ${products.product_id} = ${collab_from_tags.product_id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: shops {
    sql_on:  ${sales.shop_id} = ${shops.shop_id} ;;
    type:  left_outer
    relationship: many_to_one
  }

  join: customers {
    sql_on: ${orders.customer_id} = ${customers.customer_id} ;;
    type:  left_outer
    relationship: many_to_one
  }

  join: customer_cohort {
    sql_on: ${orders.customer_id} = ${customer_cohort.customer_id} ;;
    type:  left_outer
    relationship: many_to_one
  }
  join: customer_lifetime_spend {
    sql_on: ${customers.customer_id} = ${customer_lifetime_spend.customer_id} ;;
    type:  left_outer
    relationship: many_to_one
  }

  join: cohort_size {
    sql_on: ${customer_cohort.processed_month} = ${cohort_size.processed_month} ;;
    type: inner
    relationship: one_to_one
  }



  #join: customer_default__billing_country_and_zone {
  #  sql_on: ${customers.customer_id} = ${customer_default__billing_country_and_zone.customer_id} ;;
  #  type: left_outer
  #  relationship: one_to_one
  #}

  join: customer_reseller_status {
    sql_on: ${customers.customer_id} = ${customer_reseller_status.customer_id} ;;
    type: left_outer
    relationship: one_to_one
  }



  join: shipping_addresses {
    from: addresses
    sql_on: ${shipping_addresses.address_id} = ${sales.shipping_address_id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: billing_addresses {
    from: addresses
    sql_on: ${billing_addresses.address_id} = ${sales.billing_address_id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: order_product_type_fact {
    sql_on: ${orders.order_id} = ${order_product_type_fact.order_id} AND ${products.product_type} = ${order_product_type_fact.product_type};;
    type: left_outer
    relationship: one_to_one
  }



  join: product_type_cohort_size {
    sql_on: ${products.product_type} = ${product_type_cohort_size.product_type};;
    type: left_outer
    relationship: one_to_one
  }




  join: order_product_sku_fact {
    sql_on: ${orders.order_id} = ${order_product_sku_fact.order_id} AND ${products.title} = ${order_product_sku_fact.title};;
    type: left_outer
    relationship: one_to_one
  }
  }


