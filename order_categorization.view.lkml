view: order_categorization {
 derived_table: {
   sql: SELECT order_id, MAX(quantity) as max_sku_quantity
        FROM shopify.sales
        WHERE line_type = 'product'
        GROUP BY order_id
     ;;
  }
  dimension: order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: max_sku_quantity {
    type: number
    hidden:  yes
    sql: ${TABLE}.max_sku_quantity ;;
  }

  dimension: is_reseller {
    type: number
    sql: case when ${TABLE}.max_sku_quantity > 4 then 1 else 0 end ;;
    group_label: "Category"
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
