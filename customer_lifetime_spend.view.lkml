  view: customer_lifetime_spend {
    view_label: "Customers"
    derived_table: {
      explore_source: sales {
        column: customer_id { field: customers.customer_id }
        column: net_sales_with_returns_total_fx {}
        column: total_no_tax_total_fx {}
        column: orders {}
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
      hidden: yes
      type: number
    }
    dimension: net_sales_with_returns_total_fx {
      group_label: "Lifetime Value"

      label: "Lifetime Net Sales (Minus Returns) Fx"
      value_format: "$#,##0.00"
      type: number
    }
    dimension: total_no_tax_total_fx {
      group_label: "Lifetime Value"

      label: "Lifetime Total Sales Fx"

      value_format: "$#,##0.00"
      type: number
    }
    dimension: orders {
      group_label: "Lifetime Value"
      label: "Lifetime Orders"

      type: number
    }






  }
