view: whisper_user_role_events_snap_20170321 {
  sql_table_name: analytics.whisper_user_role_events_snap_20170321 ;;

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: isactive {
    type: string
    sql: ${TABLE}.isactive ;;
  }

  dimension: messageid {
    type: string
    sql: ${TABLE}.messageid ;;
  }

  dimension: roleid {
    type: string
    sql: ${TABLE}.roleid ;;
  }

  dimension: rolename {
    type: string
    sql: ${TABLE}.rolename ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
  }

  dimension: whisperrange {
    type: string
    sql: ${TABLE}.whisperrange ;;
  }

  dimension: whispertimestamp {
    type: string
    sql: ${TABLE}.whispertimestamp ;;
  }

  measure: count {
    type: count
    drill_fields: [rolename]
  }
}
