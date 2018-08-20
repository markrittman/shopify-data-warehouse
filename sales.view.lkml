# This explore allows you to view the sales data from your Shopify store, such as total gross sales, total orders, etc

# Docs are here: https://help.shopify.com/api/data-warehouse/schema-reference/sales


view: sales {

  sql_table_name: shopify.sales ;;

  # Parameters -------------------------------------------------------------------

# Parameters used to create the Metric, Time Granularity and Date Range drop-down menu items in the Reseller dashboard.
# These parameters appear as Filter Only Fields in an explore and are referenced later in the view by the
# period dimension (date_part parameter) and primary_metric (primary_metric_name parameter), and in the sales explore (date_filter)

  parameter: primary_metric_name {
    type: unquoted
    default_value: "total_sales_fx"
    allowed_value: {
      label: "Total Sales FX"
      value: "sales.total_sales_fx"
    }
    allowed_value: {
      label: "Net Sales FX"
      value: "sales.net_sales_fx"
    }
    allowed_value: {
      label: "Gross Sales FX"
      value: "sales.gross_sales_fx"
    }
    allowed_value: {
      label: "Gift Cards Issued Fx"
      value: "sales.gift_cards_issued_fx"
    }
    allowed_value: {
      label: "Gift Card Gross Sales FX"
      value: "sales.gift_card_gross_sales_fx"
    }
    allowed_value: {
      label: "Discounts FX"
      value: "sales.discounts_fx"
    }
  }

    parameter: date_part {
      type: string
      label: "Time Granularity"
      default_value: "month"
      allowed_value: {
        value: "day"
      }
      allowed_value: {
        value: "week"
      }
      allowed_value: {
        value: "month"
      }
      allowed_value: {
        value: "quarter"
      }
      allowed_value: {
        value: "year"
      }
    }

  parameter: date_filter {
    type: date_time
    label: "Date Range"
    default_value: "Last 3 Month"
    allowed_value: {
      label: "Current Week"
      value: "This Week"
    }
    allowed_value: {
      label: "1 Week"
      value: "Last Week"
    }
    allowed_value: {
      label: "2 Weeks"
      value: "Last 2 Week"
    }
    allowed_value: {
      label: "4 Weeks"
      value: "Last 4 Week"
    }
    allowed_value: {
      label: "Current Month"
      value: "This Month"
    }
    allowed_value: {
      label: "1 Month"
      value: "Last Month"
    }
    allowed_value: {
      label: "3 Months"
      value: "Last 3 Month"
    }
    allowed_value: {
      label: "6 Months"
      value: "Last 6 Month"
    }
    allowed_value: {
      label: "Current Qtr"
      value: "This Quarter"
    }
    allowed_value: {
      label: "1 Qtr"
      value: "Last Quarter"
    }
    allowed_value: {
      label: "2 Qtrs"
      value: "Last 2 Quarter"
    }
    allowed_value: {
      label: "YTD"
      value: "This Year"
    }
  }

  # IDs -------------------------------------------------------------------

  dimension: sale_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.sale_id ;;
    group_label: "IDs"
  }

  dimension: api_client_id {
    hidden: yes
    type: number
    sql: ${TABLE}.api_client_id ;;
    group_label: "IDs"
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    group_label: "IDs"
  }

  dimension: billing_address_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billing_address_id ;;
    group_label: "IDs"
  }

  dimension: line_item_id {
    hidden: yes
    type: number
    sql: ${TABLE}.line_item_id ;;
    group_label: "IDs"
  }

  dimension: location_id {
    type: number
    sql: ${TABLE}.location_id ;;
    group_label: "IDs"
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    group_label: "IDs"
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
    group_label: "IDs"
  }

  dimension: product_variant_id {
    type: number
    sql: ${TABLE}.product_variant_id ;;
    group_label: "IDs"
  }

  dimension: shipping_address_id {
    hidden: yes
    type: number
    sql: ${TABLE}.shipping_address_id ;;
    group_label: "IDs"
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    group_label: "IDs"
  }

  dimension: shop_id {
    type: number
    sql: ${TABLE}.shop_id ;;
    group_label: "IDs"
  }

  # Dates -------------------------------------------------------------------

  dimension_group: happened {
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
    sql: ${TABLE}.happened_at ;;
    group_label: "Dates"
  }

  # Dimension that goes with the "date_part" parameter, that when added to a look that uses this parameter alters the time
  # granularity of the report to subtotal metrics by day, month, week, quarter or year

  dimension: period {
    label_from_parameter : date_part
    sql: {% if date_part._parameter_value == "'day'" %}
         to_char(DATE_TRUNC({% parameter date_part %}, CONVERT_TIMEZONE('UTC', 'US/Pacific', ${happened_date})),'YYYY-MM-DD')
         {% elsif date_part._parameter_value == "'month'" %}
         to_char(DATE_TRUNC({% parameter date_part %}, CONVERT_TIMEZONE('UTC', 'US/Pacific', ${happened_date})),'YYYY-MM')
         {% elsif date_part._parameter_value == "'week'" %}
         to_char(DATE_TRUNC({% parameter date_part %}, CONVERT_TIMEZONE('UTC', 'US/Pacific', ${happened_date})),'YYYY-WW')
        {% elsif date_part._parameter_value == "'quarter'" %}
         to_char(DATE_TRUNC({% parameter date_part %}, CONVERT_TIMEZONE('UTC', 'US/Pacific', ${happened_date})),'YYYY-Q')
        {% elsif date_part._parameter_value == "'year'" %}
         to_char(DATE_TRUNC({% parameter date_part %}, CONVERT_TIMEZONE('UTC', 'US/Pacific', ${happened_date})),'YYYY')
         {% else %}
    NULL
    {% endif %} ;;
  }


  # Money -------------------------------------------------------------------

  dimension: currency {
    hidden: yes
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: discounts {
    hidden: yes
    type: number
    sql: ${TABLE}.discounts ;;
    value_format_name: local_currency
  }

  dimension: discounts_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.discounts_fx ;;
    value_format_name: usd
  }

  dimension: gift_card_discounts {
    hidden: yes
    type: number
    sql: ${TABLE}.gift_card_discounts ;;
    value_format_name: local_currency
  }

  dimension: gift_card_discounts_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.gift_card_discounts_fx ;;
    value_format_name: usd
  }

  dimension: gift_card_gross_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.gift_card_gross_sales ;;
    value_format_name: local_currency
  }

  dimension: gift_card_gross_sales_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.gift_card_gross_sales_fx ;;
    value_format_name: usd
  }

  dimension: gift_cards_issued {
    hidden: yes
    type: number
    sql: ${TABLE}.gift_cards_issued ;;
    value_format_name: local_currency
  }

  dimension: gift_cards_issued_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.gift_cards_issued_fx ;;
    value_format_name: usd
  }

  dimension: gross_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.gross_sales ;;
    value_format_name: local_currency
  }

  dimension: gross_sales_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.gross_sales_fx ;;
    value_format_name: usd
  }

  dimension: net_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.net_sales ;;
    value_format_name: local_currency
  }

  dimension: net_sales_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.net_sales_fx ;;
    value_format_name: usd
  }

  dimension: returns {
    hidden: yes
    type: number
    sql: ${TABLE}.returns ;;
    value_format_name: local_currency
  }

  dimension: returns_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.returns_fx ;;
    value_format_name: usd
  }

  dimension: taxes {
    hidden: yes
    type: number
    sql: ${TABLE}.taxes ;;
    value_format_name: local_currency
  }

  dimension: taxes_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.taxes_fx ;;
    value_format_name: usd
  }

  dimension: shipping {
    hidden: yes
    type: number
    sql: ${TABLE}.shipping ;;
    value_format_name: local_currency
  }

  dimension: shipping_fx {
    hidden: yes
    type: number
    sql: ${TABLE}.shipping_fx ;;
    value_format_name: usd
  }

  dimension: total_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.total_sales ;;
    value_format_name: local_currency
  }

  dimension: total_sales_fx {
    type: number
    sql: ${TABLE}.total_sales_fx ;;
    value_format_name: usd
  }

  # Other -------------------------------------------------------------------

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.is_deleted ;;
    group_label: "Other"
  }

  dimension: kind {
    type: string
    sql: ${TABLE}.kind ;;
    group_label: "Other"
  }

  dimension: line_type {
    type: string
    sql: ${TABLE}.line_type ;;
    group_label: "Other"
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    group_label: "Other"
  }

  dimension: test {
    type: yesno
    sql: ${TABLE}.test ;;
    group_label: "Other"
  }

  dimension: customer_first_order_month {
    type: string
    sql:  ${customers.customer_first_order_month} ;;
    group_label: "Other"
  }

  dimension: customer_first_order_quarter {
    type: string
    sql:  ${customers.customer_first_order_quarter} ;;
    group_label: "Other"
  }

  dimension: months_from_start {
    type: number
    sql: datediff(month, ${customers.customer_first_order_month}, ${orders.processed_date}) ;;
    group_label: "Other"
  }



# Measures -------------------------------------------------------------------

# Local Currency -------------------------------------------------------------------

  measure: discounts_total {
    type: sum
    sql: ${TABLE}.discounts ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

  measure: gift_card_discounts_total {
    type: sum
    sql: ${TABLE}.gift_card_discounts ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

  measure: gift_card_gross_sales_total {
    type: sum
    sql: ${TABLE}.gift_card_gross_sales ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

  measure: gift_cards_issued_total {
    type: sum
    sql: ${TABLE}.gross_sales ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

  measure: net_sales_total {
    type: sum
    sql: ${TABLE}.net_sales ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

  measure: returns_total {
    type: sum
    sql: ${TABLE}.returns ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

  measure: taxes_total {
    type: sum
    sql: ${TABLE}.taxes ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

  measure: shipping_total {
    type: sum
    sql: ${TABLE}.shipping ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

  measure: gross_sales_total {
    type: sum
    sql: ${TABLE}.gross_sales ;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }

    #added by MR 08-14-2018

  measure: total_sales_total {
    type: sum
    sql: ${TABLE}.net_sales + ${TABLE}.shipping + ${TABLE}.taxes;;
    value_format_name: local_currency
    group_label: "Local Currency"
    }

  measure: total_sales_no_tax_total {
    type: sum
    sql: ${TABLE}.net_sales + ${TABLE}.shipping;;
    value_format_name: local_currency
    group_label: "Local Currency"
  }


# FX -------------------------------------------------------------------

  measure: discounts_total_fx {
    type: sum
    sql: ${TABLE}.discounts_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: gift_card_discounts_total_fx {
    type: sum
    sql: ${TABLE}.gift_card_discounts_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: gift_card_gross_sales_total_fx {
    type: sum
    sql: ${TABLE}.gift_card_gross_sales_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: gift_cards_issued_total_fx {
    type: sum
    sql: ${TABLE}.gross_sales_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: net_sales_total_fx {
    type: sum
    sql: ${TABLE}.net_sales_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: returns_total_fx {
    type: sum
    sql: ${TABLE}.returns_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: taxes_total_fx {
    type: sum
    sql: ${TABLE}.taxes_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: shipping_total_fx {
    type: sum
    sql: ${TABLE}.shipping_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: gross_sales_total_fx {
    type: sum
    sql: ${TABLE}.gross_sales_fx ;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: total_sales_total_fx {
    type: sum
    sql: ${TABLE}.net_sales_fx + ${TABLE}.shipping_fx + ${TABLE}.taxes_fx;;
    value_format_name: usd
    group_label: "FX"
  }

  measure: total_sales_total_no_tax_fx {
    type: sum
    sql: ${TABLE}.net_sales_fx + ${TABLE}.shipping_fx + ${TABLE}.taxes_fx;;
    value_format_name: usd
    group_label: "FX"
  }


  # Counts -------------------------------------------------------------------

  measure: order_items {
    type: count
    group_label: "Counts"
  }

  measure: orders {
    type: count_distinct
    sql: ${order_id} ;;
    group_label: "Counts"
  }

  measure: customers {
    type: count_distinct
    sql: ${customer_id} ;;
    group_label: "Counts"
  }

  # Dynamic measure used in conjunction with the primary_metric_name parameter to allow the user to
  # switch the measure used in a look or tile

  measure: primary_metric {
    sql: {% parameter primary_metric_name %};;
    type: sum
    value_format_name: usd

    label_from_parameter: primary_metric_name
  }





  set: customer_details {
    fields: [
      customers.first_name,
      customers.last_name,
      customers.email,
      customers.country,
      customers.created_date,
      customers.last_order_date,
      gross_sales_total
    ]
  }

}
