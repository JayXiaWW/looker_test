view: food_journal {
  sql_table_name: analytics.food_journal ;;

  dimension_group: createdtimestamp {
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

  dimension: foodjournalkey {
    type: number
    sql: ${TABLE}.foodjournalkey ;;
    primary_key: yes
  }

  dimension: iscore {
    type: yesno
    sql: ${TABLE}.iscore ;;
  }

  dimension: itemid {
    type: string
    sql: ${TABLE}.itemid ;;
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

  dimension: pointsperserving {
    type: number
    sql: ${TABLE}.pointsperserving ;;
  }

  dimension: portionid {
    type: string
    sql: ${TABLE}.portionid ;;
  }

  dimension: portionmeasurement {
    type: string
    sql: ${TABLE}.portionmeasurement ;;
  }

  dimension: portionsize {
    type: number
    sql: ${TABLE}.portionsize ;;
  }

  dimension: smartpoints {
    type: number
    sql: ${TABLE}.smartpoints ;;
  }

  dimension: smartpointsperserving {
    type: number
    sql: ${TABLE}.smartpointsperserving ;;
  }

  dimension: subordering {
    type: number
    sql: ${TABLE}.subordering ;;
  }

  dimension: timeclassifier {
    type: string
    sql: ${TABLE}.timeclassifier ;;
  }

  dimension_group: updatedtimestamp {
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

  dimension: weeks_since_pilot_start {
    type: number
    sql: DATEDIFF(week,'01-01-2017',${wwdate_date}) ;;
  }
  dimension_group: wwdate {
    label: "Food Entry"
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
  measure: user_count {
    description: "Users who logged a food entry"
    type: count_distinct
    sql: ${userid} ;;
    drill_fields: [userid,total_points]
  }

  measure: total_points {
    type: sum
    sql: ${points} ;;
  }
  measure: count {
    type: count
    drill_fields: []
  }


}
