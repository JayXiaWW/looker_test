view: weight_journal {
  sql_table_name: analytics.weight_journal ;;

  dimension_group: completedat {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.completedat ;;
  }

  dimension_group: createdtimestamp {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdtimestamp ;;
  }

  dimension: eventid {
    type: string
    sql: ${TABLE}.eventid ;;
    hidden: yes
  }

  dimension: eventtype {
    type: string
    sql: ${TABLE}.eventtype ;;
    hidden: yes
  }

  dimension: itemtype {
    type: string
    sql: ${TABLE}.itemtype ;;
    label: "Type"
    group_label: "Weight Characteristics"
  }

  dimension: journalid {
    type: string
    sql: ${TABLE}.journalid ;;
    hidden: yes
  }

  dimension: journaltype {
    type: string
    sql: ${TABLE}.journaltype ;;
    hidden: yes
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
    group_label: "Weight Characteristics"
  }

  dimension: subordering {
    type: number
    sql: ${TABLE}.subordering ;;
    group_label: "Weight Characteristics"
  }

  dimension: units {
    type: string
    sql: ${TABLE}.units ;;
    group_label: "Weight"
  }

  dimension_group: updatedtimestamp {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updatedtimestamp ;;
  }

  dimension: useraltid {
    type: string
    sql: ${TABLE}.useraltid ;;
    group_label: "User"
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
    group_label: "User"
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
    group_label: "Weight"
    hidden: yes
  }

  dimension: weight_lbs {
    label: "Weight in Lbs"
    description: "This is the weight converted to Lbs"
    type: number
    sql: CASE WHEN ${units} = 'Kgs' THEN 2.2 * ${weight}
    WHEN ${units} = 'Stones' THEN 14 * ${weight}
    ELSE ${weight}
    END;;
    group_label: "Weight"
  }

  dimension: lbs_to_goal {
    type: number
    sql:${user_profile.goal_weight_lbs} - ${weight_lbs} ;;
    group_label: "Weight"
    description: "The number of pounds away from user's stated goal weight"
  }


  measure: total_weight  {
    type:  sum
    sql: ${weight_lbs} ;;
    group_label: "Weight"
  }

  measure: total_goal_weight {
    type: sum
    sql: ${user_profile.goal_weight_lbs} ;;
    group_label: "Goal Weight"
  }

  measure: percent_to_goal  {
    type:  number
    sql:  1.0* ${total_weight} / ${total_goal_weight} ;;
    value_format_name: percent_2
    group_label: "Goal Weight"
  }

  measure: average_lbs_to_goal {
    description: "Average of gap between current and goal weight"
    type: average
    sql: ${lbs_to_goal} ;;
    value_format_name: decimal_2
    group_label: "Goal Weight"
  }

  dimension: weightjournalkey {
    type: number
    sql: ${TABLE}.weightjournalkey ;;
    primary_key: yes
    hidden: yes
  }

  dimension: weeks_since_pilot_start {
    type: number
    sql: DATEDIFF(week,'01-01-2017',${wwdate_date}) ;;
    drill_fields: [wwdate_date]
  }

  dimension_group: wwdate {
    label: "Weigh-In"
    type: time
    timeframes: [
      raw,
      date,
      week,
      day_of_week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.wwdate ;;
  }

  dimension: weeks_since_enrollment {
    type: number
    sql: DATEDIFF(week,${member_enrollment_tracking.enrolled_date},${wwdate_date}) ;;
  }
  measure: count {
    type: count
    drill_fields: []
    label: "Weigh-In Count"
    group_label: "Counts"
  }

  measure: user_count {
    type: count_distinct
    sql: ${userid} ;;
    group_label: "Counts"
  }

 measure: percent_of_active_users {
   type: number
   value_format_name: percent_2
   sql: 1.0 * ${user_count}/NULLIF(${member_enrollment_tracking.user_count},0)  ;;
 }

  measure: percent_of_cohort {
    type: number
    sql: 1.0 * ${user_count}/NULLIF(${group_sizes.cohort_size},0) ;;
    value_format_name: percent_2
  }

  measure: average_weight {
    type: average
    sql: ${weight} ;;
    group_label: "Weight"
  }

  measure: max_weight {
    type: max
    sql: ${weight} ;;
    group_label: "Weight"
  }

  measure: min_weight {
    type: min
    sql: ${weight} ;;
    group_label: "Weight"
  }

  measure: entries_per_user {
    type: number
    sql: 1.0 * ${count}/NULLIF(${user_count},0);;
    group_label: "Counts"
    value_format_name: decimal_2
  }
}
