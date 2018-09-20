- dashboard: retention
  title: Retention
  layout: newspaper
  elements:
  - title: Total Customers
    name: Total Customers
    model: shopify
    explore: sales
    type: single_value
    fields:
    - customers.count
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Total Customers
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Customer Active Date Range: orders.processed_date
    row: 0
    col: 0
    width: 5
    height: 6
  - title: Product Type Customer Count
    name: Product Type Customer Count
    model: shopify
    explore: sales
    type: single_value
    fields:
    - customers.count
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Total Purchased
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Customer Active Date Range: orders.processed_date
    row: 0
    col: 5
    width: 5
    height: 6
  - name: merge-rwejBkUXQGBEgHN3tTRbkv-240
    type: text
    title_text: New Tile
    subtitle_text: This item contains data that can no longer be displayed.
    body_text: This item contains results merged from two or more queries. This is
      currently not supported in LookML dashboards.
    row: 0
    col: 10
    width: 6
    height: 6
  - title: Total Purchases Histogram
    name: Total Purchases Histogram
    model: shopify
    explore: sales
    type: looker_column
    fields:
    - customers.count
    - order_product_type_fact.total_type_orders
    filters:
      sales.is_deleted: 'no'
      sales.test: 'no'
      products.product_type: No Filter Matte Concealer
      order_product_type_fact.total_type_orders: "-Below 1"
      orders.processed_date: 2 years
    sorts:
    - order_product_type_fact.total_type_orders
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    font_size: 9px
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 0
    col: 16
    width: 8
    height: 6
  - title: Months to First Repurchase
    name: Months to First Repurchase
    model: shopify
    explore: sales
    type: table
    fields:
    - products.product_type
    - order_product_type_fact.months_to_next_type_order_tier
    - customers.count
    - order_product_type_fact.first_type_order_processed_at_month
    pivots:
    - order_product_type_fact.first_type_order_processed_at_month
    fill_fields:
    - order_product_type_fact.first_type_order_processed_at_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      order_product_type_fact.product_type_order_index: '1'
      products.product_type: No Filter Natural Matte Foundation
    sorts:
    - order_product_type_fact.first_type_order_processed_at_month desc
    - order_product_type_fact.months_to_next_type_order_tier
    limit: 5000
    dynamic_fields:
    - table_calculation: of_customers
      label: "% of Customers"
      expression: "${customers.count}/sum(${customers.count})"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 10
    col: 0
    width: 24
    height: 9
  - title: Average Customer Orders
    name: Average Customer Orders
    model: shopify
    explore: sales
    type: table
    fields:
    - order_product_type_fact.first_type_order_processed_at_month
    - order_product_type_fact.avg_product_type_orders
    pivots:
    - order_product_type_fact.first_type_order_processed_at_month
    fill_fields:
    - order_product_type_fact.first_type_order_processed_at_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
    sorts:
    - order_product_type_fact.first_type_order_processed_at_month desc
    limit: 5000
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    series_labels:
      orders.avg_order_value: AOV
      order_product_type_fact.first_type_order_processed_at_month: Cohort
    table_theme: editable
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    series_types: {}
    listen: {}
    row: 6
    col: 0
    width: 24
    height: 4
  filters:
  - name: Customer Active Date Range
    title: Customer Active Date Range
    type: field_filter
    default_value: 24 months
    allow_multiple_values: true
    required: false
    model: shopify
    explore: sales
    listens_to_filters: []
    field: orders.processed_date
