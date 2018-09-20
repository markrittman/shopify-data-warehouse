view: orders_count {
  view_label: "Customers"
  derived_table: {
    sql: SELECT
  sales.customer_id  AS customer_id,
  COUNT(DISTINCT orders.order_id ) AS total_orders
FROM shopify.sales  AS sales
INNER JOIN shopify.orders  AS orders ON sales.order_id = orders.order_id

WHERE (NOT COALESCE(sales.is_deleted , FALSE)) AND (NOT COALESCE(sales.test , FALSE))
GROUP BY 1;;
}
dimension: customer_id {
  primary_key: yes
  hidden: yes
}

  dimension: total_orders_tier {
    type: tier
    tiers: [1,2,3,4,5,8,10,20,50,100]
    style: integer
    label: "Total Orders Tier"
    value_format: "0"
    sql: ${TABLE}.total_orders ;;
  }

measure: total_orders  {
  type: average
  value_format: "0.00"
  group_label: "Counts"

}

  }
