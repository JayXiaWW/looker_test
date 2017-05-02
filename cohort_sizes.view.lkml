view: cohort_sizes {

  derived_table: {
    sql: SELECT
        DATE_TRUNC('week', member_enrollment_tracking.enrolled_on )
        AS enrolled_week
        , COUNT(*) as cohort_size
      FROM analytics.member_enrollment_tracking_snap_20170329 as member_enrollment_tracking
      WHERE member_enrollment_tracking.enrolled_on > '2017-01-01'
      GROUP BY 1
      ;;
    sortkeys: ["enrolled_week"]
    distribution_style: all
    sql_trigger_value: SELECT CURRENT_DATE ;;
  }

  dimension: enrolled_week {
    type: date
    sql: ${TABLE}.enrolled_week ;;
  }

  dimension:  cohort_size {
    type: number
    sql: ${TABLE}.cohort_size ;;
  }

  measure: max_cohort_size {
    type: max
    sql: ${cohort_size} ;;
  }
}
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
