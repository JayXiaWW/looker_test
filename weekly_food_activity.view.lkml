view: weekly_food_activity {

  derived_table: {
    sql:SELECT

       DATE_TRUNC('week', food_journal.wwdate ) AS "week",
       userid,
       COUNT(DISTINCT (DATE(food_journal.wwdate )) ) AS "days_tracked"


       FROM food_journal
       WHERE wwdate > '2017-01-01'
       GROUP BY 1,2 ;;
    sortkeys: ["week"]
    distribution: "week"
    persist_for: "168 hours"
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
  }

  dimension: food_log_week {
    type: date
    sql: ${TABLE}.week ;;
  }

  dimension: key {
    type: string
    sql: ${userid} || ${food_log_week} ;;
    primary_key: yes
  }
  dimension: days_tracked {
    type: number
    sql: ${TABLE}.days_tracked ;;
  }

  measure: average_days_tracked {
    type: average
    sql: 1.0 * ${days_tracked} ;;
    value_format_name: decimal_2
  }
}


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
