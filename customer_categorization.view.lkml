view: customer_categorization {
  derived_table: {
     sql: SELECT customer_id, (CASE WHEN MAX(total_quantity) >= 5 THEN 1 else 0 END) as reseller, MAX(total_quantity)
          FROM (
                SELECT customer_id, SUM(quantity) as total_quantity
                FROM shopify.sales
                WHERE line_type = 'product'
                GROUP BY customer_id, line_item_id
          ) as per_item
          GROUP BY customer_id
       ;;
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
