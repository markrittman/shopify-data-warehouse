view: order_fact {
  view_label: "Orders"
  derived_table: {
    persist_for: "24 hours"
    indexes: ["order_id"]
    distribution_style: "all"

    sql:
    SELECT   orders.order_id
           , row_number() over (partition by customer_id order by processed_at) as order_index,
          FIRST_VALUE(orders.processed_at) OVER (PARTITION BY customer_id ORDER BY orders.processed_at
    rows between unbounded preceding and unbounded following) as first_order_processed_at,
    LAG(orders.processed_at,1) OVER (PARTITION BY customers.customer_id ORDER BY orders.processed_at) as prev_processed_at,
  LEAD(orders.processed_at,1) OVER (PARTITION BY customers.customer_id ORDER BY orders.processed_at) as next_processed_at,
    COUNT(orders.order_id) over (PARTITION BY customers.customer_id ORDER BY orders.processed_at
    rows between unbounded preceding and unbounded following) as total_order_count
    FROM shopify.orders ;;
    # sortkeys: ["order_id"]
    # distribution: "order_id"
  }

  dimension: order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_index {
    group_label: "Repurchases"

    type: number
    sql: ${TABLE}.order_index ;;
  }

  dimension: new_vs_repeat {
    type: string
    sql: case when ${order_index} = 1 then 'new' else 'repeat' end ;;
    group_label: "Repurchases"
    }

  dimension_group: first_order_processed_at  {
    type: time
    group_label: "Dates"
    label: "First Purchase"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    }

  dimension: total_orders {
    type: tier
    tiers: [1,2,3,4,5,8,10,20,50,100]
    style: integer
    label: "Total Purchases Tier"
    value_format: "0"
    sql: ${TABLE}.total_order_count ;;
    group_label: "Repurchases"
  }

  measure: avg_orders {
    type: average
    label: "Average # Purchases"
    value_format: "0.0"
    sql: ${TABLE}.total_order_count ;;
    group_label: "Repurchases"
  }

  dimension_group: next_processed_at {
    group_label: "Dates"
    label: "Next Purchase At"
    type: time
    timeframes: [
      date,
      month
    ]
  }




  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: order_fact {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
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
