view: member_enrollment_tracking_snap_20170329 {
  sql_table_name: analytics.member_enrollment_tracking_snap_20170329 ;;


  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: member_no {
    type: string
    sql: ${TABLE}.member_no ;;
  }

  dimension: site_id {
    type: number
    sql: ${TABLE}.site_id ;;
  }

  dimension: program_id {
    type: number
    sql: ${TABLE}.program_id ;;
  }

  dimension: program_type {
    type: string
    sql: ${TABLE}.program_type ;;
  }

  dimension: affiliate_id {
    type: number
    sql: ${TABLE}.affiliate_id ;;
    hidden: yes
  }

  dimension: affiliate_name {
    type: string
    sql: ${TABLE}.affiliate_name ;;
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
  }

  dimension: revenue_type {
    type: string
    sql: ${TABLE}.revenue_type ;;
    group_label: "revenue"
  }

  dimension: total_credit {
    type: number
    sql: ${TABLE}.total_credit ;;
    group_label: "revenue"
  }

  dimension: total_debit {
    type: number
    sql: ${TABLE}.total_debit ;;
    group_label: "revenue"
  }

  dimension: most_recent_enrollment_date {
    type:  date
    sql: max(${enrolled_date}) ;;
  }

  measure: tenure_in_days {

    type: number
    sql: date(getdate()) - ${most_recent_enrollment_date}   ;;

  }
  measure: tenure_in_months {

    type: number
    sql: datediff(month,${most_recent_enrollment_date},date(getdate()))   ;;
  }

  measure: count {
    type: count_distinct
    sql: ${TABLE}.uuid ;;
  }



}
