- dashboard: cp_customer_overview
  title: CP Customer Overview
  layout: newspaper
  elements:
  - title: Cohort Orders Over Time
    name: Cohort Orders Over Time
    model: shopify
    explore: sales
    type: looker_area
    fields:
    - customer_cohort.processed_month
    - orders.count
    - orders.processed_month
    pivots:
    - customer_cohort.processed_month
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      customer_cohort.processed_month: "%2018%"
    sorts:
    - customer_cohort.processed_month
    - orders.processed_month desc
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - 2018-06 - orders.count
    - 2018-07 - orders.count
    - 2018-08 - orders.count
    - 2018-09 - orders.count
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
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Customer Segment: customer_reseller_status.summary_segment
    row: 5
    col: 0
    width: 24
    height: 8
  - title: 3mth CLV
    name: 3mth CLV
    model: shopify
    explore: sales
    type: looker_column
    fields:
    - sales.total_no_tax_total_fx
    - customers.count
    - order_fact.first_order_processed_at_month
    fill_fields:
    - order_fact.first_order_processed_at_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      orders.months_since_first_purchase: "<=3"
      order_fact.first_order_processed_at_month: 15 months
    sorts:
    - order_fact.first_order_processed_at_month
    limit: 500
    total: true
    dynamic_fields:
    - table_calculation: average_sales_less_tax_per_customer
      label: Average Sales (Less Tax) Per Customer
      expression: "${sales.total_no_tax_total_fx}/${customers.count}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    show_value_labels: true
    label_density: 25
    font_size: 10px
    legend_position: right
    hide_legend: false
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors: {}
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '3'
    hidden_series:
    - 2017-07 - sales.total_no_tax_total_fx
    - 2017-04 - sales.total_no_tax_total_fx
    - 2017-05 - sales.total_no_tax_total_fx
    - 2017-06 - sales.total_no_tax_total_fx
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: average_sales_less_tax_per_customer
        name: Average Sales (Less Tax) Per Customer
        axisId: average_sales_less_tax_per_customer
      showLabels: true
      showValues: true
      maxValue: 100
      minValue: 0
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Customer Cohort
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    label_value_format: ''
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    hidden_fields:
    - customers.count
    - sales.total_no_tax_total_fx
    listen:
      Customer Segment: customer_reseller_status.summary_segment
    row: 13
    col: 0
    width: 8
    height: 6
  - title: 6mth LTV
    name: 6mth LTV
    model: shopify
    explore: sales
    type: looker_column
    fields:
    - sales.total_no_tax_total_fx
    - customers.count
    - order_fact.first_order_processed_at_month
    fill_fields:
    - order_fact.first_order_processed_at_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      orders.months_since_first_purchase: "<=6"
      order_fact.first_order_processed_at_month: 18 months
    sorts:
    - order_fact.first_order_processed_at_month
    limit: 500
    total: true
    dynamic_fields:
    - table_calculation: average_sales_less_tax_per_customer
      label: Average Sales (Less Tax) Per Customer
      expression: "${sales.total_no_tax_total_fx}/${customers.count}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    show_value_labels: true
    label_density: 25
    font_size: 10px
    legend_position: right
    hide_legend: false
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors: {}
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '6'
    hidden_series:
    - 2017-07 - sales.total_no_tax_total_fx
    - 2017-04 - sales.total_no_tax_total_fx
    - 2017-05 - sales.total_no_tax_total_fx
    - 2017-06 - sales.total_no_tax_total_fx
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: average_sales_less_tax_per_customer
        name: Average Sales (Less Tax) Per Customer
        axisId: average_sales_less_tax_per_customer
      showLabels: true
      showValues: true
      maxValue: 100
      minValue: 0
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Customer Cohort
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    label_value_format: ''
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines:
    - color: "#929292"
      label_position: right
      period: 7
      regression_type: linear
      series_index: 1
      show_label: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    hidden_fields:
    - customers.count
    - sales.total_no_tax_total_fx
    listen:
      Customer Segment: customer_reseller_status.summary_segment
    row: 13
    col: 8
    width: 8
    height: 6
  - title: 12mth CLV
    name: 12mth CLV
    model: shopify
    explore: sales
    type: looker_column
    fields:
    - sales.total_no_tax_total_fx
    - customers.count
    - order_fact.first_order_processed_at_month
    fill_fields:
    - order_fact.first_order_processed_at_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      orders.months_since_first_purchase: "<=12"
      order_fact.first_order_processed_at_month: 24 months
    sorts:
    - order_fact.first_order_processed_at_month
    limit: 500
    total: true
    dynamic_fields:
    - table_calculation: average_sales_less_tax_per_customer
      label: Average Sales (Less Tax) Per Customer
      expression: "${sales.total_no_tax_total_fx}/${customers.count}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    show_value_labels: true
    label_density: 25
    font_size: 10px
    legend_position: right
    hide_legend: false
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors: {}
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '12'
    hidden_series:
    - 2017-07 - sales.total_no_tax_total_fx
    - 2017-04 - sales.total_no_tax_total_fx
    - 2017-05 - sales.total_no_tax_total_fx
    - 2017-06 - sales.total_no_tax_total_fx
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: average_sales_less_tax_per_customer
        name: Average Sales (Less Tax) Per Customer
        axisId: average_sales_less_tax_per_customer
      showLabels: true
      showValues: true
      maxValue: 125
      minValue: 0
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Customer Cohort
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    label_value_format: ''
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines:
    - color: "#929292"
      label_position: right
      period: 7
      regression_type: linear
      series_index: 1
      show_label: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    hidden_fields:
    - customers.count
    - sales.total_no_tax_total_fx
    listen:
      Customer Segment: customer_reseller_status.summary_segment
    row: 13
    col: 16
    width: 8
    height: 6
  - title: 24 Months
    name: 24 Months
    model: shopify
    explore: sales
    type: single_value
    fields:
    - customers.count
    filters:
      orders.processed_date: 24 months
      sales.is_deleted: 'no'
      sales.test: 'no'
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Active Customers Last 24 mths
    value_format: 0.00,,"M"
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
      Customer Segment: customer_reseller_status.summary_segment
    row: 0
    col: 4
    width: 4
    height: 5
  - title: All Time Tile
    name: All Time Tile
    model: shopify
    explore: sales
    type: single_value
    fields:
    - customers.count
    filters:
      sales.is_deleted: 'no'
      sales.test: 'no'
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Active Customers All Time
    value_format: 0.00,,"M"
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
      Customer Segment: customer_reseller_status.summary_segment
    row: 0
    col: 0
    width: 4
    height: 5
  - title: Customers
    name: Customers
    model: shopify
    explore: sales
    type: looker_column
    fields:
    - order_fact.new_vs_repeat
    - orders.processed_month
    - customers.count
    pivots:
    - order_fact.new_vs_repeat
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      orders.processed_date: 12 months
    sorts:
    - orders.processed_month
    - order_fact.new_vs_repeat 0
    limit: 500
    stacking: normal
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: new - customers.count
        name: new
        axisId: customers.count
      - id: repeat - customers.count
        name: repeat
        axisId: customers.count
      showLabels: false
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Month
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
      Customer Segment: customer_reseller_status.summary_segment
    row: 0
    col: 12
    width: 6
    height: 5
  - title: Total Sales
    name: Total Sales
    model: shopify
    explore: sales
    type: looker_column
    fields:
    - order_fact.new_vs_repeat
    - orders.processed_month
    - sales.total_sales_total_fx
    pivots:
    - order_fact.new_vs_repeat
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      orders.processed_date: 12 months
    sorts:
    - orders.processed_month
    - order_fact.new_vs_repeat 0
    limit: 500
    stacking: normal
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: new - sales.total_sales_total_fx
        name: new
        axisId: sales.total_sales_total_fx
      - id: repeat - sales.total_sales_total_fx
        name: repeat
        axisId: sales.total_sales_total_fx
      showLabels: false
      showValues: true
      valueFormat: $0,,"M"
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: $0.00,,"M"
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Customer Segment: customer_reseller_status.summary_segment
    row: 0
    col: 18
    width: 6
    height: 5
  - title: 12 Months
    name: 12 Months
    model: shopify
    explore: sales
    type: single_value
    fields:
    - customers.count
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      order_fact.first_order_processed_at_date: 12 months
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Active Customers Last 12 Months
    value_format: 0.00,,"M"
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
      Customer Segment: customer_reseller_status.summary_segment
    row: 0
    col: 8
    width: 4
    height: 5
  filters:
  - name: Customer Segment
    title: Customer Segment
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: shopify
    explore: sales
    listens_to_filters: []
    field: customer_reseller_status.summary_segment
