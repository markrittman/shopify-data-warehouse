view: order_product_sku_fact {
  view_label: "Orders"
  derived_table: {
    #persist_for: "24 hours"
    #indexes: ["order_id","customer_id","title","processed_at"]
    #distribution_style: "all"

    sql:
    SELECT
  orders.order_id,
  customers.customer_id,
  products.title,
  orders.processed_at,
  ROW_NUMBER() OVER (PARTITION BY customers.customer_id,products.title ORDER BY orders.processed_at) as product_title_order_index,
    LAG(orders.processed_at,1) OVER (PARTITION BY customers.customer_id,products.title ORDER BY orders.processed_at) as prev_processed_at

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

  dimension: title {
    type: string
    hidden: yes
    sql: ${TABLE}.title ;;
  }

  dimension: pk{
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(concat(concat(${TABLE}.order_id,${TABLE}.customer_id),${TABLE}.title),${TABLE}.product_title_order_index) ;;
  }

  dimension: customer_id {
    type: string
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: product_title_order_index {
    group_label: "Repurchases"
    label: "Product Title Order Index"
    type: number
    sql: ${TABLE}.product_title_order_index ;;
  }

  dimension: title_new_vs_repeat {
    label: "Product Title New vs Repeat"
    type: string
    sql: case when ${product_title_order_index} = 1 then 'new' else 'repeat' end ;;
    group_label: "Repurchases"
    }

  measure: days_since_last_title_order {
    label: "Days Since Last Product Title Order"

    type: average
    value_format: "0"
    sql: DATEDIFF(day,${TABLE}.prev_processed_at,${TABLE}.processed_at) ;;
    group_label: "Repurchases"

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
