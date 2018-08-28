# Docs here: https://help.shopify.com/api/data-warehouse/schema-reference/orders

view: orders {
  sql_table_name: shopify.orders ;;

  # IDs -------------------------------------------------------------------

  dimension: order_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.order_id ;;
    group_label: "IDs"

   # this is the email example from our demo environment
    link: {
      label: "Go to Shopify"
      url: "https://colourpop-prd.myshopify.com/admin/orders/{{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    action: {
      label: "Email Promotion to Customer"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      # param: {
      #   name: "some_auth_code"
      #   value: "abc123456"
      # }
      form_param: {
        name: "Subject"
        required: yes
        default: "Thank you {{ value }}"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ orders.customer_id._value }},

        Thanks for your loyalty to SEED Beauty.  We'd like to offer you a 10% discount
        on your next purchase!  Just use the code LOYAL when checking out!

        Your friends at SEED Beauty"
      }
    }
    required_fields: [customers.full_name, customers.first_name]
  }

  dimension: billing_address_id {
    type: number
    hidden: yes
    sql: ${TABLE}.billing_address_id ;;
    group_label: "IDs"
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
    group_label: "IDs"
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
    group_label: "IDs"
  }

  dimension: shipping_address_id {
    hidden: yes
    type: number
    sql: ${TABLE}.shipping_address_id ;;
    group_label: "IDs"
  }

  dimension: shop_id {
    type: number
    hidden: yes
    sql: ${TABLE}.shop_id ;;
    group_label: "IDs"
  }

  dimension: location_id {
    type: number
    hidden: yes
    sql: ${TABLE}.location_id ;;
    group_label: "IDs"
  }

  # Dates -------------------------------------------------------------------

  dimension_group: processed {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.processed_at ;;
    group_label: "Dates"
  }

  dimension_group: canceled {
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
    sql: ${TABLE}.canceled_at ;;
    group_label: "Dates"
  }

  dimension_group: deleted {
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
    sql: ${TABLE}.deleted_at ;;
    group_label: "Dates"
  }

  dimension_group: cohort {
    type: time
    timeframes: [
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.cohort ;;
    group_label: "Dates"
  }

  # Money -------------------------------------------------------------------

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
    group_label: "Money"
  }

  dimension: total_price {
    type: number
    sql: ${TABLE}.total_price ;;
    value_format_name: local_currency
    group_label: "Money"
  }

  dimension: total_price_fx {
    type: number
    sql: ${TABLE}.total_price_fx ;;
    value_format_name: usd
    group_label: "Money"
  }

  # Status -------------------------------------------------------------------

  dimension: financial_status {
    type: string
    sql: ${TABLE}.financial_status ;;
    group_label: "Status"
  }

  dimension: fulfillment_status {
    type: string
    sql: ${TABLE}.fulfillment_status ;;
    group_label: "Status"
  }

  # Other -------------------------------------------------------------------

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    group_label: "Other"
  }

  dimension: test {
    type: yesno
    sql: ${TABLE}.test ;;
    group_label: "Other"
  }

  dimension: discount_code {
    sql: ${TABLE}.discount_code ;;
    group_label: "Other"
  }

###### These were moved into the order_fact table that we built ######

#   dimension: order_index {
#     type: number
#     sql: ${TABLE}.order_index ;;
#     value_format_name: decimal_0
#     group_label: "Other"
#   }

#   dimension: new_vs_repeat {
#     type: string
#     sql: case when ${order_index} = 1 then 'new' else 'repeat' end ;;
#     group_label: "Other"
#   }

  # Measures -------------------------------------------------------------------

  measure: count {
    type: count
    group_label: "Counts"
  }

  measure: count_customers {
    type: count_distinct
    sql: ${TABLE}.customer_id ;;
    group_label: "Counts"

  }

  measure: avg_order_value {
    type: average
    sql: ${TABLE}.total_price_fx ;;
    value_format_name: usd
    group_label: "Order Value"
  }

  measure: order_value {
    type: sum
    sql: ${TABLE}.total_price_fx ;;
    value_format_name: usd
    group_label: "Order Value"

  }



}
