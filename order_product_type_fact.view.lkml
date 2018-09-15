view: order_product_type_fact {
  view_label: "Orders"
  derived_table: {
    persist_for: "24 hours"
    indexes: ["order_id","customer_id","product_type","processed_at"]
    distribution_style: "all"

    sql:
    SELECT
  orders.order_id,
  customers.customer_id,
  products.product_type,
  orders.processed_at,
  ROW_NUMBER() OVER (PARTITION BY customers.customer_id,products.product_type ORDER BY orders.processed_at) as product_type_order_index,
  LAG(orders.processed_at,1) OVER (PARTITION BY customers.customer_id,products.product_type ORDER BY orders.processed_at) as prev_processed_at,
    FIRST_VALUE(orders.processed_at) OVER (PARTITION BY customers.customer_id,products.product_type ORDER BY orders.processed_at
    rows between unbounded preceding and unbounded following) as first_type_order_processed_at,
    FIRST_VALUE(products.product_type) OVER (PARTITION BY customers.customer_id,products.product_type ORDER BY orders.processed_at
    rows between unbounded preceding and unbounded following) as first_product_type_ordered
FROM shopify.sales  AS sales
INNER JOIN shopify.orders  AS orders ON sales.order_id = orders.order_id
LEFT JOIN colourpop_data.products_custom  AS products ON sales.product_id = products.product_id
LEFT JOIN shopify.customers  AS customers ON orders.customer_id = customers.customer_id
WHERE (NOT COALESCE(sales.is_deleted , FALSE)) AND (NOT COALESCE(sales.test , FALSE))
GROUP BY 1,2,3,4;;
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
    sql: concat(concat(concat(${TABLE}.order_id,${TABLE}.customer_id),${TABLE}.product_type),${TABLE}.product_type_order_index) ;;
  }

  dimension: product_type {
    type: string
    hidden: yes
    sql: ${TABLE}.product_type ;;
  }

  dimension: customer_id {
    type: string
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: product_type_order_index {
    group_label: "Repurchases"

    label: "Product Type Order Index"
    type: number
    sql: ${TABLE}.product_type_order_index ;;
  }

  dimension: first_product_type_ordered {
    group_label: "Repurchases"
    label: "First Product Type Ordered"
  }


  dimension: type_new_vs_repeat {
    label: "Product Type New vs Repeat"
    type: string
    sql: case when ${product_type_order_index} = 1 then 'new' else 'repeat' end ;;
    group_label: "Repurchases"
    }

  measure: days_since_last_type_order {
    type: average
    label: "Days Since Last Product Type Order"
    value_format: "0"
    sql: DATEDIFF(day,${TABLE}.prev_processed_at,${TABLE}.processed_at) ;;
    group_label: "Repurchases"

  }

  dimension_group: first_type_order_processed_at {
    group_label: "Dates"
    label: "First Product Type Purchase"
    type: time
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

  dimension: months_to_repeat_type {
    group_label: "Repurchases"
    label: "Months to Repeat First Product Type Purchase"
    type: string
    order_by_field:  months_to_repeat_type_sort_order
    sql: case when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) >= 0 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=1 then 'Within 1 Month'
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) >= 0 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=2 then 'Within 2 Months'
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) >= 0 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=3 then 'Within 3 Months'
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) > 3 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=6 then 'Within 6 Months'
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) > 6 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=9 then 'Within 9 Months'
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) > 9 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=12 then 'Within 12 Months'
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) >= 12 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=24 then 'Within 24 Months'
         else null end;;

  }



  dimension: months_to_repeat_type_sort_order {
    group_label: "Retention"

    type: number
    hidden: yes
    sql: case when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) >= 0 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=3 then 2
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) > 3 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=6 then 3
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) > 6 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=9 then 4
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) > 9 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=12 then 5
              when DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) >= 12 AND DATEDIFF(month,${TABLE}.prev_processed_at,${TABLE}.processed_at) <=24 then 6

         else null end;;
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
