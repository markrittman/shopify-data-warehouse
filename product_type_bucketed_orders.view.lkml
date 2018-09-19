view: product_type_bucketed_orders {
  view_label: "Customers"
  derived_table: {
    explore_source: sales {
      column: customer_id {}
      column: count { field: orders.count }
      filters: {
        field: sales.is_deleted
        value: "no"
      }
      filters: {
        field: sales.test
        value: "no"
      }
      filters: {
        field: products.product_type
        value: "No Filter Natural Matte Foundation"
      }
    }
  }
  dimension: customer_id {
    type: number
  }
  dimension: count {
    hidden: yes
    label: "Total Purchases Group"
    type: tier
    tiers: [0,1,2,3,4,5,8,9]
    style: integer
  }

  dimension: total_purchases_tier {
    hidden: yes
    label: "Total Type Purchases Tier"
    group_label: "Repurchases"
    case: {
      when: {
        sql: ${TABLE}.count is null;;
        label: "Never"
      }
      when: {
        sql: ${TABLE}.count <= 1;;
        label: "1"
      }
      when: {
        sql:  ${TABLE}.count <= 2;;
        label: "2"
      }
      when: {
        sql:  ${TABLE}.count <= 3;;
        label: "3"
      }
      when: {
        sql:  ${TABLE}.count <= 4;;
        label: "4"
      }
      when: {
        sql:  ${TABLE}.count <= 5;;
        label: "5"
      }
      when: {
        sql:  ${TABLE}.count <= 8;;
        label: "8"
      }
      when: {
        sql:  ${TABLE}.count <= 9;;
        label: "9"
      }
      when: {
        sql:  ${TABLE}.count > 9;;
        label: "9+"
      }

    }

  }
}
