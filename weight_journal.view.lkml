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
  }

  dimension_group: wwdate {
    label: "Weigh-In"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.wwdate ;;
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
