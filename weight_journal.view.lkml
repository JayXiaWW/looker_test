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
  }

  dimension: eventtype {
    type: string
    sql: ${TABLE}.eventtype ;;
  }

  dimension: itemtype {
    type: string
    sql: ${TABLE}.itemtype ;;
  }

  dimension: journalid {
    type: string
    sql: ${TABLE}.journalid ;;
  }

  dimension: journaltype {
    type: string
    sql: ${TABLE}.journaltype ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: subordering {
    type: number
    sql: ${TABLE}.subordering ;;
  }

  dimension: units {
    type: string
    sql: ${TABLE}.units ;;
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
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  dimension: weightjournalkey {
    type: number
    sql: ${TABLE}.weightjournalkey ;;
    primary_key: yes
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
  }
}
