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
  dimension: is_enrolled_month {
    type: yesno
    sql: ${member_enrollment_tracking.enrolled_month} = ${event_month} ;;
    view_label: "Subscriptions"
  }

  dimension: is_cancel_month {
    type: yesno
    sql: ${member_enrollment_tracking.cancel_month} = ${event_month} ;;
  }

  measure: new_subscribers{
    type: count_distinct
    filters: {
      field: is_enrolled_month
      value: "yes"
    }
    view_label: "Subscriptions"
    sql: ${member_enrollment_tracking.uuid} ;;
  }
  measure: canceled_subscribers {
    type: count_distinct
    filters: {
      field: is_cancel_month
      value: "yes"
    }
    view_label: "Subscriptions"
    sql: ${member_enrollment_tracking.uuid} ;;
  }
  measure: existing_subscribers {
    type: count_distinct
    filters: {
      field: is_enrolled_month
      value: "no"
    }
    filters: {
      field: is_cancel_month
      value: "no"
    }
    view_label: "Subscriptions"
    sql: ${member_enrollment_tracking.uuid} ;;
  }
  measure: canceled_subscribers_net {
    type: number
    sql: -1 * ${canceled_subscribers} ;;
    view_label: "Subscriptions"
  }

  measure: net_new_members {
    description: "Net new members"
    type:  number
    sql: ${new_subscribers}-${canceled_subscribers} ;;
    view_label: "Subscriptions"
  }

  measure:  current_members {
    type:  count_distinct
    filters: {
      field: is_cancel_month
      value: "no"
    }
    view_label: "Subscriptions"
    sql: ${member_enrollment_tracking.uuid} ;;
  }

  measure: net_total_members {
    description: "Net Total members"
    type: number
    sql:  ${current_members}+${net_new_members} ;;
    view_label: "Subscriptions"
  }
}


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
#  measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
