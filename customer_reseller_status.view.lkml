# If necessary, uncomment the line below to include explore_source.
# include: "shopify.model.lkml"

view: customer_reseller_status {
  view_label: "Customers"
  derived_table: {
    explore_source: sales {
      column: customer_id { field: customers.customer_id }
      column: count { field: orders.count }
      column: count_reseller { field: order_categorization.count_reseller }
      column: default_billing_address_zone { field: customer_default__billing_country_and_zone.default_billing_address_zone }
      derived_column: is_reseller {
        sql: case when ((count = 1 AND count_reseller = 1)
        OR (count > 1 AND count_reseller >= 2)) then 1 else 0 end ;;
      }
      derived_column: segment {
        sql: case when ((count = 1 AND count_reseller = 1)
          OR (count > 1 AND count_reseller >= 2)) then 'Reseller' else 'Beauty Enthusiast' end ;;
      }

      derived_column: summary_segment {
        sql: case when ((count = 1 AND count_reseller = 1)
            OR (count > 1 AND count_reseller >= 2)) then 'Reseller' else
            concat(concat('Core ',default_billing_address_zone),' Beauty Enthusiast') end;;
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
  dimension: count {
    hidden: yes
    type: number
  }
  dimension: count_reseller {
    label: "Orders Count Reseller"
    hidden: yes
    type: number
  }

  dimension: is_reseller {
    group_label: "Category"
    type: number
  }

  dimension: segment {
    group_label: "Category"
    hidden: yes
    type: string
  }

  dimension: summary_segment {
    group_label: "Category"
    type: string
  }

  #dimension: segment {
  #  type: string
  #  sql: if((${orders.count} = 1 AND ${order_categorization.count_reseller} = 1)
  #  OR (${orders.count} > 1 AND ${order_categorization.count_reseller} >= 2),'Reseller','Beauty Enthusiast') ;;
  #  group_label: "Category"
  # }
  }
