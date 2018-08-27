view: product_type_cohort_size {
  # If necessary, uncomment the line below to include explore_source.
# include: "shopify.model.lkml"

  view_label: "Products"
    derived_table: {
      sql: SELECT
  products.product_type  AS product_type,
  COUNT(DISTINCT orders.customer_id ) AS count_customers
FROM shopify.sales  AS sales
INNER JOIN shopify.orders  AS orders ON sales.order_id = orders.order_id
LEFT JOIN shopify.products  AS products ON sales.product_id = products.product_id
LEFT JOIN looker_temp.LR$H3827Z4YQBFYFK3N3X9TG_order_product_type_fact AS order_product_type_fact ON orders.order_id = order_product_type_fact.order_id AND products.product_type = order_product_type_fact.product_type

WHERE (NOT COALESCE(sales.is_deleted , FALSE)) AND (NOT COALESCE(sales.test , FALSE)) AND (order_product_type_fact.product_type_order_index  = 1) AND ((((order_product_type_fact.first_type_order_processed_at) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(month,-23, DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE()))) )))) AND (order_product_type_fact.first_type_order_processed_at) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(month,24, DATEADD(month,-23, DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE()))) ) ))))))) AND (1=1 -- no filter on 'sales.date_filter'
)
GROUP BY 1
ORDER BY 2 DESC ;;
  }
  dimension: product_type {
    hidden: yes
    primary_key: yes
  }
  dimension: count_customers {
    label: "Product Type Cohort Size"
    type: number
  }
}
