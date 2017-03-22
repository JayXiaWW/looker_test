view: user_profile {
  sql_table_name: analytics.user_profile ;;

  dimension: acquisitionid {
    type: string
    sql: ${TABLE}.acquisitionid ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: avatarurl {
    type: string
    sql: ${TABLE}.avatarurl ;;
  }

  dimension: birthyear {
    type: number
    sql: ${TABLE}.birthyear ;;
  }

  dimension: classiccountry {
    type: string
    sql: ${TABLE}.classiccountry ;;
  }

  dimension: classiclocale {
    type: string
    sql: ${TABLE}.classiclocale ;;
  }

  dimension: communicationpreferences {
    type: string
    sql: ${TABLE}.communicationpreferences ;;
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

  dimension: dptadjustment {
    type: number
    sql: ${TABLE}.dptadjustment ;;
  }

  dimension: entitlements {
    type: string
    sql: ${TABLE}.entitlements ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: goalweight {
    type: number
    sql: ${TABLE}.goalweight ;;
  }

  dimension: goalweightunits {
    type: string
    sql: ${TABLE}.goalweightunits ;;
  }

  dimension: hascompletedonboarding {
    type: yesno
    sql: ${TABLE}.hascompletedonboarding ;;
  }

  dimension: height {
    type: number
    sql: ${TABLE}.height ;;
  }

  dimension: home_postalcode {
    type: string
    sql: ${TABLE}.home_postalcode ;;
  }

  dimension: newsletteroption {
    type: yesno
    sql: ${TABLE}.newsletteroption ;;
  }

  dimension: nursingmother {
    type: string
    sql: ${TABLE}.nursingmother ;;
  }

  dimension: optin {
    type: yesno
    sql: ${TABLE}.optin ;;
  }

  dimension: preferredheightweightunits {
    type: string
    sql: ${TABLE}.preferredheightweightunits ;;
  }

  dimension: referrersite {
    type: string
    sql: ${TABLE}.referrersite ;;
  }

  dimension_group: registrationdate {
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
    sql: ${TABLE}.registrationdate ;;
  }

  dimension_group: smartpointsactivationdate {
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
    sql: ${TABLE}.smartpointsactivationdate ;;
  }

  dimension: swappingmode {
    type: string
    sql: ${TABLE}.swappingmode ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: trackingmode {
    type: string
    sql: ${TABLE}.trackingmode ;;
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

  dimension: weighinday {
    type: string
    sql: ${TABLE}.weighinday ;;
  }

  dimension: weightlossmode {
    type: string
    sql: ${TABLE}.weightlossmode ;;
  }

  dimension: work_postalcode {
    type: string
    sql: ${TABLE}.work_postalcode ;;
  }

  dimension: wpaadjustment {
    type: number
    sql: ${TABLE}.wpaadjustment ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
