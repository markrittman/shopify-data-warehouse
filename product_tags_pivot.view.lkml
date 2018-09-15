view: product_tags_pivot {
  view_label: "Products"
  derived_table: {
    sql: select product_id,  (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'collab'
                     and   t.product_id = p.product_id
                     limit 1) as collab,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'color'
                     and   t.product_id = p.product_id
                     limit 1) as color,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'unitnumber'
                     and   t.product_id = p.product_id
                     limit 1) as unitnumber,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'productsize'
                     and   t.product_id = p.product_id
                     limit 1) as productsize,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'subcategory'
                     and   t.product_id = p.product_id
                     limit 1) as subcategory,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = '#.excluded'
                     and   t.product_id = p.product_id
                     limit 1) as excluded,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'GW'
                     and   t.product_id = p.product_id
                     limit 1) as GW,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'technology'
                     and   t.product_id = p.product_id
                     limit 1) as technology,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'productline'
                     and   t.product_id = p.product_id
                     limit 1) as productline,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = '#.hidden'
                     and   t.product_id = p.product_id
                     limit 1) as hidden,
                      (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = '#.value'
                     and   t.product_id = p.product_id
                     limit 1) as value,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'category'
                     and   t.product_id = p.product_id
                     limit 1) as category,
                     (select split_part(title,':',2)
                     from shopify.product_tags t
                     where split_part(title,':',1) = 'finish'
                     and   t.product_id = p.product_id
                     limit 1) as finish
from shopify.product_tags p
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

  dimension: excluded {

    type: string
    sql: ${TABLE}.excluded ;;
  }

  dimension: gw {
   hidden: yes
    type: string
    sql: ${TABLE}.gw ;;
  }

  dimension: technology {
    label: "Product Technology"


    type: string
    sql: ${TABLE}.technology ;;
  }

  dimension: productline {
    label: "Product Line"

    type: string
    sql: ${TABLE}.productline ;;
  }

  dimension: hidden {

    type: string
    sql: ${TABLE}.hidden ;;
  }

  dimension: value {

    type: string
    sql: ${TABLE}.value ;;
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
      excluded,
      gw,
      technology,
      productline,
      hidden,
      value,
      category,
      finish
    ]
  }
  }
