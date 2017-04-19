view: food_journal {
  sql_table_name: analytics.food_journal ;;

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

  dimension: foodjournalkey {
    type: number
    sql: ${TABLE}.foodjournalkey ;;
    primary_key: yes
    hidden: yes
  }

  dimension: iscore {
    type: yesno
    sql: ${TABLE}.iscore ;;
    hidden: yes
  }

  dimension: weeks_since_enrollment {
    type: number
    sql: DATEDIFF(week,${member_enrollment_tracking.enrolled_date},${wwdate_date}) ;;
  }

  dimension: itemid {
    type: string
    sql: ${TABLE}.itemid ;;
    group_label: "Item"
  }

  dimension: itemtype {
    type: string
    sql: ${TABLE}.itemtype ;;
    group_label: "Item"
  }

  dimension: meal {
    type: string
    sql: ${userid} || ${wwdate_date} || ${timeclassifier} ;;
    hidden: yes
  }

  measure: total_meal_count {
    type: count_distinct
    sql: ${meal} ;;
    group_label: "Meals"
  }

  measure: meals_per_user {
    type: number
    sql: 1.0 * ${total_meal_count}/NULLIF(${user_count},0) ;;
    value_format_name: decimal_2
    group_label: "Meals"
  }

  measure: days_tracked {
    type:  count_distinct
    sql: ${wwdate_date} ;;
    group_label: "Meals"
    drill_fields: [wwdate_date,total_meal_count]
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
    group_label: "Points"
  }

  dimension: points_tier {
    type: tier
    sql: ${points} ;;
    tiers: [2,4,6,8,10,12]
    style: integer
    group_label: "Points"
  }

  dimension: pointsperserving {
    type: number
    sql: ${TABLE}.pointsperserving ;;
    group_label: "Points"
  }

  dimension: portionid {
    type: string
    sql: ${TABLE}.portionid ;;
    group_label: "Portions"
  }

  dimension: portionmeasurement {
    type: string
    sql: ${TABLE}.portionmeasurement ;;
    group_label: "Portions"
  }

  dimension: portionsize {
    type: number
    sql: ${TABLE}.portionsize ;;
    group_label: "Portions"
  }

  dimension: smartpoints {
    type: number
    sql: ${TABLE}.smartpoints ;;
    group_label: "Smartpoints"
  }

  dimension: smartpoints_tier {
    type: tier
    sql: ${smartpoints} ;;
    tiers: [2,4,6,8,10,12]
    style: integer
    group_label: "Smartpoints"
  }

  dimension: smartpointsperserving {
    type: number
    sql: ${TABLE}.smartpointsperserving ;;
    group_label: "Points"
  }

  dimension: subordering {
    type: number
    sql: ${TABLE}.subordering ;;
    hidden: yes
  }

  dimension: timeclassifier {
    label: "Time of Day"
    type: string
    sql: ${TABLE}.timeclassifier ;;
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
    hidden: yes
  }

  dimension: weeks_since_pilot_start {
    type: number
    sql: DATEDIFF(week,'01-01-2017',${wwdate_date}) ;;
    drill_fields: [wwdate_date]
  }
  dimension_group: wwdate {
    label: "Food Entry"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      day_of_week,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.wwdate ;;
  }
  measure: user_count {
    description: "Users who logged a food entry"
    type: count_distinct
    sql: ${userid} ;;
    drill_fields: [userid,total_points]
    group_label: "Counts"
  }

  measure: percent_of_cohort {
    type: number
    sql: 1.0 * ${user_count}/NULLIF(${group_sizes.cohort_size},0) ;;
    value_format_name: percent_2
  }

  measure: total_points {
    type: sum
    sql: ${points} ;;
    group_label: "Points"
  }

  measure: average_points {
    type: number
    sql: 1.0 * ${total_points}/NULLIF(${count},0);;
    group_label: "Points"
    value_format_name: decimal_2
  }

  measure: points_per_user {
    type: number
    sql: 1.0 * ${total_points}/NULLIF(${user_count},0);;
    group_label: "Points"
    value_format_name: decimal_2
  }

  measure: entries_per_user {
    type: number
    sql: 1.0 * ${count}/NULLIF(${user_count},0);;
    group_label: "Counts"
    value_format_name: decimal_2
  }



  measure: total_smartpoints {
    type: sum
    sql: ${smartpoints} ;;
    group_label: "Smartpoints"
  }

  measure: average_smartpoints {
    type: average
    sql: ${smartpoints} ;;
    group_label: "Smartpoints"
  }

  measure: total_portions {
    type: sum
    sql: ${portionsize} ;;
    group_label: "Portions"
  }

  measure: avg_portions {
    type: average
    sql: ${portionsize} ;;
    group_label: "Portions"
  }

  measure: count {
    label: "Food Entries"
    type: count
    drill_fields: []
    group_label: "Counts"
  }

  measure: percent_of_active_users {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${user_count}/NULLIF(${member_enrollment_tracking.user_count},0)  ;;
    drill_fields: [wwdate_week,user_count,member_enrollment_racking.user_count, percent_of_active_users]
    link: {
      label: "Food Dashboard"
      url: "/dashboards/10"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }



}
