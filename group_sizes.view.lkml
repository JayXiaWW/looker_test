view: group_sizes {



  derived_table: {
    sql: SELECT rolename,count(distinct userid) as cohort_size
    FROM analytics.whisper_user_role_events_snap_20170321
    GROUP BY 1
      ;;
    sortkeys: ["cohort_size"]
    distribution: "rolename"
    persist_for: "720 hours"
  }
#
  # Define your dimensions and measures here, like this:
  dimension: rolename {
    type: string
    sql: ${TABLE}.rolename ;;
  }

  dimension: cohortsize {
    type: number
    sql: ${TABLE}.cohort_size ;;
  }

  measure: cohort_size {
    type: max
    sql: ${cohortsize} ;;
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
