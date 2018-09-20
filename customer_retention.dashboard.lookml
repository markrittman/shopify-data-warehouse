- dashboard: retention_customerlevel
  title: Retention (Customer-Level)
  layout: newspaper
  elements:
  - title: Average Count of Purchases
    name: Average Count of Purchases
    model: shopify
    explore: sales
    type: single_value
    fields:
    - order_fact.avg_orders
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: 'Average # Purchases'
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
      Customer Segment: order_categorization.summary_segment
    row: 0
    col: 5
    width: 5
    height: 6
  - title: Total Purchases Histogram
    name: Total Purchases Histogram
    model: shopify
    explore: sales
    type: looker_column
    fields:
    - customers.count
    - order_fact.total_orders
    filters:
      sales.is_deleted: 'no'
      sales.test: 'no'
      order_fact.total_orders: "-Below 1"
    sorts:
    - order_fact.total_orders
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
    listen:
      Customer Active Date Range: orders.processed_date
      Customer Segment: order_categorization.summary_segment
    row: 0
    col: 10
    width: 14
    height: 11
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
      Customer Segment: order_categorization.summary_segment
    row: 0
    col: 0
    width: 5
    height: 6
  - title: Average Customer Orders
    name: Average Customer Orders
    model: shopify
    explore: sales
    type: table
    fields:
    - order_fact.avg_orders
    - order_fact.first_order_processed_at_month
    pivots:
    - order_fact.first_order_processed_at_month
    fill_fields:
    - order_fact.first_order_processed_at_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
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
    listen:
      Customer Active Date Range: orders.processed_date
      Customer Segment: order_categorization.summary_segment
    row: 6
    col: 0
    width: 10
    height: 5
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
  - name: Customer Segment
    title: Customer Segment
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: shopify
    explore: sales
    listens_to_filters: []
    field: order_categorization.summary_segment
