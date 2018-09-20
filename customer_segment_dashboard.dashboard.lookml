- dashboard: customer_segment_dashboard
  title: Customer Segment Dashboard
  layout: newspaper
  elements:
  - title: Trend over Time
    name: Trend over Time
    model: shopify
    explore: sales
    type: looker_line
    fields:
    - sales.net_sales_with_returns_total_fx
    - order_categorization.summary_segment
    - orders.processed_month
    pivots:
    - order_categorization.summary_segment
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
    sorts:
    - order_categorization.summary_segment 0
    - orders.processed_month
    limit: 500
    stacking: ''
    colors:
    - "#4954ba"
    - "#d14d6d"
    - "#7b80bd"
    - "#51589c"
    - "#4CAF50"
    - "#8BC34A"
    - "#CDDC39"
    - "#FFEB3B"
    - "#9E9E9E"
    - "#607D8B"
    - "#607D8B"
    - "#a6cee3"
    - "#1f78b4"
    - "#5245ed"
    - "#ed6168"
    - "#1ea8df"
    - "#353b49"
    - "#49cec1"
    - "#b3a0dd"
    - "#db7f2a"
    - "#706080"
    - "#a2dcf3"
    - "#776fdf"
    - "#e9b404"
    - "#635189"
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors:
      Core Intl Beauty Enthusiast - 2 - sales.primary_metric: "#7b80bd"
      Core Asia Beauty Enthusiast - 3 - sales.primary_metric: "#51589c"
      Reseller - 4 - sales.primary_metric: "#d14d6d"
      Reseller - 4 - sales.total_no_tax_total_fx: "#d14d6d"
      Core Intl Beauty Enthusiast - 2 - sales.total_no_tax_total_fx: "#1f78b4"
      Reseller - 4 - sales.net_sales_with_returns_total_fx: "#d14d6d"
      Core Intl Beauty Enthusiast - 2 - sales.net_sales_with_returns_total_fx: "#5245ed"
    series_types: {}
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: Core US Beauty Enthusiast - 1 - sales.primary_metric
        name: Core US Beauty Enthusiast
        axisId: sales.primary_metric
      - id: Core Intl Beauty Enthusiast - 2 - sales.primary_metric
        name: Core Intl Beauty Enthusiast
        axisId: sales.primary_metric
      - id: Core Asia Beauty Enthusiast - 3 - sales.primary_metric
        name: Core Asia Beauty Enthusiast
        axisId: sales.primary_metric
      - id: Reseller - 4 - sales.primary_metric
        name: Reseller
        axisId: sales.primary_metric
      showLabels: true
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
    x_axis_label: ''
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    listen:
      Date Range: orders.processed_month
    row: 10
    col: 8
    width: 8
    height: 7
  - title: Reseller AOV This Month
    name: Reseller AOV This Month
    model: shopify
    explore: sales
    type: single_value
    fields:
    - orders.avg_order_value
    - order_categorization.summary_segment
    - orders.processed_month
    pivots:
    - order_categorization.summary_segment
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      sales.date_filter: Last 3 Month
      order_categorization.summary_segment: Reseller
    sorts:
    - order_categorization.summary_segment desc 0
    - orders.avg_order_value desc 0
    limit: 500
    dynamic_fields:
    - table_calculation: prior_month
      label: Prior Month
      expression: offset(${orders.avg_order_value},1)
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: false
    comparison_label: ''
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
    hidden_fields: []
    listen:
      Date Range: orders.processed_month
    row: 0
    col: 16
    width: 8
    height: 4
  - title: Segment Sales Summary
    name: Segment Sales Summary
    model: shopify
    explore: sales
    type: table
    fields:
    - order_categorization.summary_segment
    - orders.processed_month
    - sales.total_no_tax_total_fx
    pivots:
    - orders.processed_month
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
    sorts:
    - order_categorization.summary_segment
    - orders.processed_month
    limit: 500
    total: true
    dynamic_fields:
    - table_calculation: of_total
      label: "% of Total"
      expression: "${sales.total_no_tax_total_fx}/sum(${sales.total_no_tax_total_fx})"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      _type_hint: number
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
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
      Date Range: orders.processed_month
    row: 4
    col: 0
    width: 24
    height: 6
  - title: Reseller Orders Last Period
    name: Reseller Orders Last Period
    model: shopify
    explore: sales
    type: single_value
    fields:
    - orders.processed_month
    - sales.total_no_tax_total_fx
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      order_categorization.summary_segment: Reseller
    limit: 500
    dynamic_fields:
    - table_calculation: previous_month
      label: Previous Month
      expression: offset(${sales.total_no_tax_total_fx},1)
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Reseller Orders This Month
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: ''
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
      Date Range: orders.processed_month
    row: 0
    col: 0
    width: 9
    height: 4
  - title: Reseller Sales By Country This Month
    name: Reseller Sales By Country This Month
    model: shopify
    explore: sales
    type: looker_map
    fields:
    - billing_addresses.country
    - sales.total_no_tax_total_fx
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      order_categorization.summary_segment: Reseller
    limit: 500
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 37.339591851359174
    map_longitude: 21.482391357421875
    map_zoom: 2
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_value_scale_clamp_min: 0
    map_value_scale_clamp_max: 2000000
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_colors:
      Core US Beauty Enthusiast - 1 - sales.primary_metric: "#4954ba"
      Core Intl Beauty Enthusiast - 2 - sales.primary_metric: "#7b80bd"
      Core Asia Beauty Enthusiast - 3 - sales.primary_metric: "#51589c"
      Reseller - 4 - sales.primary_metric: "#d14d6d"
    limit_displayed_rows: false
    hidden_series:
    - Core Asia Beauty Enthusiast - 3 - sales.primary_metric
    - Core Intl Beauty Enthusiast - 2 - sales.primary_metric
    - Core US Beauty Enthusiast - 1 - sales.primary_metric
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
    show_silhouette: true
    totals_color: "#808080"
    series_types: {}
    listen:
      Date Range: orders.processed_month
    row: 10
    col: 0
    width: 8
    height: 7
  - title: Reseller Share by Period
    name: Reseller Share by Period
    model: shopify
    explore: sales
    type: looker_column
    fields:
    - order_categorization.summary_segment
    - orders.processed_month
    - sales.total_no_tax_total_fx
    pivots:
    - order_categorization.summary_segment
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
    sorts:
    - order_categorization.summary_segment 0
    - sales.period
    limit: 500
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      Core US Beauty Enthusiast - 1 - sales.primary_metric: "#4954ba"
      Core Intl Beauty Enthusiast - 2 - sales.primary_metric: "#7b80bd"
      Core Asia Beauty Enthusiast - 3 - sales.primary_metric: "#51589c"
      Reseller - 4 - sales.primary_metric: "#d14d6d"
      Reseller - 4 - sales.total_no_tax_total_fx: "#d14d6d"
      Core Asia Beauty Enthusiast - 3 - sales.total_no_tax_total_fx: "#7b80bd"
      Core Intl Beauty Enthusiast - 2 - sales.total_no_tax_total_fx: "#1f78b4"
      Core US Beauty Enthusiast - 1 - sales.total_no_tax_total_fx: "#4954ba"
      Core Intl Beauty Enthusiast - 2 - sales.net_sales_with_returns_total_fx: "#5245ed"
      Reseller - 4 - sales.net_sales_with_returns_total_fx: "#ed6168"
      Core Asia Beauty Enthusiast - 3 - sales.net_sales_with_returns_total_fx: "#7b80bd"
      Core US Beauty Enthusiast - 1 - sales.net_sales_with_returns_total_fx: "#4954ba"
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - Core Asia Beauty Enthusiast - 3 - sales.primary_metric
    - Core Intl Beauty Enthusiast - 2 - sales.primary_metric
    - Core US Beauty Enthusiast - 1 - sales.primary_metric
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
    show_silhouette: true
    totals_color: "#808080"
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 37.339591851359174
    map_longitude: 21.482391357421875
    map_zoom: 2
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: true
    reverse_map_value_colors: false
    listen:
      Date Range: orders.processed_month
    row: 10
    col: 16
    width: 8
    height: 7
  - title: Reseller Share of Orders This Month
    name: Reseller Share of Orders This Month
    model: shopify
    explore: sales
    type: single_value
    fields:
    - order_categorization.summary_segment
    - sales.total_no_tax_total_fx
    - orders.processed_month
    pivots:
    - orders.processed_month
    fill_fields:
    - orders.processed_month
    filters:
      sales.test: 'no'
      sales.is_deleted: 'no'
      orders.processed_date: 3 months
    sorts:
    - order_categorization.summary_segment desc
    - orders.processed_month desc
    limit: 500
    dynamic_fields:
    - table_calculation: of_total
      label: of_total
      expression: "${sales.total_no_tax_total_fx}/sum(${sales.total_no_tax_total_fx})"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      _type_hint: number
    - table_calculation: prior_month
      label: prior month
      expression: pivot_offset(${of_total},1)
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      _type_hint: number
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    value_format: ''
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: ''
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
    hidden_fields:
    - sales.total_no_tax_total_fx
    listen:
      Date Range: orders.processed_month
    row: 0
    col: 9
    width: 7
    height: 4
  filters:
  - name: Date Range
    title: Date Range
    type: field_filter
    default_value: 6 months
    allow_multiple_values: true
    required: false
    model: shopify
    explore: sales
    listens_to_filters: []
    field: orders.processed_month
