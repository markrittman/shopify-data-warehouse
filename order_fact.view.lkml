view: order_fact {
  view_label: "Orders"
  derived_table: {
    persist_for: "24 hours"
    indexes: ["order_id"]
    distribution_style: "all"

    sql:
    SELECT   orders.order_id,
             customers.customer_id,
           row_number() over (partition by customers.customer_id order by processed_at) as order_index,
          FIRST_VALUE(orders.processed_at) OVER (PARTITION BY customers.customer_id ORDER BY orders.processed_at
    rows between unbounded preceding and unbounded following) as first_order_processed_at,
    LAG(orders.processed_at,1) OVER (PARTITION BY customers.customer_id ORDER BY orders.processed_at) as prev_processed_at,
  LEAD(orders.processed_at,1) OVER (PARTITION BY customers.customer_id ORDER BY orders.processed_at) as next_processed_at

    FROM shopify.orders
    LEFT JOIN shopify.customers  AS customers ON orders.customer_id = customers.customer_id;;
    # sortkeys: ["order_id"]
    # distribution: "order_id"
  }

  dimension: order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: pk{
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(concat(${TABLE}.order_id,${TABLE}.customer_id),${TABLE}.order_index) ;;
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

  dimension: months_to_next_purchase_tier {
    label: "Months To Next Purchase Tier"
    group_label: "Repurchases"
    case: {
      when: {
        sql: ${TABLE}.next_processed_at is null;;
        label: "Never"
      }
      when: {
        sql: DATEDIFF(month,${TABLE}.processed_at,${TABLE}.next_processed_at) <= 2;;
        label: "Within 2 Months"
      }
      when: {
        sql:  DATEDIFF(month,${TABLE}.processed_at,${TABLE}.next_processed_at) > 2 AND DATEDIFF(month,${TABLE}.processed_at,${TABLE}.next_processed_at) <= 3;;
        label: "Within 3 Months"
      }
      when: {
        sql: DATEDIFF(month,${TABLE}.processed_at,${TABLE}.next_processed_at) > 3 AND DATEDIFF(month,${TABLE}.processed_at,${TABLE}.next_processed_at) <= 6;;
        label: "Within 6 Months"
      }
      when: {
        sql: DATEDIFF(month,${TABLE}.processed_at,${TABLE}.next_processed_at) > 6 AND DATEDIFF(month,${TABLE}.processed_at,${TABLE}.next_processed_at) <= 9;;
        label: "Within 9 Months"
      }
      when: {
        sql: DATEDIFF(month,${TABLE}.processed_at,${TABLE}.next_processed_at) > 9 ;;
        label: "Over 9 Months"
      }
      else:"Unknown"
    }

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
