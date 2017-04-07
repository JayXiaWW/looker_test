view: activity_journal {
  sql_table_name: analytics.activity_journal ;;


  dimension: activityjournalkey {
    type: number
    sql: ${TABLE}.activityjournalkey ;;
    primary_key: yes
    hidden: yes
  }

  dimension: calories {
    type: number
    sql: ${TABLE}.calories ;;
    group_label: "Activity Characteristics"
  }

  dimension: weeks_since_enrollment {
    type: number
    sql: DATEDIFF(week,${member_enrollment_tracking.enrolled_date},${wwdate_date}) ;;
  }

  measure: total_calories {
    type: sum
    sql: ${calories} ;;
    group_label: "Fitness Stats"
  }

  measure: average_calories {
    type: average
    sql: ${calories} ;;
    group_label: "Fitness Stats"
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
    group_label: "Activity Type"
  }

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

  dimension: currentweightinkgs {
    type: number
    sql: ${TABLE}.currentweightinkgs ;;
    group_label: "User"
  }

  measure: average_weight_in_kgs {
    type: average
    sql: ${currentweightinkgs} ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
    group_label: "Activity Characteristics"
  }

  measure: total_duration {
    type: sum
    sql: ${duration} ;;
    group_label: "Fitness Stats"
  }

  measure: average_duration {
    type: average
    sql: ${duration} ;;
    group_label: "Fitness Stats"
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

  dimension: intensity {
    type: number
    sql: ${TABLE}.intensity ;;
    group_label: "Activity Characteristics"
  }

  dimension: isambulatory {
    type: yesno
    sql: ${TABLE}.isambulatory ;;
    group_label: "Activity Characteristics"
  }

  dimension: itemname {
    type: string
    sql: ${TABLE}.itemname ;;
    group_label: "Activity Type"
  }

  dimension: itemtype {
    type: string
    sql: ${TABLE}.itemtype ;;
    group_label: "Activity Type"
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

  dimension: points {
    type: number
    sql: ${TABLE}.points ;;
    group_label: "Activity Characteristics"
  }

  measure: total_points {
    type:  sum
    sql: ${points} ;;
    group_label: "Fitness Stats"
  }


  dimension: smartpoints {
    type: number
    sql: ${TABLE}.smartpoints ;;
    group_label: "Activity Characteristics"
  }

  measure: total_smartpoints {
    type: sum
    sql: ${smartpoints} ;;
    group_label: "Fitness Stats"
  }

  measure: average_smartpoints {
    type: average
    sql: ${smartpoints} ;;
    group_label: "Fitness Stats"
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
    group_label: "Activity Type"
  }

  dimension: activity_type {
    label: "Activity Type Is Manual"
    type: yesno
    sql: ${source} = 'Manual' ;;
    group_label: "Activity Type"
    drill_fields: [platform,itemtype]
  }

  dimension: platform {
    type: string
    sql: CASE WHEN ${source} LIKE '%Fitbit%' THEN 'Fitbit'
    WHEN ${source} LIKE '%MapMyRun%' THEN 'MapMyRun'
    WHEN ${source} LIKE '%Jawbone%' THEN 'Jawbone'
    WHEN ${source} LIKE '%Garmin%' THEN 'Garmin'
    WHEN ${source} LIKE '%Apple%' THEN 'Apple Health'
    WHEN ${source} LIKE '%Manual%' THEN 'Manual'
    ELSE 'Other'
    END;;
    drill_fields: [activity_journal.source,activity_journal.itemname]
    group_label: "Activity Type"
  }

  dimension: steps {
    type: number
    sql: ${TABLE}.steps ;;
    group_label: "Activity Characteristics"
  }

  measure: total_steps {
    type: sum
    sql: ${steps} ;;
    group_label: "Fitness Stats"
  }

  measure: average_steps {
    type: average
    sql: ${steps} ;;
    group_label: "Fitness Stats"
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

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
    group_label: "User"
  }

  dimension: weeks_since_pilot_start {
    label: "Number of Weeks Since Start of Pilot"
    description: "The Whisper Program Started on 1/1/2017"
    type: number
    sql: DATEDIFF(week,'01-01-2017',${wwdate_date}) ;;
    drill_fields: [wwdate_date]
  }

  dimension_group: wwdate {
    label: "Activity"
    description: "This is the activity time"
    type: time
    timeframes: [
      raw,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.wwdate ;;
  }

  measure: activity_count {
    type: count
    drill_fields: [platform,activity_count]
    group_label: "Counts"
  }

  measure: average_points {
    type: number
    sql: 1.0 * ${total_points}/NULLIF(${activity_count},0);;
    group_label: "Fitness Stats"
    value_format_name: decimal_2
  }

  measure: entries_per_user {
    type: number
    sql: 1.0 * ${activity_count}/NULLIF(${user_count},0);;
    group_label: "Counts"
    value_format_name: decimal_2
  }

  measure: percent_of_enrollment_week_cohort {
    type: number
    sql: 1.0 * ${user_count}/NULLIF(${cohort_sizes.max_cohort_size},0) ;;
    value_format_name: percent_2
    group_label: "Enrollment Information"
  }

  measure: percent_of_cohort {
    type: number
    sql: 1.0 * ${user_count}/NULLIF(${group_sizes.cohort_size},0) ;;
    value_format_name: percent_2
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

}
