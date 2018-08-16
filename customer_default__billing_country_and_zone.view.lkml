view: customer_default__billing_country_and_zone {
  view_label: "Customers"
  derived_table: {
    sql: SELECT   c.customer_id, first_value(a.country)
                        over(partition by c.customer_id
                        order by o.processed_at desc
                        rows between unbounded preceding and unbounded following) as country
         from shopify.customers c
         join shopify.orders o
         on   c.customer_id = o.order_id
         join shopify.addresses a
         on   o.billing_address_id = a.address_id
 ;;
  }
  dimension: default_billing_address_country {
    type: string
    hidden: no
    group_label: "Category"
    label: "Default Billing Country"
    sql: ${TABLE}.country ;;
  }


  dimension: billing_address_zone {
    type: number
    hidden: yes
    sql: case
      when ${TABLE}.country = 'United States' then 1
      when ${TABLE}.country = 'Singapore' OR ${TABLE}.country = 'Hong Kong' OR ${TABLE}.country = 'China' OR ${TABLE}.country = 'Malaysia' then 2
      else 4 end ;;
  }

  dimension: customer_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: default_billing_address_zone {
    label: "Default Billing Address Zone"
    type: string
    group_label: "Category"
    order_by_field: billing_address_zone
    sql: case
      when ${TABLE}.country = 'United States' then 'USA'
      when ${TABLE}.country = 'Singapore' OR ${TABLE}.country = 'Hong Kong' OR ${TABLE}.country = 'China' OR ${TABLE}.country = 'Malaysia' then 'Asia'
      else 'Other' end ;;
  }

  }
