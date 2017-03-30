view: weight_journal_tp {
  sql_table_name: analytics.weight_journal ;;

dimension: userid  {

  type:  string
  sql: ${TABLE}.userid ;;
  hidden: no
}

dimension_group: wwdate {
  label: "Weigh-In"
  type: time
  datatype: date
  timeframes: [
    date,
    year,
    quarter,
    month,
    week,
    day_of_week
  ]

  sql: ${TABLE}.wwdate ;;
}

  dimension: units {
    type: string
    sql: ${TABLE}.units ;;
    group_label: "Weight"
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
    group_label: "Weight"
  }

  dimension: weight_lbs {
    label: "Weight in Lbs"
    type: number
    sql: CASE WHEN ${units} = 'Kgs' THEN 2.2 * ${weight}
          WHEN ${units} = 'Stones' THEN 14 * ${weight}
          ELSE ${weight}
          END;;
    group_label: "Weight"
  }

measure: start_weight {
  type : min
  sql: ${wwdate_date} ;;
  value_format_name: "date"
}

measure: end_weight {
  type: max
  sql: ${wwdate_date} ;;
  value_format_name: "date"
}

measure: NoOfWeighIns {
  label: "Number Of Weigh-Ins"
  type:  count
  sql: ${userid} ;;

}


  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: weight_journal_tp {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
