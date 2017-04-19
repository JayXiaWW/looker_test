view: member_enrollment_tracking {
  sql_table_name: analytics.member_enrollment_tracking_snap_20170329 ;;

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
    hidden: yes
  }

  dimension: member_no {
    type: string
    sql: ${TABLE}.member_no ;;
  }

  dimension: site_id {
    type: number
    sql: ${TABLE}.site_id ;;
    group_label: "Enrollment Characteristics"
  }

  dimension: program_id {
    type: number
    sql: ${TABLE}.program_id ;;
    group_label: "Program"
  }

  dimension: program_type {
    type: string
    sql: case when ${TABLE}.program_type = '' then 'other' else ${TABLE}.program_type end ;;
    group_label: "Program"
    link: {
      label: "Food Dashboard"
      url: "/dashboards/10?Program%20Type={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"

  }
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

  dimension: key {
    type: string
    sql: ${uuid} || ${enrolled_date} ;;
    primary_key: yes
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
    view_label: "Subscription Dates"
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
    hidden: yes
  }

  dimension: duration_in_months {
    description: "The number of months that subscription is for"
    type: number
    sql: ${TABLE}.duration_inmonths ;;
    group_label: "Enrollment Characteristics"
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
      year,
      day_of_week,
      hour_of_day
    ]
    sql: ${TABLE}.enrolled_on ;;
    view_label: "Subscription Dates"
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
    view_label: "Subscription Dates"
  }

  dimension: enrollment_rank {
    description: "What number subscription it is for that user"
    type: number
    sql: ${TABLE}.enrollment_rank ;;
    group_label: "Enrollment Characteristics"
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
    group_label: "Enrollment Characteristics"
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
    view_label: "Subscription Dates"
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
    group_label: "Revenue"
  }

  dimension: total_credit {
    type: number
    sql: ${TABLE}.total_credit ;;
    group_label: "Revenue"
  }

  dimension: total_debit {
    type: number
    sql: ${TABLE}.total_debit ;;
    group_label: "Revenue"
  }

  measure: total_debits {
    type: sum
    sql: ${total_debit} ;;
    group_label: "Revenue"
  }

  measure: total_credits {
    type: sum
    sql: ${total_credit} ;;
    group_label: "Revenue"
  }

  measure: total_revenue {
    type: number
    sql: ${total_debits}-${total_credits};;
    group_label: "Revenue"
  }

  dimension: subscription_tenure_in_months {
    type: number
    sql: DATEDIFF(month,${enrolled_raw},${enrollment_ends_raw}) ;;
    group_label: "Tenure"
  }

  dimension: subscription_tenure_months_tier {
    type: tier
    sql: ${subscription_tenure_in_months};;
    tiers: [1,2,3,6,12,24,36,60]
    group_label: "Tenure"
    style: integer
  }

  dimension: subscription_tenure_in_weeks {
    type: number
    sql: DATEDIFF(week,${enrolled_raw},${enrollment_ends_raw})  ;;
    group_label: "Tenure"
  }

  dimension: subscription_tenure_in_days {
    type: number
    sql: DATEDIFF(day,${enrolled_raw},${enrollment_ends_raw})  ;;
    group_label: "Tenure"
  }

  measure: total_tenure_in_days {
    type: sum
    sql: ${subscription_tenure_in_days}  ;;
    group_label: "Tenure"
  }

  measure: total_tenure_in_months {
    type: sum
    sql: ${subscription_tenure_in_months} ;;
    group_label: "Tenure"
  }

  measure: total_tenure_in_weeks {
    type: sum
    sql: ${subscription_tenure_in_weeks} ;;
    group_label: "Tenure"
  }

  measure: subscription_count {
    type: count
    group_label: "Counts"
  }

  measure: user_count {
    type: count_distinct
    sql: ${TABLE}.uuid ;;
    group_label: "Counts"
    drill_fields: [user_count]
  }



}
