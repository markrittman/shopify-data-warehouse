# If necessary, uncomment the line below to include explore_source.
# include: "shopify.model.lkml"

view: customer_reseller_status {
  view_label: "Customers"
  derived_table: {
    persist_for: "8 hours"
    indexes: ["customer_id","zone_name"]
    distribution_style: "all"
    explore_source: sales {
      timezone: "America/Los_Angeles"
      column: customer_id { field: customers.customer_id }
      column: count { field: orders.count }
      column: count_reseller { field: order_categorization.count_reseller }
      column: zone_name {field: customer_cohort.zone_name}
      derived_column: is_reseller {
        sql: case when ((count = 1 AND count_reseller = 1)
        OR (count > 1 AND count_reseller >= 2)) then 1 else 0 end ;;
      }
      derived_column: summary_segment {
        sql: case when ((count = 1 AND count_reseller = 1)
            OR (count > 1 AND count_reseller >= 2)) then 'Reseller' else
            concat(concat('Core ',zone_name),' Beauty Enthusiast') end;;
      }
      filters: {
        field: sales.test
        value: "no"
      }
      filters: {
        field: sales.is_deleted
        value: "no"
      }
    }
  }
  dimension: customer_id {
    type: number
    primary_key: yes
  }


  dimension: is_reseller {
    group_label: "Category"
    type: number
  }


  dimension: summary_segment {
    group_label: "Category"
    type: string
  }

 }
