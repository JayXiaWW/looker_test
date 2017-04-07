view: dates {
  derived_table: {
    sql: SELECT
    DATEADD(day, index, '2001-01-01') as series_date
    FROM ${numbers.SQL_TABLE_NAME} as numbers;;
    sql_trigger_value: SELECT COUNT(*) ;;
    sortkeys: ["series_date"]
    distribution: "series_date"
  }
#
  # Define your dimensions and measures here, like this:
  dimension_group: event {
    type: time
    timeframes: [date,week,month,raw]
    sql: ${TABLE}.series_date ;;
    group_label: "Date"
  }

  dimension: days_since_enrollment {
    type: number
    sql: DATEDIFF(day, ${member_enrollment_tracking.enrolled_raw},${event_raw}) ;;
  }
  dimension: weeks_since_enrollment {
    type: number
    sql: DATEDIFF(week, ${member_enrollment_tracking.enrolled_raw},${event_raw}) ;;
  }
  dimension: months_since_enrollment {
    type: number
    sql: DATEDIFF(month, ${member_enrollment_tracking.enrolled_raw},${event_raw}) ;;
  }
}
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
