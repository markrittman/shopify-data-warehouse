view: collab_from_tags {
  view_label: "Products"
  derived_table: {
    sql: select product_id, split_part(title,':',2) as collab
from shopify.product_tags
where title like '%collab%' ;;
  }
  dimension: product_id {
    hidden: yes
    primary_key: yes
  }
  dimension: collab {

  }
  }
