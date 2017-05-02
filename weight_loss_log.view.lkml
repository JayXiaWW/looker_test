view: weight_loss_log {

  derived_table: {
    sql: SELECT
         weight_journal.userid  AS "userid",
         DATEDIFF(week,'01-01-2017',(DATE(weight_journal.wwdate )))  AS "weeks_since_pilot_start",
         AVG(CASE WHEN weight_journal.units = 'Kgs' THEN 2.2 * weight_journal.weight
             WHEN weight_journal.units = 'Stones' THEN 14 * weight_journal.weight
             ELSE weight_journal.weight
             END ) AS "average_weight",
         LAG(DATEDIFF(week,'01-01-2017',(DATE(weight_journal.wwdate ))),1) OVER(PARTITION BY weight_journal.userid ORDER BY DATEDIFF(week,'01-01-2017',(DATE(weight_journal.wwdate )))) AS "prev_week",
         LAG(AVG(CASE WHEN weight_journal.units = 'Kgs' THEN 2.2 * weight_journal.weight
                 WHEN weight_journal.units = 'Stones' THEN 14 * weight_journal.weight
                 ELSE weight_journal.weight
                 END ),1) OVER (PARTITION BY weight_journal.userid ORDER BY DATEDIFF(week,'01-01-2017',(DATE(weight_journal.wwdate )))) as "prev_weight"
         FROM analytics.weight_journal  AS weight_journal
         INNER JOIN analytics.whisper_user_role_events_snap_20170321  AS whisper_user_role_events_snap_20170321 ON weight_journal.userid = whisper_user_role_events_snap_20170321.userid
         WHERE ((DATEDIFF(week,'01-01-2017',(DATE(weight_journal.wwdate )))  <= 12)) AND
        (whisper_user_role_events_snap_20170321.rolename = 'rewards-2017-jan-online-control' OR whisper_user_role_events_snap_20170321.rolename = 'rewards-2017-jan-online-high' OR whisper_user_role_events_snap_20170321.rolename = 'rewards-2017-jan-online-low' OR whisper_user_role_events_snap_20170321.rolename = 'rewards-2017-jan-meetings-conrol' OR whisper_user_role_events_snap_20170321.rolename = 'rewards-2017-jan-meetings-high' OR whisper_user_role_events_snap_20170321.rolename = 'rewards-2017-jan-meetings-low') AND ((DATE(weight_journal.wwdate )) > '01-01-2017')
         GROUP BY 1,2
      ;;
    sortkeys: ["weeks_since_pilot_start"]
    distribution: "userid"
    persist_for: "168 hours"
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
  }

  dimension: weeks_since_pilot_start {
    type: number
    sql: ${TABLE}.weeks_since_pilot_start ;;
  }

  dimension: key {
    type: string
    sql: CONCAT(${userid},${weeks_since_pilot_start}) ;;
    primary_key: yes
    hidden: yes
  }
  dimension: prev_week {
    type: number
    sql: ${TABLE}.prev_week ;;
    hidden: yes
  }
  dimension: weekly_average_weight {
    type: number
    sql: ${TABLE}.average_weight ;;
    group_label: "Weight Loss"
  }

  dimension: previous_week_average_weight {
    type: number
    sql: ${TABLE}.prev_weight ;;
    group_label: "Weight Loss"
  }

  dimension: weight_tier {
    type: tier
    sql: ${weekly_average_weight} ;;
    tiers: [150,200,250,300]
    style: interval
    group_label: "Weight Loss"
  }

  dimension: weeks_between_weighings {
    type: number
    sql: ${weeks_since_pilot_start} - ${prev_week} ;;
    group_label: "Weight Loss"
  }

  dimension:  weekly_weight_loss {
    type: number
    sql: -1.0 * (${weekly_average_weight} - ${previous_week_average_weight}) ;;
    group_label: "Weight Loss"
  }

  dimension: abs_val_weight_loss {
    type: number
    sql: ABS(${weekly_weight_loss}) ;;
    hidden: yes

  }
  dimension: weekly_weight_loss_tier {
    type: tier
    sql: ${weekly_weight_loss} ;;
    tiers: [-20,-5,-3,-2,-1,0,1,2,3,5,20]
    style: interval
    group_label: "Weight Loss"
  }

  measure: average_weekly_weight_loss {
    type: average
    sql: ${weekly_weight_loss} ;;
    value_format_name: decimal_2
#     filters: {
#       field: abs_val_weight_loss
#       value: "<20"
#     }
    drill_fields: [userid,weekly_average_weight,previous_week_average_weight,weekly_weight_loss]
  }

  measure: user_count {
    type: count_distinct
    sql: ${userid} ;;
    drill_fields: [userid,weekly_average_weight,previous_week_average_weight,weekly_weight_loss]
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
