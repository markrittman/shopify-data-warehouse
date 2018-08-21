view: order_categorization {
 derived_table: {
  persist_for: "24 hours"
  indexes: ["order_id"]
  distribution_style: "all"

   sql: SELECT order_id, ba.country as country, MAX(quantity) as max_sku_quantity, count(*) as count_order_items
        FROM shopify.sales s
        JOIN shopify.addresses ba
        ON s.billing_address_id = ba.address_id
        WHERE line_type = 'product'
        GROUP BY order_id, country
     ;;
  }

  set: sales_drilldown_set {
    fields: [
      customers.full_name,
      products.product_type,
      products.title,
      products.vendor,
      addresses.zone_name,
      customer_default__billing_country_and_zone.default_billing_address_zone,
      customer_default__billing_country_and_zone.default_billing_address_country,
      customer_reseller_status.segment
    ]
  }

  dimension: order_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: max_sku_quantity {
    type: number
    hidden:  yes
    sql: ${TABLE}.max_sku_quantity ;;
  }

  dimension: count_order_items {
    type: number
    hidden: yes
    sql: ${TABLE}.count_order_items ;;
  }

  dimension: is_reseller {
    type: number
    sql: case when ${TABLE}.max_sku_quantity > 4 then 1 else 0 end ;;
    group_label: "Category"
  }

  dimension: is_enthusiast {
    type: number
    hidden: yes
    sql: case when (${TABLE}.count_order_items > 100 and ${TABLE}.max_sku_quantity <= 4) then 1 else 0 end ;;
    group_label: "Category"
    }



  dimension: segment {
    type: string
    sql: case when ${TABLE}.max_sku_quantity > 4 then 'Reseller'
         else 'Beauty Enthusiast' end ;;
    group_label: "Category"
    drill_fields: [sales_drilldown_set*]

  }

  dimension: summary_segment {
    type: string
    order_by_field: summary_segment_sort_key
    sql: case when ${TABLE}.max_sku_quantity > 4 then 'Reseller'
              when ${TABLE}.country = 'United States' then 'Core US Beauty Enthusiast'
              when ${TABLE}.country = 'Singapore' OR ${TABLE}.country = 'Hong Kong' OR ${TABLE}.country = 'China' OR ${TABLE}.country = 'Malaysia' then 'Core Asia Beauty Enthusiast'
              else 'Core Intl Beauty Enthusiast' end ;;
    group_label: "Category"
    drill_fields: [sales_drilldown_set*]

  }

  dimension: summary_segment_sort_key {
    type: number
    sql: case when ${TABLE}.max_sku_quantity > 4 then 4
              when ${TABLE}.country = 'United States' then 1
              when ${TABLE}.country = 'Singapore' OR ${TABLE}.country = 'Hong Kong' OR ${TABLE}.country = 'China' OR ${TABLE}.country = 'Malaysia' then 3
              else 2 end ;;
    hidden: yes
  }

  measure: count_reseller {
    type: sum
    sql: case when ${TABLE}.max_sku_quantity > 4 then 1 else 0 end ;;


  }

#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
}
