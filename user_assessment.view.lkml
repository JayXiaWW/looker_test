view: user_assessment {
  sql_table_name: analytics.user_assessment ;;

  dimension: answer1 {
    type: string
    sql: ${TABLE}.answer1 ;;
  }

  dimension: answer10 {
    type: string
    sql: ${TABLE}.answer10 ;;
  }

  dimension: answer11 {
    type: string
    sql: ${TABLE}.answer11 ;;
  }

  dimension: answer12 {
    type: string
    sql: ${TABLE}.answer12 ;;
  }

  dimension: answer13 {
    type: string
    sql: ${TABLE}.answer13 ;;
  }

  dimension: answer14 {
    type: string
    sql: ${TABLE}.answer14 ;;
  }

  dimension: answer15 {
    type: string
    sql: ${TABLE}.answer15 ;;
  }

  dimension: answer16 {
    type: string
    sql: ${TABLE}.answer16 ;;
  }

  dimension: answer17 {
    type: string
    sql: ${TABLE}.answer17 ;;
  }

  dimension: answer18 {
    type: string
    sql: ${TABLE}.answer18 ;;
  }

  dimension: answer19 {
    type: string
    sql: ${TABLE}.answer19 ;;
  }

  dimension: answer2 {
    type: string
    sql: ${TABLE}.answer2 ;;
  }

  dimension: answer20 {
    type: string
    sql: ${TABLE}.answer20 ;;
  }

  dimension: answer21 {
    type: string
    sql: ${TABLE}.answer21 ;;
  }

  dimension: answer22 {
    type: string
    sql: ${TABLE}.answer22 ;;
  }

  dimension: answer23 {
    type: string
    sql: ${TABLE}.answer23 ;;
  }

  dimension: answer24 {
    type: string
    sql: ${TABLE}.answer24 ;;
  }

  dimension: answer25 {
    type: string
    sql: ${TABLE}.answer25 ;;
  }

  dimension: answer26 {
    type: string
    sql: ${TABLE}.answer26 ;;
  }

  dimension: answer27 {
    type: string
    sql: ${TABLE}.answer27 ;;
  }

  dimension: answer28 {
    type: string
    sql: ${TABLE}.answer28 ;;
  }

  dimension: answer29 {
    type: string
    sql: ${TABLE}.answer29 ;;
  }

  dimension: answer3 {
    type: string
    sql: ${TABLE}.answer3 ;;
  }

  dimension: answer4 {
    type: string
    sql: ${TABLE}.answer4 ;;
  }

  dimension: answer5 {
    type: string
    sql: ${TABLE}.answer5 ;;
  }

  dimension: answer6 {
    type: string
    sql: ${TABLE}.answer6 ;;
  }

  dimension: answer7 {
    type: string
    sql: ${TABLE}.answer7 ;;
  }

  dimension: answer8 {
    type: string
    sql: ${TABLE}.answer8 ;;
  }

  dimension: answer9 {
    type: string
    sql: ${TABLE}.answer9 ;;
  }

  dimension: assesmentkey {
    type: number
    sql: ${TABLE}.assesmentkey ;;
  }

  dimension: assessmentlocale {
    type: string
    sql: ${TABLE}.assessmentlocale ;;
  }

  dimension: assessmentname {
    type: string
    sql: ${TABLE}.assessmentname ;;
  }

  dimension: assessmentversion {
    type: string
    sql: ${TABLE}.assessmentversion ;;
  }

  dimension: completed {
    type: yesno
    sql: ${TABLE}.completed ;;
  }

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

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
  }

  measure: count {
    type: count
    drill_fields: [assessmentname]
  }
}
