view: member_enrollment_tracking_snap_20170329 {
  sql_table_name: analytics.member_enrollment_tracking_snap_20170329 ;;

  dimension: affiliate_id {
    type: number
    sql: ${TABLE}.affiliate_id ;;
  }

  dimension: affiliate_name {
    type: string
    sql: ${TABLE}.affiliate_name ;;
  }

  dimension_group: cancel {
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
    sql: ${TABLE}.cancel_date ;;
  }

  dimension_group: cancel_projdate {
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
    sql: ${TABLE}.cancel_projdate ;;
  }

  dimension_group: conversion {
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
    sql: ${TABLE}.conversion_date ;;
  }

  dimension: duration_inmonths {
    type: number
    sql: ${TABLE}.duration_inmonths ;;
  }

  dimension_group: enrol_projdate {
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
    sql: ${TABLE}.enrol_projdate ;;
  }

  dimension_group: enrolled {
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
    sql: ${TABLE}.enrolled_on ;;
  }

  dimension_group: enrollment_ends {
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
    sql: ${TABLE}.enrollment_ends ;;
  }

  dimension: enrollment_rank {
    type: number
    sql: ${TABLE}.enrollment_rank ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension_group: last_enrolled {
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
    sql: ${TABLE}.last_enrolled ;;
  }

  dimension_group: last_upd {
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
    sql: ${TABLE}.last_upd_date ;;
  }

  dimension: member_no {
    type: string
    sql: ${TABLE}.member_no ;;
  }

  dimension: program_id {
    type: number
    sql: ${TABLE}.program_id ;;
  }

  dimension: program_type {
    type: string
    sql: ${TABLE}.program_type ;;
  }

  dimension: revenue_type {
    type: string
    sql: ${TABLE}.revenue_type ;;
  }

  dimension: site_id {
    type: number
    sql: ${TABLE}.site_id ;;
  }

  dimension: total_credit {
    type: number
    sql: ${TABLE}.total_credit ;;
  }

  dimension: total_debit {
    type: number
    sql: ${TABLE}.total_debit ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: [affiliate_name]
  }
}
