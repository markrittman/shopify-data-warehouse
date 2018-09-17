view: product_tags_pivot {
  view_label: "Products"
  derived_table: {
    sql: select product_id,
        max(case when split_part(title,':',1) = 'collab' then split_part(title,':',2) end) as collab,
        max(case when split_part(title,':',1) = 'color' then split_part(title,':',2) end) as color,
       max(case when split_part(title,':',1) = 'unitnumber' then split_part(title,':',2) end) as unitnumber,
      max(case when split_part(title,':',1) = 'productsize' then split_part(title,':',2) end) as productsize,
      max(case when split_part(title,':',1) = 'subcategory' then split_part(title,':',2) end) as subcategory,
      max(case when split_part(title,':',1) = 'technology' then split_part(title,':',2) end) as technology,
      max(case when split_part(title,':',1) = 'category' then split_part(title,':',2) end) as category,
      max(case when split_part(title,':',1) = 'finish' then split_part(title,':',2) end) as finish
from shopify.product_tags
group by product_id
 ;;

  persist_for: "24 hours"
  distribution_style: all

}

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  dimension: product_id {
    hidden: yes

    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: collab {
    label: "Product Collab"

    type: string
    sql: ${TABLE}.collab ;;
  }

  dimension: color {
    label: "Product Color"


    type: string
    sql: ${TABLE}.color ;;
  }

  dimension: unitnumber {
    label: "Product Unit Number"


    type: string
    sql: ${TABLE}.unitnumber ;;
  }

  dimension: productsize {
    label: "Product Size"


    type: string
    sql: ${TABLE}.productsize ;;
  }

  dimension: subcategory {
    label: "Product Subcategory"


    type: string
    sql: ${TABLE}.subcategory ;;
  }



  dimension: technology {
    label: "Product Technology"


    type: string
    sql: ${TABLE}.technology ;;
  }



  dimension: category {
    label: "Product Category"


    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: finish {
    label: "Product Finish"

    type: string
    sql: ${TABLE}.finish ;;
  }

  set: detail {
    fields: [
      product_id,
      collab,
      color,
      unitnumber,
      productsize,
      subcategory,
      technology,
      category,
      finish
    ]
  }
  }
