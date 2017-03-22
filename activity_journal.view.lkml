view: activity_journal {
  sql_table_name: analytics.activity_journal ;;

  dimension: activityjournalkey {
    type: number
    sql: ${TABLE}.activityjournalkey ;;
  }

  dimension: calories {
    type: number
    sql: ${TABLE}.calories ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
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
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension: eventid {
    type: string
    sql: ${TABLE}.eventid ;;
  }

  dimension: eventtype {
    type: string
    sql: ${TABLE}.eventtype ;;
  }

  dimension: intensity {
    type: number
    sql: ${TABLE}.intensity ;;
  }

  dimension: isambulatory {
    type: yesno
    sql: ${TABLE}.isambulatory ;;
  }

  dimension: itemname {
    type: string
    sql: ${TABLE}.itemname ;;
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

  dimension: points {
    type: number
    sql: ${TABLE}.points ;;
  }

  dimension: smartpoints {
    type: number
    sql: ${TABLE}.smartpoints ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: activity_type {
    type: yesno
    sql: ${source} = 'Manual' ;;
  }

  dimension: steps {
    type: number
    sql: ${TABLE}.steps ;;
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
  }

  dimension_group: wwdate {
    label: "Activity"
    description: "This is the activity time"
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
    drill_fields: [itemname]
  }
}
